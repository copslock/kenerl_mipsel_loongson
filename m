Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 20:08:39 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35820 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990765AbdKNTIbnEWw- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 20:08:31 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vAEJ8T5n023700;
        Tue, 14 Nov 2017 20:08:29 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vAEJ8S5R023699;
        Tue, 14 Nov 2017 20:08:28 +0100
Date:   Tue, 14 Nov 2017 20:08:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3 04/11] MIPS: Octeon: Remove usage of cvmx_wait()
 everywhere.
Message-ID: <20171114190828.GD16044@linux-mips.org>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-5-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510633827-23548-5-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60933
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

On Mon, Nov 13, 2017 at 10:30:20PM -0600, Steven J. Hill wrote:

> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/cavium-octeon/executive/cvmx-helper.c |  2 +-
>  arch/mips/cavium-octeon/executive/cvmx-spi.c    | 10 +++++-----
>  arch/mips/include/asm/octeon/cvmx-fpa.h         |  4 +++-
>  arch/mips/include/asm/octeon/cvmx.h             | 15 ++-------------
>  arch/mips/pci/pcie-octeon.c                     | 12 ++++++------
>  5 files changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> index f24be0b..75108ec 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> @@ -862,7 +862,7 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
>  	 */
>  	cvmx_write_csr(CVMX_ASXX_RX_PRT_EN(INTERFACE(FIX_IPD_OUTPORT)), 0);
>  
> -	cvmx_wait(100000000ull);
> +	__delay(100000000ull);
>  
>  	for (retry_loop_cnt = 0; retry_loop_cnt < 10; retry_loop_cnt++) {
>  		retry_cnt = 100000;
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
> index 459e3b1..f51957a 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
> @@ -215,7 +215,7 @@ int cvmx_spi_reset_cb(int interface, cvmx_spi_mode_t mode)
>  	spxx_clk_ctl.u64 = 0;
>  	spxx_clk_ctl.s.runbist = 1;
>  	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
> -	cvmx_wait(10 * MS);
> +	__delay(10 * MS);

At this place and many others cvmx_wait() was used to wait for a number
of miliseconds, so I think it should better be replaced with something
like mdelay(10).

>  	spxx_bist_stat.u64 = cvmx_read_csr(CVMX_SPXX_BIST_STAT(interface));
>  	if (spxx_bist_stat.s.stat0)
>  		cvmx_dprintf
> @@ -265,14 +265,14 @@ int cvmx_spi_reset_cb(int interface, cvmx_spi_mode_t mode)
>  	spxx_clk_ctl.s.rcvtrn = 0;
>  	spxx_clk_ctl.s.srxdlck = 0;
>  	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
> -	cvmx_wait(100 * MS);
> +	__delay(100 * MS);

mdelay(100);

>  	/* Reset SRX0 DLL */
>  	spxx_clk_ctl.s.srxdlck = 1;
>  	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
>  
>  	/* Waiting for Inf0 Spi4 RX DLL to lock */
> -	cvmx_wait(100 * MS);

mdelay(100);

After these three substitions I think the variable MS in cvmx_spi_reset_cb()
will be unused.

Or will __delay() be used before bogomips is calibrated?

>  	/* Enable dynamic alignment */
>  	spxx_trn4_ctl.s.trntest = 0;
> @@ -527,7 +527,7 @@ int cvmx_spi_training_cb(int interface, cvmx_spi_mode_t mode, int timeout)
>  	spxx_clk_ctl.s.rcvtrn = 1;
>  	spxx_clk_ctl.s.srxdlck = 1;
>  	cvmx_write_csr(CVMX_SPXX_CLK_CTL(interface), spxx_clk_ctl.u64);
> -	cvmx_wait(1000 * MS);

mdelay(1000);

>  
>  	/* SRX0 clear the boot bit */
>  	spxx_trn4_ctl.u64 = cvmx_read_csr(CVMX_SPXX_TRN4_CTL(interface));
> @@ -536,7 +536,7 @@ int cvmx_spi_training_cb(int interface, cvmx_spi_mode_t mode, int timeout)
>  
>  	/* Wait for the training sequence to complete */
>  	cvmx_dprintf("SPI%d: Waiting for training\n", interface);
> -	cvmx_wait(1000 * MS);
> +	__delay(1000 * MS);

mdelay(1000);

>  	/* Wait a really long time here */
>  	timeout_time = cvmx_get_cycle() + 1000ull * MS * 600;
>  	/*
> diff --git a/arch/mips/include/asm/octeon/cvmx-fpa.h b/arch/mips/include/asm/octeon/cvmx-fpa.h
> index c00501d..29ae636 100644
> --- a/arch/mips/include/asm/octeon/cvmx-fpa.h
> +++ b/arch/mips/include/asm/octeon/cvmx-fpa.h
> @@ -36,6 +36,8 @@
>  #ifndef __CVMX_FPA_H__
>  #define __CVMX_FPA_H__
>  
> +#include <linux/delay.h>
> +
>  #include <asm/octeon/cvmx-address.h>
>  #include <asm/octeon/cvmx-fpa-defs.h>
>  
> @@ -165,7 +167,7 @@ static inline void cvmx_fpa_enable(void)
>  		}
>  
>  		/* Enforce a 10 cycle delay between config and enable */
> -		cvmx_wait(10);
> +		__delay(10);
>  	}
>  
>  	/* FIXME: CVMX_FPA_CTL_STATUS read is unmodelled */
> diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
> index 205ab2c..25854ab 100644
> --- a/arch/mips/include/asm/octeon/cvmx.h
> +++ b/arch/mips/include/asm/octeon/cvmx.h
> @@ -30,6 +30,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> +#include <linux/delay.h>
>  
>  enum cvmx_mips_space {
>  	CVMX_MIPS_SPACE_XKSEG = 3LL,
> @@ -429,18 +430,6 @@ static inline uint64_t cvmx_get_cycle(void)
>  }
>  
>  /**
> - * Wait for the specified number of cycle
> - *
> - */
> -static inline void cvmx_wait(uint64_t cycles)
> -{
> -	uint64_t done = cvmx_get_cycle() + cycles;
> -
> -	while (cvmx_get_cycle() < done)
> -		; /* Spin */
> -}
> -
> -/**
>   * Reads a chip global cycle counter.  This counts CPU cycles since
>   * chip reset.	The counter is 64 bit.
>   * This register does not exist on CN38XX pass 1 silicion
> @@ -481,7 +470,7 @@ static inline uint64_t cvmx_get_cycle_global(void)
>  				result = -1;				\
>  				break;					\
>  			} else						\
> -				cvmx_wait(100);				\
> +				__delay(100);				\
>  		}							\
>  	} while (0);							\
>  	result;								\
> diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
> index fd28874..87ba86b 100644
> --- a/arch/mips/pci/pcie-octeon.c
> +++ b/arch/mips/pci/pcie-octeon.c
> @@ -639,7 +639,7 @@ static int __cvmx_pcie_rc_initialize_link_gen1(int pcie_port)
>  			cvmx_dprintf("PCIe: Port %d link timeout\n", pcie_port);
>  			return -1;
>  		}
> -		cvmx_wait(10000);
> +		__delay(10000);
>  		pciercx_cfg032.u32 = cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG032(pcie_port));
>  	} while (pciercx_cfg032.s.dlla == 0);
>  
> @@ -821,7 +821,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
>  	 * don't poll PESCX_CTL_STATUS2[PCIERST], but simply wait a
>  	 * fixed number of cycles.
>  	 */
> -	cvmx_wait(400000);
> +	__delay(400000);
>  
>  	/*
>  	 * PESCX_BIST_STATUS2[PCLK_RUN] was missing on pass 1 of
> @@ -1018,7 +1018,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
>  		i = in_p_offset;
>  		while (i--) {
>  			cvmx_write64_uint32(write_address, 0);
> -			cvmx_wait(10000);
> +			__delay(10000);
>  		}
>  
>  		/*
> @@ -1034,7 +1034,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
>  			dbg_data.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_DBG_DATA);
>  			old_in_fif_p_count = dbg_data.s.data & 0xff;
>  			cvmx_write64_uint32(write_address, 0);
> -			cvmx_wait(10000);
> +			__delay(10000);
>  			dbg_data.u64 = cvmx_read_csr(CVMX_PEXP_NPEI_DBG_DATA);
>  			in_fif_p_count = dbg_data.s.data & 0xff;
>  		} while (in_fif_p_count != ((old_in_fif_p_count+1) & 0xff));
> @@ -1053,7 +1053,7 @@ static int __cvmx_pcie_rc_initialize_gen1(int pcie_port)
>  			cvmx_dprintf("PCIe: Port %d aligning TLP counters as workaround to maintain ordering\n", pcie_port);
>  			while (in_fif_p_count != 0) {
>  				cvmx_write64_uint32(write_address, 0);
> -				cvmx_wait(10000);
> +				__delay(10000);
>  				in_fif_p_count = (in_fif_p_count + 1) & 0xff;
>  			}
>  			/*
> @@ -1105,7 +1105,7 @@ static int __cvmx_pcie_rc_initialize_link_gen2(int pcie_port)
>  	do {
>  		if (cvmx_get_cycle() - start_cycle >  octeon_get_clock_rate())
>  			return -1;
> -		cvmx_wait(10000);
> +		__delay(10000);
>  		pciercx_cfg032.u32 = cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG032(pcie_port));
>  	} while ((pciercx_cfg032.s.dlla == 0) || (pciercx_cfg032.s.lt == 1));

  Ralf
