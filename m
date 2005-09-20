Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 15:27:34 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:12679
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8224903AbVITO1M>; Tue, 20 Sep 2005 15:27:12 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j8KEQw6U004993;
	Tue, 20 Sep 2005 07:26:58 -0700 (PDT)
Received: from laptopuhler4 (laptop-uhler4.mips.com [192.168.2.3])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j8KEQs17013302;
	Tue, 20 Sep 2005 07:26:58 -0700 (PDT)
From:	"Michael Uhler" <uhler@mips.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>,
	"'Matej Kupljen'" <matej.kupljen@ultra.si>
Cc:	"'Maciej W. Rozycki'" <macro@linux-mips.org>,
	"'Daniel Jacobowitz'" <dan@debian.org>, <linux-mips@linux-mips.org>
Subject: RE: [PATCH] Fix TCP/UDP checksums on the Broadcom SB-1
Date:	Tue, 20 Sep 2005 07:26:54 -0700
Organization: MIPS Technologies, Inc.
Message-ID: <00da01c5bdef$596ee380$0502a8c0@MIPS.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
In-Reply-To: <20050920110609.GB3159@linux-mips.org>
X-Scanned-By: MIMEDefang 2.39
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

For what it's worth, the 64-bit architecture, both prior to and with MIPS64,
has always required that 64-bit GPRs be sign-extended when used with 32-bit
operations.  I'm surprised that this wasn't seen on more 64-bit CPUs than
just the SB1.


/gmu
---
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.   Email: uhler at mips.com
1225 Charleston Road      Voice:  (650)567-5025
Mountain View, CA 94043

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
> Sent: Tuesday, September 20, 2005 4:06 AM
> To: Matej Kupljen
> Cc: Maciej W. Rozycki; Daniel Jacobowitz; linux-mips@linux-mips.org
> Subject: Re: [PATCH] Fix TCP/UDP checksums on the Broadcom SB-1
> 
> 
> On Tue, Sep 20, 2005 at 01:00:04PM +0200, Matej Kupljen wrote:
> 
> > > > This caused incorrect checksums in some UDP packets for 
> NFS root.  
> > > > The problem was mild when using a 10.0.1.x IP address, 
> but severe 
> > > > when using 192.168.1.x.
> > > 
> > >  Ah!  So *that* is the reason for the absolutely abysmal NFS 
> > > performance
> > > of the SWARM with 2.6!  I have had no time to track it 
> down -- thanks a 
> > > lot!
> > 
> > Is this for MIPS64 only?
> > Because, on dbau1200 we also have poor NFS performance :-(
> 
> It's for 64-bit kernels only.  Note the difference, I didn't 
> say MIPS64.
> 
> Also, since this bug did result in an operation that has 
> undefined behaviour it likely may will only have impacted 
> some 64-bit processors - such as the SB1 - but others may 
> have been unaffected.
> 
>   Ralf
> 
> 
