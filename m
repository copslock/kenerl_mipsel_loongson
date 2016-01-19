Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 14:04:00 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:35388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010601AbcASND6iTuH1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 14:03:58 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9A3FD60377;
        Tue, 19 Jan 2016 13:03:56 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8E4C860388; Tue, 19 Jan 2016 13:03:56 +0000 (UTC)
Received: from potku.adurom.net (a88-115-185-251.elisa-laajakaista.fi [88.115.185.251])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B2A960251;
        Tue, 19 Jan 2016 13:03:50 +0000 (UTC)
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Michael Buesch <m@bues.ch>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH, RESEND^2] ssb: mark ssb_bus_register as __maybe_unused
References: <8128014.DbbgBtKY3z@wuerfel>
        <8760ywd5fe.fsf@kamboji.qca.qualcomm.com> <6063400.39vor3soEb@wuerfel>
Date:   Tue, 19 Jan 2016 15:03:45 +0200
In-Reply-To: <6063400.39vor3soEb@wuerfel> (Arnd Bergmann's message of "Mon, 18
        Jan 2016 20:39:56 +0100")
Message-ID: <877fj567ri.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51216
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

> The SoC variant of the ssb code is now optional like the other
> ones, which means we can build the framwork without any
> front-end, but that results in a warning:
>
> drivers/ssb/main.c:616:12: warning: 'ssb_bus_register' defined but not used [-Wunused-function]
>
> This annotates the ssb_bus_register function as __maybe_unused to
> shut up the warning. A configuration like this will not work on
> any hardware of course, but we still want this to silently build
> without warnings if the configuration is allowed in the first
> place.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 845da6e58e19 ("ssb: add Kconfig entry for compiling SoC related code")
> Acked-by: Michael Buesch <m@bues.ch>
> ---
> Resent to linux-wireless as requested

Thanks, and sorry for the hassle. I'm planning to push this to 4.5.

-- 
Kalle Valo
