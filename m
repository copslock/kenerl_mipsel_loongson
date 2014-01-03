Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 01:36:25 +0100 (CET)
Received: from mail-we0-f175.google.com ([74.125.82.175]:58845 "EHLO
        mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825710AbaACAgWdDVTh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 01:36:22 +0100
Received: by mail-we0-f175.google.com with SMTP id t60so12894068wes.20
        for <linux-mips@linux-mips.org>; Thu, 02 Jan 2014 16:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=P6z5gQEEj2uLxRyhHF6V8dDZZWO50zXPe5lSoVWw/tM=;
        b=ZlSENPgKu1LUfJ/W9vybAFbOXRTB4vvOgn+hcK6lgsmE88ejMwMd6n46xYdOKwrA1L
         kWQqVgtokzz7DygqbFc8+0Vd98ENTl4HyEVjhnPM6yAACWdV/K8n8nc56MSsQcD15gpP
         fDQr4Flo9gBfoDmOV8i9JER15/FdgNOoS7+kyUF4t1wsIl1tdgv9am9A2Dksuh7fqXky
         ZXy1diHhL6uJg+PvSZFwuem2xRpUbNrPc3hN3bK9+V6Ru7fCy01HiBLqtJDlXfGRfp8r
         Uk3dzYPd5gAbaZH4dIkjc+P8HVO2Ek1M7K8LgfA322db32dX+SvVqenk9Vj2fZD5S6Mk
         cIVw==
X-Gm-Message-State: ALoCoQlPOlDTXl3NM068pLcC32JMfihPRzfCkBjNylTSsElPwkMgTvkoKKe/4ckA58tbSaulxNkX
X-Received: by 10.180.76.103 with SMTP id j7mr34537960wiw.58.1388709376841;
        Thu, 02 Jan 2014 16:36:16 -0800 (PST)
Received: from sylph (94.197.120.76.threembb.co.uk. [94.197.120.76])
        by mx.google.com with ESMTPSA id a9sm72754251wiy.10.2014.01.02.16.36.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2014 16:36:16 -0800 (PST)
Date:   Fri, 3 Jan 2014 00:36:11 +0000
From:   Robert Graffham <psquid@psquid.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, x86@kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        Hirokazu Takata <takata@linux-m32r.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-am33-list@redhat.com,
        linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-m32r@ml.linux-m32r.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Paul Mundt <lethal@linux-sh.org>,
        linux-arm-kernel@lists.infradead.org,
        Matt Turner <mattst88@gmail.com>, linux390@de.ibm.com,
        Russell King <linux@arm.linux.org.uk>,
        linux-m32r-ja@ml.linux-m32r.org
Subject: Re: [PATCH] Slightly outdated CONFIG_SMP documentation fix
Message-ID: <20140103003610.GA21711@sylph>
References: <20131231225921.GA1624@sylph>
 <23596.1388674589@warthog.procyon.org.uk>
 <20140102150219.3df32a23cf7dbe9618ea118e@linux-foundation.org>
 <CAAJfVc7vK9W9Zy0LvGWSTWMSEb_JEx7FbLECy44QEwj+CWgSGg@mail.gmail.com>
 <20140102151547.fde4aa5855cc75e91fea95e5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140102151547.fde4aa5855cc75e91fea95e5@linux-foundation.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <psquid@psquid.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38855
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

As requested, I've modified "singleprocessor" to "uniprocessor" in my tree, and
the revised patch is included below (with the Signed-off-by at the right end
this time - thanks Andrew).

To re-summarize given the new revision, this patch now removes an outdated
reference to "most personal computers" having only one CPU, and changes the use
of "singleprocessor" and "single processor" in CONFIG_SMP's documentation to
"uniprocessor" across all arches where that documentation is present.

Signed-off-by: Robert Graffham <psquid@psquid.net>

diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/alpha/Kconfig linux/arch/alpha/Kconfig
--- linux-vanilla/arch/alpha/Kconfig	2013-12-22 18:03:11.881499508 +0000
+++ linux/arch/alpha/Kconfig	2014-01-03 00:20:04.660530554 +0000
@@ -539,13 +539,13 @@ config SMP
 	depends on ALPHA_SABLE || ALPHA_LYNX || ALPHA_RAWHIDE || ALPHA_DP264 || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_GENERIC || ALPHA_SHARK || ALPHA_MARVEL
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  See also the SMP-HOWTO available at
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
+++ linux/arch/arm/Kconfig	2014-01-03 00:18:04.776533229 +0000
@@ -1435,14 +1435,14 @@ config SMP
 	depends on MMU || ARM_MPU
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
-	  you say Y here, the kernel will run on many, but not all, single
-	  processor machines. On a single processor machine, the kernel will
-	  run faster if you say N here.
+	  you say Y here, the kernel will run on many, but not all,
+	  uniprocessor machines. On a uniprocessor machine, the kernel
+	  will run faster if you say N here.
 
 	  See also <file:Documentation/x86/i386/IO-APIC.txt>,
 	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/m32r/Kconfig linux/arch/m32r/Kconfig
--- linux-vanilla/arch/m32r/Kconfig	2013-12-22 18:03:13.100499481 +0000
+++ linux/arch/m32r/Kconfig	2014-01-03 00:19:05.746531868 +0000
@@ -277,13 +277,13 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  People using multiprocessor machines who say Y here should also say
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-vanilla/arch/mips/Kconfig	2013-12-22 18:03:13.290499477 +0000
+++ linux/arch/mips/Kconfig	2014-01-03 00:19:16.904531619 +0000
@@ -2128,13 +2128,13 @@ config SMP
 	depends on SYS_SUPPORTS_SMP
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  People using multiprocessor machines who say Y here should also say
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mn10300/Kconfig linux/arch/mn10300/Kconfig
--- linux-vanilla/arch/mn10300/Kconfig	2013-12-22 18:03:13.598499470 +0000
+++ linux/arch/mn10300/Kconfig	2014-01-03 00:19:02.061531951 +0000
@@ -184,13 +184,13 @@ config SMP
 	depends on MN10300_PROC_MN2WS0038 || MN10300_PROC_MN2WS0050
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  See also <file:Documentation/x86/i386/IO-APIC.txt>,
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/parisc/Kconfig linux/arch/parisc/Kconfig
--- linux-vanilla/arch/parisc/Kconfig	2013-12-22 18:03:13.682499468 +0000
+++ linux/arch/parisc/Kconfig	2014-01-03 00:18:38.464532477 +0000
@@ -229,13 +229,13 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  See also <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/s390/Kconfig linux/arch/s390/Kconfig
--- linux-vanilla/arch/s390/Kconfig	2014-01-03 00:09:20.086544936 +0000
+++ linux/arch/s390/Kconfig	2014-01-03 00:19:59.831530662 +0000
@@ -334,10 +334,10 @@ config SMP
 	  a system with only one CPU, say N. If you have a system with more
 	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  See also the SMP-HOWTO available at
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/sh/Kconfig linux/arch/sh/Kconfig
--- linux-vanilla/arch/sh/Kconfig	2013-12-22 18:03:14.188499457 +0000
+++ linux/arch/sh/Kconfig	2014-01-03 00:18:58.090532039 +0000
@@ -714,13 +714,13 @@ config SMP
 	depends on SYS_SUPPORTS_SMP
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  People using multiprocessor machines who say Y here should also say
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/sparc/Kconfig linux/arch/sparc/Kconfig
--- linux-vanilla/arch/sparc/Kconfig	2013-12-22 18:03:14.368499453 +0000
+++ linux/arch/sparc/Kconfig	2014-01-03 00:19:50.073530879 +0000
@@ -152,10 +152,10 @@ config SMP
 	  a system with only one CPU, say N. If you have a system with more
 	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  People using multiprocessor machines who say Y here should also say
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/x86/Kconfig linux/arch/x86/Kconfig
--- linux-vanilla/arch/x86/Kconfig	2013-12-22 18:03:14.584499448 +0000
+++ linux/arch/x86/Kconfig	2014-01-03 00:20:02.957530592 +0000
@@ -278,13 +278,13 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  Note that if you say Y here and choose architecture "586" or
