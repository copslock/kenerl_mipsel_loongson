Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 03:54:28 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011662AbcBVCy1C1HD2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Feb 2016 03:54:27 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id D8F79203AA;
        Mon, 22 Feb 2016 02:54:24 +0000 (UTC)
Received: from rob-hp-laptop (unknown [198.170.185.222])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0658203B1;
        Mon, 22 Feb 2016 02:54:22 +0000 (UTC)
Date:   Sun, 21 Feb 2016 20:54:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>, Marek Vasut <marex@denx.de>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 02/10] MIPS: dts: qca: ar9132: fix typo: "ppl" -> "pll"
Message-ID: <20160222025420.GI15973@rob-hp-laptop>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
 <1455400697-29898-3-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455400697-29898-3-git-send-email-antonynpavlov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Sun, Feb 14, 2016 at 12:58:09AM +0300, Antony Pavlov wrote:
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/clock/qca,ath79-pll.txt | 2 +-
>  arch/mips/boot/dts/qca/ar9132.dtsi                        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'd just roll this into the previous patch.

Acked-by: Rob Herring <robh@kernel.org>
