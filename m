Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 09:04:02 +0000 (GMT)
Received: from web60103.mail.yahoo.com ([IPv6:::ffff:216.109.118.82]:3450 "HELO
	web60103.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224990AbULGJD5>; Tue, 7 Dec 2004 09:03:57 +0000
Received: (qmail 32853 invoked by uid 60001); 7 Dec 2004 09:03:50 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=BaxPSgxidVcwzAvZZJhmG6Ax8/Sxk80K10fUT5/jHeqlywHomlD7ke0dInfDEJadtux2m1ccNnUYTckhIgKkc3JjAZp4ewgKELxS36i8EG2xk11XIsbvniY1CA0k46OPCieRFgImYAzdt/5/F2/ACiwgL4fJkhKMkYwY9aFinls=  ;
Message-ID: <20041207090350.32851.qmail@web60103.mail.yahoo.com>
Received: from [63.111.213.196] by web60103.mail.yahoo.com via HTTP; Tue, 07 Dec 2004 01:03:50 PST
Date: Tue, 7 Dec 2004 01:03:50 -0800 (PST)
From: Krishnamurthy Daulatabad <krishnamurthydv@yahoo.com>
Subject: MIPS - 2.4.20 kernel - wait_on_irq issue
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <krishnamurthydv@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krishnamurthydv@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi
  Request some clarification on the 2.4.20 MIPS kernel
port.

Specifically refer to function wait_on_irq() in
arch/mips/kernel/irq.c. This function is called from 
get_irqlock() which in turn is called from
__global_cli eventually by cli().     
                                                      
                                                      
                                                   The
wait_on_irq() function does not return until "all the
CPUS" have run the ISRs.  To reach this state
interrupts have to be disabled on all the CPUs and
then wait for the ISRs to complete.  So __cli()
function called from this function is supposed to
disable the interrupts. The __cli() in MIPS will
disable the Interrupts by resetting the coprocessor
register's "Interrupt Enable"  bit which is per CPU. 
So this is going to just disable the interrupts on the
current CPU and not others.                           
                                                      
                                            

So in  a SMP system with N CPUs, can there be a
situation where wait_on_irq() may never return as an
ISR could be running in one CPU or the other as the
interrupts are not being disabled on all the CPUs? The
irq_running() function may always return TRUE for a
large number of CPUs in this case.

So, is there a problem here or am I missing something?

2.6 kernel seems to be handling the cli() call
differently.

Thanks
Krishnamurthy

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
