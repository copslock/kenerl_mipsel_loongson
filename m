Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 09:26:39 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:57349 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010464AbcARI0h5NK28 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 09:26:37 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4CA1B60244;
        Mon, 18 Jan 2016 08:26:36 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40AE860577; Mon, 18 Jan 2016 08:26:36 +0000 (UTC)
Received: from potku.adurom.net (a88-115-185-251.elisa-laajakaista.fi [88.115.185.251])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE6CB60244;
        Mon, 18 Jan 2016 08:26:32 +0000 (UTC)
From:   Kalle Valo <kvalo@codeaurora.org>
To:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips\@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Buesch <m@bues.ch>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH, RESEND] ssb: mark ssb_bus_register as __maybe_unused
References: <8128014.DbbgBtKY3z@wuerfel>
        <8760ywd5fe.fsf@kamboji.qca.qualcomm.com> <4037550.DMaVTE01Aq@wuerfel>
        <87bn8l7miw.fsf@kamboji.qca.qualcomm.com>
        <CACna6ryvDFHqwJ3ExURcyFT2ZaT9fS9v36wCnJfze5BLnE88og@mail.gmail.com>
Date:   Mon, 18 Jan 2016 10:26:29 +0200
In-Reply-To: <CACna6ryvDFHqwJ3ExURcyFT2ZaT9fS9v36wCnJfze5BLnE88og@mail.gmail.com>
        (=?utf-8?Q?=22Rafa=C5=82_Mi=C5=82ecki=22's?= message of "Sat, 16 Jan 2016
 15:44:23 +0100")
Message-ID: <87y4bn5m4q.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51193
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

Rafał Miłecki <zajec5@gmail.com> writes:

> On 16 January 2016 at 13:10, Kalle Valo <kvalo@codeaurora.org> wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>>> On Thursday 14 January 2016 08:46:29 Kalle Valo wrote:
>>>> I can take it. For historical reasons ssb patches go through my
>>>> wireless-drivers trees.
>>>
>>> I found this in my backlog, and I believe it still applies. Can you take
>>> that one too?
>>
>> I'm not sure what you mean here, I can take any ssb patch if it's ok for
>> Michael or Rafal :)
>>
>> Just please submit the patch properly (with S-o-B line) and CC
>> linux-wireless so that it goes to patchwork.
>
> It was already sent once and Acked by Michael:
> https://patchwork.kernel.org/patch/7543191/
>
> The problem was not cc-ing linux-wireless so it wasn't picked by the
> linux-wireless patchwork.

Ah, that's why I missed it. I only follow patchwork, I basically ignore
patches which are sent via email. Arnd, can you please resend the patch
and CC linux-wireless? Sorry for the trouble.

To avoid this in the future I think we should replace netdev with
linux-wireless in the MAINTAINERS entry:

SONICS SILICON BACKPLANE DRIVER (SSB)
M:      Michael Buesch <m@bues.ch>
L:      netdev@vger.kernel.org
S:      Maintained
F:      drivers/ssb/
F:      include/linux/ssb/

Are people ok with that? Patches welcome :)

-- 
Kalle Valo
