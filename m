Received:  by oss.sgi.com id <S305160AbQDTRR7>;
	Thu, 20 Apr 2000 10:17:59 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:26140 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305157AbQDTRRu>;
	Thu, 20 Apr 2000 10:17:50 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA13322; Thu, 20 Apr 2000 10:13:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA59348; Thu, 20 Apr 2000 10:17:19 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA64541
	for linux-list;
	Thu, 20 Apr 2000 10:07:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA77275
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 10:07:33 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA07327
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 10:07:33 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id KAA11388;
	Thu, 20 Apr 2000 10:07:34 -0700 (PDT)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA18150;
	Thu, 20 Apr 2000 10:07:31 -0700 (PDT)
Message-ID: <012b01bfaaeb$27911800$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>
Cc:     <linux@cthulhu.engr.sgi.com>
Subject: Re: Should send SIGFPE to .*
Date:   Thu, 20 Apr 2000 19:09:07 +0200
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

>> if it was actually a problem), and as such the force_sig() should
>> use the value returned by compute_return_epc() as the signal
>
>I dont think compute_return_epc returns a signal value.

Oops.  You're right.  It returns -EFAULT.  And it handles
the signal propagation all by its lonesome, so nothing
further needs to be done if it failed.

>> I was going to make another cleanup pass over traps.c this
>> week, so it looks like you've found me another nit to excise.
>> (Although we've got the full-blown Algorithmics emulator
>> in our source base - coming soon to a repository near you -
>> we kept the old stuff around for people wanting to build for
>> a minimal footprint).
>
>How much is the full emulator as binary ?

About 47Kbytes, I'm afraid.


__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
