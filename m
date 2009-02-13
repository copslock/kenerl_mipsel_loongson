Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2009 23:10:22 +0000 (GMT)
Received: from n4b.bullet.mail.ac4.yahoo.com ([76.13.13.74]:26448 "HELO
	n4b.bullet.mail.ac4.yahoo.com") by ftp.linux-mips.org with SMTP
	id S21103609AbZBMXKU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Feb 2009 23:10:20 +0000
Received: from [76.13.13.25] by n4.bullet.mail.ac4.yahoo.com with NNFMP; 13 Feb 2009 23:10:13 -0000
Received: from [76.13.10.179] by t4.bullet.mail.ac4.yahoo.com with NNFMP; 13 Feb 2009 23:10:13 -0000
Received: from [127.0.0.1] by omp120.mail.ac4.yahoo.com with NNFMP; 13 Feb 2009 23:10:13 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 963205.92131.bm@omp120.mail.ac4.yahoo.com
Received: (qmail 32776 invoked by uid 60001); 13 Feb 2009 23:10:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=j3GvXT/h+PupHQR/wNPOWryvmPEShxuexSKEDAefA8cHIcZa30nBZ7AyFOB8eIi7/8iIP+xK03z2rW76xtnU1tk0axu0q1H6CbulCeKG4059y7Nzm9Ui+2m7LyuBQDcVtcVF0qEcRpioQaKMgtw1l6xKmeMuefeWgVI00pMpLuk=;
X-YMail-OSG: UsBJQyYVM1ksRRj_xeHXApP.uk7WnWZSo2KcQfWomGo2AmniI29d.t6vZDo6b84z60cvG3YriECtP5hxjOIqRSOZWtKne_VoP1YVszq0F7LMZ82CXDI.SoO8DDPr7t9YxmFL3YYRtJCE3ghLLIki8HcaszfdTHJp4D.QwnOi7LAcek40w7mJu15._qPK7QHw2cDOJs4Z
Received: from [91.196.252.17] by web59815.mail.ac4.yahoo.com via HTTP; Fri, 13 Feb 2009 15:10:13 PST
X-Mailer: YahooMailWebService/0.7.260.1
Date:	Fri, 13 Feb 2009 15:10:13 -0800 (PST)
From:	Andrew Randrianasulu <randrik_a@yahoo.com>
Reply-To: randrik_a@yahoo.com
Subject: gcc-4.4 svn and 2.6.29-rc4 compile error
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <549158.21115.qm@web59815.mail.ac4.yahoo.com>
Return-Path: <randrik_a@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrik_a@yahoo.com
Precedence: bulk
X-list: linux-mips

I have cross-compiler build in this way:

(cross-compiled binutils-2.19 was already installed in /home/guest/cross-compiler/mips/ )

export PATH="${PATH}":/home/guest/cross-compiler/mips/bin

mkdir build-gcc-bootstrap
cd build-gcc-bootstrap/

.../gcc-svn/./configure  --target=mips-unknown-linux-gnu --prefix=/home/guest/cross-compiler/mips --enable-languages=c --without-headers --with-gnu-ld --with-gnu-as --disable-shared --disable-threads --disable-libmudflap  --disable-libssp

make all-gcc install-gcc

(gcc rev. r144149)

Then i have linux kernel from kernel.org main git tree, up to 
commit 37bed90094fdb1eea6e4afec6a200d4e60143e55
(Date:   Thu Feb 12 17:47:15 2009 -0800

Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6)

-rc5 already released, but i see only sound fixes there ...

after trying 
make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu- menuconfig
make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu- 

i got this error:
CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_rd.o
  CC      init/do_mounts_initrd.o
  LD      init/mounts.o
  CC      init/initramfs.o
  CC      init/calibrate.o
  LD      init/built-in.o
  HOSTCC  usr/gen_init_cpio
  GEN     usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  CC      arch/mips/sgi-ip32/ip32-berr.o
  CC      arch/mips/sgi-ip32/ip32-irq.o
  CC      arch/mips/sgi-ip32/ip32-platform.o
  CC      arch/mips/sgi-ip32/ip32-setup.o
  CC      arch/mips/sgi-ip32/ip32-reset.o
cc1: warnings being treated as errors
arch/mips/sgi-ip32/ip32-reset.c: В функции 'debounce':
arch/mips/sgi-ip32/ip32-reset.c:97: ошибка: 'reg_a' is used uninitialized in this function
make[1]: *** [arch/mips/sgi-ip32/ip32-reset.o] Ошибка 1
make: *** [arch/mips/sgi-ip32] Ошибка 2

and restart make with with LANG=C give this

guest@slax:/mnt/hdb1/src/linux-git/linux-2.6$ make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu- 
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-mips
  Checking missing-syscalls for O32
  CALL    scripts/checksyscalls.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      arch/mips/sgi-ip32/ip32-reset.o
cc1: warnings being treated as errors
arch/mips/sgi-ip32/ip32-reset.c: In function 'debounce':
arch/mips/sgi-ip32/ip32-reset.c:97: error: 'reg_a' is used uninitialized in this function
make[1]: *** [arch/mips/sgi-ip32/ip32-reset.o] Error 1
make: *** [arch/mips/sgi-ip32] Error 2

Is this known error? Or I should downgrade toolchain/kernel?

i actually have SGI o2 hardware now, but my SGI machine only run standalone so far, i was played with dvhtools/genisoimage and slightly older self-compiled kernel, without any luck. Should putting kernel in fake volume header work at all on CD-ROM?




      
