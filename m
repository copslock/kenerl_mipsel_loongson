Received:  by oss.sgi.com id <S305158AbQCIKjS>;
	Thu, 9 Mar 2000 02:39:18 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:4668 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQCIKiu>;
	Thu, 9 Mar 2000 02:38:50 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA17652; Thu, 9 Mar 2000 02:34:13 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA99357
	for linux-list;
	Thu, 9 Mar 2000 02:00:33 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA37705
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Mar 2000 02:00:14 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06693
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Mar 2000 02:00:13 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA19318;
	Thu, 9 Mar 2000 02:00:08 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA20589;
	Thu, 9 Mar 2000 02:00:03 -0800 (PST)
Message-ID: <007701bf89ae$ae3d9710$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Dominic Sweetman" <dom@algor.co.uk>
Cc:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
Subject: R39xx and Processor IDs (was Re: FP emulation patch available)
Date:   Thu, 9 Mar 2000 11:03:04 +0100
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

>> If Philips/Tosh are really aliasing the PrID of the R4650, sombody
>> has done something Deeply Evil (and probably in violation of one
>> agreement or another).  I'm checking with MIPS HQ on this, and
>> hoping that in fact the R4650 value in the source code is in error.
>
>The R3900 should be 34 (decimal).  We don't have a record of the
>R4640/4650, which must surely be the same as each other.

The collision is real.  As has been noted elsewhere in this thread,
the R4640/4650 has no business running Linux, as it lacks a
page-based MMU.  I had a bit of "cognative dissonance" when
I did the conversion to the C-based system, but I left it in, figuring
it was better to preserve partial support than to eliminate all trace
of it.   But I think it could be argued that the R3900 characteristics
should go into the table in place of those for the R4650 (which 
are anyway wrong bacause they indicate that there is a TLB).
Those characteristics should be essentially the same as those
for the R3000A.

>Probably not.  But this is a good chance to ride a favourite hobby
>horse... 
>
>But I think code should *never* read the PRId value.
>
>It often doesn't change when the chip does, and often changes when the
>chip doesn't.  There's no guarantee that it marks the difference you
>care about, and if it does now there's no guarantee it will do so
>tomorrow.  Chip companies change it (or don't) for marketing reasons
>more often than technical ones.
>
>Instead, software should contain probes for individual attributes.
>Want to know whether you've got an R4000-style CP0?  Read the 'count'
>register and see is it counting.  Want to know how large the cache is?
>Easy to look for wraparound on an R3000; on an R4000, if you can't be
>bothered to do the rather elaborate code, use the Config register.
>Want to know whether the cache is 2-way set associative?  It usually
>doesn't matter, so remain in happy ignorance.  How big is the TLB?
>read and write to it and see when it wraps.  And so on.
>
>[Nobody will listen, probably rightly - I don't seem to have time to
> hack code any more...]


I quite sympthise with your frustration, and indeed the sloppy 
use of PrID by various MIPS licensees makes it impossible
to use *only* the PrID to determine things like cache size.  That
having been said, I don't see it as being practical to dynamically
probe for, say, the CP0 hazards to be respected in the TLB miss
handler.  Probing for the TLB size may not be as simple as you 
think: there's nothing that says that access to index N+1 is going
to *necessarily* wrap to 0 - that's an implementation detail.
Similarly, testing for the presence or absence of an FPU
*might* be as simple as setting the CU1 bit and seeing if
it can be read back, but I'm aware of at least one MIPS-based
design where there's a flip-flop there even without an FPU.
Sometimes one *does* care about the associativity of a
cache, as in the case where one wants to flush all possible
virtual aliases of an address.  Etc, etc.

The PrID has been horribly abused, and can not be treated as 
if it were a true architectural mechanism for distinguishing 
implementations, but it remains at minimum one of the tools 
available to the OS to determine where it is running. With the 
newer MIPS32 and MIPS64 CPUs, we have codified mechanisms 
for determining most of the information in the mips_cpu structure 
based on extended configuration information from the core. Most 
of the MIPS licensees have agreed to use this system for future 
designs.  But so long as Linux is going to be used on older CPUs, 
which will be for a  while, I fear we will be stuck with a mixture of 
PrID and heuristics.

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
