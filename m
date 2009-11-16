Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 18:34:46 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:38792 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493790AbZKPRd5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 18:33:57 +0100
Received: by pzk35 with SMTP id 35so4597174pzk.22
        for <multiple recipients>; Mon, 16 Nov 2009 09:33:50 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=FU1l/o38myF/LbRRAxIJOYS1Ren4vHjbDp/q8x5blVk=;
        b=hChabFWBCREKGxUP/ZYwrPV5V7UsNLGvLOUAZ9Fs1+ODIEvME+eEE39JWqLVLL9ob8
         6dxeOnVWAWeCxlOYKf5DAS6LZOxqAsD4I4Dw0V0PbIgD75pQaDpWZ3jCA95wtRXzPeVm
         v4hp3Xqg2foPLCH3g8u5aYiN6PhhSYsGXXWHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LGElhHh0DMofT8X2eIUAsu0BS8+EGjkQT4+U4aQvVnyGiuXB3WQn+Fp3ZqUJFZ2dR3
         D0AzAiFuDo8G/PKLNLwyILdIAXlbxsc2q8BO/rcJuzEDl/vzZvpMb6GE3+T6p4zOsf2w
         2mIx+fQHrxAlAM1CwTGPb7caSSW9rt0P7Sajs=
Received: by 10.115.80.14 with SMTP id h14mr5499394wal.133.1258392830518;
        Mon, 16 Nov 2009 09:33:50 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1603406pzk.4.2009.11.16.09.33.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 09:33:50 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	yanh@lemote.com, huhb@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 2/3] MIPS: add basic options for CPUFreq support
Date:	Tue, 17 Nov 2009 01:32:58 +0800
Message-Id: <2baac080ae9d0abb943b44b0505a8759cdaa9a41.1258392631.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <824cd0205789fb1332079a4f3ff3bb0fb9f446e2.1258392631.git.wuzhangjin@gmail.com>
References: <cover.1258392326.git.wuzhangjin@gmail.com>
 <824cd0205789fb1332079a4f3ff3bb0fb9f446e2.1258392631.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258392631.git.wuzhangjin@gmail.com>
References: <cover.1258392631.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24932
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
index 0e4b510..bfe8c39 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2146,6 +2146,7 @@ config MMU
 
 config I8253
 	bool
+	select MIPS_EXTERNAL_TIMER
 
 config ZONE_DMA32
 	bool
@@ -2222,6 +2223,8 @@ source "kernel/power/Kconfig"
 
 endmenu
 
+source "arch/mips/kernel/cpufreq/Kconfig"
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/mips/kernel/cpufreq/Kconfig b/arch/mips/kernel/cpufreq/Kconfig
new file mode 100644
index 0000000..37983a1
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
+	depends on CPU_SUPPORTS_CPUFREQ && MIPS_EXTERNAL_TIMER
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
