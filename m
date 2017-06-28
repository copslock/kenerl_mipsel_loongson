Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 16:58:17 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:46998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993964AbdF1O6JMse-r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 16:58:09 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B12280D;
        Wed, 28 Jun 2017 07:58:01 -0700 (PDT)
Received: from leverpostej (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40A1E3F4FF;
        Wed, 28 Jun 2017 07:57:58 -0700 (PDT)
Date:   Wed, 28 Jun 2017 15:57:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, will.deacon@arm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 1/4] misc: sram: Allow ARM64 to select SRAM_EXEC
Message-ID: <20170628145707.GB8252@leverpostej>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
 <20170626223248.14199-3-f.fainelli@gmail.com>
 <20170627173859.GA5189@leverpostej>
 <171ae8ff-2af2-65e3-9796-308b21976876@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171ae8ff-2af2-65e3-9796-308b21976876@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mark.rutland@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.rutland@arm.com
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

On Tue, Jun 27, 2017 at 11:21:17AM -0700, Florian Fainelli wrote:
> On 06/27/2017 10:38 AM, Mark Rutland wrote:
> > On Mon, Jun 26, 2017 at 03:32:42PM -0700, Florian Fainelli wrote:
> >> Now that ARM64 also has a fncpy() implementation, allow selection
> >> SRAM_EXEC for ARM64 as well.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > 
> > Sorr,y but I must NAK this patch.
> > 
> > As mentioned on prior threads regarding fncpy, I do not think it makes
> > sense to enable this for arm64. The only use-cases that have been
> > described so far for this are power-management stuff that should live in
> > PSCI or other secure FW, and have no place in the kernel on arm64
> 
> This is a valid reason, but this is only one use case presented, the
> only thing is that we need to make sure, as patch reviewers and you guys
> as architecture maintainers, that this is not used as a means to bypass
> PSCI for suspend/resume operation, which I now agree with.
> 
> Still, the general use case remains: you have a piece of addressable
> memory which can be used to allocate space from and relocate code to be
> it for security, performance, predictability, isolation, or anything,
> and that should be possible given standard kernel facilities offered by
> the SRAM driver.

While I agree that these are *theoretically* possible use cases, they
aren't *real* cases today. 

If someone comes by with code that needs this (which doesn't fall into
one of those NAK'd cases above), then I'm happy for this to be enabled
for that feature.

Until such time, I see no reason to enable this. Given it comes with
strong the potential for abuse, I'd rather it remained disabled.

> > > There are no other users of this functionality, and until there are, I
> > see no reason to enable this, and risk a proliferation of unnecessary
> > platform-specific code.
> > 
> > It should be possible to #ifdef-ise the relevant callers of this such
> > that they can be built on arm64 without using fncpy or sram_exec
> > functionality. AFAICT, there are no users on arm64 introduced by this
> > series.
> 
> I sent this patch accidentally as part of this patch series anyway, so
> if you want to keep the discussion alive, reply here:
> 
> https://patchwork.kernel.org/patch/9793745/

That appears to be v2 of the series, and there's a v3 afterwards, so
I've replied on v3.

Thanks,
Mark.
