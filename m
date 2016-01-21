Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 11:52:44 +0100 (CET)
Received: from smtp1-g21.free.fr ([212.27.42.1]:62889 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009265AbcAUKwmrKLmQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 11:52:42 +0100
Received: from tock (unknown [78.54.115.92])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 42EDD94016E;
        Thu, 21 Jan 2016 11:51:16 +0100 (CET)
Date:   Thu, 21 Jan 2016 11:52:18 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: dts: qca: ar9132: drop unused extosc mentions
Message-ID: <20160121115218.6fa21a3a@tock>
In-Reply-To: <1453370345-16688-3-git-send-email-antonynpavlov@gmail.com>
References: <1453370345-16688-1-git-send-email-antonynpavlov@gmail.com>
        <1453370345-16688-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51273
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

On Thu, 21 Jan 2016 12:59:04 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> At the moment ar913x_clocks_init() does not use extosc node at all,
> the reference clock rate is hardcoded inside arch/mips/ath79/clock.c
> 
>     #define AR913X_BASE_FREQ        5000000
> 
>     ...
> 
>     static void __init ar913x_clocks_init(void)
>     {
>             ref_rate = AR913X_BASE_FREQ;
> 
>     ...
> 
>             ath79_add_sys_clkdev("ref", ref_rate);
> 
> Also please see the commits 'MIPS: ath79: Fix the ar913x reference clock rate'
> and 'MIPS: ath79: Fix the ar724x clock calculation' in Alban Bedel's
> github ath79 branch https://github.com/AlbanBedel/linux/tree/ath79

Yes, the reference clock definition is not yet used by the code, but
the binding define it as required. This is because a proper
implementation would need the reference clock rate.

It would be better to fix the code to get rid of the hard coded rates
when using DT. I haven't done so yet because I wanted to first get DT
support without too many changes, but that's on the TODO list along with
moving to drivers/clk.

Alban
