Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2003 06:00:31 +0000 (GMT)
Received: from rj.sgi.com ([IPv6:::ffff:192.82.208.96]:52629 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8224939AbTBMGAa>;
	Thu, 13 Feb 2003 06:00:30 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1D40ZG8014388;
	Wed, 12 Feb 2003 20:00:37 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id RAA24802; Thu, 13 Feb 2003 17:00:22 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1D60J8G013130;
	Thu, 13 Feb 2003 17:00:19 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1D60HOc013128;
	Thu, 13 Feb 2003 17:00:17 +1100
Date: Thu, 13 Feb 2003 17:00:17 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Linux-MIPS <linux-mips@linux-mips.org>
Cc: ralf@linux-mips.org, mg@sgi.com, gnb@sgi.com
Subject: [patch] ip27's _flush_cache_all uninitialized
Message-ID: <20030213060017.GL8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

_flush_cache_all() and ___flush_cache_all() were uninitialized
(i.e. NULL).  Someone probably assumed (incorrectly) that this
was ok, since flush_cache_all() doesn't use _flush_cache_all()
(or so they thought...).

End result: anything that called flush_cache_all() (a macro)
tried to call a function at 0x0, and died.  This includes vmalloc().

I'm not sure what the best solution is, but this makes things work:

--- arch/mips64/mm/c-andes.c	9 Feb 2003 22:03:23 -0000	1.1.2.2
+++ arch/mips64/mm/c-andes.c	13 Feb 2003 05:50:54 -0000
@@ -48,6 +48,12 @@
 	}
 }
 
+static void andes_flush_cache_all(void)
+{
+	andes_flush_cache_l1();
+	andes_flush_cache_l2();
+}
+
 void andes_flush_icache_page(unsigned long page)
 {
 	if (scache_lsz64)
@@ -80,6 +86,7 @@
 	_clear_page = andes_clear_page;
 	_copy_page = andes_copy_page;
 
+	_flush_cache_all = ___flush_cache_all = andes_flush_cache_all;
 	_flush_cache_l1 = andes_flush_cache_l1;
 	_flush_cache_l2 = andes_flush_cache_l2;
 	_flush_cache_sigtramp = andes_flush_cache_sigtramp;


Cheers,
Andrew
