Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2015 23:05:20 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:34684 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012890AbbERVFSYUyqS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2015 23:05:18 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id C74485A6DBC;
        Tue, 19 May 2015 00:05:07 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id g521RlM8adaT; Tue, 19 May 2015 00:05:02 +0300 (EEST)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 2CED85BC015;
        Tue, 19 May 2015 00:05:15 +0300 (EEST)
Date:   Tue, 19 May 2015 00:05:14 +0300
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
Message-ID: <20150518210514.GG609@fuloong-minipc.musicnaut.iki.fi>
References: <1426518362-24349-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426518362-24349-1-git-send-email-aleksey.makarov@auriga.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47464
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

On Mon, Mar 16, 2015 at 06:06:00PM +0300, Aleksey Makarov wrote:
> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
> devices.  Device parameters are configured from device tree data.
> 
> eMMC, MMC and SD devices are supported.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
> Signed-off-by: Peter Swain <pswain@cavium.com>
> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
> ---

Any updates on this patch? Are you still working on it for
the mainline kernel inclusion?

A:
