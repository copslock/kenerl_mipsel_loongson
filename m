Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2012 14:40:16 +0200 (CEST)
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51397 "EHLO
        mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903494Ab2FPMkK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2012 14:40:10 +0200
Received: from 10.103.77.188.dynamic.jazztel.es ([188.77.103.10] helo=mail.viric.name)
        by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1SfsIO-0009z7-Eg; Sat, 16 Jun 2012 12:40:04 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id 4FEB358FD9B; Sat, 16 Jun 2012 14:40:01 +0200 (CEST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 188.77.103.10
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+IcudpfI7v9Da9tEpv1FM7
Date:   Sat, 16 Jun 2012 14:40:01 +0200
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [loongson-dev] Re: [PATCH] MIPS: Add emulation for fpureg-mem
 unaligned access
Message-ID: <20120616124001.GQ2039@vicerveza.homeunix.net>
References: <20120615234641.6938B58FE7C@mail.viric.name>
 <CAOiHx==JS9KfPWxx+pyRNwvq-pWdhbZk+Q-qvRPsVGh90Xso9Q@mail.gmail.com>
 <20120616121513.GP2039@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20120616121513.GP2039@vicerveza.homeunix.net>
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 8BIT
X-archive-position: 33673
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

Hello,

On Sat, Jun 16, 2012 at 02:15:13PM +0200, Lluís Batlle i Rossell wrote:
> On Sat, Jun 16, 2012 at 01:21:27PM +0200, Jonas Gorski wrote:
> > On 16 June 2012 00:22, Lluis Batlle i Rossell <viric@viric.name> wrote:
> > > Reusing most of the code from lw,ld,sw,sd emulation,
> > > I add the emulation for lwc1,ldc1,swc1,sdc1.
> > 
> > What about lwxc1, ldxc1, swxc1 and sdxc1? These also require alignment.
> 
> Looking at gcc code, I could not find those instructions emmitted. I could write
> some assembly tests cases though.

I just undesrtood the Loongson2f only does MIPS III, and the *xc1
instructions are for MIPS IV, which I don't have, so I can't test.

I started to write the handling of cop1x_op, then a switch() of the coprocessor
operation, then I had to introduce a new instruction format not available in
inst.h, ... too much new lines I won't be able to test.

I'll repost only with the attention on MIPS II ldc1/sdc1. Btw, mips-iv.pdf says
in the LDC1 page that it's MIPS II, but Table B-5 mentions it as MIPS III. I
imagine the table is wrong, because it appears in Table B-25 too.

Regards,
Lluís.
