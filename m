Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g38Hmh8d031668
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Apr 2002 10:48:43 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g38HmhHL031667
	for linux-mips-outgoing; Mon, 8 Apr 2002 10:48:43 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g38Hmc8d031664
	for <linux-mips@oss.sgi.com>; Mon, 8 Apr 2002 10:48:38 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA20739;
	Mon, 8 Apr 2002 18:58:31 -0700
Message-ID: <3CB1D7E6.5010804@mvista.com>
Date: Mon, 08 Apr 2002 10:48:22 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: New style IRQs for DECstation
References: <Pine.GSO.3.96.1020408184203.26107I-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


What is the intention of introducing MIPS_CPU_FPUEX?  It seems an overkill if 
it is just needed by DecStation.  How many CPUs really need this?


Jun

Maciej W. Rozycki wrote:

> Hello,
> 
>  Here is code that implements new style IRQ handlers for DECstation. 
> Beside obvious things, like mask/unmask, etc. functions it adds IRQ
> routing tables for individual systems (including somewhat more complete
> basic support for the 5100) so that device drivers for onboard devices do
> not have to code IRQ guesswork based on model types.  I tried to make
> hardware documentation more complete as well as its external sources are
> scarce to say at least, so it might be best to keep bits described within
> the code that deals with them. 
> 
>  Also included there are a few updates to generic code:
> 
> 1. A few clean-ups to arch/mips/kernel/irq_cpu.c.  Just a five minute
> approach to fix obvious things.  A deeper action is needed, in particular
> locking is missing altogether.
> 
> 2. A new mips_cpu option to denote the dedicated FPU exception is present
> as there is currently no sane way to conclude whether it's available or
> not.
> 
> 3. A few missing header inclusions.
> 
>  Actually the code is nothing new, but since I'm resubmitting it and a few
> people confirmed their interest in the DECstation port since the previous
> submission, I'm making the patch available to the public.  I'm running the
> code since mid January successfully with only a few minor fixes since
> then.
> 
>  Due to a relatively large size the patch is available here:
> 'ftp://ftp.ds2.pg.gda.pl/pub/macro/linux/patch-mips-2.4.18-20020402-irq-48.gz'.
> 
>   Maciej
> 
> 
