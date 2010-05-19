Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 03:12:44 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:53011 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492254Ab0ESBMj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 03:12:39 +0200
Received: by pvg13 with SMTP id 13so966706pvg.36
        for <multiple recipients>; Tue, 18 May 2010 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sxXSiwZQkBMucaslxHQrAlFQFsNh1ioQqhkDtL7oGZs=;
        b=TR5WcovF3AUVhkrzMap3jT6D/nVxZxMaFDkTGokr9NHmHO+hb0b1aNyktCi3Eu9VIK
         +MpXi5KP1H8QRnKb6WwdCt2rC2ChZJjVnR4dLjNGZy9TLo7BAgZiVwkPAqEKvJSFPW/B
         YQcd9pYtBrmrCFfob+7qEY4y/1lJaCirKJF4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QC9wKyiiY3Gdm1oSAZ9TgCOzVX39q9y4tNJDCGkG1oiZcIf6utIeSw6f1KHIygeCMf
         dfiWr/t58zz3a9siabpYw1MClcGIdM3dz8oqerNGzkQdQ67IaJwLIsd7DzBRv754GrH7
         TRFxJElkbsbGMfViu+h96O/7uniheLI6w5Hd0=
Received: by 10.141.107.11 with SMTP id j11mr5654279rvm.199.1274231550409;
        Tue, 18 May 2010 18:12:30 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b2sm75156rvn.7.2010.05.18.18.12.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 May 2010 18:12:29 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Zhang Le <r0bertz@gentoo.org>,
        loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>,
        Hu Hongbing <huhb@lemote.com>
Subject: [PATCH] Loongson: cs5536: add missing 'rdmsr's for ide and usb
Date:   Wed, 19 May 2010 09:12:17 +0800
Message-Id: <f75f871c4cb08e9a6655d2cea4aa4a5b439af25c.1274231248.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Several 'rdmsr's for ide and usb are missing, this patch adds them to
avoid the agressive modification of the high 32bit of the msr.

Without this patch, some usb devices may not work after printing "reset
ehci host ....." when they are reading the partition information.

Signed-off-by: Hu Hongbing <huhb@lemote.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/cs5536/cs5536_ehci.c |    2 ++
 arch/mips/loongson/common/cs5536/cs5536_ide.c  |   14 +++++++++++++-
 arch/mips/loongson/common/cs5536/cs5536_ohci.c |    2 ++
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/common/cs5536/cs5536_ehci.c b/arch/mips/loongson/common/cs5536/cs5536_ehci.c
index eaf8b86..5b5cbba 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_ehci.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_ehci.c
@@ -49,6 +49,8 @@ void pci_ehci_write_reg(int reg, u32 value)
 			lo |= SOFT_BAR_EHCI_FLAG;
 			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
 		} else if ((value & 0x01) == 0x00) {
+			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+			lo = value;
 			_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
 
 			value &= 0xfffffff0;
diff --git a/arch/mips/loongson/common/cs5536/cs5536_ide.c b/arch/mips/loongson/common/cs5536/cs5536_ide.c
index 9a96b56..7ebf17a 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_ide.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_ide.c
@@ -51,6 +51,7 @@ void pci_ide_write_reg(int reg, u32 value)
 			lo |= SOFT_BAR_IDE_FLAG;
 			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
 		} else if (value & 0x01) {
+			_rdmsr(IDE_MSR_REG(IDE_IO_BAR), &hi, &lo);
 			lo = (value & 0xfffffff0) | 0x1;
 			_wrmsr(IDE_MSR_REG(IDE_IO_BAR), hi, lo);
 
@@ -65,19 +66,30 @@ void pci_ide_write_reg(int reg, u32 value)
 			_rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
 			lo |= 0x01;
 			_wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
-		} else
+		} else {
+			_rdmsr(IDE_MSR_REG(IDE_CFG), &hi, &lo);
+			lo = value;
 			_wrmsr(IDE_MSR_REG(IDE_CFG), hi, lo);
+		}
 		break;
 	case PCI_IDE_DTC_REG:
+		_rdmsr(IDE_MSR_REG(IDE_DTC), &hi, &lo);
+		lo = value;
 		_wrmsr(IDE_MSR_REG(IDE_DTC), hi, lo);
 		break;
 	case PCI_IDE_CAST_REG:
+		_rdmsr(IDE_MSR_REG(IDE_CAST), &hi, &lo);
+		lo = value;
 		_wrmsr(IDE_MSR_REG(IDE_CAST), hi, lo);
 		break;
 	case PCI_IDE_ETC_REG:
+		_rdmsr(IDE_MSR_REG(IDE_ETC), &hi, &lo);
+		lo = value;
 		_wrmsr(IDE_MSR_REG(IDE_ETC), hi, lo);
 		break;
 	case PCI_IDE_PM_REG:
+		_rdmsr(IDE_MSR_REG(IDE_INTERNAL_PM), &hi, &lo);
+		lo = value;
 		_wrmsr(IDE_MSR_REG(IDE_INTERNAL_PM), hi, lo);
 		break;
 	default:
diff --git a/arch/mips/loongson/common/cs5536/cs5536_ohci.c b/arch/mips/loongson/common/cs5536/cs5536_ohci.c
index db5900a..bdedf51 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_ohci.c
@@ -49,6 +49,8 @@ void pci_ohci_write_reg(int reg, u32 value)
 			lo |= SOFT_BAR_OHCI_FLAG;
 			_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
 		} else if ((value & 0x01) == 0x00) {
+			_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+			lo = value;
 			_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
 
 			value &= 0xfffffff0;
-- 
1.7.0.4
