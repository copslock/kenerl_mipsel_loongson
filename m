Received:  by oss.sgi.com id <S554152AbRA0Kwb>;
	Sat, 27 Jan 2001 02:52:31 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:61455 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S554149AbRA0KwJ>; Sat, 27 Jan 2001 02:52:09 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01JZEG0B548W0007BC@research.kpn.com> for
 linux-mips@oss.sgi.com; Sat, 27 Jan 2001 11:52:06 +0100
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id LAA21268; Sat, 27 Jan 2001 11:52:05 +0100 (MET)
X-URL:  http://www-lsdm.research.kpn.com/~karel
Date:   Sat, 27 Jan 2001 11:52:05 +0100 (MET)
From:   Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: Re: Cross compiling RPMs
In-reply-to: <200101262114.NAA26672@saturn.mikemac.com>
To:     mikemac@mikemac.com (Mike McDonald)
Cc:     flo@rfc822.org (Florian Lohoff), linux-mips@oss.sgi.com
Message-id: <200101271052.LAA21268@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Mike wrote:
> 
>   If one were to go the native compiling route, what would the minimum
> set of rpms needed be? kernel, bin-utils, cc. file-utils? ???
> 

It depends on what and how you want to compile. To use rpm, you need
quite a lot tools (db3, patch, sed, grep, find,...). Beside that
you'll at least need glibc, binutils, gcc, and make. But you'll find
out that you'll have to compile flex, bison, m4, automake, autoconf,
and even perl to get rpm builds going. My mipsel native environment
currently has the following packages:

MAKEDEV-3.0.6-5         gcc-c++-2.95.3-14       newt-devel-0.50.17-1
SysVinit-2.78-10        gcc-libstdc++-2.95.3-14 pam-0.72-26
XFree86-4.0.1-1lm       gdbm-1.8.0-5            patch-2.5.4-4
XFree86-devel-4.0.1-1lm gdbm-devel-1.8.0-5      perl-5.6.0-9
XFree86-libs-4.0.1-1lm  gettext-0.10.35-23      popt-1.6-4lm
autoconf-2.13-9         glib-1.2.8-4            pwdb-0.61.1-1
automake-1.4-8          glib-devel-1.2.8-4      python-1.5.2-27
basesystem-7.0-2        glibc-2.1.97-1          python-devel-1.5.2-27
bash-2.04-11            glibc-devel-2.1.97-1    python-tools-1.5.2-27
bc-1.05a-13             gmp-3.0.1-5             readline-4.1-5
bdflush-1.5-14          gmp-devel-3.0.1-5       readline-devel-4.1-5
binutils-2.10.1-3       gpm-1.19.3-4            rpm-4.0-4lm
binutils-libs-2.10.1-3  gpm-devel-1.19.3-4      rpm-build-4.0-4lm
bison-1.28-5            grep-2.4.2-4            sed-3.02-8
byacc-1.9-16            groff-1.16-7            sh-utils-2.0-11
bzip2-1.0.1-3           gtk+-1.2.8-7            slang-1.4.1-5
bzip2-devel-1.0.1-3     gtk+-devel-1.2.8-7      slang-devel-1.4.1-5
cpio-2.4.2-20           gzip-1.3-6              tar-1.13-4
db1-1.85-4              info-4.0-15             tcl-8.3.1-46
db1-devel-1.85-4        ldconfig-1.9.5-16       tcllib-0.4-46
db2-2.4.14-4            libelf-0.7.0-3          termcap-11.0.1-3
db2-devel-2.4.14-4      libelf-devel-0.7.0-3    texinfo-4.0-15
db3-3.1.14-6lm          libpng-1.0.8-1          textutils-2.0e-8
db3-devel-3.1.14-6lm    libpng-devel-1.0.8-1    tix-4.1.0.6-46
db3-utils-3.1.14-6lm    libtermcap-2.0.8-25     tk-8.3.1-46
dev-3.0.6-5             libtermcap-devel-2.0.8- tkinter-1.5.2-27
diffutils-2.7-21        libtool-1.3.4-3lm       unzip-5.41-3
fileutils-4.0x-3        m4-1.4.1-3              utempter-0.5.2-4
findutils-4.1.5-4       make-3.79.1-5           vim-common-5.7-6
flex-2.5.4a-11          ncurses-5.1-2           vim-minimal-5.7-6
gawk-3.0.6-1            ncurses-devel-5.1-2     zlib-1.1.3-12
gcc-2.95.3-14           newt-0.50.17-1          zlib-devel-1.1.3-12

But you surely can start with less... :-)
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
