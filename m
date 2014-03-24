Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 17:20:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55758 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817294AbaCXQUYgW0ty (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 17:20:24 +0100
Date:   Mon, 24 Mar 2014 16:20:24 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org,
        blogic@openwrt.org
Subject: Re: [PATCH 1/2] MIPS: add MIPS_L1_CACHE_SHIFT_2
In-Reply-To: <20140324141259.GL17197@linux-mips.org>
Message-ID: <alpine.LFD.2.10.1403241604280.18427@eddie.linux-mips.org>
References: <1390327294-2618-1-git-send-email-florian@openwrt.org> <20140324141259.GL17197@linux-mips.org>
User-Agent: Alpine 2.10 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39575
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

On Mon, 24 Mar 2014, Ralf Baechle wrote:

> > Some older machines such as the DECStation use a L1 data-cache shift of
> > 2 (value of 4), add a Kconfig symbol for this value so they can express
> > this requirement.
> 
> Older DECstations got R2000/R3000 processors which have 16 byte cache
> lines.  So a cache shift value of 4 would appear to be right.  Maciej?

 Nope:

This is a DECstation 5000/1xx
CPU revision is: 00000230 (R3000A)
FPU revision is: 00000340
[...]
Primary instruction cache 64kB, linesize 4 bytes.
Primary data cache 128kB, linesize 4 bytes.

or:

This is a DECstation 5000/2x0
CPU revision is: 00000230
FPU revision is: 00000340
[...]
Primary instruction cache 64kB, linesize 4 bytes.
Primary data cache 64kB, linesize 4 bytes.

or:

This is a DECstation 5000/200
CPU revision is: 00000220
FPU revision is: 00000320
[...]
Primary instruction cache 64kB, linesize 4 bytes.
Primary data cache 64kB, linesize 4 bytes.

or even:

This is a DECstation 2100/3100
CPU revision is: 00000220
FPU revision is: 00000320
[...]
Primary instruction cache 64kB, linesize 4 bytes.
Primary data cache 64kB, linesize 4 bytes.

-- so it looks like it's consistent 4 bytes across all the variations 
(there's also a /1xx variant with 64kB D$ that I don't have a log from, 
but it has the same line size AFAIK).

  Maciej
