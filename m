Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 08:44:51 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:52162 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492134AbZIXGok (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2009 08:44:40 +0200
Received: by bwz4 with SMTP id 4so1132459bwz.0
        for <linux-mips@linux-mips.org>; Wed, 23 Sep 2009 23:44:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=56stehPIurl7gobcyKEvd4LAFzEyWCkelP9hYDNTHJQ=;
        b=FOPOG5Xe/A0z+ULO71P8nZPHU7xxsIqpYJtDwIN3yLOLoPVAhZQXwrbORTbXM3TfYb
         IBSpVixWKNH6rLXhUzjssBL/x9mA0jE2s3dY2HO5Bf+OBU5Z5/HRVy7maA88ItqX0VSg
         hIRGSkaRpA1JO0zPNY0pFtPjYQyR1JQaVYB4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=NXpDZhRiIjGluFydX8rJHXXa6pxawJakXDBuwp7Qkq474NPeNxo5FUzunN2TA9V1Ah
         bkpW2ZrEzzJ4Y6C6EmiIzOJN138iAptVIskbKmCMb1UikKhnOEZgd2ZqdaKvjsCpDqly
         QQ1R46Qcxmb4A34mgzJh8oSD9mY6xYwTy576M=
MIME-Version: 1.0
Received: by 10.223.24.87 with SMTP id u23mr1065249fab.81.1253774674718; Wed, 
	23 Sep 2009 23:44:34 -0700 (PDT)
Date:	Thu, 24 Sep 2009 08:44:34 +0200
Message-ID: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>
Subject: MIPS: Alchemy build broken in latest linus-git
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Sam!

Commit 51b563fc93c8cb5bff1d67a0a71c374e4a4ea049 breaks
Alchemy build in vmlinux.lds:


mipsel-softfloat-linux-gnu-gcc -E
-Wp,-MD,arch/mips/kernel/.vmlinux.lds.d  -nostdinc -isystem
/usr/lib/gcc/mipsel-softfloat-linux-gnu/4.3.4/include -Iinclude
-Iinclude2 -I/mnt/work/au1200/kernel/linux-2.6.git/include
-I/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/include -include
include/linux/autoconf.h -D__KERNEL__
-D"VMLINUX_LOAD_ADDRESS=0xffffffff80100000" -D"DATAOFFSET=0" -P -C
-Umips -D__ASSEMBLY__ -DLINKER_SCRIPT -o arch/mips/kernel/vmlinux.lds
/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/kernel/vmlinux.lds.S
In file included from
/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/kernel/vmlinux.lds.S:2:
/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/include/asm/page.h:12:20:
error: spaces.h: No such file or directory
make[2]: *** [arch/mips/kernel/vmlinux.lds] Error 1
make[1]: *** [arch/mips/kernel] Error 2
make: *** [sub-make] Error 2

I tracked it to this part in the commit:
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index c825b14..77f5021 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
[...]
-#
-# Choosing incompatible machines durings configuration will result in
-# error messages during linking.  Select a default linkscript if
-# none has been choosen above.
-#
-
-CPPFLAGS_vmlinux.lds := \
-       $(KBUILD_CFLAGS) \
-       -D"LOADADDR=$(load-y)" \
-       -D"JIFFIES=$(JIFFIES)" \
-       -D"DATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)"
-


This eliminates the a whole lot of include directives, among which is
"-Iarch/mips/include/asm/mach-generic" which provides a path to the
now-missing "spaces.h".

Is there a cheap way to add this back again?

For reference, here's the full compiler command for the previously-working
case:

mipsel-softfloat-linux-gnu-gcc -E
-Wp,-MD,arch/mips/kernel/.vmlinux.lds.d  -nostdinc -isystem
/usr/lib/gcc/mipsel-softfloat-linux-gnu/4.3.4/include -Iinclude
-Iinclude2 -I/mnt/work/au1200/kernel/linux-2.6.git/include
-I/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/include -include
include/linux/autoconf.h -D__KERNEL__ -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-Werror-implicit-function-declaration -Wno-format-security
-fno-delete-null-pointer-checks -O2 -ffunction-sections
-mno-check-zero-division -mabi=32 -G 0 -mno-abicalls -fno-pic -pipe
-msoft-float -ffreestanding -march=mips32 -Wa,-mips32 -Wa,--trap
-I/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/include/asm/mach-db1x00
  -I/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/include/asm/mach-au1x00
  -I/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/include/asm/mach-generic
-D"VMLINUX_LOAD_ADDRESS=0xffffffff80100000"
-D"LOADADDR=0xffffffff80100000" -D"JIFFIES=jiffies_64"
-D"DATAOFFSET=0" -P -C -Umips -D__ASSEMBLY__ -o
arch/mips/kernel/vmlinux.lds
/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/kernel/vmlinux.lds.S

Btw, I've been using bash-4 on my hosts since Gentoo added it to
their repos a few months ago, and I haven't noticed any breakages
so far.

Thanks!
        Manuel Lauss
