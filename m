Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2016 12:03:05 +0100 (CET)
Received: from mga05.intel.com ([192.55.52.43]:43023 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990510AbcLHLC61KwLa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Dec 2016 12:02:58 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP; 08 Dec 2016 03:02:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,319,1477983600"; 
   d="scan'208";a="1079175032"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2016 03:02:55 -0800
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX152.ger.corp.intel.com (163.33.192.66) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Thu, 8 Dec 2016 11:02:53 +0000
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.248]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.55]) with mapi id 14.03.0248.002;
 Thu, 8 Dec 2016 11:02:53 +0000
From:   "Langer, Thomas" <thomas.langer@intel.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "john@phrozen.org" <john@phrozen.org>
Subject: RE: [PATCH] MIPS: lantiq: fix mask of GPE frequency
Thread-Topic: [PATCH] MIPS: lantiq: fix mask of GPE frequency
Thread-Index: AQHSUNFnRao4sep82k6yttcyWkRQ1qD92W9Q
Date:   Thu, 8 Dec 2016 11:02:52 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1E68CB3B@IRSMSX101.ger.corp.intel.com>
References: <20161207213200.32611-1-hauke@hauke-m.de>
In-Reply-To: <20161207213200.32611-1-hauke@hauke-m.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <thomas.langer@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55973
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
> From: Hauke Mehrtens [mailto:hauke@hauke-m.de]
> Sent: Wednesday, December 7, 2016 10:32 PM
> To: ralf@linux-mips.org
> Cc: dan.carpenter@oracle.com; linux-mips@linux-mips.org; john@phrozen.org;
> Hauke Mehrtens <hauke@hauke-m.de>; Langer, Thomas
> <thomas.langer@intel.com>
> Subject: [PATCH] MIPS: lantiq: fix mask of GPE frequency
> 
> The hardware documentation says bit 11:10 are used for the GPE
> frequency selection. Fix the mask in the define to match these bits.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Thomas Langer <thomas.langer@intel.com>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/lantiq/falcon/sysctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/lantiq/falcon/sysctrl.c
> b/arch/mips/lantiq/falcon/sysctrl.c
> index 2a1b302..82bbd0e 100644
> --- a/arch/mips/lantiq/falcon/sysctrl.c
> +++ b/arch/mips/lantiq/falcon/sysctrl.c
> @@ -24,7 +24,7 @@
> 
>  /* GPE frequency selection */
>  #define GPPC_OFFSET		24
> -#define GPEFREQ_MASK		0x00000C0
> +#define GPEFREQ_MASK		0x0000C00
>  #define GPEFREQ_OFFSET		10
>  /* Clock status register */
>  #define SYSCTL_CLKS		0x0000

Looks good. 

Reviewed-by: Thomas Langer <thomas.langer@intel.com>
