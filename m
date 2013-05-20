Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 01:10:15 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46545 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825726Ab3ETXKKNFxub (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 May 2013 01:10:10 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45E58567;
        Mon, 20 May 2013 23:10:02 +0000 (UTC)
Date:   Mon, 20 May 2013 16:10:01 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
        spi-devel-general@lists.sourceforge.net,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: Rename Kconfig
 CAVIUM_OCTEON_REFERENCE_BOARD to CAVIUM_OCTEON_SOC
Message-ID: <20130520231001.GA21559@kroah.com>
References: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369088378-13957-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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
> Cc: linux-ide@vger.kernel.org
> Cc: linux-edac@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: spi-devel-general@lists.sourceforge.net
> Cc: devel@driverdev.osuosl.org
> Cc: linux-usb@vger.kernel.org
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
