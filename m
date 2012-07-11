Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2012 02:05:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39075 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903700Ab2GKAFE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2012 02:05:04 +0200
Date:   Wed, 11 Jul 2012 01:05:04 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     =?ISO-8859-15?Q?Llu=EDs_Batlle_i_Rossell?= <viric@viric.name>
cc:     linux-mips@linux-mips.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
In-Reply-To: <20120620190545.GV2039@vicerveza.homeunix.net>
Message-ID: <alpine.LFD.2.00.1207090122240.12288@eddie.linux-mips.org>
References: <20120615234641.6938B58FE7C@mail.viric.name> <CAOiHx==JS9KfPWxx+pyRNwvq-pWdhbZk+Q-qvRPsVGh90Xso9Q@mail.gmail.com> <20120616121513.GP2039@vicerveza.homeunix.net> <20120616124001.GQ2039@vicerveza.homeunix.net>
 <20120620190545.GV2039@vicerveza.homeunix.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-archive-position: 33889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 20 Jun 2012, Lluís Batlle i Rossell wrote:

> > > Well, I think I take my words back. Handling the ldc1/sdc1 cases in MIPS32 is
> > > tricker than I thought first, because I can't use ldl/ldr or sdl/sdr there.
> > > Given my ability with mips assembly, I leave the patch as is.

 I suggest that for 32-bit kernels you simply reuse the existing snippets 
from that function and handle ldc1/sdc1 with a pair of lwl/ldr or swl/swr 
pairs ordered as appropriate for the endianness selected -- that should be 
fairly easy.

 Also regardless of that, please make sure that your code handles the two 
possible settings of CP0 Status register's bit FR correctly, as the 32-bit 
halves of floating-point data are distributed differently across 
floating-point registers based on this bit's setting (check if an o32 and 
an n64 or n32 program gets these values right).

> > why is there a reason for this ? Unaligned FPU access shouts to me simply
> > broken code, go fix that. But maybe I'm wrong ?

 Since we're emulating these accesses at all I concur Lluís we should stay 
consistent across the whole instruction set.

> Right, the patch allows broken code to run further, instead of fail straight.
> The crash can be still achieved disabling the emulation of unaligned accesses
> completely, through debugfs, for example.

 sysmips(MIPS_FIXADE, 0) is another way.

> As Jonas reported, I think that maybe I should rework the patch for it to emit
> sigbus instead of sigill on ldc1,ldc1 for mips32. Do I understand it right?

 Have you checked your code against a non-FPU processor (or with the 
"nofpu" kernel option) too?

  Maciej
