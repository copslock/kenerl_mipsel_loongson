Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 07:41:42 +0000 (GMT)
Received: from jeeves.momenco.com ([IPv6:::ffff:64.169.228.99]:24334 "EHLO 
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S8225254AbUAVHlm>; Thu, 22 Jan 2004 07:41:42 +0000
Received: (from mdharm@localhost)
	by  host099.momenco.com (8.11.6/8.11.6) id i0M7fda24599;
	Wed, 21 Jan 2004 23:41:39 -0800
Date: Wed, 21 Jan 2004 23:41:38 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: karthikeyan natarajan <karthik_96cse@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Doubt in timer interrupt
Message-ID: <20040121234138.A24587@momenco.com>
References: <20040122072407.11156.qmail@web10102.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040122072407.11156.qmail@web10102.mail.yahoo.com>; from karthik_96cse@yahoo.com on Thu, Jan 22, 2004 at 07:24:07AM +0000
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
Return-Path: <mdharm@host099.momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

As with any timer interrupt, if you mask it too long you'll lose time.

Generally, masking interrupts via the IE bit is a bad idea.

Matt

On Thu, Jan 22, 2004 at 07:24:07AM +0000, karthikeyan natarajan wrote:
> Hi All,
> 
>   In R4000 & descendent processors, interrupt number 7
> is being used for internal timer interrupt. From this
> i understand that the timer interrupt is also maskable
> when the IE bit in status register is cleared. If 
> somebody mask this interrupt for a long time 
> erroneously, then won't there be a problem in 
> maintaining the system time?
>     Please correct me if i am wrong..
> 
> Does the system time is maintained via NMI?
>    
> Thanks in advance,
> -karthi
> 
> =====
> The expert at anything was once a beginner
>                   ______________________________
>                  /                              \
>              O  /      Karthikeyan.N             \
>            O   |       Chennai, India.            |
>     `\|||/'     \    Mobile: +919884104346       /
>      (o o)       \                              /
> _ ooO (_) Ooo____________________________________
> _____|_____|_____|_____|_____|_____|_____|_____|_
> __|_____|_____|_____|_____|_____|_____|_____|____
> _____|_____|_____|_____|_____|_____|_____|_____|_
> 
> ________________________________________________________________________
> Yahoo! Messenger - Communicate instantly..."Ping" 
> your friends today! Download Messenger Now 
> http://uk.messenger.yahoo.com/download/index.html

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
