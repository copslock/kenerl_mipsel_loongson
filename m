Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jun 2013 20:49:20 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:52171 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825885Ab3FXStIr3uC4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jun 2013 20:49:08 +0200
Received: by mail-pa0-f44.google.com with SMTP id lj1so11459572pab.17
        for <multiple recipients>; Mon, 24 Jun 2013 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=b8CqfMvkgxoLPUJ4YyoAJwEFUYk1KyN4frItbBBUKMI=;
        b=hru0a5Tsholgh//Q1PrRoVclvA3QXKu2CnJPUnGUZu+CAVcUCbh+9X5vIulj7JSbCc
         sJPFrS36oaMBvBwJacMbwzpcwIoEeRI9w8g4W0jAkluhNDrLgRAMtGstznZdAyb+4WUh
         mv/Kv4hmpkWYbLGLPpuMTHwZBP0hG7DlE6X4wt+Hks6FG0bKNc0nqLaMo7PnyXl1usIK
         eHY3w5vmVV9+pcDKqWt2RlgnnSBI9J6Dr2OVTJq9we6QP00ermidTf5Ws70MvKECY+Ak
         2STYpyUSZbrvAnX+DLzoTwYTFWU/2nVkGzxrfg50ZtS+BHBiAhCnfu2sNP+6hIvXgPZB
         na6g==
X-Received: by 10.68.75.110 with SMTP id b14mr25107485pbw.89.1372099731340;
        Mon, 24 Jun 2013 11:48:51 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id sq5sm21104219pab.11.2013.06.24.11.48.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 11:48:50 -0700 (PDT)
Message-ID: <51C89490.2060307@gmail.com>
Date:   Mon, 24 Jun 2013 11:48:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/2] MIPS: cavium-octeon: enable interfaces on EdgeRouter
 Lite
References: <1372023524-17333-1-git-send-email-aaro.koskinen@iki.fi> <1372023524-17333-2-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1372023524-17333-2-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/23/2013 02:38 PM, Aaro Koskinen wrote:
> Enable interfaces on EdgeRouter Lite. Tested with cavium_octeon_defconfig
> and busybox shell. DHCP & ping works with eth0, eth1 and eth2.
>
> The board type "UBNT_E100" is taken from the sources of the vendor kernel
> shipped with the product.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

I don't have a board to verify any of this, but...

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 13 +++++++++++++
>   arch/mips/include/asm/octeon/cvmx-bootinfo.h          |  2 ++
>   2 files changed, 15 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> index 9838c0e..2fcf030 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> @@ -183,6 +183,11 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
>   			return ipd_port - 16 + 4;
>   		else
>   			return -1;
> +	case CVMX_BOARD_TYPE_UBNT_E100:
> +		if (ipd_port >= 0 && ipd_port <= 2)
> +			return 7 - ipd_port;
> +		else
> +			return -1;
>   	}
>
>   	/* Some unknown board. Somebody forgot to update this function... */
> @@ -707,6 +712,14 @@ int __cvmx_helper_board_hardware_enable(int interface)
>   				}
>   			}
>   		}
> +	} else if (cvmx_sysinfo_get()->board_type ==
> +			CVMX_BOARD_TYPE_UBNT_E100) {
> +		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface), 0);
> +		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface), 0x10);
> +		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(1, interface), 0);
> +		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(1, interface), 0x10);
> +		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(2, interface), 0);
> +		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(2, interface), 0x10);
>   	}
>   	return 0;
>   }
> diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> index 284fa8d..7b7818d 100644
> --- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> +++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> @@ -227,6 +227,7 @@ enum cvmx_board_types_enum {
>   	 * use any numbers in this range.
>   	 */
>   	CVMX_BOARD_TYPE_CUST_PRIVATE_MIN = 20001,
> +	CVMX_BOARD_TYPE_UBNT_E100 = 20002,
>   	CVMX_BOARD_TYPE_CUST_PRIVATE_MAX = 30000,
>
>   	/* The remaining range is reserved for future use. */
> @@ -325,6 +326,7 @@ static inline const char *cvmx_board_type_to_string(enum
>
>   		    /* Customer private range */
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
> +		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
>   	}
>   	return "Unsupported Board";
>
