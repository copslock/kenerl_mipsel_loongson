Received:  by oss.sgi.com id <S305159AbQBPWqQ>;
	Wed, 16 Feb 2000 14:46:16 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:34410 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBPWpw>;
	Wed, 16 Feb 2000 14:45:52 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA29802; Wed, 16 Feb 2000 14:41:20 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA47921
	for linux-list;
	Wed, 16 Feb 2000 14:34:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA09461;
	Wed, 16 Feb 2000 14:34:09 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00314; Wed, 16 Feb 2000 14:34:12 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA13459;
	Wed, 16 Feb 2000 14:34:06 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA16552;
	Wed, 16 Feb 2000 14:34:03 -0800 (PST)
Message-ID: <00bf01bf78ce$37cf6cc0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
Cc:     <linux-mips@vger.rutgers.edu>, <linux-mips@fnet.fr>,
        <linux@cthulhu.engr.sgi.com>
Subject: Re: Indy crashes
Date:   Wed, 16 Feb 2000 23:33:33 +0100
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

>Emprirically, it appears that the [R5000] manual is incorrect in regard
>to the number of nop instructions.  The above sequences are known
>to work (via years of testing, and also via validation in discussions
>with people familiar with the hardware pipelines).

In principle, I could check it against the RTL, but I probably
won't bother.  Many thanks for sharing the IRIX disassembly!

> > Thirdly, this whole thread underscores why "clever" solutions that 
> > depend on implementation features of particular CPUs should 
> > be avoided whenever possible. If you want to be assured of
> > getting a delay cycle in a MIPS instruction stream, you should
> > use a "SSNOP", (sll r0,r0,1 as opposed to the "nop" sll r0,r0,0),
> > which forces delays even in superscalar implementations.
>
>      This is not realistic, given the number of workarounds required
>for various processors, unless you are willing to have most processors
>run quite a bit slower.  (Extra cycles in utlbmiss are noticeable.)


I agree that it is not realistic to hav a single binary TLB miss handler
for all possible MIPS CPUs, but that's not what I was getting at.
I just consider it unwise to use the fact that one "knows" that branches 
"always" delay three cycles to avoid hazards.  Such tricks are 
obscurantist, and lead, in my experience, to errors.

            Kevin K.
