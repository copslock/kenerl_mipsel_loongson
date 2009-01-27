Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 02:19:01 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:62913 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S21366006AbZA0CSx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 02:18:53 +0000
Received: from 71.145.136.190 ([71.145.136.190]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Tue, 27 Jan 2009 02:18:45 +0000
Received: from kh-d820 by webmail.razamicroelectronics.com; 26 Jan 2009 20:18:46 -0600
Subject: Re: [PATCH] Alchemy: fix edge irq handling
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20090121064856.GA27020@roarinelk.homelinux.net>
References: <20090120100353.GA18971@roarinelk.homelinux.net>
	 <1232498838.3678.17.camel@kh-d820>
	 <20090121064856.GA27020@roarinelk.homelinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Mon, 26 Jan 2009 20:18:45 -0600
Message-Id: <1233022725.14733.10.camel@kh-d820>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

I am still concerned about this patch.  Just last week we encountered
similar behavior that turned out to be a board design error.  I had a
similar patch in that kernel that allowed me to run without error.  Our
Windows CE developer, however, did not and ended up finding the board
bug.  Fixing the board improved performance and system stability - had
we not been running CE we probably would not have found the issue until
much later and with greater effort.

Your example below is similar - debouncing the switch in hardware seems
a better solution (albeit likely an expensive one) than patching the
mainline kernel.  And I reiterate: some devices send a lot of interrupts
by design; we should honor their requests, not mask them out.

=Kevin

On Wed, 2009-01-21 at 07:48 +0100, Manuel Lauss wrote:
> Hi Kevin,
> 
> > Have you actually seen this happen (outside of inducing it manually)?  I
> > have some concern that by doing this we may either miss interrupts on
> > devices that send a lot (by design) or miss a design bug in a system
> > because we are masking out some interrupts.  I know that system
> > stability is important, but I don't like hiding problems.
> 
> Yes, in a customer project.  A simple pushbutton which connects a pulled-up
> gpio pin to ground.  Push it, instant hang (handler called over and over
> again) when it is not debounced.  With a single edge and a much lower
> edge-frequency it obviously works fine (see timer).
> 
> (And, handle_edge_irq() _does_ call mask_ack() after all).

-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P:  512.691.8044
