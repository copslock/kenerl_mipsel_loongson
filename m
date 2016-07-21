Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2016 15:46:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34828 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992764AbcGUNqQ0kIyw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jul 2016 15:46:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u6LDk7br025812;
        Thu, 21 Jul 2016 15:46:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u6LDk4pq025810;
        Thu, 21 Jul 2016 15:46:04 +0200
Date:   Thu, 21 Jul 2016 15:46:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Steven J. Hill" <Steven.Hill@caviumnetworks.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
Message-ID: <20160721134603.GA25689@linux-mips.org>
References: <57853474.9050108@cavium.com>
 <578E71E6.2020700@caviumnetworks.com>
 <CAPDyKFqb-7LLM0XPtVWj1qHib991E2dHt+6W0UPgbXnukGkmXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqb-7LLM0XPtVWj1qHib991E2dHt+6W0UPgbXnukGkmXA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54353
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

On Tue, Jul 19, 2016 at 11:19:43PM +0200, Ulf Hansson wrote:

> > Has anyone reviewed the driver or have any comments? Thanks.
> 
> Sorry I need more time, been partly out of office lately.
> I intend to review this prior rc1 is out, but no promises.
> 
> Kind regards
> Uffe

Ulf,

if you decide to accept this patch, could you also push the bindings
patch ("[V8,1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller.")
upstream?  I think they should be merged together.

Thanks,

  Ralf
