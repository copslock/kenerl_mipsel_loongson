Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 17:22:41 +0100 (BST)
Received: from gateway12.websitewelcome.com ([70.85.130.9]:25323 "HELO
	gateway12.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S20022714AbZCaQWf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 17:22:35 +0100
Received: (qmail 25764 invoked from network); 31 Mar 2009 16:23:33 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway12.websitewelcome.com with SMTP; 31 Mar 2009 16:23:33 -0000
Received: from [217.109.65.213] (port=3362 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LogjO-0006IF-AZ; Tue, 31 Mar 2009 11:22:30 -0500
Message-ID: <49D24348.2030603@paralogos.com>
Date:	Tue, 31 Mar 2009 18:22:32 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Linux MIPS org <linux-mips@linux-mips.org>
Subject: Re: PATCH for SMTC: Fix Name Collision in _clockevent_init	functions
References: <49D1FA28.4030308@paralogos.com> <20090331131251.GC3804@linux-mips.org> <20090331153213.GA11043@roarinelk.homelinux.net>
In-Reply-To: <20090331153213.GA11043@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> I'm curious: Is it required to use the CP0 counter for SMTC kernels, or
> could the SMTC-specific parts somehow be abstracted out and called by
> other timer backends? (for a hypothetical SMTC-enhanced Alchemy core)
>   
Theoretically, one could, but it would require a major rewrite of
cevt-smtc.c, which implements multiple virtual per-CPU one-shot timer
interrupts multiplexed off a single timer interrupt source (the SMTC
environment has a couple of quirks that make the generic timer broadcast
code pretty useless). The concept could be applied to arbitrary
counter-based interrupts, but for simplicity and performance, the code
assumes MIPS32 Count/Compare, and to minimize redundant source code, it
uses common functions with cevt-r4k.c wherever possible (that's why
there are those #ifdef MIPS_MT_SMTC's in cevt-r4k.c).

          Regards,

          Kevin K.
