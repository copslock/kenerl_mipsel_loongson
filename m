Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 19:02:02 +0100 (CET)
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:60244 "EHLO
        cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012149AbaJ2SCAe8hQK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 19:02:00 +0100
Received: from leverpostej (leverpostej.cambridge.arm.com [10.1.205.151])
        by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id s9TI1awo019234;
        Wed, 29 Oct 2014 18:01:36 GMT
Date:   Wed, 29 Oct 2014 18:01:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/4] of: Add binding document for MIPS GIC
Message-ID: <20141029180125.GD26471@leverpostej>
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>
 <1414541562-10076-3-git-send-email-abrestic@chromium.org>
 <5450B1B1.5070301@imgtec.com>
 <CAL1qeaFeoKFbea7eiiXaw87PYUWO1JmP5xxdLLpW2RrFCprtZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1qeaFeoKFbea7eiiXaw87PYUWO1JmP5xxdLLpW2RrFCprtZg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mark.rutland@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43718
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

On Wed, Oct 29, 2014 at 04:55:56PM +0000, Andrew Bresticker wrote:
> Hi James,
> 
> On Wed, Oct 29, 2014 at 2:21 AM, James Hogan <james.hogan@imgtec.com> wrote:
> > Hi Andrew,
> >
> > On 29/10/14 00:12, Andrew Bresticker wrote:
> >>  - changed compatible string to include CPU version
> >
> >> +Required properties:
> >> +- compatible : Should be "mti,<cpu>-gic".  Supported variants:
> >> +  - "mti,interaptiv-gic"
> >
> >> +Required properties for timer sub-node:
> >> +- compatible : Should be "mti,<cpu>-gic-timer".  Supported variants:
> >> +  - "mti,interaptiv-gic-timer"
> >
> > Erm, I'm a bit confused...
> > Why do you include the core name in the compatible string?
> >
> > You seem to be suggesting that:
> >
> > 1) The GIC/timer drivers need to know what core they're running on.
> >
> > Is that really true?
> 
> They don't now, but it's possible that a future CPU has a newer
> revision of the GIC which has some differences that need to be
> accounted for in the driver.

At that point you can allocate a new compatible string. Until then you
don't necessarily need to distinguish.

Is the timer defined by the architecture, or is it specific to this CPU
(and might get reused in future)?

> > 2) It isn't possible to probe the core type.
> >
> > But the kernel already knows this, so what's wrong with using
> > current_cpu_type() like everything else that needs to know?
> >
> > 3) Every new core should require a new compatible string to be added
> > before the GIC will work. You don't even have a generic compatible
> > string that DT can specify after the core specific one as a fallback.
> 
> Yes, adding a generic compatible string would be a good idea.
> 
> > Please lets not do this unless it's actually necessary (which AFAICT it
> > really isn't).
> 
> The point of this was to future-proof these bindings and I though that
> CPU type was the best way to indicate version in the compatible
> string.  This is also how it's done for the ARM GIC and arch timers.
> Perhaps the best thing to do is to require both a core-specific
> ("mti,interaptiv-gic") and generic ("mti,gic") compatible string and
> just match on the generic one for now until there's a need to use the
> core-specific one.  Thoughts?

If this timer is architected you can have a generic string for now, with
each CPU having a more specific string just in case, e.g.

	compatible = "mti,interaptiv-gic-timer", "mti,gic-timer".

The kernel driver can currently match just "mti,gic-timer", andd
everything should be fine if it turns out nothing changes with new CPUs:

	compatible = "mti,newcpu-gic-timer", "mti,gic-timer";

If the new CPU's timer doesn't quite match, you add its comaptible
string to the driver, and drop "mti,gic-timer" from the node's
comaptible list:

	compatible = "mti,newcpu-gic-timer";

Mark.
