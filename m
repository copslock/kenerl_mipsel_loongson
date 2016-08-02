Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2016 15:44:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55758 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993006AbcHBNo0uc5zU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2016 15:44:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u72DiKsQ024395;
        Tue, 2 Aug 2016 15:44:20 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u72DiI0q024394;
        Tue, 2 Aug 2016 15:44:18 +0200
Date:   Tue, 2 Aug 2016 15:44:18 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Baole Ni <baolex.ni@intel.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     fenghua.yu@intel.com, robert.jarzmik@free.fr,
        linux@armlinux.org.uk, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, chuansheng.liu@intel.com
Subject: Re: [PATCH 0014/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802134418.GF15910@linux-mips.org>
References: <20160802103421.14690-1-baolex.ni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160802103421.14690-1-baolex.ni@intel.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54398
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

On Tue, Aug 02, 2016 at 06:34:21PM +0800, Baole Ni wrote:

> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  arch/mips/txx9/generic/7segled.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/txx9/generic/7segled.c b/arch/mips/txx9/generic/7segled.c
> index 566c58b..1fcd1ec 100644
> --- a/arch/mips/txx9/generic/7segled.c
> +++ b/arch/mips/txx9/generic/7segled.c
> @@ -55,8 +55,8 @@ static ssize_t raw_store(struct device *dev,
>  	return size;
>  }
>  
> -static DEVICE_ATTR(ascii, 0200, NULL, ascii_store);
> -static DEVICE_ATTR(raw, 0200, NULL, raw_store);
> +static DEVICE_ATTR(ascii, S_IWUSR, NULL, ascii_store);
> +static DEVICE_ATTR(raw, S_IWUSR, NULL, raw_store);
>  
>  static ssize_t map_seg7_show(struct device *dev,
>  			     struct device_attribute *attr,
> @@ -76,7 +76,7 @@ static ssize_t map_seg7_store(struct device *dev,
>  	return size;
>  }
>  
> -static DEVICE_ATTR(map_seg7, 0600, map_seg7_show, map_seg7_store);
> +static DEVICE_ATTR(map_seg7, S_IRUSR | S_IWUSR, map_seg7_show, map_seg7_store);
>  
>  static struct bus_type tx_7segled_subsys = {
>  	.name		= "7segled",

I find this one of the case where the number is much understandable than
a cryptic symbol whos name was chosen when C compilers still had
limitations on the symbol length and every byte was sacred.

  Ralf
