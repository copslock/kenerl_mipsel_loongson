Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2011 03:31:51 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:33318 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491851Ab1BGCbs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Feb 2011 03:31:48 +0100
Received: by yxd30 with SMTP id 30so1618117yxd.36
        for <multiple recipients>; Sun, 06 Feb 2011 18:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=A+H0c80Ljkdhh6hKRHCd5xseh/v3LeAGVzpJS37j0Qk=;
        b=dDN9FkjyEo2rzcFAY3Se8JD+XPiiSeekpm+1V9Uf+V4xHRJFrB1FPM7/QWgWEx3wX1
         Y4ja3CCG+FMMWBMyFc+ze+fZxrHuuBKUDMMSmRxfkg8l4DyCGLYG5urb/5TOhGJOSi0+
         FzXRcDJaHwt+icWN/1gA5a3n3E8JB867qaHr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=S/6lvSUdEjbvou6d/AGZXnD0GlV1gVR9683ilLE+aAbn1eLK1dNxDah94JBN/KYQQd
         Z+FRgdR8JErKSemaqz45163Z/xqwLO74n9SUGE1zBTF15IEAIQC6Nlg5xjmvojGJAghE
         ITIBjpBFQIi1tOge8rY4ufae5ai3plPqVvAUc=
Received: by 10.236.109.131 with SMTP id s3mr28855637yhg.92.1297045902012;
        Sun, 06 Feb 2011 18:31:42 -0800 (PST)
Received: from stratos (sannin29007.nirai.ne.jp [203.160.29.7])
        by mx.google.com with ESMTPS id a11sm2515618yhd.36.2011.02.06.18.31.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 18:31:41 -0800 (PST)
Date:   Mon, 7 Feb 2011 11:31:36 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: fix always CONFIG_LOONGSON_UART_BASE=y
Message-Id: <20110207113136.2179ffc9.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.1.0beta7 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/loongson/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 6e1b77f..aca93ee 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -1,6 +1,7 @@
+if MACH_LOONGSON
+
 choice
 	prompt "Machine Type"
-	depends on MACH_LOONGSON
 
 config LEMOTE_FULOONG2E
 	bool "Lemote Fuloong(2e) mini-PC"
@@ -87,3 +88,5 @@ config LOONGSON_UART_BASE
 config LOONGSON_MC146818
 	bool
 	default n
+
+endif # MACH_LOONGSON
-- 
1.7.4
