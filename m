Received:  by oss.sgi.com id <S305166AbQBNVXK>;
	Mon, 14 Feb 2000 13:23:10 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:63321 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBNVWv>;
	Mon, 14 Feb 2000 13:22:51 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA00272; Mon, 14 Feb 2000 13:18:21 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA98388
	for linux-list;
	Mon, 14 Feb 2000 13:14:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA06082
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 14 Feb 2000 13:13:30 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA01322
	for <linux@cthulhu.engr.sgi.com>; Mon, 14 Feb 2000 13:13:30 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA19215;
	Mon, 14 Feb 2000 13:13:13 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA23690;
	Mon, 14 Feb 2000 13:13:09 -0800 (PST)
Message-ID: <022301bf7730$92b87180$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     <geert@linux-m68k.org>, "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
Subject: Re: Indy crashes
Date:   Mon, 14 Feb 2000 22:15:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>On Thu, 3 Feb 2000, Ralf Baechle wrote:
>> Today I exchanged the R5000 CPU module in my Indy against a R4600 module
>> and found that on R4600SC the kernel runs reliable while it crashs pretty
>> soon after booting on a R5000SC module.  This is consistent with the
>> reports that I've looked at.
>
>That could explain the crashes I see on the DDB Vrc-5074 as well, which has a
>NEC VR5000.
>
>I'll try to fix the bootmem stuff ASAP and upgrade to 2.3.38.


The problem may be in the assumption made even in the
most recent 2.3.x code that a hit-writeback-invalidate cache
operation on the secondary cache automagically affects the
primary.  That's the way it is on the R4000/4400, but that's
not the way the R5000 is specified.  So rather than set
dma_cache_wback_inv to r4k_dma_cache_wback_inv_sc
or r4k_dma_cache_wback_inv_pc, depending on the
presence or absence of a primary cache,  in the MIPS 
Technologies I bound it to a function:

static void
r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
{
        r4k_dma_cache_wback_inv_pc(addr, size);
        if(sc_present) r4k_dma_cache_wback_inv_sc(addr, size);
}

However, I have not had the opportunity to test this code on
an R5000SC platform.   Looking at the R5000 spec, it is a
little ambiguous.  The special case of sc HWIs affecting
the primary isn't there, but then again sc HWIs aren't even
called out in the table of defined cache operations.  Indeed,
one *could* interpret the spec to mean that HWI on the 
*primary* flushes the secondary, the reverse of the R4000,
but it's by no means clear.   Thus I suggest hitting 'em both.

Does anybody on this list have an R527x manual?   How
is HWI of the primary/seconday caches defined there?

            Regards,

            Kevin K.
