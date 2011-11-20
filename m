Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Nov 2011 17:31:29 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37438 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903602Ab1KTQbZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Nov 2011 17:31:25 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id AF27923C0130;
        Sun, 20 Nov 2011 17:31:23 +0100 (CET)
Message-ID: <4EC92B5D.6000607@openwrt.org>
Date:   Sun, 20 Nov 2011 17:31:25 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Thomas Meyer <thomas@m3y3r.de>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: Use kmemdup rather than duplicating its
 implementation
References: <1321569820.1624.273.camel@localhost.localdomain>
In-Reply-To: <1321569820.1624.273.camel@localhost.localdomain>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16707

2011.11.17. 23:43 keltezéssel, Thomas Meyer írta:
> The semantic patch that makes this change is available
> in scripts/coccinelle/api/memdup.cocci.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---

Acked-by: Gabor Juhos <juhosg@openwrt.org>
