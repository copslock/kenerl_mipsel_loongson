Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Mar 2015 19:37:08 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:58649 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008174AbbCOShGojFI5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Mar 2015 19:37:06 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 0A26419C15B;
        Sun, 15 Mar 2015 20:37:07 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id Nx97H34MAsQw; Sun, 15 Mar 2015 20:37:02 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id DA8EB5BC010;
        Sun, 15 Mar 2015 20:37:01 +0200 (EET)
Date:   Sun, 15 Mar 2015 20:37:01 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Aleksey Makarov <aleksey.makarov@auriga.com>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Aaron Williams <aaron.williams@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Chris Ball <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] mmc: OCTEON: Add host driver for OCTEON MMC controller
Message-ID: <20150315183701.GB586@fuloong-minipc.musicnaut.iki.fi>
References: <1425567033-31236-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425567033-31236-1-git-send-email-aleksey.makarov@auriga.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46390
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

On Thu, Mar 05, 2015 at 05:50:31PM +0300, Aleksey Makarov wrote:
> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
> devices.  Device parameters are configured from device tree data.
> 
> eMMC, MMC and SD devices are supported.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
> Signed-off-by: Peter Swain <pswain@cavium.com>
> [aleksey.makarov@auriga.com: preparation for submission]
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>

Seems to work fine on EdgeRouter Pro (cn61xx).

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

However, there is a sparse warning that probably needs to be fixed:

	octeon_mmc.c:1141:29: error: incompatible types for operation (>=)
	octeon_mmc.c:1141:29:    left side has type struct gpio_desc *pwr_gpiod
	octeon_mmc.c:1141:29:    right side has type int

A.
