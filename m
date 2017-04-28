Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 16:57:40 +0200 (CEST)
Received: from mga07.intel.com ([134.134.136.100]:6474 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991672AbdD1O5bevNLs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 16:57:31 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP; 28 Apr 2017 07:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,388,1488873600"; 
   d="scan'208";a="1141375960"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2017 07:57:26 -0700
Received: from irsmsx156.ger.corp.intel.com (10.108.20.68) by
 irsmsx110.ger.corp.intel.com (163.33.3.25) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 28 Apr 2017 15:55:49 +0100
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.187]) by
 IRSMSX156.ger.corp.intel.com ([169.254.3.246]) with mapi id 14.03.0319.002;
 Fri, 28 Apr 2017 15:55:49 +0100
From:   "Langer, Thomas" <thomas.langer@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] clk: Provide dummy of_clk_get_from_provider() for
 compile-testing
Thread-Topic: [PATCH v2] clk: Provide dummy of_clk_get_from_provider() for
 compile-testing
Thread-Index: AQHSwCC7E2nVSiHxc0qAEADJdZB76KHa3kHQ
Date:   Fri, 28 Apr 2017 14:55:48 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1E8AF019@IRSMSX101.ger.corp.intel.com>
References: <1493384933-31297-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1493384933-31297-1-git-send-email-geert+renesas@glider.be>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 10.0.102.7
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <thomas.langer@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.langer@intel.com
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



> -----Original Message-----
> From: devicetree-owner@vger.kernel.org [mailto:devicetree-
> owner@vger.kernel.org] On Behalf Of Geert Uytterhoeven
> Sent: Friday, April 28, 2017 3:09 PM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@codeaurora.org>; Russell King <linux@armlinux.org.uk>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; John Crispin
> <john@phrozen.org>; Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
> mips@linux-mips.org; linux-kernel@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>
> Subject: [PATCH v2] clk: Provide dummy of_clk_get_from_provider() for
> compile-testing
> 
> When CONFIG_ON=n, dummies are provided for of_clk_get() and
> of_clk_get_by_name(), but not for of_clk_get_from_provider().
> 
> Provide a dummy for the latter, to improve the ability to do
> compile-testing.  This requires removing the existing dummy in the
> Lantiq clock code.
> 
> Fixes: 766e6a4ec602d0c1 ("clk: add DT clock binding support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Regarding the Lantiq part:
Acked-by: Thomas Langer <thomas.langer@intel.com>

> ---
> v2:
>   - Remove conflicting dummy in Lantiq clock code (reported by 0day).
> ---
>  arch/mips/lantiq/clk.c | 5 -----
>  include/linux/clk.h    | 4 ++++
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
> index 149f0513c4f5d0d4..a263d1b751ffe48d 100644
> --- a/arch/mips/lantiq/clk.c
> +++ b/arch/mips/lantiq/clk.c
> @@ -160,11 +160,6 @@ void clk_deactivate(struct clk *clk)
>  }
>  EXPORT_SYMBOL(clk_deactivate);
> 
> -struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
> -{
> -	return NULL;
> -}
> -
>  static inline u32 get_counter_resolution(void)
>  {
>  	u32 res;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index e9d36b3e49de5b1b..3ed97abb5cbb7f94 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -539,6 +539,10 @@ static inline struct clk *of_clk_get_by_name(struct
> device_node *np,
>  {
>  	return ERR_PTR(-ENOENT);
>  }
> +static inline struct clk *of_clk_get_from_provider(struct of_phandle_args
> *clkspec)
> +{
> +	return ERR_PTR(-ENOENT);
> +}
>  #endif
> 
>  #endif
> --
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
