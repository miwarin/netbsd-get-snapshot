# coding: utf-8

require 'net/ftp'
require 'pp'

FTP_SITE = 'ftp7.jp.netbsd.org'
HEAD_DIR = 'pub/NetBSD-daily/HEAD/'

def main(argv)
  Net::FTP.open(FTP_SITE) do |ftp|
    ftp.login
    ftp.chdir(HEAD_DIR)
    dirs = ftp.list('*').reverse.each { |d|
      ymd = d.split(' ')[8]
      sets_dir = "#{ymd}/source/sets/"
      files = ftp.list(sets_dir)
      next if files.length == 0
      
      ftp.chdir(sets_dir)
      files.each {|l|
        f = l.split(' ')[8]
        printf "#{f} ..."
        ftp.get(f)
        printf "done\n"
      }
    }
  end
end

main(ARGV)

