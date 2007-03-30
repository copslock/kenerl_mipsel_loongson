Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2007 15:50:56 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:30851 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20021376AbXC3Ouu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2007 15:50:50 +0100
Received: (qmail 18329 invoked by uid 507); 30 Mar 2007 22:50:08 +0800
Received: from unknown (HELO ?192.168.1.3?) (fxzhang@210.77.15.146)
  by ict.ac.cn with SMTP; 30 Mar 2007 22:50:08 +0800
Message-ID: <460D2602.6060003@ict.ac.cn>
Date:	Fri, 30 Mar 2007 23:00:18 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: kbuild O= support broken?
Content-Type: text/plain; charset=GB18030; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hello,

  Recently I meet a strange error when building a kernel: if I build the 
kernel in the source tree, then it will work well; but if I build it 
with O=../build, then the resulting kernel is unstable.

  Looking into the problem, I find that these two kernel is quite 
different, e.g.

ls -l */built-in.o in build/ dir:
-rw-r--r-- 1 loongson loongson  155239 2007-03-30 10:21 block/built-in.o
-rw-r--r-- 1 loongson loongson   18923 2007-03-30 10:20 crypto/built-in.o
-rw-r--r-- 1 loongson loongson 1498144 2007-03-30 10:30 drivers/built-in.o
-rw-r--r-- 1 loongson loongson 1075678 2007-03-30 10:20 fs/built-in.o
-rw-r--r-- 1 loongson loongson   48747 2007-03-30 22:24 init/built-in.o
-rw-r--r-- 1 loongson loongson   38110 2007-03-30 10:20 ipc/built-in.o
-rw-r--r-- 1 loongson loongson  468469 2007-03-30 10:18 kernel/built-in.o
-rw-r--r-- 1 loongson loongson   18898 2007-03-30 10:41 lib/built-in.o
-rw-r--r-- 1 loongson loongson  313511 2007-03-30 10:12 mm/built-in.o
-rw-r--r-- 1 loongson loongson  974689 2007-03-30 10:40 net/built-in.o
-rw-r--r-- 1 loongson loongson    6774 2007-03-30 10:20 security/built-in.o
-rw-r--r-- 1 loongson loongson       8 2007-03-30 22:43 sound/built-in.o
-rw-r--r-- 1 loongson loongson     913 2007-03-30 10:07 usr/built-in.o

ls -l */built-in.o in src tree:
-rw-r--r-- 1 loongson loongson  155484 2007-03-29 23:03 block/built-in.o
-rw-r--r-- 1 loongson loongson   21702 2007-03-29 23:01 crypto/built-in.o
-rw-r--r-- 1 loongson loongson 1771957 2007-03-29 23:26 drivers/built-in.o
-rw-r--r-- 1 loongson loongson 1087193 2007-03-29 23:00 fs/built-in.o
-rw-r--r-- 1 loongson loongson   48747 2007-03-30 22:21 init/built-in.o
-rw-r--r-- 1 loongson loongson   54546 2007-03-29 23:01 ipc/built-in.o
-rw-r--r-- 1 loongson loongson  470917 2007-03-30 10:16 kernel/built-in.o
-rw-r--r-- 1 loongson loongson   23356 2007-03-29 23:51 lib/built-in.o
-rw-r--r-- 1 loongson loongson  314543 2007-03-29 22:30 mm/built-in.o
-rw-r--r-- 1 loongson loongson  935894 2007-03-29 23:50 net/built-in.o
-rw-r--r-- 1 loongson loongson    6774 2007-03-29 23:01 security/built-in.o
-rw-r--r-- 1 loongson loongson   12154 2007-03-30 22:21 sound/built-in.o
-rw-r--r-- 1 loongson loongson     894 2007-03-29 22:20 usr/built-in.o

loongson@debian:~/old$ ls -l vmlinux ../build-old/vmlinux
-rwxr-xr-x 1 loongson loongson 3856719 2007-03-30 22:24 ../build-old/vmlinux
-rwxr-xr-x 1 loongson loongson 4079730 2007-03-30 22:21 vmlinux

the size different is around 200K!


Take the "sound" subdir for example, I use Make V=1 to check the output 
and find that
while in the src tree, obj-y is correctly set to soundcore.o, so 
built-in.o will be linked
using: (CONFIG_SOUND=y)
  make -f scripts/Makefile.build obj=sound
   ld  -m elf32ltsmip  -r -o sound/built-in.o sound/soundcore.o
while with O= option:
  make -f /home/loongson/old/scripts/Makefile.build obj=sound
   rm -f sound/built-in.o; ar rcs sound/built-in.o

check scripts/Makefile.build we can find that it indicates that obj-y is 
null:
around line 260:

ifdef builtin-target
quiet_cmd_link_o_target = LD      $@
# If the list of objects to link is empty, just create an empty built-in.o
cmd_link_o_target = $(if $(strip $(obj-y)),\
                      $(LD) $(ld_flags) -r -o $@ $(filter $(obj-y), $^),\
                      rm -f $@; $(AR) rcs $@)

$(builtin-target): $(obj-y) FORCE
        $(call if_changed,link_o_target)

Anybody can help explain this?

Thank you.


yours
Fuxin Zhang
