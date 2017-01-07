Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jan 2017 01:14:58 +0100 (CET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:39810 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990508AbdAGAOt06TJM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Jan 2017 01:14:49 +0100
Received: from raspberrypi-2.musicnaut.iki.fi (85-76-79-36-nat.elisa-mobile.fi [85.76.79.36])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id CAAD142AC;
        Sat,  7 Jan 2017 02:14:48 +0200 (EET)
Date:   Sat, 7 Jan 2017 02:14:48 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: Platform support for DWC3 USB controller.
Message-ID: <20170107001448.oeef42gtjo72zznn@raspberrypi-2.musicnaut.iki.fi>
References: <ee4bb10f-aa3e-3f22-4ee1-7d2d397c466c@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee4bb10f-aa3e-3f22-4ee1-7d2d397c466c@cavium.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56224
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

On Fri, Jan 06, 2017 at 05:42:24PM -0600, Steven J. Hill wrote:
> Add all the necessary platform code to initialize the dwc3
> USB host controller found on OCTEON III processors. This
> code initializes the clocks and resets the USB core with
> PHYs. It is then passed off to the platform independent
> DWC3 driver found in the 'drivers/usb/dwc3' directory.
> Based off code written by David Daney.
> 
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>

[...]

> +/* USB Control Register */
> +union cvm_usbdrd_uctl_ctl {
> +	uint64_t u64;
> +	struct cvm_usbdrd_uctl_ctl_s {
> +	/* 1 = BIST and set all USB RAMs to 0x0, 0 = BIST */
> +	__BITFIELD_FIELD(uint64_t clear_bist:1,
> +	/* 1 = Start BIST and cleared by hardware */
> +	__BITFIELD_FIELD(uint64_t start_bist:1,
> +	/* Reference clock select for SuperSpeed and HighSpeed PLLs:
> +	 *	0x0 = Both PLLs use DLMC_REF_CLK0 for reference clock
> +	 *	0x1 = Both PLLs use DLMC_REF_CLK1 for reference clock
> +	 *	0x2 = SuperSpeed PLL uses DLMC_REF_CLK0 for reference clock &
> +	 *	      HighSpeed PLL uses PLL_REF_CLK for reference clck
> +	 *	0x3 = SuperSpeed PLL uses DLMC_REF_CLK1 for reference clock &
> +	 *	      HighSpeed PLL uses PLL_REF_CLK for reference clck
> +	 */

Maybe use kernel-doc comment style to document the fields?

> +typedef union cvm_usbdrd_uctl_ctl cvm_usbdrd_uctl_ctl_t;

[...]

> +typedef union cvm_usbdrd_uctl_host_cfg cvm_usbdrd_uctl_host_cfg_t;

[...]

> +typedef union cvm_usbdrd_uctl_shim_cfg cvm_usbdrd_uctl_shim_cfg_t;

These typedefs are not used, so they should not be added.

A.
