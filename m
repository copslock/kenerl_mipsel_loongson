Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 18:59:49 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:35827 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225223AbTCMS7t>;
	Thu, 13 Mar 2003 18:59:49 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA16850;
	Thu, 13 Mar 2003 10:59:42 -0800
Subject: Re: arch/mips/au1000/common/irq.c
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: linux-mips@linux-mips.org
In-Reply-To: <20030313104704.V20129@luca.pas.lab>
References: <20030313104704.V20129@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047581991.819.52.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 10:59:51 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-03-13 at 10:47, Jeff Baitis wrote:
> Pete:
> 
> I've got a question concerning irq.c. In intc0_req0_irqdispatch() (linux_2_4
> branch) on lines 545 thru 552, the code reads:
> 
>       for (i=0; i<32; i++) {
>           if ((intc0_req0 & (1<<i))) {
>               intc0_req0 &= ~(1<<i);
>               do_IRQ(irq, regs);
>               break;
>           }
>           irq++;
>       }
> 
> My question is: why do we increment i and irq independently?
> Why doesn't the code read:
> 
>       for (i=0; i<32; i++) {
>           if ((intc0_req0 & (1<<i))) {
>               intc0_req0 &= ~(1<<i);
>               do_IRQ(i, regs);
>               break;
>           }
>       }
> 
> Thanks for your help!

No reason. It was probably more clear to me when writing the code and
later I didn't look for such improvements. Like Dan said though, he's
updating/optimizing that part of the code anyway ...

Pete
