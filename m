Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 15:35:13 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990557AbdK1OfF6wzL- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 15:35:05 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF0E1BF0;
        Tue, 28 Nov 2017 14:34:57 +0000 (UTC)
Date:   Tue, 28 Nov 2017 15:35:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        "stable # 4 . 14" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Add custom serial.h with BASE_BAUD override
 for generic kernel
Message-ID: <20171128143502.GA17699@kroah.com>
References: <1511344649-27612-1-git-send-email-matt.redfearn@mips.com>
 <1511344649-27612-2-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511344649-27612-2-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61136
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

On Wed, Nov 22, 2017 at 09:57:29AM +0000, Matt Redfearn wrote:
> Add a custom serial.h header for MIPS, allowing platforms to override
> the asm-generic version if required.
> 
> The generic platform uses this header to set BASE_BAUD to 0. The
> generic platform supports multiple boards, which may have different
> UART clocks. Also one of the boards supported is the Boston FPGA board,
> where the UART clock depends on the loaded FPGA bitfile. As such there
> is no way that the generic kernel can set a compile time default
> BASE_BAUD.
> 
> Commit 31cb9a8575ca ("earlycon: initialise baud field of earlycon device
> structure") changed the behavior of of_setup_earlycon such that any baud
> rate set in the device tree is now set in the earlycon structure. The
> UART driver will then calculate a divisor based on BASE_BAUD and set it.
> With MIPS generic kernels this resulted in garbage output due to the
> incorrect uart clock rate being used to calculate a divisor. This
> commit, combined with "serial: 8250_early: Only set divisor if valid clk
> & baud" prevents the earlycon code setting a bad divisor and restores
> earlycon output.
> 
> Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
> Cc: stable <stable@vger.kernel.org> # 4.14
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> 
> ---
> 
>  arch/mips/include/asm/Kbuild   |  1 -
>  arch/mips/include/asm/serial.h | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/include/asm/serial.h
> 
> diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
> index 7c8aab23bce8..b1f66699677d 100644
> --- a/arch/mips/include/asm/Kbuild
> +++ b/arch/mips/include/asm/Kbuild
> @@ -16,7 +16,6 @@ generic-y += qrwlock.h
>  generic-y += qspinlock.h
>  generic-y += sections.h
>  generic-y += segment.h
> -generic-y += serial.h
>  generic-y += trace_clock.h
>  generic-y += unaligned.h
>  generic-y += user.h
> diff --git a/arch/mips/include/asm/serial.h b/arch/mips/include/asm/serial.h
> new file mode 100644
> index 000000000000..30be5cd8efdb
> --- /dev/null
> +++ b/arch/mips/include/asm/serial.h
> @@ -0,0 +1,21 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.

Which version of the GPL?  As it is, this means "GPL v1 and all others".

I doubt you want that :)

thanks,

greg k-h
