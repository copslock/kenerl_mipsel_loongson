Received:  by oss.sgi.com id <S305159AbQCRMOw>;
	Sat, 18 Mar 2000 04:14:52 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:3651 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCRMOn>; Sat, 18 Mar 2000 04:14:43 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA05534; Sat, 18 Mar 2000 04:18:10 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA35179
	for linux-list;
	Sat, 18 Mar 2000 03:54:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA63786
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 18 Mar 2000 03:54:06 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA00202
	for <linux@cthulhu.engr.sgi.com>; Sat, 18 Mar 2000 03:54:06 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA29294;
	Sat, 18 Mar 2000 03:54:05 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA28114;
	Sat, 18 Mar 2000 03:54:02 -0800 (PST)
Message-ID: <005901bf90d1$269b2690$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>
Subject: Re: Include coherency problem, sigaction and otherwise
Date:   Sat, 18 Mar 2000 12:57:29 +0100
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

>> > > I have the impresson that the /usr/include stuff in the
>> > > "Hard Hat" distribution for MIPS is keyed to a 2.0.x kernel,
>> > > and that an update of /usr/include (as opposed to a downgrade
>> > > of the kernel headers) may be in order.
>> ...
>> >      As near as I can tell, at least for glibc-2.1.1-7, there
>> >is not machine-dependent <bits/sigaction.h> for mips, so the
>> >generic one is used, and the definitions are incompatible with the
>> >MIPS ABI.  The Linux kernel, on the other hand, is compatible with the
>> >MIPS ABI.  The cure is to supply a MIPS-specific <bits/sigaction.h>.
>>
>> It's worse than that - the "Hard Hat" 5.1 distribution that serves
>> as the reference userland for most SGI/MIPS/Linux platforms
>> doesn't even have a /usr/include/bits directory, which seems
>> to have been a more recent invention.
>
>The whole inconsistence was a stupid accident.  Since apparently only very
>little software was affected negativly (read: no known problems)  we didn't
>try to come up with some genious compatibility hacks but just fixed the
>definitions the hard way.

Having two independent sets of include files between kernel and userland
is always a bad idea, but is not *necessarily* broken, and sometimes
cannot be avoided.   The problem is not that the definitions are seperately
wired, but that they are incompatible - the risk one takes when one creates
multiple independent definitions.

>                                     Current glibc snapshots and Linuxkernels
have
>been fixed to use the same definitions.  If not, mail me a brown paperbag.

Certainly the hardhat-sgi-5.1-tar.gz archive on oss.sgi.com is out of sync
with any MIPS/Linux kernel sources of which I am aware.  The most recent
version of glibc 2.0 for MIPS that I have been able to find is 2.0.7, and it
too seems to be out of synch.  Which version of glibc has been fixed,
and where can I download it?   Which userland distribution is built with
the consistent glibc?

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
