Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 09:52:30 +0100 (CET)
Received: from mail-fx0-f217.google.com ([209.85.220.217]:36115 "EHLO
        mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491820Ab0CJIw1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Mar 2010 09:52:27 +0100
Received: by fxm9 with SMTP id 9so3602007fxm.24
        for <multiple recipients>; Wed, 10 Mar 2010 00:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:organization:to:cc:content-type
         :content-transfer-encoding:message-id;
        bh=PV7uJ48vU8yCv7q18E5A/ROfennsztzN3/r6Pejhmoc=;
        b=wS/8yxZ+yI0j/IKHpz9cMUxtUOV+MCKEPzIOEkNZEDbGI6tT5lewaMUUMnN84SJ4Uo
         7CKSUuLmuTAEO0w7+UQRlb2+LUGnPiiIpORvyvIbOpImuwv/Bl22lh/sF8bKv2JmGkKe
         mhROJUq+DHn5d0w87dUzKHBXrydCJe/aMl01Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:organization
         :to:cc:content-type:content-transfer-encoding:message-id;
        b=Bh813b7BXNgb9O7koiRYV2nfXM/TkXk7IYYDlv5wNgaExne+STA2A17INKwDZEU5AC
         JCX5EUfnbf0+4YOPu/XQ9X7SdYtH0Ai+kSrKlc/GvT+TA1n4++FKqWrZ49Knl7JyKnz5
         6fXEYrx8bix6PPEwNiDNY3PAy5SVaMT3qE7OQ=
Received: by 10.223.143.82 with SMTP id t18mr1121388fau.52.1268211140636;
        Wed, 10 Mar 2010 00:52:20 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 26sm12863247fks.22.2010.03.10.00.52.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 00:52:19 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Wed, 10 Mar 2010 09:51:09 +0100
Subject: [PATCH v2] MIPS: make CAC_ADDR and UNCAC_ADDR account for PHYS_OFFSET
MIME-Version: 1.0
X-UID:  24995
X-Length: 3378
Organization: OpenWrt
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, peter fuerst <post@pfrst.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003100951.10028.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

On AR7, we already redefine PHYS_OFFSET to match the system specifities, it is
however not sufficient when unsing dma_{map,unmap}_single, specifically in the
Ethernet driver, we must also adjust CAC_ADDR and UNCAC_ADDR for DMA to work
correctly. This patch fixes the following issue, seen in cpmac_open:

ops[#1]:
Cpu 0
$ 0   : 00000000 10008400 a0f5b120 00000000
$ 4   : 94c59000 94270f64 00000020 00000010
$ 8   : 00000010 94103ce0 0000000a 94c03400
$12   : ffffffff 94c03408 94c03410 00000001
$16   : a0f5ba20 00000041 94c592c0 94c59200
$20   : 94c59000 000005ee 00002000 9438c8f0
$24   : 00000010 00000000
$28   : 94fac000 94fadd58 94390000 942724a8
Hi    : 00000000
Lo    : 00000001
epc   : 94272518 cpmac_open+0x208/0x3f8
    Not tainted
ra    : 942724a8 cpmac_open+0x198/0x3f8
Status: 10008403    KERNEL EXL IE
Cause : 3080000c
BadVA : 00000000
PrId  : 00018448 (MIPS 4KEc)
Modules linked in:
Process ifconfig (pid: 278, threadinfo=94fac000, task=94e79590, tls=00000000)
Stack : 7f8da120 2ab05cb0 94c59000 943356f0 00000000 943d0000 94c59000 943356f0
        94c59030 943d0000 943c27c0 94fade10 00000000 94fade20 94c59000 9428e5a4
        00000000 94c59000 00000041 94289768 94c59000 00000041 00001002 00001043
        00000000 9428d810 00000000 94fade10 7f8da4e8 9428e6b8 00000000 7f8da4a8
        7f8da4e8 00008914 00000000 942f7f2c 00000000 00000008 00408000 00008913
        ...
Call Trace:
[<94272518>] cpmac_open+0x208/0x3f8
[<9428e5a4>] dev_open+0x164/0x264
[<9428d810>] dev_change_flags+0xd0/0x1bc
[<942f7f2c>] devinet_ioctl+0x2d8/0x908
[<942771f8>] sock_ioctl+0x29c/0x2fc
[<941a0fb4>] vfs_ioctl+0x2c/0x7c
[<941a16ec>] do_vfs_ioctl+0x5dc/0x630
[<941a1790>] sys_ioctl+0x50/0x88
[<94101e10>] stack_done+0x20/0x3c

Signed-off-by: peter fuerst <post@pfrst.de>
Signed-off-by: Regards, Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index ac32572..a16beaf 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -188,8 +188,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
-#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
+#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE + 	\
+								PHYS_OFFSET)
+#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET -	\
+								PHYS_OFFSET)
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
