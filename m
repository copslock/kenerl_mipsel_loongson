Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 01:07:47 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:37187 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011915AbbD2XHqARKoe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Apr 2015 01:07:46 +0200
Received: from tock (unknown [78.54.103.113])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id C518B822CA;
        Thu, 30 Apr 2015 01:04:57 +0200 (CEST)
Date:   Thu, 30 Apr 2015 01:07:28 +0200
From:   Alban <albeu@free.fr>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] MIPS: ath79: Add OF support and DTS for
 TL-WR1043ND
Message-ID: <20150430010728.0331a736@tock>
In-Reply-To: <553E3CC8.3070304@vanguardiasur.com.ar>
References: <1429875679-14973-1-git-send-email-albeu@free.fr>
        <553E3CC8.3070304@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47165
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

On Mon, 27 Apr 2015 10:42:32 -0300
Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:

> On 04/24/2015 08:41 AM, Alban Bedel wrote:
> > This series add OF bindings and code support for the interrupt
> > controllers, clocks and GPIOs. However it was only tested on a
> > TL-WR1043ND with an AR9132, others SoCs are untested, and a few are
> > not supported at all.
> > 
 
> Hi Alban,

Hi,

> I've booted a Carambola2 using this (plus a custom devicetree and some
> small changes):
> 
> Tested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
> Just a small comment/question: Shouldn't we allow to build all the
> devicetree files, instead of just the one that will be built-in?
> 
> I.e., something like this:
> 
> dtb-$(CONFIG_MATCH_ATH79_DT)   += ar9132_tl_wr1043nd_v1.dtb
> dtb-$(CONFIG_MACH_ATH79_DT)    += ar9331_carambola2.dtb
> 
> It should be useful to catch errors, but also in general, as the
> devicetree is supposed to be independent of the kernel and should be
> built separate from it.

Yes, that would be better, I'll fix that.

> PS: This series depends on a previous patchset. It's usually useful to
> mention this in the cover letter and make a poor tester's life
> easier :)

> > Most code changes base on the previous bug fix series:
> > [PATCH v2 0/5] MIPS: ath79: Various small fix to prepare OF support

Wasn't that clear enough?

> Thanks for the work,

Thanks for the testing.

Alban
