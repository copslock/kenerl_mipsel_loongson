Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2016 15:53:05 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:56094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011457AbcBLOxCpXPWm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Feb 2016 15:53:02 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id DCD51203AC;
        Fri, 12 Feb 2016 14:53:00 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2232025B;
        Fri, 12 Feb 2016 14:52:59 +0000 (UTC)
Date:   Fri, 12 Feb 2016 08:52:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, Marek Vasut <marex@denx.de>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org
Subject: Re: [RFC v5 02/15] dt-bindings: clock: qca,ath79-pll: fix copy-paste
 typos
Message-ID: <20160212145257.GA13635@rob-hp-laptop>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
 <1455005641-7079-3-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455005641-7079-3-git-send-email-antonynpavlov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52023
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

On Tue, Feb 09, 2016 at 11:13:48AM +0300, Antony Pavlov wrote:
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/clock/qca,ath79-pll.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
