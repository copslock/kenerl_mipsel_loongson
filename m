Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jun 2015 12:52:03 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:26540 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006852AbbFTKwABUtFO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Jun 2015 12:52:00 +0200
Received: from tock (unknown [78.50.171.48])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 1C583822F6;
        Sat, 20 Jun 2015 12:47:16 +0200 (CEST)
Date:   Sat, 20 Jun 2015 12:51:37 +0200
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
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
Subject: Re: [PATCH v4 12/12] MIPS: Add basic support for the TL-WR1043ND
 version 1
Message-ID: <20150620125137.2020a855@tock>
In-Reply-To: <20150615104213.92258d2d0616c12e4aa7bf1a@gmail.com>
References: <1433029955-7346-1-git-send-email-albeu@free.fr>
        <1433031506-7984-5-git-send-email-albeu@free.fr>
        <20150608131758.9d76be074998ea3de0e976a4@gmail.com>
        <20150610235811.0b18af9b@tock>
        <20150615104213.92258d2d0616c12e4aa7bf1a@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47993
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

On Mon, 15 Jun 2015 10:42:13 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> On Wed, 10 Jun 2015 23:58:11 +0200
> Alban <albeu@free.fr> wrote:
> 
> > On Mon, 8 Jun 2015 13:17:58 +0300
> > Antony Pavlov <antonynpavlov@gmail.com> wrote:
> > 
> > > IMHO AR9132 SoC can't work without external oscilator.
> > > 
> > > Can we just move basic extosc declaration to SoC dt file
> > > (ar9132.dtsi)? So board dt file ar9132_tl_wr1043nd_v1.dts will
> > > contain only oscilator clock frequency value.
> > 
> > I would prefer to keep the split between the files in sync with the
> > hardware. I understand that most simple board designs use a fixed
> > oscillator, but that might not always be the case.
> > 
> 
> The AR9132 SoC __always__ use one external oscilator.

Yes, but what I don't like is to impose the clock source being a
fixed-oscillator. What if the board use a clock from another
component that need to be represented in the DT as something else
than a fixed-oscillator?

> So it's reasonable to have the first mention of extosc in
> ar9132.dtsi not in a board file. This description style is always
> sync with hardware.

In your proposal it wouldn't as the AR9132 doesn't have a
fixed-oscillator on chip. So boards using another type of clock would
still have that fixed-oscillator hanging around.

> On the other hand pll-controller is always part
> of the SoC not a part of a board. So pll-controller on extosc
> dependency have to go to SoC dts file not to a board file. In your dts
> description pll-controller is a part of a dts board file.

The PLL controller shows up in the board DTS as the connection between
the SoC and the other components on boards has to be represented. We
could use a label and reference it in the board file but that is the
same in the end.

But that's not really the point, more important is the fact that DTS
don't allow to delete nodes. This mean that DTSI should really not
start to define more than is strictly needed.

Alban
