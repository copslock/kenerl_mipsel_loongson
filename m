Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 08:12:44 +0100 (BST)
Received: from n9.bullet.ukl.yahoo.com ([217.146.182.189]:6991 "HELO
	n9.bullet.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20027210AbXJQHMf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 08:12:35 +0100
Received: from [217.12.4.214] by n9.bullet.ukl.yahoo.com with NNFMP; 17 Oct 2007 07:12:29 -0000
Received: from [68.142.194.244] by t1.bullet.ukl.yahoo.com with NNFMP; 17 Oct 2007 07:12:29 -0000
Received: from [209.191.119.153] by t2.bullet.mud.yahoo.com with NNFMP; 17 Oct 2007 07:12:29 -0000
Received: from [127.0.0.1] by omp100.mail.mud.yahoo.com with NNFMP; 17 Oct 2007 07:12:29 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 387272.82708.bm@omp100.mail.mud.yahoo.com
Received: (qmail 76582 invoked by uid 60001); 17 Oct 2007 07:12:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=IcAPtJEDEuf2yP9fhTYW0xTjEkdGBZr4L6qgoICRCUpbIobZT/BogzR+WmWW9Dl/xeTmHr8UIltQAAMt/+yw83qBN5nDzCX8gZEttxBEhd7XkLDM0wtBqOhH29NbMHeY7ZV5NYli3xM6RxjOWaSjYAQDB9gUkfx4kfof6zFVcZ0=;
X-YMail-OSG: x3fqIzMVM1mJr6LyhOfk270m6rCaQSDtgTT3xlfJ_XZ8XyLPPN01TsifsqoW6S_BviHp1_Xf5M7cIWTD5zMinROvZwvB4ig2RZbu9V0BAEouEG2GWSBN7BsGD1ZT3Q--
Received: from [199.239.167.162] by web8411.mail.in.yahoo.com via HTTP; Wed, 17 Oct 2007 08:12:27 BST
Date:	Wed, 17 Oct 2007 08:12:27 +0100 (BST)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
Subject: Linux-2.6.18.8 compilation errors with GCC-4.2.1 and binutils-2.17 on MIPS
To:	"linux-kernel.org" <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <304090.76321.qm@web8411.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

Hi,

I tried to compile Linux-2.6.18.8 for MIPS24KE
processor using cross-compiler built from gcc-4.2.1,
binutils-2.17 and uClibc-0.9.27. But, the compilation
failed with below error message ("mips-linux-ld: final
link failed: Bad value"):
================================
mips-linux-gcc -Wp,-MD,drivers/mtd/.mtd_blkdevs.o.d 
-nostdinc -isystem /home/
sedara/BETA_REL/buildroot/build_mips_nofpu/staging_dir/lib/gcc/mips-linux-uclibc/4.2.1/include

-D__KERNEL__ -Iinclude  -include
include/linux/autoconf.h -DNEW_C
ONFIG -I/home/sedara/BETA_REL/linux-2.6.18/include
-I/home/sedara/BETA_REL/linux
-2.6.18/../fusiv_src/kernel/ap_code
-I/home/sedara/BETA_REL/linux-2.6.18/../fusi
v_src/kernel/ap_code/inc
-I/home/sedara/BETA_REL/linux-2.6.18/../fusiv_src/kerne
l/drivers/inc
-I/home/sedara/BETA_REL/linux-2.6.18/../fusiv_src/kernel/drivers/a
dsl -Wall -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -O
2  -mabi=32 -G 0 -mno-abicalls -fno-pic -pipe
-msoft-float -ffreestanding  -marc
h=mips32r2 -Wa,-mips32r2 -Wa,--trap
-Iinclude/asm-mips/mach-ikan_mips -Iinclude/
asm-mips/mach-generic -fomit-frame-pointer 
-fno-stack-protector -Wdeclaration-a
fter-statement -Wno-pointer-sign   
-D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUI
LD_STR(mtd_blkdevs)" 
-D"KBUILD_MODNAME=KBUILD_STR(mtd_blkdevs)" -c -o
drivers/m
td/.tmp_mtd_blkdevs.o drivers/mtd/mtd_blkdevs.c
mips-linux-ld: final link failed: Bad value
make[2]: *** [drivers/mtd/mtd_blkdevs.o] Error 1
make[1]: *** [drivers/mtd] Error 2
make: *** [drivers] Error 2
=====================================

has anybody faced similar problem?

Could you please help in resolving this?

Thanks in advance.

Regards,
Veerasena.


      Save all your chat conversations. Find them online at http://in.messenger.yahoo.com/webmessengerpromo.php
