Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 03:36:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63356 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993945AbdF1Bf7hviXs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2017 03:35:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AF9D4B38F8BB9;
        Wed, 28 Jun 2017 02:35:52 +0100 (IST)
Received: from [10.20.78.46] (10.20.78.46) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 28 Jun 2017
 02:35:52 +0100
Date:   Wed, 28 Jun 2017 02:35:37 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        <linux-mips@linux-mips.org>, James Hogan <James.Hogan@imgtec.com>,
        <Paul.Burton@imgtec.com>, <Raghu.Gandham@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <Douglas.Leung@imgtec.com>, <Petar.Jovanovic@imgtec.com>,
        <Miodrag.Dinic@imgtec.com>, <Goran.Ferenc@imgtec.com>
Subject: Re: [PATCH 3/8] MIPS: R6: Fix PREF instruction usage by memcpy for
 MIPS R6
In-Reply-To: <20170628005853.GC6738@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1706280224120.31404@tp.orcam.me.uk>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com> <1497887415-13825-4-git-send-email-aleksandar.markovic@rt-rk.com> <a5842e4b-a75b-2dde-d835-6a488790dbda@imgtec.com> <20170628005853.GC6738@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.46]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, 28 Jun 2017, Ralf Baechle wrote:

> > Wouldn't the more correct thing be to modify the memcpy loop such that
> > prefetches do not fetch the larger offset? Just turning off prefetch
> > altogether in memcpy for r6 seems like a heavy hammer to me...
> 
> It's the same heavy hammer we've been using for ages to deal with this
> problem for other configurations as well.  So while you're right I don't
> want to force Aleksandar to come up with The One Perfect Fix.  Though
> that would be lovely :)

 The The One Perfect Fix is to switch to the `at' assembly mode as with 
PREFE (which suffers from the same limitation and uses the same internal 
operand code even), as GAS does the right thing automagically if allowed, 
even for R6:

$ cat pref.s
	.text
foo:
	pref	0, 32767($2)
$ as -32 -mips32 -o pref.o pref.s
$ as -32 -mips32r6 -o pref6.o pref.s
$ objdump -d pref*.o

pref.o:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <foo>:
   0:	cc407fff 	pref	0x0,32767(v0)
	...

pref6.o:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <foo>:
   0:	24417fff 	addiu	at,v0,32767
   4:	7c200035 	pref	0x0,0(at)
	...

Implementing it should be a trivial exercise given the existing example.

  Maciej
