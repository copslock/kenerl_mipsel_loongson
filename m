Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2003 23:27:57 +0000 (GMT)
Received: from p508B60ED.dip.t-dialin.net ([IPv6:::ffff:80.139.96.237]:7131
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226025AbTKYX1p>; Tue, 25 Nov 2003 23:27:45 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAPNRhA0013143
	for <linux-mips@linux-mips.org>; Wed, 26 Nov 2003 00:27:43 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAPNRh4V013142
	for linux-mips@linux-mips.org; Wed, 26 Nov 2003 00:27:43 +0100
Resent-Message-Id: <200311252327.hAPNRh4V013142@dea.linux-mips.net>
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAPNLAA0012986
	for <linux-mips@linux-mips.org>; Wed, 26 Nov 2003 00:21:10 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAPN9kms012751;
	Wed, 26 Nov 2003 00:09:46 +0100
Date: Wed, 26 Nov 2003 00:09:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kapoor, Pankaj" <pkapoor@telogy.com>
Cc: linux-mips@linux-mips.org
Subject: Re: MIPS Interrupts.
Message-ID: <20031125230946.GA12422@linux-mips.org>
References: <37A3C2F21006D611995100B0D0F9B73C02C8FCAE@tnint11.telogy.design.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37A3C2F21006D611995100B0D0F9B73C02C8FCAE@tnint11.telogy.design.ti.com>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Wed, 26 Nov 2003 00:27:43 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 25, 2003 at 04:52:20PM -0500, Kapoor, Pankaj wrote:

> Now there are 2 cases that can happen 
> 
> 1. Since we have not exited the ISR and the exception level has still not 
>    been restored there can be no more interrupts that are generated in the 
>    system. In such a case does that mean that the all bottom half handlers 
>    pending execution will run with interrupts disabled. 
>    NOTE: This does not seem likely because the local_irq_enable routine
>    calls _sti which clears the exception level in the status register and
>    also sets the IE bit. 
> 
> 2. If we have large number of tasklets or if the bottom half handlers take
>    time to execute, then we could get another timer interrupt or other
>    device interrupts causing context saves which would cause the stack to
>    grow and CRASH the system. 

Interrupts are disabled while the respective interrupt handler is running.

  Ralf
