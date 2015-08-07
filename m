Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 12:43:46 +0200 (CEST)
Received: from mail-bn1bon0056.outbound.protection.outlook.com ([157.56.111.56]:50547
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011711AbbHGKnoW4abA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Aug 2015 12:43:44 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@caviumnetworks.com; 
Received: from rric.localhost (92.224.195.216) by
 CY1PR0701MB1613.namprd07.prod.outlook.com (10.163.20.150) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Fri, 7 Aug 2015 10:43:34 +0000
Date:   Fri, 7 Aug 2015 12:43:20 +0200
From:   Robert Richter <robert.richter@caviumnetworks.com>
To:     Tomasz Nowicki <tomasz.nowicki@linaro.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Sunil Goutham <sgoutham@cavium.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
Message-ID: <20150807104320.GQ1820@rric.localhost>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
 <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
 <55C467A0.4020601@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55C467A0.4020601@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [92.224.195.216]
X-ClientProxiedBy: AMSPR04CA0026.eurprd04.prod.outlook.com (10.242.87.144) To
 CY1PR0701MB1613.namprd07.prod.outlook.com (25.163.20.150)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1613;2:Fd/yOVmqT2YTIHVWcNu8l5l1qXS0r7q8GZHmb4ZVIa8JKVjPCOgKlHXyp7+43Tp1D20TsMnNO4Zfwrh49b9GX+X6gutvoggPHO9O0qoORq5AYV3HsHDT9u+Jb+bB66sDL/NHC1nhQrfJKe8IPk2ZSPXqP3gbsKV5av1Lrh6PNco=;3:2NpVX0VGn6Vau4MVGKmvDqWmeBUMwCU3qHD0BXPZH8JFx+IeD2+qER1aBd6+dHjL9xlDpCz46z1LhOuj53bY0OBy9czg/b48//ATdkwXquUyQN2jDCeDTYASqhl+sXs/zi+FW5N/A/+WPBEgA7DelA==;25:lXgblr5xNJP3Via0ViOfOdgKdX6pQKcV/1xVgjMw5crMQV0pFkRQnOe68DZEp3X6JDi8Gp98iGatI8M8y3Nmp1jyJwKvQRQgrLXblRqacak/g+ywVh445XUf7x/grPA9G88qwbcqb6b41/BqEx+YMpiVtNq3nkY9GU6HjdkbJ2RDEeQFTHGL7nfm03HAPpfHh49vPmVstUizsJWbOE5T1yqoNJ/2E8hfbG6Y8dOqar3DPzw/I+/7eV3/hYb5xQ15wno5PWJN6g6xDRbf+k9pHA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1613;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1613;20:RMvDd4F2FLmONp6IRUmgjn5Ysn5eNTKfd6qxSHhRN+e+OhJYHeZRZYOWJ/ECFk6azcAijkP0OOY3zXQgBsstUpoZr3ImF42HDjtEbWsSNYVx803kPgmFrEtnkyaAcR0oMdwHS6Xu9sfhEf91MnxEQ4EBY8EjduAn/PRpuZb5mvzKHUBVr7xZWtJS+VHEi/wjv2RA8beJKG7oOYZcDWwEd4c+AT13YipV/AsLwZq5ui7czPkIXFtuTKqfV6cN/QZguD7F0Ifblpa8lbRH3BGGkC+9QWzdmcLquSxq1LdHW+QWRRajurFbthBs/5+XcLFXLBOpuYGRQ6zLjcdxqz2tI/hC4KoO+kdcqdlGcciCDXhOZWHlF//sqm/+FrStEktvawBkLOLl8yQnd+Dow3JWfoPv9vckvidi97Ep5h/7+Ybwyan3N4R0nnd7CH2kE4O1VLStDJFkM4zJ+S+FS4Oz39rhxKI/lQmCpbL7xZIb0Semw7kwKNRbVN3M7rg4w6lkY1BP0aKrazok900wmr2Uab819zAIpJj7/Q5z3EZVGmxtEDEAikSD/5UpfddGsIb3Q57NfuBWFN5DteCdKbCyy4bd7gCkIAM6YPCJeoNCbh4=;4:Tv202D5jGVfQ1v/OVKP6jSQ/QSJV4E+LFnubp0yvXfzw/oa5MnLRQ0of+AVnbQRUanmYUkm09nthMg++FRkB9ZxfO3N7hKx6+Imzk+meCaJVXTlTrOI0ZmYWFgqEXs97JEFCtg70ZREDValaw/xl4z6hxvDsJ8qUKlQ4ibKZLnn/xl6p0ifSuGt1mvXsrTkxYDn3EVdXBoS9rVl9RaQC9xXq78TON7647IVRtnlR+J99ezgZkKBG5wO0MoIDfEylFcQaDk33z5P30Vf7skmmCnOpIw4rc1xmrGVF6Jl13nI=
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1613B52D8D10C3B8B4D89F57FC730@CY1PR0701MB1613.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:CY1PR0701MB1613;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1613;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(6009001)(199003)(24454002)(189002)(64706001)(5001860100001)(50466002)(66066001)(47776003)(23726002)(42186005)(76506005)(122386002)(40100003)(46102003)(46406003)(33656002)(81156007)(4001540100001)(5001960100002)(4001350100001)(77156002)(86362001)(110136002)(87976001)(62966003)(92566002)(97756001)(101416001)(83506001)(189998001)(77096005)(106356001)(105586002)(97736004)(54356999)(76176999)(50986999)(2950100001)(68736005)(5001830100001)(5001920100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1613;H:rric.localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1613;23:vEd7MvXIVqx97URNRJNw8mFG9FGds5dLuvWaI15?=
 =?us-ascii?Q?neZasFZE34h/OTsLA8PWBzmyXPLsdGw8GHabaPnT6KGzb15FDXLYaUQPYHKG?=
 =?us-ascii?Q?szz8kUK4ie21wr7tABbkIlM+SHu+/G96rMgOAkBEZVYcu9x+dvb6OvK2HUr/?=
 =?us-ascii?Q?ol5/PhWi3f3QDDNQvzt9WPXQbzFpEhzNX4m2EH05HXuIoqN0q6oCGf9pAYFc?=
 =?us-ascii?Q?XKwRSh5urSzlrqkWYbNZXSrneJ4sMpQ8xPQE2j/1m0vhmKxMrCUucl4/99+E?=
 =?us-ascii?Q?JZMie/fROdeoOYNwBA45wdkcv69w36RcMn0+ee0JvpxVxB4lrSDd0cCBoCCA?=
 =?us-ascii?Q?shfCeoFc4rqqkSljjh3Gw763JgYUHtBSyn/SNHUG+NQDhOvUO4LZQwgq5+yw?=
 =?us-ascii?Q?9oGJ/D1hE1kI6Xsr2wOyp+wVwnxozIy97XDqMd8j1oBeZQ40yLWxtt/3/VwN?=
 =?us-ascii?Q?zwlM/EX+/QRduy3fq8p8rp1s7MApLOYrk9o3cgTnaOAvtDhnBfSlMze1nGQ9?=
 =?us-ascii?Q?TaxJCPFwFBQwJeODHNUlN87eXsOm1vyOkK55hlBUlKo/2Nvy45app2fYpmgO?=
 =?us-ascii?Q?fgMGoWt4WCI+PdIb8zPHfqs0i7H00DZ+NeSjV4XKVlbGh8p2CNEXtuFnSLO4?=
 =?us-ascii?Q?8NndaT3Wkd2omW6TjVDGO2GXSZBKzvWICPP5fiHHJLJENvqEJJhR7scQqI82?=
 =?us-ascii?Q?iNHQUezY69Piy6cncLvRib7C8iPmxC2ssy8Q62QQqTX8X9nGjKvMqDQEGt6/?=
 =?us-ascii?Q?05ZVx/IfqGYd7fvOBni3xdG6kOA5TT1vcqoOsYf7ZqJM5bfNvEYjF+5VTqmF?=
 =?us-ascii?Q?gxWlyeGxeOaMuAFo8hGQs564N6A4/89Exf2AQ9GfeG+DEs6/ZSEVJVOSBCgU?=
 =?us-ascii?Q?7/RbRQXe6pESBMI0VWnErQ7+6yCY5np8X2PCLEMEkxpHa1wIwj2TmoNlzbYt?=
 =?us-ascii?Q?WBYRHGKj2/4YYTMDacH3kaXAGrSml32KOy28bpz+yX6LOPWEiuGz9vWbRKDw?=
 =?us-ascii?Q?mSqWN24EIw83h8EqJvMsXOWHmNNTnlxX9KZh05lJVDUiRI2mc1/+gzLmoMl7?=
 =?us-ascii?Q?U35IJhX3bZqzaZgakaEAmhXf313/r4eegniylZJy3YFcFSyOsK51/l8GehYP?=
 =?us-ascii?Q?KsW1GyR31QnxyEwZd0iLjCCJVGAFQoH87?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1613;5:TT6tDFd7flcBTHjLHvQWEC+gie/P1d0HnWL5B5ixWn2Xa+/BPuphPs2eq/K9pBq0RiuCZd7qJ8Dzof8qLhPkTiijDOgAFXU1GvHTmUTJzCvx1QFpIMVjMXfz2DNzOPUCdPpwx01itn7cjxoM+N8/KQ==;24:ZGMZ2sCYSpH5zeCYEd/iLg4GnKLxmAeMcihKN3B9FwuofTpgEQBdRT/riB1HS5w2M4qoBLimM8lnZU8OVqslKS7hBSHDPgFQ0FsIzk4nmmQ=;20:gtityx0+choz0Ew0pN9l3trh862vrRxRXrrmisIcKeV4dI4q8B5DQiOtsR/mF2n5n+mRVcacKLCL66aeumztZA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2015 10:43:34.8535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1613
Return-Path: <Robert.Richter@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@caviumnetworks.com
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

On 07.08.15 10:09:04, Tomasz Nowicki wrote:
> On 07.08.2015 02:33, David Daney wrote:

...

> >+#else
> >+
> >+static int bgx_init_acpi_phy(struct bgx *bgx)
> >+{
> >+	return -ENODEV;
> >+}
> >+
> >+#endif /* CONFIG_ACPI */
> >+
> >  #if IS_ENABLED(CONFIG_OF_MDIO)
> >
> >  static int bgx_init_of_phy(struct bgx *bgx)
> >@@ -882,7 +1010,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
> >
> >  static int bgx_init_phy(struct bgx *bgx)
> >  {
> >-	return bgx_init_of_phy(bgx);
> >+	int err = bgx_init_of_phy(bgx);
> >+
> >+	if (err != -ENODEV)
> >+		return err;
> >+
> >+	return bgx_init_acpi_phy(bgx);
> >  }
> >
> 
> If kernel can work with DT and ACPI (both compiled in), it should take only
> one path instead of probing DT and ACPI sequentially. How about:
> 
> @@ -902,10 +925,9 @@ static int bgx_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	bgx_vnic[bgx->bgx_id] = bgx;
>  	bgx_get_qlm_mode(bgx);
> 
> -	snprintf(bgx_sel, 5, "bgx%d", bgx->bgx_id);
> -	np = of_find_node_by_name(NULL, bgx_sel);
> -	if (np)
> -		bgx_init_of(bgx, np);
> +	err = acpi_disabled ? bgx_init_of_phy(bgx) : bgx_init_acpi_phy(bgx);
> +	if (err)
> +		goto err_enable;
> 
>  	bgx_init_hw(bgx);

I would not pollute bgx_probe() with acpi and dt specifics, and instead
keep bgx_init_phy(). The typical design pattern for this is:

static int bgx_init_phy(struct bgx *bgx)
{
#ifdef CONFIG_ACPI
        if (!acpi_disabled)
                return bgx_init_acpi_phy(bgx);
#endif
        return bgx_init_of_phy(bgx);
}

This adds acpi runtime detection (acpi=no), does not call dt code in
case of acpi, and saves the #else for bgx_init_acpi_phy().

-Robert
