Received:  by oss.sgi.com id <S305207AbQD1SBf>;
	Fri, 28 Apr 2000 11:01:35 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:61787 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305202AbQD1SBS>;
	Fri, 28 Apr 2000 11:01:18 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA13698; Fri, 28 Apr 2000 10:56:32 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA29273
	for linux-list;
	Fri, 28 Apr 2000 10:31:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA56430
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Apr 2000 10:31:56 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA08652
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 10:31:53 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id KAA15916
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 10:31:50 -0700 (PDT)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA08291
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 10:31:48 -0700 (PDT)
Message-ID: <008a01bfb137$ec2c3120$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>
Subject: Merge of MIPS 2.2 kernel enhancements for FPU emulation, etc.
Date:   Fri, 28 Apr 2000 19:33:46 +0200
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

OK folks, here's the deal.   As some of you will have noticed, 
I checked the FPU emulation machinery of for the MIPS 2.2 
kernel into the oss.sgi.com repository earlier this week.  Since 
then, I've been working on merging in the changes to the other 
kernel modules (most importantly traps.c, but a number of others)
necessary to integrate it into the kernel.   I had hoped to keep it 
to a subset of the mods and fixes we've made at MIPS, but as is 
often the case,  there are chains of interdependency.  I cannot spare 
the time to re-engineer everything to isolate the FP emulation support.
In particular, I'm not going to back-out the changes that were made
to eliminate the (intrinsically unsafe) use of bitfields for instruction
decoding.
  
So, here's the deal.  Either I will merge the totality of our mods into 
the 2.2 repository, or I will leave things as they are now, and leave it 
to others to re-implement what we did at MIPS (and which can be 
ownloaded from ftp://ftp.mips.com/pub/linux/kernel ).   My inclination
is to check the stuff in and get it over with, but this *will* create some 
differences with the 2.3 tree that might confuse some people.   It will
also be the case that there I cannot test all known configurations - 
indeed, as far as SGI boxes go, I can only test on an Indy - and risk 
leaving some minor problems to be cleaned up by someone else with 
the appropriate platform.  So it those sorts of prospects scare you, 
speak up now.

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
