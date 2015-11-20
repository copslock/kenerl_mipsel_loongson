Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2015 18:33:21 +0100 (CET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:58002 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012082AbbKTRdTeMb8Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2015 18:33:19 +0100
Received: from blackmetal.musicnaut.iki.fi (85-76-66-151-nat.elisa-mobile.fi [85.76.66.151])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id CD2689001E;
        Fri, 20 Nov 2015 19:33:17 +0200 (EET)
Date:   Fri, 20 Nov 2015 19:32:33 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Aleksey Makarov <aleksey.makarov@auriga.com>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Chris Ball <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] mmc: OCTEON: Add host driver for OCTEON MMC controller
Message-ID: <20151120173233.GH18138@blackmetal.musicnaut.iki.fi>
References: <1426518362-24349-1-git-send-email-aleksey.makarov@auriga.com>
 <20150518210514.GG609@fuloong-minipc.musicnaut.iki.fi>
 <555A5C5C.9090903@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555A5C5C.9090903@auriga.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Mon, May 18, 2015 at 02:40:44PM -0700, Aleksey Makarov wrote:
> On 05/18/2015 02:05 PM, Aaro Koskinen wrote:
> >On Mon, Mar 16, 2015 at 06:06:00PM +0300, Aleksey Makarov wrote:
> >>The OCTEON MMC controller is currently found on cn61XX and cnf71XX
> >>devices.  Device parameters are configured from device tree data.
> >>
> >>eMMC, MMC and SD devices are supported.
> >>
> >>Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >>Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
> >>Signed-off-by: David Daney <david.daney@cavium.com>
> >>Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> >>Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
> >>Signed-off-by: Peter Swain <pswain@cavium.com>
> >>Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
> >>---
> >
> >Any updates on this patch? Are you still working on it for
> >the mainline kernel inclusion?
>
> We are working on it.  It will also be used in ARM ThunderX arch.  So we
> will send a new version soon.

Any updates?

Also distros are waiting for this patch, MMC is the main medium on
some boards:

	https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=800594

A.
