Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2003 08:15:37 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:21897 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225197AbTCNIPg>;
	Fri, 14 Mar 2003 08:15:36 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h2E8FJUe017662;
	Fri, 14 Mar 2003 00:15:19 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA20692;
	Fri, 14 Mar 2003 00:15:19 -0800 (PST)
Message-ID: <001301c2ea02$d27a9bc0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Wayne Gowcher" <wgowcher@yahoo.com>, <linux-mips@linux-mips.org>
References: <20030314021308.60082.qmail@web11905.mail.yahoo.com>
Subject: Re: Tips on inspecting / debuging cache
Date: Fri, 14 Mar 2003 09:22:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> I am wondering if someone could point me towards
> articles / source code that would give me a little
> insight into how to debug cache problems in mips.
> 
> For example , how do I inspect the contents of the
> cache ? 

Which MIPS CPU are you using?  The CACHE instruction
was introduced with the R4000 CPU as an implementation
dependent feature, and was finally standardized in the MIPS32
and MIPS64 architecture specs.  See
http://www.mips.com/publications/processor_architecture.html
In MIPS32, to be able to properly inspect the cache, one needs
a CPU which implements the optional Index_Load_Tag CACHE 
operation and has both TagHi/TagLo (required) DataHi/DataLo 
(optional) registers. Pre-MIPS32 CPUs may offer the ability
to inspect the cache with variant mechanisms (see your chip
spec), or not at all.

>Are there routines to dump out the contents of
> the cache ?

People write them from time to time, but so far I don't
think anyone has written a "standard" cache dump API
or implementation in the Linux kernel.

            Kevin K.
