Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 03:44:42 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:17054 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225321AbULPDoh>; Thu, 16 Dec 2004 03:44:37 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.34 #1 (Debian))
	id 1CemZ0-00049T-3g; Wed, 15 Dec 2004 21:44:26 -0600
Message-ID: <41C105BB.9020402@realitydiluted.com>
Date: Wed, 15 Dec 2004 21:49:15 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Manish Lachwani <mlachwani@mvista.com>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH] Avoid compile warnings on Sibyte using 2.6.10-rc3
References: <20041215235632.GA11386@prometheus.mvista.com> <41C0FCFD.9010603@realitydiluted.com> <41C100CB.2070000@mvista.com>
In-Reply-To: <41C100CB.2070000@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------050304050001060503050205"
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050304050001060503050205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Manish Lachwani wrote:
> 
> When did you last sync with CVS?  There was a change introduced : 
>
Literally 10 minutes ago and I did a fresh compile.

> And if running Sibyte in UP mode, cpu_icache_snoops_remote_store is 
> redefined
> 
I do not run in UP mode, so that is why I did not see it. I suggest
a different version attached. How does that work for you?

-Steve


--------------050304050001060503050205
Content-Type: text/x-patch;
 name="cpu-feature-warn.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu-feature-warn.patch"

Index: cpu-features.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/cpu-features.h,v
retrieving revision 1.9
diff -u -r1.9 cpu-features.h
--- cpu-features.h	7 Dec 2004 02:08:34 -0000	1.9
+++ cpu-features.h	16 Dec 2004 03:42:03 -0000
@@ -87,13 +87,13 @@
  * that did the store so we can't optimize this into only doing the flush on
  * the local CPU.
  */
-#ifdef CONFIG_SMP
 #ifndef cpu_icache_snoops_remote_store
+#ifdef CONFIG_SMP
 #define cpu_icache_snoops_remote_store	(cpu_data[0].icache.flags & MIPS_IC_SNOOPS_REMOTE)
-#endif
 #else
 #define cpu_icache_snoops_remote_store	1
 #endif
+#endif
 
 /*
  * Certain CPUs may throw bizarre exceptions if not the whole cacheline

--------------050304050001060503050205--
