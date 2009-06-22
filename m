Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2009 11:18:26 +0200 (CEST)
Received: from mail-ew0-f221.google.com ([209.85.219.221]:50369 "EHLO
	mail-ew0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491959AbZFVJST (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Jun 2009 11:18:19 +0200
Received: by ewy21 with SMTP id 21so4020964ewy.0
        for <multiple recipients>; Mon, 22 Jun 2009 02:15:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OzpxYB2kbrPwqZ/5O0WjRGWtA/KOb8RMYO8oOvrr2Pw=;
        b=mCDaxWkPA69QatMP37zMbAJx6hX3qedvvITCjB4om5tBXTWFFYsmIurxtk6NgdBPUT
         bR2VFUlMBff2RWMB0QLP/Dlom49GTgNcPUbvQEG3DA2ibNyWpmoMFjty11Afqz/lsoQn
         chyiKfK7nom4+VLEAa/ybUtm8sunapYElJ0Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=FmWplLbToxg/ml9BgjEOnX+dc6conJ7kP5B3N+IKzA1Vn3U+KZvFSQxHzkyceFOfCL
         k+iDrZT4zS/H5PpTdZuqNwezJ3MERj0kdniLX6FhUFkwpe3I29FDPjvcxtwOPmXqncz4
         MQ4nozrkxrRMTltTdmd2jcSIpb0pfDWcBmdig=
Received: by 10.210.134.6 with SMTP id h6mr4572996ebd.58.1245662125592;
        Mon, 22 Jun 2009 02:15:25 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 23sm122922eya.29.2009.06.22.02.15.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 02:15:25 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 22 Jun 2009 11:15:23 +0200
Subject: [PATCH 1/2] octeon: flash_setup blows on !MTD_COMPLEX_MAPPINGS and !MTD_MAP_BANK_WIDTH_1
MIME-Version: 1.0
X-UID:	343
X-Length: 3706
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906221115.23628.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes the flash_setup code register the MTD physmap driver
only when MTD_COMPLEX_MAPPINGS and MTD_MAP_BANK_WIDTH_1 are set.
Otherwise, this would result in an oops while booting:

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

CC: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
index 008f657..894edbb 100644
--- a/arch/mips/cavium-octeon/flash_setup.c
+++ b/arch/mips/cavium-octeon/flash_setup.c
@@ -41,6 +41,7 @@ static int __init flash_init(void)
 	 */
 	union cvmx_mio_boot_reg_cfgx region_cfg;
 	region_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(0));
+#if defined (CONFIG_MTD_COMPLEX_MAPPINGS) && (CONFIG_MTD_MAP_BANK_WIDTH_1)
 	if (region_cfg.s.en) {
 		/*
 		 * The bootloader always takes the flash and sets its
@@ -78,6 +79,7 @@ static int __init flash_init(void)
 			pr_err("Failed to register MTD device for flash\n");
 		}
 	}
+#endif /* (CONFIG_MTD_COMPLEX_MAPPINGS) && (CONFIG_MTD_MAP_BANK_WIDTH_1) */
 	return 0;
 }
 
