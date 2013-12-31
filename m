Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Dec 2013 23:59:38 +0100 (CET)
Received: from mail-we0-f174.google.com ([74.125.82.174]:34724 "EHLO
        mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822668Ab3LaW7fK4y90 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Dec 2013 23:59:35 +0100
Received: by mail-we0-f174.google.com with SMTP id q58so11284005wes.19
        for <linux-mips@linux-mips.org>; Tue, 31 Dec 2013 14:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=KuzGcwZDhnKsPn7GMqzE3G15qaz2fAD7pTHvDURn3ms=;
        b=KSEnuc3JNV0nxFUnaPDR+cuoBIYbH13X7ljq70gQdoF1tOE3LPHAWwI+PfZZXWkTaN
         tobUzovK6SjZozfMINej9Of1ECeUzKka2H/O3Cn2CRrpYIlzRBBjBTP8HY/DqbjsWWqR
         KIh61CBZsCyq3M5CpTEO8DDQ2YmK3yPCn/yS7e5XbeAzA8rUQgx5cpX0pGY6KvmoCxSa
         FcLSZrTVlZkHJxB2Py6VIR3xST5lF0BXIA2edJaD1I2Lm+wITXp21DpYK987yn/JnaMq
         uYFfip+Jl96YXGYNLeWAmAV2nNWHEMwF6vEaW1u1MpFhjeDEZDRN77ik2CTM/2bZ0n4L
         QJtA==
X-Gm-Message-State: ALoCoQmKoAfqd6m/L5/Nad3ys9b4Pb1Iod4ejAL3S4w0/+tg/rLQ2KLtgNtnNiU+kT27QXz060tL
X-Received: by 10.180.91.11 with SMTP id ca11mr49359452wib.39.1388530769436;
        Tue, 31 Dec 2013 14:59:29 -0800 (PST)
Received: from sylph (94.197.121.8.threembb.co.uk. [94.197.121.8])
        by mx.google.com with ESMTPSA id bc5sm74618956wib.4.2013.12.31.14.59.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2013 14:59:28 -0800 (PST)
Date:   Tue, 31 Dec 2013 22:59:22 +0000
From:   Robert Graffham <psquid@psquid.net>
To:     linux-kernel@vger.kernel.org
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org,
        linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [PATCH] Slightly outdated CONFIG_SMP documentation fix
Message-ID: <20131231225921.GA1624@sylph>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <psquid@psquid.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: psquid@psquid.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

I've removed a reference to "most personal computers" being singleprocessor
machines in multiple arches' config help, and also brought the arch/arm spacing
for "singleprocessor" (vs. "single processor" used there originally) in line
with other arches that had that text.

The diff is included below, and cleanly applies and builds on my system. I have
not tested on other systems yet since a documentation fix shouldn't fail to
build inconsistently, but if that's no excuse, I'll be happy to test further
when I can.


diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/alpha/Kconfig linux/arch/alpha/Kconfig
--- linux-vanilla/arch/alpha/Kconfig	2013-12-22 18:03:11.881499508 +0000
+++ linux/arch/alpha/Kconfig	2013-12-22 17:58:31.448505765 +0000
@@ -539,8 +539,8 @@ config SMP
 	depends on ALPHA_SABLE || ALPHA_LYNX || ALPHA_RAWHIDE || ALPHA_DP264 || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_GENERIC || ALPHA_SHARK || ALPHA_MARVEL
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/arc/Kconfig linux/arch/arc/Kconfig
--- linux-vanilla/arch/arc/Kconfig	2013-12-22 18:03:11.933499507 +0000
+++ linux/arch/arc/Kconfig	2013-12-22 17:58:24.412505922 +0000
@@ -128,8 +128,8 @@ config SMP
 	default n
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 if SMP
 
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/arm/Kconfig linux/arch/arm/Kconfig
--- linux-vanilla/arch/arm/Kconfig	2013-12-22 18:03:11.956499506 +0000
+++ linux/arch/arm/Kconfig	2013-12-22 17:56:31.187508449 +0000
@@ -1435,14 +1435,14 @@ config SMP
 	depends on MMU || ARM_MPU
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
-	  you say Y here, the kernel will run on many, but not all, single
-	  processor machines. On a single processor machine, the kernel will
-	  run faster if you say N here.
+	  you say Y here, the kernel will run on many, but not all,
+	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  will run faster if you say N here.
 
 	  See also <file:Documentation/x86/i386/IO-APIC.txt>,
 	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/m32r/Kconfig linux/arch/m32r/Kconfig
--- linux-vanilla/arch/m32r/Kconfig	2013-12-22 18:03:13.100499481 +0000
+++ linux/arch/m32r/Kconfig	2013-12-22 17:58:27.485505854 +0000
@@ -277,8 +277,8 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-vanilla/arch/mips/Kconfig	2013-12-22 18:03:13.290499477 +0000
+++ linux/arch/mips/Kconfig	2013-12-22 17:58:28.576505829 +0000
@@ -2128,8 +2128,8 @@ config SMP
 	depends on SYS_SUPPORTS_SMP
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mn10300/Kconfig linux/arch/mn10300/Kconfig
--- linux-vanilla/arch/mn10300/Kconfig	2013-12-22 18:03:13.598499470 +0000
+++ linux/arch/mn10300/Kconfig	2013-12-22 17:58:26.460505877 +0000
@@ -184,8 +184,8 @@ config SMP
 	depends on MN10300_PROC_MN2WS0038 || MN10300_PROC_MN2WS0050
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/parisc/Kconfig linux/arch/parisc/Kconfig
--- linux-vanilla/arch/parisc/Kconfig	2013-12-22 18:03:13.682499468 +0000
+++ linux/arch/parisc/Kconfig	2013-12-22 17:57:38.097506956 +0000
@@ -229,8 +229,8 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/s390/Kconfig linux/arch/s390/Kconfig
--- linux-vanilla/arch/s390/Kconfig	2013-12-22 18:03:14.077499459 +0000
+++ linux/arch/s390/Kconfig	2013-12-22 17:58:29.631505806 +0000
@@ -332,8 +332,8 @@ config SMP
 	prompt "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/sh/Kconfig linux/arch/sh/Kconfig
--- linux-vanilla/arch/sh/Kconfig	2013-12-22 18:03:14.188499457 +0000
+++ linux/arch/sh/Kconfig	2013-12-22 17:58:25.470505899 +0000
@@ -714,8 +714,8 @@ config SMP
 	depends on SYS_SUPPORTS_SMP
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/x86/Kconfig linux/arch/x86/Kconfig
--- linux-vanilla/arch/x86/Kconfig	2013-12-22 18:03:14.584499448 +0000
+++ linux/arch/x86/Kconfig	2013-12-22 17:58:30.711505782 +0000
@@ -278,8 +278,8 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
Signed-off-by: Robert Graffham <psquid@psquid.net>
