Received:  by oss.sgi.com id <S553958AbQKAS6c>;
	Wed, 1 Nov 2000 10:58:32 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:6895 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553955AbQKAS6J>;
	Wed, 1 Nov 2000 10:58:09 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eA1IuH330315;
	Wed, 1 Nov 2000 10:56:18 -0800
Message-ID: <3A0067C5.BA9E3174@mvista.com>
Date:   Wed, 01 Nov 2000 10:58:13 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: "Setting flush to zero for ..." - what is the warning?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I ran some stress tests and start to get this warning.  It appears to be
generated in do_fpe() routine.  See below.  I wonder why this is
happening.  Can someone explain what is going on?  Thanks.


Jun


void do_fpe(struct pt_regs *regs, unsigned long fcr31)
{
        ....
        if (fcr31 & 0x20000) {
                /* Retry instruction with flush to zero ...  */
                if (!(fcr31 & (1<<24))) {
                        printk("Setting flush to zero for %s.\n",
                               current->comm);
                        fcr31 &= ~0x20000;
                        fcr31 |= (1<<24);
                        __asm__ __volatile__(
                                "ctc1\t%0,$31"
                                : /* No outputs */
                                : "r" (fcr31));
                        return;
                }
