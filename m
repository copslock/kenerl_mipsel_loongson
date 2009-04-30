Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 16:49:09 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:51423 "EHLO
	mail-ew0-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026574AbZD3PtD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 16:49:03 +0100
Received: by ewy22 with SMTP id 22so2029649ewy.0
        for <multiple recipients>; Thu, 30 Apr 2009 08:48:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YQSoEGp3NbC1cPDckyGqHAV9DUjudCOHaUZy8KvrKAk=;
        b=MHjxBKAWvs8LRWLd/Iz8fcX1nEeRGZoVkwYUw9fa9PKfxUhovRPsU3bPXyciFS+MUo
         fIa/LPAL4FSZ+Ey2UBT7t10w1SVZn71wKks1YXw6ZTKnzXPawTEsMucuQz0sAfnkQB2k
         SX+qrvbcQ4y75p2b7sV3eD1rPfNKVbKyzyFC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=OY6h8hadk74FP5ZmgQBzCgd6aQYFIQ+cQCXxqa+a38nfKBZi+E9JZMh+35XGoI7N85
         TyU6EQh4z9xeD1QrDtEBWPiZvkwQDDja8pKudzNrer32DkJ5j9Kb5LefO5LSYDwMnAK/
         E0nK6Ed3oqIsfV+PAbahj9txgEe/vnOyAQnEI=
Received: by 10.210.139.15 with SMTP id m15mr6983515ebd.36.1241106536968;
        Thu, 30 Apr 2009 08:48:56 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm4141335eyh.20.2009.04.30.08.48.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 08:48:56 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 30 Apr 2009 17:48:51 +0200
Subject: [PATCH] flash_setup should only be built when CONFIG_MTD is enabled
MIME-Version: 1.0
X-UID:	110
X-Length: 3440
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904301748.52718.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Building flash_setup while CONFIG_MTD is not enabled does work, but
results in the following oops while booting:

Bootbus flash: Setting flash for 32MB flash at 0x1dc00000
Kernel bug detected[#1]:
Cpu 0
$ 0   : 0000000000000000 0000000000000010 000000000000003d 0000000000000002
$ 4   : 0000000000000001 0000000000000000 ffffffffffffffff 0000000000000d52
$ 8   : 0000000000000d52 000000000000003e 000000000000000a 0000000000000d17
$12   : 0000000000000031 ffffffff81105e2c 00000000f34c39b5 0000000017da5c01
$16   : ffffffff813ab588 ffffffff8138b514 0000000000000001 ffffffff814d2390
$20   : 0000000000000010 0000000000000010 0000000000000000 0000000000000000
$24   : 000000000931a549 ffffffff8110e68c
$28   : a800000007828000 a80000000782bf00 0000000000000000 ffffffff8138b594
Hi    : 0000000000000191
Lo    : 36978d4fdf254137
epc   : ffffffff8138b594 0xffffffff8138b594
    Not tainted
ra    : ffffffff8138b594 0xffffffff8138b594
Status: 10008ce3    KX SX UX KERNEL EXL IE
Cause : 00800024
PrId  : 000d0601 (Cavium Octeon)
Modules linked in:
Process swapper (pid: 1, threadinfo=a800000007828000, task=a800000007825540, tls=0000000000000000)
Stack : ffffffff813ab580 ffffffff8110d918 0000000007885780 ffffffff81385080
        ffffffff81385080 ffffffff8116ca10 3135310000000000 0000000000000000
        0000000000000098 ffffffff81360000 ffffffff81350000 ffffffff813ab588
        ffffffff813ab5d0 ffffffff81350000 ffffffff814d2390 ffffffff813862e8
        000000000000ffff 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 ffffffff81114f38 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
Call Trace:[<ffffffff8110d918>] 0xffffffff8110d918
[<ffffffff8116ca10>] 0xffffffff8116ca10
[<ffffffff813862e8>] 0xffffffff813862e8
[<ffffffff81114f38>] 0xffffffff81114f38

This patch makes flash_setup be compiled only when CONFIG_MTD
which solves issue, the MTD driver then fails to register but this is
less critical.

CC: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index d6903c3..32bdc81 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -10,9 +10,10 @@
 #
 
 obj-y := setup.o serial.o octeon-irq.o csrc-octeon.o
-obj-y += dma-octeon.o flash_setup.o
+obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
 
 obj-$(CONFIG_SMP)                     += smp.o
+obj-$(CONFIG_MTD)		+= flash_setup.o
 
 EXTRA_CFLAGS += -Werror
