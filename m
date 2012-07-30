Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2012 21:48:12 +0200 (CEST)
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21588 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903458Ab2G3TsF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2012 21:48:05 +0200
Received: from [188.77.107.114] (helo=mail.viric.name)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1Svvwd-000HQE-1a; Mon, 30 Jul 2012 19:47:59 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id 8F8491E47; Mon, 30 Jul 2012 21:47:54 +0200 (CEST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 188.77.107.114
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18XKJE4AnmnqaOOB8hSjhbA
Date:   Mon, 30 Jul 2012 21:47:54 +0200
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
Message-ID: <20120730194754.GA25996@vicerveza.homeunix.net>
References: <20120615234641.6938B58FE7C@mail.viric.name>
 <CAOiHx==JS9KfPWxx+pyRNwvq-pWdhbZk+Q-qvRPsVGh90Xso9Q@mail.gmail.com>
 <20120616121513.GP2039@vicerveza.homeunix.net>
 <20120616124001.GQ2039@vicerveza.homeunix.net>
 <20120620190545.GV2039@vicerveza.homeunix.net>
 <alpine.LFD.2.00.1207090122240.12288@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1207090122240.12288@eddie.linux-mips.org>
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 8BIT
X-archive-position: 34001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viric@viric.name
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello Maciej,

On Wed, Jul 11, 2012 at 01:05:04AM +0100, Maciej W. Rozycki wrote:
> On Wed, 20 Jun 2012, Lluís Batlle i Rossell wrote:
> 
> > > > Well, I think I take my words back. Handling the ldc1/sdc1 cases in MIPS32 is
> > > > tricker than I thought first, because I can't use ldl/ldr or sdl/sdr there.
> > > > Given my ability with mips assembly, I leave the patch as is.
>  I suggest that for 32-bit kernels you simply reuse the existing snippets 
> from that function and handle ldc1/sdc1 with a pair of lwl/ldr or swl/swr 
> pairs ordered as appropriate for the endianness selected -- that should be 
> fairly easy.

Hm I still don't understand well enough how to do that. Would I need to get some
aligned memory (a stack automatic variable for example), copy the double word
there with proper endianness, and then call again ldc1? (similar for sdc1)

>  Also regardless of that, please make sure that your code handles the two 
> possible settings of CP0 Status register's bit FR correctly, as the 32-bit 
> halves of floating-point data are distributed differently across 
> floating-point registers based on this bit's setting (check if an o32 and 
> an n64 or n32 program gets these values right).

Hm I'm failing to find in the mips-iv.pdf how to check that FR bit, although I
see it mentioned there. Sorry.

> > As Jonas reported, I think that maybe I should rework the patch for it to emit
> > sigbus instead of sigill on ldc1,ldc1 for mips32. Do I understand it right?
> 
>  Have you checked your code against a non-FPU processor (or with the 
> "nofpu" kernel option) too?

No. Would in that case the processor have the fpu disabled? I understand that
the code path is called only in a particular case of 'unaligned access'
exception.

Thank you for your comments.

Regards,
Lluís.
