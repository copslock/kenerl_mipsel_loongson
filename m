Received:  by oss.sgi.com id <S305162AbQCCWm3>;
	Fri, 3 Mar 2000 14:42:29 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:10524 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305177AbQCCWmL>;
	Fri, 3 Mar 2000 14:42:11 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA11290; Fri, 3 Mar 2000 14:37:36 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA78690; Fri, 3 Mar 2000 14:40:25 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA75485
	for linux-list;
	Fri, 3 Mar 2000 14:27:45 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA80047
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Mar 2000 14:27:42 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05420
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Mar 2000 14:27:42 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA01272
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Mar 2000 14:27:36 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA22073
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Mar 2000 14:27:34 -0800 (PST)
Message-ID: <020901bf8560$1143e4c0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>
Subject: R5xxx Instability (Indy Crashes?) and CP0 Hazards
Date:   Fri, 3 Mar 2000 23:30:17 +0100
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

In a thread in this group some weeks ago, I suggested
that the problems observed with running Linux on R5K
Indys might be related to the fact that the TLB miss
handler did not respect the rules set out in the R5000
users' manual, specifically, that there be two integer instructions
between any modification of the EntryHi/EntryLo/PageMask
registers and a TLB Write operation.   The response of 
the old hands in the group was that this couldn't be a problem,
since IRIX didn't respect that rule, and IRIX empirically works.

Perhaps, but In the course of tormenting our various systems with 
"crashme",  we discovered that, while we could make crashme
run for unbounded  periods of time on our new MIPS "Jade" CPUs,
it would sieze up  in less than a minute on a QED R5260 running 
on the same hardware platform.  Logic analyser traces seemed to 
indicate  that it may have been a problem with TLB miss service where
the instruction causing the fault was a load/store using k0/k1 as 
a base register - something no sane program would do, of course. 

On a hunch, I modified the excep_vec0_nevada routine to insert
two nops between the mtc0 to EntryLo1 and the tlbwr. I also took 
out one of the nops between the tlbwr and the eret.  The documentation 
implies that none is necessary, but I note that the IRIX handler has 
a single nop, and  I didn't want to push my luck.  So there was a net 
addition of 1 nop.  Bingo.  The system is as stable as with a Jade.

Now, that's on an R5260, not an R5000, but from what the engineers 
at QED have told me, the CP0 design is the same for both families. 
I am for once checking this change directly into the SGI repository,
but only for the "Nevada" CPUs.  Someone with an R5000 Indy needs 
to repeat the experiment for the R5000, and check in the change if 
it helps there as well.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
