Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 14:23:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33349 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824795Ab3EVMXKq2Nmk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 May 2013 14:23:10 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4MCMq32025550;
        Wed, 22 May 2013 14:22:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4MCMXsW025549;
        Wed, 22 May 2013 14:22:33 +0200
Date:   Wed, 22 May 2013 14:22:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
        spi-devel-general@lists.sourceforge.net,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: Rename Kconfig
 CAVIUM_OCTEON_REFERENCE_BOARD to CAVIUM_OCTEON_SOC
Message-ID: <20130522122232.GD10769@linux-mips.org>
References: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
 <20130521220457.GF31836@blackmetal.musicnaut.iki.fi>
 <519BF01B.1010600@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519BF01B.1010600@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36521
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

On Tue, May 21, 2013 at 03:07:23PM -0700, David Daney wrote:

> >>  config USB_OCTEON_OHCI
> >>  	bool "Octeon on-chip OHCI support"
> >>-	depends on CPU_CAVIUM_OCTEON
> >>+	depends on  CAVIUM_OCTEON_SOC
> >
> >Just a minor comment, here the extra whitespace after "depends on"
> >could be eliminated.
> >
> 
> Good point.  I will regenerate the patch to correct this.

I took care of that and queued the patch.

Thanks,

  Ralf
