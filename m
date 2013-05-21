Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 11:25:10 +0200 (CEST)
Received: from sauhun.de ([89.238.76.85]:59024 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822345Ab3EUJZJIs4V0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 May 2013 11:25:09 +0200
Received: from p5b386bb1.dip0.t-ipconnect.de ([91.56.107.177]:8821 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <wsa@the-dreams.de>)
        id 1Ueiob-0005qC-4L; Tue, 21 May 2013 11:25:05 +0200
Date:   Tue, 21 May 2013 11:26:40 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
        spi-devel-general@lists.sourceforge.net,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: Rename Kconfig
 CAVIUM_OCTEON_REFERENCE_BOARD to CAVIUM_OCTEON_SOC
Message-ID: <20130521092637.GA2975@katana>
References: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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

On Mon, May 20, 2013 at 03:19:38PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> CAVIUM_OCTEON_SOC most place we used to use CPU_CAVIUM_OCTEON.  This
> allows us to CPU_CAVIUM_OCTEON in places where we have no OCTEON SOC.
> 
> Remove CAVIUM_OCTEON_SIMULATOR as it doesn't really do anything, we can
> get the same configuration with CAVIUM_OCTEON_SOC.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

For I2C:

Acked-by: Wolfram Sang <wsa@the-dreams.de>
