Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2NM5RC19269
	for linux-mips-outgoing; Sat, 23 Mar 2002 14:05:27 -0800
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2NM5Gq19263
	for <linux-mips@oss.sgi.com>; Sat, 23 Mar 2002 14:05:16 -0800
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020323220734.UTED1147.rwcrmhc52.attbi.com@ocean.lucon.org>;
          Sat, 23 Mar 2002 22:07:34 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B3A21125C7; Sat, 23 Mar 2002 14:07:28 -0800 (PST)
Date: Sat, 23 Mar 2002 14:07:28 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: tytso@thunk.org, linux-mips@oss.sgi.com
Subject: Does e2fsprogs-1.26 work on mips?
Message-ID: <20020323140728.A4306@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I got

[root@localhost e2fsprogs-1.26]# ./e2fsck/e2fsck -f /dev/hda1
e2fsck 1.26 (3-Feb-2002)
Pass 1: Checking inodes, blocks, and sizes
File size limit exceeded

on Linux/mipsel. /dev/hda1 is a 7GB ext3 partition. e2fsprogs-1.23
works fine. Strace

open("/dev/hda1", O_RDWR|O_LARGEFILE)   = 4
fstat(4, {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 1), ...}) = 0
setrlimit(RLIMIT_FSIZE, {rlim_cur=-1, rlim_max=-1}) = 0
getrlimit(RLIMIT_FSIZE, {rlim_cur=-1, rlim_max=-1}) = 0
lseek(4, 1024, SEEK_SET)                = 1024
read(4, "\0\200\22\0b\357$\0\304\330\1\0\230\211\36\0\35\322\21"..., 1024) =
102
4
lseek(4, 4096, SEEK_SET)                = 4096
read(4, "\2\0\0\0\3\0\0\0\4\0\0\0\0\0\365?\2\0\0\0\0\0\0\0\0\0\0"..., 4096) =
40
96
time(NULL)                              = 1016919001
lseek(4, 1072, SEEK_SET)                = 1072
write(4, "\331\363", 2)                 = 2
lseek(4, 1120, SEEK_SET)                = 1120
write(4, "\2\0", 2)                     = 2
lseek(4, 4096, SEEK_SET)                = 4096
write(4, "\2\0\0\0\3\0\0\0\4\0\0\0\0\0\365?\2\0\0\0\0\0\0\0\0\0\0"..., 4096) =
4
096
lseek(4, 134217728, SEEK_SET)           = 134217728
write(4, "\0\200\22\0b\357$\0\304\330\1\0\230\211\36\0\35\322\21"..., 1024) =
10
24
lseek(4, 134221824, SEEK_SET)           = 134221824
write(4, "\2\0\0\0\3\0\0\0\4\0\0\0\0\0\365?\2\0\0\0\0\0\0\0\0\0\0"..., 4096) =
4
096
lseek(4, 402653184, SEEK_SET)           = 402653184
write(4, "\0\200\22\0b\357$\0\304\330\1\0\230\211\36\0\35\322\21"..., 1024) =
10
24
lseek(4, 402657280, SEEK_SET)           = 402657280
write(4, "\2\0\0\0\3\0\0\0\4\0\0\0\0\0\365?\2\0\0\0\0\0\0\0\0\0\0"..., 4096) =
4
096
lseek(4, 671088640, SEEK_SET)           = 671088640
write(4, "\0\200\22\0b\357$\0\304\330\1\0\230\211\36\0\35\322\21"..., 1024) =
10
24
lseek(4, 671092736, SEEK_SET)           = 671092736
write(4, "\2\0\0\0\3\0\0\0\4\0\0\0\0\0\365?\2\0\0\0\0\0\0\0\0\0\0"..., 4096) =
4
096
lseek(4, 939524096, SEEK_SET)           = 939524096
write(4, "\0\200\22\0b\357$\0\304\330\1\0\230\211\36\0\35\322\21"..., 1024) =
10
24
lseek(4, 939528192, SEEK_SET)           = 939528192
write(4, "\2\0\0\0\3\0\0\0\4\0\0\0\0\0\365?\2\0\0\0\0\0\0\0\0\0\0"..., 4096) =
4
096
lseek(4, 1207959552, SEEK_SET)          = 1207959552
write(4, "\0\200\22\0b\357$\0\304\330\1\0\230\211\36\0\35\322\21"..., 1024) =
10
24
lseek(4, 1207963648, SEEK_SET)          = 1207963648
write(4, "\2\0\0\0\3\0\0\0\4\0\0\0\0\0\365?\2\0\0\0\0\0\0\0\0\0\0"..., 4096) =
4
096
_llseek(4, 18446744072770027520, [3355443200], SEEK_SET) = 0
write(4, "\0\200\22\0b\357$\0\304\330\1\0\230\211\36\0\35\322\21"..., 1024) =
10
24
_llseek(4, 18446744072770031616, [3355447296], SEEK_SET) = 0
write(4, "\2\0\0\0\3\0\0\0\4\0\0\0\0\0\365?\2\0\0\0\0\0\0\0\0\0\0"..., 4096) =
4
096
_llseek(4, 18446744073038462976, [3623878656], SEEK_SET) = 0
write(4, "\0\200\22\0b\357$\0\304\330\1\0\230\211\36\0\35\322\21"..., 1024) =
10
24
_llseek(4, 18446744073038467072, [3623882752], SEEK_SET) = 0
write(4, "\2\0\0\0\3\0\0\0\4\0\0\0\0\0\365?\2\0\0\0\0\0\0\0\0\0\0"..., 4096) =
4
096
_llseek(4, 18446744071696285696, [6576668672], SEEK_SET) = 0
write(4, "\0\200\22\0b\357$\0\304\330\1\0\230\211\36\0\35\322\21"..., 1024) =
-1
 EFBIG (File too large)
--- SIGXFSZ (File size limit exceeded) ---
+++ killed by SIGXFSZ +++

Any ideas?


H.J.
