Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 08:11:16 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:46482 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492473AbZKKHK3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 08:10:29 +0100
Received: by pwi15 with SMTP id 15so542123pwi.24
        for <multiple recipients>; Tue, 10 Nov 2009 23:10:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ExptP/rsoqSgkQIu5Fqal2K9LKwf7G1SDc3KhSO0e1E=;
        b=BQzoSRNA2Y2A9cSVNgQdOrRZRcgwdHw2ZNKJS7EAnPiSCLSf74B+XBckfhGInW/Cv4
         ih0ssxCmktDJlkcNZrWobFWxSzKvjX/htHsjh8mGssg1/oAg+Tsa53YT33tLkctWmrEU
         uw0MlbwCgV1vE3tAVdunUvcVf9h2b7Q2b9esg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f5o+rZjLfa3+O9AsQOtSoVhQnpb5pujDsE4ZWclKz+orjqlndfTL354RnN6PR+IlmS
         VkapsfxL8TEB8R2DZ/4zfy1y6pMxbdsRTqNfx3bkqjVjsjMdDaqcmq0BYRdr/S2jWEmr
         kRj0+3a8BF1h3UGAYUN78sNmTB7zvh1/cO+so=
Received: by 10.114.237.18 with SMTP id k18mr2476819wah.63.1257923423151;
        Tue, 10 Nov 2009 23:10:23 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm830254pzk.7.2009.11.10.23.10.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 23:10:22 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>, yanh@lemote.com,
	huhb@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 2/3] MIPS: add basic options for CPUFreq support
Date:	Wed, 11 Nov 2009 15:09:58 +0800
Message-Id: <f5f863b7d2bf8f739db134afa12c7b6c2bf7d256.1257923011.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <de82733902e9549883b840f082a67b9edaa32c45.1257923011.git.wuzhangjin@gmail.com>
References: <cover.1257923011.git.wuzhangjin@gmail.com>
 <de82733902e9549883b840f082a67b9edaa32c45.1257923011.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257923011.git.wuzhangjin@gmail.com>
References: <cover.1257923011.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch adds basic options for MIPS CPUFreq support.

Since MIPS Timer's frequency is relative to the processor's frequency,
So, MIPS CPUFreq support not only need the processor's CPUFreq support
but also need an external timer. otherwise, we will make the system time
"mussy".

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig                |    3 +++
 arch/mips/kernel/cpufreq/Kconfig |   27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/cpufreq/Kconfig

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2e39609..2228e5a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2127,6 +2127,7 @@ config MMU
 
 config I8253
 	bool
+	select MIPS_EXTERNAL_TIMER
 
 config ZONE_DMA32
 	bool
@@ -2203,6 +2204,8 @@ source "kernel/power/Kconfig"
 
 endmenu
 
+source "arch/mips/kernel/cpufreq/Kconfig"
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/mips/kernel/cpufreq/Kconfig b/arch/mips/kernel/cpufreq/Kconfig
new file mode 100644
index 0000000..3969661
--- /dev/null
+++ b/arch/mips/kernel/cpufreq/Kconfig
@@ -0,0 +1,27 @@
+#
+# CPU Frequency scaling
+#
+
+config MIPS_EXTERNAL_TIMER
+	bool
+
+config MIPS_CPUFREQ
+	bool
+	default y
+	depends on CPU_SUPPORT_CPUFREQ && MIPS_EXTERNAL_TIMER
+
+if MIPS_CPUFREQ
+
+menu "CPU Frequency scaling"
+
+source "drivers/cpufreq/Kconfig"
+
+if CPU_FREQ
+
+comment "CPUFreq processor drivers"
+
+endif	# CPU_FREQ
+
+endmenu
+
+endif	# MIPS_CPUFREQ
-- 
1.6.2.1
