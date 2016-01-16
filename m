Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jan 2016 13:10:43 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:50889 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008872AbcAPMKllgxXo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jan 2016 13:10:41 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B538E60606;
        Sat, 16 Jan 2016 12:10:39 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E6EA6060D; Sat, 16 Jan 2016 12:10:39 +0000 (UTC)
Received: from potku.adurom.net (a88-115-185-251.elisa-laajakaista.fi [88.115.185.251])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EC7560251;
        Sat, 16 Jan 2016 12:10:37 +0000 (UTC)
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Michael Buesch <m@bues.ch>,
        netdev@vger.kernel.org
Subject: Re: [PATCH, RESEND] ssb: mark ssb_bus_register as __maybe_unused
References: <8128014.DbbgBtKY3z@wuerfel>
        <8760ywd5fe.fsf@kamboji.qca.qualcomm.com> <4037550.DMaVTE01Aq@wuerfel>
Date:   Sat, 16 Jan 2016 14:10:31 +0200
In-Reply-To: <4037550.DMaVTE01Aq@wuerfel> (Arnd Bergmann's message of "Fri, 15
        Jan 2016 00:13 +0100")
Message-ID: <87bn8l7miw.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51171
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

> On Thursday 14 January 2016 08:46:29 Kalle Valo wrote:
>> I can take it. For historical reasons ssb patches go through my
>> wireless-drivers trees.
>
> I found this in my backlog, and I believe it still applies. Can you take
> that one too?

I'm not sure what you mean here, I can take any ssb patch if it's ok for
Michael or Rafal :)

Just please submit the patch properly (with S-o-B line) and CC
linux-wireless so that it goes to patchwork.

-- 
Kalle Valo
