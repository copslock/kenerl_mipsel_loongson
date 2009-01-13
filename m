Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 14:19:24 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.240]:59347 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S21103557AbZAMOTV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 14:19:21 +0000
Received: by an-out-0708.google.com with SMTP id d14so9075and.24
        for <linux-mips@linux-mips.org>; Tue, 13 Jan 2009 06:19:20 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=C5bvhM89DPdUKBaPz2AmWOuUXcCHy7DYDMEewyVhYm8=;
        b=eUWoijcJ5YWcA084UynLPd/OzpSJi1Hq4tId0LG8i3aYdmkyI/mJEdH90+AsPIpgAJ
         aU2oq2m9x+ktxgEjk3ICkbkof+OLqe+mGCEo2BfRMA+9JGGzNvYCNNaFl/Kf399EiFZ8
         GmptnsAArwV+mxDxhn5WZ4GTP+91XQW8n8+pE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=lUSoAmdW1yTyvK3hN+8lKsJqnlABHSagTEi+C8t9U4VRULFIpgIMdBtL2CFYBY7zJe
         6/bk+hiH6hjqpmDjmERhOO3ETseMvgBIUe2V8M+HnzDzpU9IInFczm40gMNZJ+5s4JGy
         PUCcopvNBzyIZHuXgJnE6k/yorVxyPAH/IEb8=
Received: by 10.100.232.10 with SMTP id e10mr16448230anh.36.1231856360284;
        Tue, 13 Jan 2009 06:19:20 -0800 (PST)
Received: from ?10.6.11.31? (cpmsq.epam.com [217.21.56.2])
        by mx.google.com with ESMTPS id b32sm8370136ana.34.2009.01.13.06.19.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jan 2009 06:19:19 -0800 (PST)
Subject: [PATCH] Added serial UART support for PNX833X devices.
From:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 13 Jan 2009 16:19:17 +0200
Message-Id: <1231856357.25974.23.camel@EPBYMINW0568>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.2 
Content-Transfer-Encoding: 7bit
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

Enabled serial UART driver for PNX833X devices.

Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
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
