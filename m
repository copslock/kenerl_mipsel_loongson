Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2005 13:48:52 +0000 (GMT)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:52440 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8228896AbVCXNsf>; Thu, 24 Mar 2005 13:48:35 +0000
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2005032413482801400sfhuce>; Thu, 24 Mar 2005 13:48:28 +0000
Message-ID: <4242C54B.3010306@gentoo.org>
Date:	Thu, 24 Mar 2005 08:48:59 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Alex Gonzalez <alex.gonzalez@packetvision.com>,
	debian-mips@lists.debian.org
Subject: Re: ABI incompatibility when building util-linux
References: <1111663536.27220.32.camel@euskadi.packetvision> <20050324120109.GI8876@hattusa.textio>
In-Reply-To: <20050324120109.GI8876@hattusa.textio>
Content-Type: multipart/mixed;
 boundary="------------080301080206020304000809"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080301080206020304000809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thiemo Seufer wrote:
> 
> n32 means 64bit wide registers and 32bit address space. It runs only on
> a 64bit kernel.
> 

A bit off topic, but it reminded me nonetheless.  Anyone trying to build a new 
version of procpcs (>3.4.2) under mips64 will likely need this patch.

Unsure what the reasoning behind this bit was in procps, but it assumes that 
n32 is usable on a mips64 system (atleast, my understanding of the conditional 
is that), and thus defines KLONG to long long on mips64, which breaks 'ps' on 
these systems (you get a nice sigsev).

Thought it'd be useful to pass along.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond

--------------080301080206020304000809
Content-Type: text/plain;
 name="procps-mips-n32_isnt_usable_on_mips64_yet.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="procps-mips-n32_isnt_usable_on_mips64_yet.patch"

diff -Naurp procps-3.2.4.orig/proc/procps.h procps-3.2.4/proc/procps.h
--- procps-3.2.4.orig/proc/procps.h	2004-08-20 18:40:13 -0400
+++ procps-3.2.4/proc/procps.h	2005-02-28 10:38:05 -0500
@@ -31,7 +31,7 @@
 //
 // Unknown: PA-RISC and zSeries
 //
-#if defined(k64test) || defined(_ABIN32)
+#if defined(k64test)
 #define KLONG long long    // not typedef; want "unsigned KLONG" to work
 #define KLF "L"
 #define STRTOUKL strtoull

--------------080301080206020304000809--
