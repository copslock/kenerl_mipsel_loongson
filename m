Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 14:11:37 +0000 (GMT)
Received: from rn-out-0910.google.com ([64.233.170.188]:52675 "EHLO
	rn-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S21103605AbZAMOLf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 14:11:35 +0000
Received: by rn-out-0910.google.com with SMTP id j66so20405rne.9
        for <linux-mips@linux-mips.org>; Tue, 13 Jan 2009 06:11:33 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=X4GbO46qrS6uk9ZEjOme04B+9LMhfUo1JmE6HsrWghk=;
        b=cNR1UdxqQwkO7ZOniDwKMdDIWB6WFCjsszZasnYZoKz2DI8c19tL4iFot3nMymKU0x
         n3J4yc+PC3XYgWsaU3YLFbDZiuWxNsBswR/8pE5hst1IpV38oxVrnNxKSP889/oNft3X
         WOx8wppN19VMTYCApM50JTMpNTs6OVnY+TlGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=TZzeVMOBHLNlxiq5PpIT+MUzCe4Pqu0jL/E/tnbA7RdnCYpVV5r590pSnIhlwodZii
         HdXfqNlLeT+j45f3tmDFnaW2t9Us+7G9J+mYeDgT95i/MvIynpo9wtoh2MnBUICf28ea
         HgmN/dnjvge6dfHPZWZP0NZ0BlOtBL+CZV2jY=
Received: by 10.100.108.20 with SMTP id g20mr16437642anc.14.1231855893881;
        Tue, 13 Jan 2009 06:11:33 -0800 (PST)
Received: from ?10.6.11.31? (cpmsq.epam.com [217.21.56.2])
        by mx.google.com with ESMTPS id c9sm6653587ana.8.2009.01.13.06.11.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jan 2009 06:11:31 -0800 (PST)
Subject: [PATCH] Added serial UART support for PNX833X devices.
From:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 13 Jan 2009 16:11:26 +0200
Message-Id: <1231855886.25974.22.camel@EPBYMINW0568>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.2 
Content-Transfer-Encoding: 7bit
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

Enabled serial UART driver for PNX833X devices.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 3e525e3..7d7f576 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -982,7 +982,7 @@ config SERIAL_SH_SCI_CONSOLE
 
 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
-	depends on MIPS && SOC_PNX8550
+	depends on MIPS && (SOC_PNX8550 || SOC_PNX833X)
 	select SERIAL_CORE
 	help
 	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
-- 
1.5.6.3
