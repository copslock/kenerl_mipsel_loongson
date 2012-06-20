Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 21:06:05 +0200 (CEST)
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59257 "EHLO
        mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903519Ab2FTTF6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2012 21:05:58 +0200
Received: from 10.103.77.188.dynamic.jazztel.es ([188.77.103.10] helo=mail.viric.name)
        by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1ShQDt-0003qO-3r; Wed, 20 Jun 2012 19:05:49 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id 517BB5902AD; Wed, 20 Jun 2012 21:05:45 +0200 (CEST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 188.77.103.10
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/FA9CCNYaR0hdzfN4KxWyU
Date:   Wed, 20 Jun 2012 21:05:45 +0200
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     linux-mips@linux-mips.org
Cc:     tsbogend@alpha.franken.de
Subject: Re: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
Message-ID: <20120620190545.GV2039@vicerveza.homeunix.net>
References: <20120615234641.6938B58FE7C@mail.viric.name>
 <CAOiHx==JS9KfPWxx+pyRNwvq-pWdhbZk+Q-qvRPsVGh90Xso9Q@mail.gmail.com>
 <20120616121513.GP2039@vicerveza.homeunix.net>
 <20120616124001.GQ2039@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20120616124001.GQ2039@vicerveza.homeunix.net>
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 8BIT
X-archive-position: 33745
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

> In reply to Thomas Bogendoerfer - 2012-06-17 09:06:43
> On Sat, Jun 16, 2012 at 02:58:47PM +0200, Llu�s Batlle i Rossell wrote:
> > Well, I think I take my words back. Handling the ldc1/sdc1 cases in MIPS32 is
> > tricker than I thought first, because I can't use ldl/ldr or sdl/sdr there.
> > Given my ability with mips assembly, I leave the patch as is.
> > 
> > In 'patchwork' I had set the patch first to superseeded, but then I set it
> > back
> > to New.
> 
> why is there a reason for this ? Unaligned FPU access shouts to me simply
> broken code, go fix that. But maybe I'm wrong ?
> 
> Thomas.

Hello Thomas,

sorry to answer this way; I was not subscribed to the list, and I noticed your
answer only today thanks to patchwork.

Right, the patch allows broken code to run further, instead of fail straight.
The crash can be still achieved disabling the emulation of unaligned accesses
completely, through debugfs, for example.

As Jonas reported, I think that maybe I should rework the patch for it to emit
sigbus instead of sigill on ldc1,ldc1 for mips32. Do I understand it right?

Regards,
Llu�s.
