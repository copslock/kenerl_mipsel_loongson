Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 22:24:33 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:49442 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008875AbaLOVY3we7sv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 22:24:29 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 7AD5B21B8A9;
        Mon, 15 Dec 2014 23:24:29 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id CvmN9tbCAxXA; Mon, 15 Dec 2014 23:24:22 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id D6A625BC011;
        Mon, 15 Dec 2014 23:24:22 +0200 (EET)
Date:   Mon, 15 Dec 2014 23:24:22 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Aleksey Makarov <feumilieu@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 14/14] MIPS: OCTEON: Handle OCTEON III in csrc-octeon.
Message-ID: <20141215212422.GD10323@fuloong-minipc.musicnaut.iki.fi>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
 <1418666603-15159-15-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418666603-15159-15-git-send-email-aleksey.makarov@auriga.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44702
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

On Mon, Dec 15, 2014 at 09:03:20PM +0300, Aleksey Makarov wrote:
>  	if (current_cpu_type() == CPU_CAVIUM_OCTEON2) {
>  		union cvmx_mio_rst_boot rst_boot;
> +
>  		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
>  		rdiv = rst_boot.s.c_mul;	/* CPU clock */
>  		sdiv = rst_boot.s.pnr_mul;	/* I/O clock */
>  		f = (0x8000000000000000ull / sdiv) * 2;
> +	} else if (current_cpu_type() == CPU_CAVIUM_OCTEON3) {
> +		union cvmx_rst_boot rst_boot;
> +
> +		rst_boot.u64 = cvmx_read_csr(CVMX_RST_BOOT);
> +		rdiv = rst_boot.s.c_mul;	/* CPU clock */
> +		sdiv = rst_boot.s.pnr_mul;	/* I/O clock */
> +		f = (0x8000000000000000ull / sdiv) * 2;
>  	}

The f = ... part could be moved outside the if blocks to avoid copy paste.

A.
