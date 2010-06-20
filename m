Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jun 2010 18:34:51 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:38062 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491048Ab0FTQeq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Jun 2010 18:34:46 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1OQNTp-0007XI-00; Sun, 20 Jun 2010 18:34:45 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id C78A11D463; Sun, 20 Jun 2010 18:34:37 +0200 (CEST)
Date:   Sun, 20 Jun 2010 18:34:37 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Graham Gower <graham.gower@gmail.com>
Subject: Re: [PATCH v2 00/26] Add support for the Ingenic JZ4740
        System-on-a-Chip
Message-ID: <20100620163437.GA8329@alpha.franken.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <20100620092610.GA4950@alpha.franken.de> <4C1E263E.1000903@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C1E263E.1000903@metafoo.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13814

On Sun, Jun 20, 2010 at 04:31:26PM +0200, Lars-Peter Clausen wrote:
> Another issue with naming is that while a component might be similar in
> JZ4730 and JZ4740 it might be completely different in a different JZ47xx
> SoC. So naming a driver 'jz47xx_driver' instead of 'jz4740_driver' wont
> work either.

so ? call it xx for the common part an exact number for special part.
It might be just jugglin with pieces, but getting it better in the first
run is always a plus.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
