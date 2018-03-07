Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 16:28:14 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:53977 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994721AbeCGP16BKWiy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 16:27:58 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1B61E2071D; Wed,  7 Mar 2018 16:27:51 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C785C20376;
        Wed,  7 Mar 2018 16:27:50 +0100 (CET)
Date:   Wed, 7 Mar 2018 16:27:51 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/5] MIPS: mscc: add ocelot dtsi
Message-ID: <20180307152751.GM3035@piout.net>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
 <20180306121607.1567-3-alexandre.belloni@bootlin.com>
 <20180307151753.GQ4197@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307151753.GQ4197@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 07/03/2018 at 15:17:56 +0000, James Hogan wrote:
> On Tue, Mar 06, 2018 at 01:16:04PM +0100, Alexandre Belloni wrote:
> > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > new file mode 100644
> > index 000000000000..8c3210577410
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > @@ -0,0 +1,117 @@
> > +//SPDX-License-Identifier: (GPL-2.0 OR MIT)
> 
> Niggle: there should be a space after // for consistency with other
> files. Same in patch 3.
> 

Ah, yes...

If that is the only thing left, I can resend right away


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
