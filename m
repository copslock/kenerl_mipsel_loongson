Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2015 11:36:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50026 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011512AbbKLKgyONG0k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Nov 2015 11:36:54 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tACAaqil016059;
        Thu, 12 Nov 2015 11:36:52 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tACAao3C016058;
        Thu, 12 Nov 2015 11:36:50 +0100
Date:   Thu, 12 Nov 2015 11:36:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        blogic@openwrt.org, Jonas Gorski <jogo@openwrt.org>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Paul Bolle <pebolle@tiscali.nl>
Subject: Re: MIPS: BMIPS: Enable GZIP ramdisk and timed printks
Message-ID: <20151112103650.GF22591@linux-mips.org>
References: <56446776.5020406@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56446776.5020406@fau.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49897
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

On Thu, Nov 12, 2015 at 11:18:30AM +0100, Andreas Ziegler wrote:

> Hi Florian,
> 
> your patch "MIPS: BMIPS: Enable GZIP ramdisk and timed printks"
> showed up as commit fb9e5642aa9e in linux-next today (that is,
> next-20151112). I noticed it because we (a research group from
> Erlangen[0]) are running daily checks on linux-next.
> 
> Your commit adds two entries to arch/mips/configs/bmips_stb_defconfig,
> but one of them has a typo (line 37):
> 
> CONFIG_PRINK_TIME=y
> 
> which should instead say (notice the missing 'T'):
> 
> CONFIG_PRINTK_TIME=y
> 
> Not sure how this got two Reviewed-by's, as this simple mistake could
> have been easily spotted by running scripts/checkkconfigsymbols.py on
> the patch.

Sigh, fixed.

  Ralf
