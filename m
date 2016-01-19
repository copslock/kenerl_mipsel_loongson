Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 20:26:28 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:58556 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014786AbcAST00MxS1i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 20:26:26 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5B02960632;
        Tue, 19 Jan 2016 19:26:25 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E3F960577; Tue, 19 Jan 2016 19:26:25 +0000 (UTC)
Received: from potku.adurom.net (a88-115-185-251.elisa-laajakaista.fi [88.115.185.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08CC66061C;
        Tue, 19 Jan 2016 19:26:22 +0000 (UTC)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND^2] ssb: mark ssb_bus_register as __maybe_unused
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <6063400.39vor3soEb@wuerfel>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Michael Buesch <m@bues.ch>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Message-Id: <20160119192625.4E3F960577@smtp.codeaurora.org>
Date:   Tue, 19 Jan 2016 19:26:25 +0000 (UTC)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51226
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

Thanks, applied to wireless-drivers.git.

Kalle Valo
