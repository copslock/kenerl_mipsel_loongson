Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2015 15:37:35 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:48267 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009046AbbLPOhclmkUD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Dec 2015 15:37:32 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 063FD60271;
        Wed, 16 Dec 2015 14:37:30 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7D5D60267; Wed, 16 Dec 2015 14:37:29 +0000 (UTC)
Received: from potku.adurom.net (a88-115-185-251.elisa-laajakaista.fi [88.115.185.251])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA33C6024B;
        Wed, 16 Dec 2015 14:37:27 +0000 (UTC)
From:   Kalle Valo <kvalo@codeaurora.org>
To:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Larry Finger <larry.finger@lwfinger.net>
Subject: Re: [PATCH] ssb: pick SoC invariants code from MIPS BCM47xx arch
References: <1449700611-6952-1-git-send-email-zajec5@gmail.com>
Date:   Wed, 16 Dec 2015 16:37:22 +0200
In-Reply-To: <1449700611-6952-1-git-send-email-zajec5@gmail.com>
 (=?utf-8?Q?=22Rafa=C5=82=09Mi=C5=82ecki=22's?= message of "Wed, 9 Dec 2015
 23:36:51 +0100")
Message-ID: <871tamfoil.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50640
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

> There is code in ssb fetching "invariants" that is basically a set of
> board specific data. Every host requires its own implementation of
> reading function. In ssb we have support for PCI, PCMCIA & SDIO.
> For some (historical?) reason code reading "invariants" for SoC was
> placed in arch code and provided by a callback. This is not needed
> nowadays, so lets move that into ssb. This way we keep all "invariants"
> functions in a single module making code cleaner.
>
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Manually applied to wireless-drivers-next.git, thanks.

-- 
Kalle Valo
