Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2003 18:00:19 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:1020 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225205AbTF3RAP>;
	Mon, 30 Jun 2003 18:00:15 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h5UH0DH08737;
	Mon, 30 Jun 2003 10:00:13 -0700
Date: Mon, 30 Jun 2003 10:00:13 -0700
From: Jun Sun <jsun@mvista.com>
To: fpga dsp <fpga_dsp@yahoo.com.au>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: schedule() and mipsel processor
Message-ID: <20030630100013.D8542@mvista.com>
References: <20030628025749.40346.qmail@web41205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030628025749.40346.qmail@web41205.mail.yahoo.com>; from fpga_dsp@yahoo.com.au on Sat, Jun 28, 2003 at 12:57:49PM +1000
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Sat, Jun 28, 2003 at 12:57:49PM +1000, fpga dsp wrote:
> Hi all,
>  
> I may ask a stupid question here but I have problem of calling any functions such as interruptible_sleep_on_timeout, sleep_on ... in a timer handler, the kernel just crash straight away in the function schedule(). Now I go and do a diff between kern/sched.c on i686 source and mipsel source. clearly , they are different. So the question is from kernel programming point of view, the bottom-half of interrupt handler is still considered interrupt handler? 

Correct.  You can't call those sleep functions from timer function.

Jun
