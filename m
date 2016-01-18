Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 20:57:48 +0100 (CET)
Received: from smtp2-g21.free.fr ([212.27.42.2]:8508 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011022AbcART5rDsTIe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jan 2016 20:57:47 +0100
Received: from tock (unknown [85.176.42.244])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id E14D24B01AD;
        Mon, 18 Jan 2016 20:56:04 +0100 (CET)
Date:   Mon, 18 Jan 2016 20:57:25 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org
Subject: Re: [RFC 1/4] WIP: MIPS: ath79: make ar933x clks more
 devicetree-friendly
Message-ID: <20160118205725.0a16be8e@tock>
In-Reply-To: <1453074987-3356-2-git-send-email-antonynpavlov@gmail.com>
References: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
        <1453074987-3356-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Mon, 18 Jan 2016 02:56:24 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> At the moment ar933x of-enabled drivers use use clock names
> (e.g. "uart" or "ahb") to get clk descriptor.
> On the other hand
> Documentation/devicetree/bindings/clock/clock-bindings.txt states
> that the 'clocks' property is required for passing clk to clock
> consumers.

This patch is not need, you should set the clock-names property in
the relevant device nodes instead.

Alban
