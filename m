Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 21:40:39 +0000 (GMT)
Received: from web60108.mail.yahoo.com ([IPv6:::ffff:216.109.118.87]:21867
	"HELO web60108.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225262AbULIVk3>; Thu, 9 Dec 2004 21:40:29 +0000
Received: (qmail 88803 invoked by uid 60001); 9 Dec 2004 21:40:21 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=aJb6GFAvpdyEcym7kdgOgxt5KK0IM7hHzwlCnfWsiKPANFz7l2OznjZPgXLHNiD0fn6uht1B/L1iHvOijRUBAKuLNu6ul2877b9NeCJ7G1uJNFW5xiCfcOdveuOz/byIgpv3rBK0T+IFRO4hB9svaE/fYU7RDD8BaCAcNpFBBrc=  ;
Message-ID: <20041209214021.88801.qmail@web60108.mail.yahoo.com>
Received: from [63.111.213.196] by web60108.mail.yahoo.com via HTTP; Thu, 09 Dec 2004 13:40:20 PST
Date: Thu, 9 Dec 2004 13:40:20 -0800 (PST)
From: Krishnamurthy Daulatabad <krishnamurthydv@yahoo.com>
Subject: Re: MIPS - 2.4.20 kernel - wait_on_irq issue
To: linux-mips@linux-mips.org
In-Reply-To: <20041207090350.32851.qmail@web60103.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <krishnamurthydv@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krishnamurthydv@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,
Any thoughts on this issue?

Thanks
Krishnamurthy


--- Krishnamurthy Daulatabad
<krishnamurthydv@yahoo.com> wrote:

> Hi
>   Request some clarification on the 2.4.20 MIPS
> kernel
> port.
> 
> Specifically refer to function wait_on_irq() in
> arch/mips/kernel/irq.c. This function is called from
> 
> get_irqlock() which in turn is called from
> __global_cli eventually by cli().     
>                                                     
>  
>                                                     
>  
>                                                   
> The
> wait_on_irq() function does not return until "all
> the
> CPUS" have run the ISRs.  To reach this state
> interrupts have to be disabled on all the CPUs and
> then wait for the ISRs to complete.  So __cli()
> function called from this function is supposed to
> disable the interrupts. The __cli() in MIPS will
> disable the Interrupts by resetting the coprocessor
> register's "Interrupt Enable"  bit which is per CPU.
> 
> So this is going to just disable the interrupts on
> the
> current CPU and not others.                         
>  
>                                                     
>  
>                                             
> 
> So in  a SMP system with N CPUs, can there be a
> situation where wait_on_irq() may never return as an
> ISR could be running in one CPU or the other as the
> interrupts are not being disabled on all the CPUs?
> The
> irq_running() function may always return TRUE for a
> large number of CPUs in this case.
> 
> So, is there a problem here or am I missing
> something?
> 
> 2.6 kernel seems to be handling the cli() call
> differently.
> 
> Thanks
> Krishnamurthy
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> 
> 



		
__________________________________ 
Do you Yahoo!? 
Jazz up your holiday email with celebrity designs. Learn more. 
http://celebrity.mail.yahoo.com
