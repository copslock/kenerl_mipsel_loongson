Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2012 13:23:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35580 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824804Ab2K1MXDE1bnQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Nov 2012 13:23:03 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qASCMxo5014269;
        Wed, 28 Nov 2012 13:22:59 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qASCMt0M014268;
        Wed, 28 Nov 2012 13:22:55 +0100
Date:   Wed, 28 Nov 2012 13:22:55 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org, Michal Marek <mmarek@suse.cz>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 05/15] MIPS: Netlogic: keep .dtb/.dtb.S until make clean
Message-ID: <20121128122255.GA13997@linux-mips.org>
References: <cover.1351688140.git.jchandra@broadcom.com>
 <7a800eb7eb2a75800749cab24e67c6b1e3c76b7c.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a800eb7eb2a75800749cab24e67c6b1e3c76b7c.1351688140.git.jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35152
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Oct 31, 2012 at 06:31:31PM +0530, Jayachandran C wrote:

> Provide a .SECONDARY entry for these intermediate files. Otherwise
> make deletes them, and these files are regenerated for every rebuild.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  arch/mips/netlogic/dts/Makefile |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
> index 67ae3fe2..40502ff 100644
> --- a/arch/mips/netlogic/dts/Makefile
> +++ b/arch/mips/netlogic/dts/Makefile
> @@ -1,4 +1,14 @@
> -obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
> +DTS_FILE		= xlp_evp.dts
> +DTB_FILE		= $(patsubst %.dts, %.dtb, $(DTS_FILE))
>  
> -$(obj)/%.dtb: $(obj)/%.dts
> -	$(call if_changed,dtc)
> +# built-in dtb
> +obj-$(CONFIG_DT_XLP_EVP) := $(DTB_FILE).o
> +
> +$(obj)/%.dtb: $(src)/%.dts
> +	$(call if_changed_dep,dtc)
> +
> +# Keep intermediate files .dtb and .dtb.S, delete them only at make clean
> +KEEP_FILES		= $(DTB_FILE) $(DTB_FILE).S
> +clean-files		+= $(KEEP_FILES)
> +
> +.SECONDARY: $(addprefix $(obj)/, $(KEEP_FILES))

This patch conflicts with a patch series by Stephen Warren to centralize
the .dts -> .dtb rules that currently exist scattered across arch/.

  Ralf
