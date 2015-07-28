Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2015 11:51:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34345 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010509AbbG1JvcSYAcL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Jul 2015 11:51:32 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6S9pUgJ023907;
        Tue, 28 Jul 2015 11:51:30 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6S9pSAr023906;
        Tue, 28 Jul 2015 11:51:28 +0200
Date:   Tue, 28 Jul 2015 11:51:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH v4 0/7] Clocksource changes for Pistachio CPUFreq.
Message-ID: <20150728095128.GA23771@linux-mips.org>
References: <1438005618-27003-1-git-send-email-govindraj.raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438005618-27003-1-git-send-email-govindraj.raja@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Daniel,

On Mon, Jul 27, 2015 at 03:00:11PM +0100, Govindraj Raja wrote:

> From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> 
> The purpose of this patchset is to support CPUFreq on Pistachio SoC.
> However, given Pistachio uses the MIPS GIC clocksource and clockevent drivers
> (clocked from the CPU), adding CPUFreq support needs some work.
> 
> This patchset changes the MIPS GIC clockevent driver to update the frequency of
> the per-cpu clockevents using a clock notifier.
> 
> Then, we add a clocksource driver for IMG Pistachio SoC, based on the 
> general purpose timers. The SoC only provides four timers, so we can't
> use them to implement the four clockevents and the clocksource.
> 
> However, we can use one of these timers to provide a clocksource and a
> sched clock. Given the general purpose timers are clocked from the peripheral
> system clock tree, they are not affected by CPU rate changes.
> 
> Patches 1 to 3 are just style cleaning and preparation work.
> Patch 4 adds the clockevent frequency update.
> Patches 5 and 6 add the new clocksource driver.
> Patch 7 introduces an option to enable the timer based clocksource on Pistachio.

if you're happy with this series feel free to add my ack to patch 7/7
which is the only one that touches arch/mips.

Alternatively I can carry this in the MIPS tree which would have tbe
benefit of better testing.

  Ralf
