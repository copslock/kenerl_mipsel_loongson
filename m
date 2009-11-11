Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 06:59:52 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:45478 "EHLO
	mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492198AbZKKF7p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 06:59:45 +0100
Received: by gxk2 with SMTP id 2so712266gxk.4
        for <multiple recipients>; Tue, 10 Nov 2009 21:59:39 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Q/6z0v98/tTrwVuVRLiL07ybba07XOrbrQzdB2nc/NI=;
        b=G+dekungEbxmZy5DUXwKQpAik3u5i7dNLI6Kf0HOs0+bF3qc13SiNkugwojh6vN0OR
         Hi5ZWDrSy0TxE2d2sFVY4DuWWR9Z2GXGt7eMp+vqc872mdDa+zFQFjJc7zcFn0C3cG/l
         DFxX/c3nVdRynnXa3TCavChrxYSHyQk7UDjIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V5I1GhwDTUyrueojR9iEsrQW2aziXrhqcmvGK/aRDOETheNdu1sVih1TwVA1XyCEgq
         ax5pH0ajNP2Y5kZo42IPQxmL50HQ13YJXCtwHbftXMYjg94u6YegPizk5r+DjYCHJWYV
         XcFq+Gep//m7Cxj8FMrP32PK3LTc0Z1p3z4Yc=
Received: by 10.91.50.29 with SMTP id c29mr1705171agk.63.1257919179039;
        Tue, 10 Nov 2009 21:59:39 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 34sm703043yxf.11.2009.11.10.21.59.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 21:59:38 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 1/2] [loongson] 2f: Add CPU_SUPPORT_VIDEO_ACC
Date:	Wed, 11 Nov 2009 13:59:23 +0800
Message-Id: <ff4228281d1e0fcadf2f34b922c2324d095fd938.1257918796.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257918796.git.wuzhangjin@gmail.com>
References: <cover.1257918796.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257918796.git.wuzhangjin@gmail.com>
References: <cover.1257918796.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Loongson2f support video acceleration.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 539c384..2e39609 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1318,6 +1318,9 @@ config CPU_LOONGSON2
 config SYS_HAS_CPU_LOONGSON2E
 	bool
 
+config CPU_SUPPORT_VIDEO_ACC
+	bool
+
 config CPU_SUPPORT_CPUFREQ
 	bool
 
@@ -1328,6 +1331,7 @@ config SYS_HAS_CPU_LOONGSON2F
 	bool
 	select CPU_SUPPORT_CPUFREQ
 	select CPU_SUPPORT_ADDRWINCFG if 64BIT
+	select CPU_SUPPORT_VIDEO_ACC
 
 config SYS_HAS_CPU_MIPS32_R1
 	bool
-- 
1.6.2.1
