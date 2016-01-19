Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 14:05:00 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:35557 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010601AbcASNE6sFZL1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 14:04:58 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C095660577;
        Tue, 19 Jan 2016 13:04:57 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B111360388; Tue, 19 Jan 2016 13:04:57 +0000 (UTC)
Received: from potku.adurom.net (a88-115-185-251.elisa-laajakaista.fi [88.115.185.251])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6BCE260376;
        Tue, 19 Jan 2016 13:04:52 +0000 (UTC)
From:   Kalle Valo <kvalo@codeaurora.org>
To:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips\@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: ssb: Set linux-wireless as MAINTAINERS list
References: <8128014.DbbgBtKY3z@wuerfel>
        <8760ywd5fe.fsf@kamboji.qca.qualcomm.com> <4037550.DMaVTE01Aq@wuerfel>
        <87bn8l7miw.fsf@kamboji.qca.qualcomm.com>
        <CACna6ryvDFHqwJ3ExURcyFT2ZaT9fS9v36wCnJfze5BLnE88og@mail.gmail.com>
        <87y4bn5m4q.fsf@kamboji.qca.qualcomm.com>
        <20160118175303.19164539@wiggum>
        <CACna6ry2jSJpov1Mcvk=NF+GKrZVSHKjOsinpEQh7_BQAx34wQ@mail.gmail.com>
Date:   Tue, 19 Jan 2016 15:04:47 +0200
In-Reply-To: <CACna6ry2jSJpov1Mcvk=NF+GKrZVSHKjOsinpEQh7_BQAx34wQ@mail.gmail.com>
        (=?utf-8?Q?=22Rafa=C5=82_Mi=C5=82ecki=22's?= message of "Mon, 18 Jan 2016
 20:09:52 +0100")
Message-ID: <8737tt67ps.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51217
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

> On 18 January 2016 at 17:53, Michael Büsch <m@bues.ch> wrote:
>
>> ssb patches go through the linux-wireless tree. Set the list to
>> linux-wireless, so linux-wireless patchwork can catch the patches.
>
> Thanks Michael

Thanks from me also. I'm planning to send this to 4.5.

-- 
Kalle Valo
