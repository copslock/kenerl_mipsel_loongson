Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 07:46:44 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:34761 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007755AbcANGqkNrK1q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 07:46:40 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7263A6060C;
        Thu, 14 Jan 2016 06:46:38 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5541160387; Thu, 14 Jan 2016 06:46:38 +0000 (UTC)
Received: from potku.adurom.net (a88-115-185-251.elisa-laajakaista.fi [88.115.185.251])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 030A560235;
        Thu, 14 Jan 2016 06:46:35 +0000 (UTC)
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, Michael Buesch <m@bues.ch>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ssb: host_soc depends on sprom
References: <8128014.DbbgBtKY3z@wuerfel>
Date:   Thu, 14 Jan 2016 08:46:29 +0200
In-Reply-To: <8128014.DbbgBtKY3z@wuerfel> (Arnd Bergmann's message of "Wed, 13
        Jan 2016 23:51:43 +0100")
Message-ID: <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Arnd Bergmann <arnd@arndb.de> writes:

> Drivers that use the SSB sprom functionality typically 'select SSB_SPROM'
> from Kconfig, but CONFIG_SSB_HOST_SOC misses this, which results in
> a build failure unless at least one of the other drivers that selects
> it is enabled:
>
> drivers/built-in.o: In function `ssb_host_soc_get_invariants':
> (.text+0x459494): undefined reference to `ssb_fill_sprom_with_fallback'
>
> This adds the same select statement that is used elsewhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 541c9a84cd85 ("ssb: pick SoC invariants code from MIPS BCM47xx arch")
> ---
> I'm not sure who the right person is to pick up the fix. The patch that
> introduced the problem was merged by Kalle through the iwlwifi tree.

I can take it. For historical reasons ssb patches go through my
wireless-drivers trees.

-- 
Kalle Valo
