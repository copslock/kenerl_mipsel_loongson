Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57IOpe01336
	for linux-mips-outgoing; Thu, 7 Jun 2001 11:24:51 -0700
Received: from t111.niisi.ras.ru (IDENT:root@t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57IOnh01333
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 11:24:49 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id WAA08493
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 22:25:02 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id WAA03747 for linux-mips@oss.sgi.com; Thu, 7 Jun 2001 22:16:03 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id WAA25523 for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 22:21:21 +0400 (MSD)
Message-ID: <3B203741.8020608@niisi.msk.ru>
Date: Thu, 07 Jun 2001 22:24:01 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Make dep doesn't work properly
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.
I have the linux-2.4.3 kernel from your CVS. It looks like the 'make 
dep' comand
doesn't work properly on my machine. With the mkdep.c from the 
linux-2.4.5 it works
fine. Did anybody see the same?

-----------------------------------
[linus linux_2_4_3]$ make dep
if [ ! -f /extra/andreev/linux/linux_2_4_3/include/asm-mips/offset.h ]; 
then \
touch /extra/andreev/linux/linux_2_4_3/include/asm-mips/offset.h; \
fi;
make[1]: Entering directory 
`/extra/andreev/linux/linux_2_4_3/arch/mips/boot'
make[1]: Nothing to be done for `dep'.
make[1]: Leaving directory `/extra/andreev/linux/linux_2_4_3/arch/mips/boot'
scripts/mkdep -- init/*.c > .depend
--: No such file or directory
find /extra/andreev/linux/linux_2_4_3/include/asm 
/extra/andreev/linux/linux_2_4_3/include/linux 
/extra/andreev/linux/linux_2_4_3/include/scsi 
/extra/andreev/linux/linux_2_4_3/include/net -name SCCS -prune -o 
-follow -name \*.h ! -name modversions.h -print | env -i 
PATH="/home/andreev/bin:/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:/usr/X11R6/bin:/sbin:/usr/sbin:/home/andreev/bin" 
HPATH="/extra/andreev/linux/linux_2_4_3/include" xargs scripts/mkdep -- 
 > .hdepend
--: No such file or directory
--: No such file or directory
--: No such file or directory
make _sfdep_arch/mips/tools _sfdep_kernel _sfdep_drivers _sfdep_mm 
_sfdep_fs _sfdep_net _sfdep_ipc _sfdep_lib _sfdep_arch/mips/math-emu 
_sfdep_arch/mips/baget _sfdep_arch/mips/baget/prom 
_sfdep_arch/mips/kernel _sfdep_arch/mips/mm _sfdep_arch/mips/lib 
_FASTDEP_ALL_SUB_DIRS="arch/mips/tools kernel drivers mm fs net ipc lib 
arch/mips/math-emu arch/mips/baget arch/mips/baget/prom arch/mips/kernel 
arch/mips/mm arch/mips/lib"
make[1]: Entering directory `/extra/andreev/linux/linux_2_4_3'
make -C arch/mips/tools fastdep
make[2]: Entering directory 
`/extra/andreev/linux/linux_2_4_3/arch/mips/tools'
/extra/andreev/linux/linux_2_4_3/scripts/mkdep -I 
/extra/andreev/linux/linux_2_4_3/include/asm/gcc -D__KERNEL__ 
-I/extra/andreev/linux/linux_2_4_3/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -G 0 -mno-abicalls -fno-pic 
-mcpu=r3000 -mips1 -pipe  -- offset.c > .depend
-I: No such file or directory
mkdep: mmap: No such device
-D__KERNEL__: No such file or directory
-I/extra/andreev/linux/linux_2_4_3/include: No such file or directory
-Wall: No such file or directory
-Wstrict-prototypes: No such file or directory
-O2: No such file or directory
...
------------------------------------------------------------------------------

I use :
egcs-mips-linux-1.1.2-2,
make-3.78.1-4
