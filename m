Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2018 00:48:34 +0200 (CEST)
Received: from mail-sn1nam01on0119.outbound.protection.outlook.com ([104.47.32.119]:6968
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993961AbeF1WsXDe4jT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jun 2018 00:48:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wRssR+Jjh1I5SoO8JZHVA0wCjKSoDzhJCmo1DJx3FU=;
 b=eABwzceXepr6bd1aazTYBxaTSQ+cXEoUQT2lchJz/WNLqn/zvAwg1YXCxm1PPmBlzz5kd888972dRDWcZwI6D86FZpMxhwbkmIoTdSOhn/FIhlaKaxQywCfD7QxRy9Zm0esfqQXXy0sy4qG5sJLQI2Cz3d/a0Z8mh2HxFrkDbE0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4931.namprd08.prod.outlook.com (2603:10b6:408:28::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.21; Thu, 28 Jun 2018 22:48:11 +0000
Date:   Thu, 28 Jun 2018 15:48:08 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, jhogan@kernel.org, linux-mips@linux-mips.org,
        ak@linux.intel.com
Subject: Re: [PATCH] MIPS: remove const from mips_io_port_base
Message-ID: <20180628224808.osbostnj77pzrsod@pburton-laptop>
References: <20180616154745.28230-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616154745.28230-1-hauke@hauke-m.de>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To BN7PR08MB4931.namprd08.prod.outlook.com
 (2603:10b6:408:28::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e95742-0bd2-4079-b5db-08d5dd493a18
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4931;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;3:r1tsOwjQKwiEmMn0Z6gUMS7T0ULpA+gMJRrV66Oj/a6GQha+zc+nCKG/nKT0vCjauYUt/tusW5/j8AFWy3jejAfYJW5CM9/xppJWPuPH4o2gZr8r7EJ7f9UtWYEY2ez8haLDZapQhZkgXzEQJ7G+pQ8862cal5B2DPAGVz3DyYznqyxQLxaiZknv9OxRBJ48/E/gwyJmibPwgaRMrdb83+w8ba9GSkiDa8+8BaQ69366qtDeaWV7mZSoi/2VC50g;25:EoqQ2vMPd+amUYGp2fQwQaKyBZpNuU8tlp0cbSXtqw4PQloLk64W6WBO6t5BRlfXlWhiDVnor/heW4Gxkw1REAs7V3ODHXHhLhDyJNiFBzqiXkXxnMEP2mjnewmxvXkPoKJpjnHRO4CSUYjSgozqdJY4tlTgfllZXR6hr41o7oupF0Np4w31wKUFbPfkK1FPrOVaF8MDVa8L2uUqBCb0TUjdH7b1lUeb0J1lytimeucJzDCzHGyGL9KVeyKHDnhjOXaYWeyjRsMUKjzgA4XYqY6CtydOf0QahaPQrRnwWwek3fXwWCtkvhTQqkBNDibPNcljkCZBkV9KzYe80jmRkw==;31:5Xhi6tMU01YnGBsMYC4peAOlLhymorTa36CfrMeVQh6ZS1AHJBqA+KZECFOQPr2YP4NnThi1io9lwYUVYYxgETfJxj8tYk4wZpW61omWY5FkZJq8f23VhBPkU253QYprm3ykCoywde9nAeqZ0hvGRV0L7lwIRahMatwrsJdDinzIDAhk7vYDiIL7E9SNmdAe9vhTmn48TdXlFVVv2ovIXYCkWM4Hpj0eRM4f/eCl844=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4931:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;20:2001dmnAZXTGd2EpnPzWkzCqShFeIjkPCI5IabZ+msuvl0xsbhCjbDAqyae+1fDlJr/ASVjzgoI2Qi7FYWUQ/BWSq+BvrHaqdlF7Y243i3O1Xc3Nq87RMJTuKXezRSx85Vwtbk4UsFd2Jr8c13w3gk+9v8cM55ezZALvL8rhPfTHosbE/pC6R9y3fHttzb6YzR6b9qsjp+AnJc5rQt1DrG7Wp6h/4g7PSXUn6jPryq6SGhNOJgumEz4N23K6N448;4:Y1MzDL0qQeVxkYr5Gh1x+erLI2+g/4tl13gTldKSwF8YhSy/ZsOBICBH1pHlzkpyKh+DdVa1d6YeFfOioc2UqNr0uAbVANabOSs0x02ITCqPxPtcyMmf+V/BcalfoTCZoNctmadPBWCfVxtP9CX/kc6r1kEsSYzIjLMIJYT5SjPYef6Iix/+Md7HJ9Yvd6pXY/bL89GcdIIT7AMTFF0tWIPUIqoT9iPsFs+Mu4tUBSWZ0kr44NrirpTZ5FJ0gsJ+TclSDVGcLfec8ydYeEvUbA==
X-Microsoft-Antispam-PRVS: <BN7PR08MB493127BCA1A6B7DEE862A9E5C14F0@BN7PR08MB4931.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4931;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4931;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(39840400004)(396003)(366004)(136003)(376002)(52314003)(199004)(189003)(54094003)(476003)(23726003)(3846002)(6116002)(68736007)(11346002)(6486002)(1076002)(446003)(44832011)(486006)(7736002)(575784001)(956004)(81166006)(81156014)(9686003)(8936002)(8676002)(2906002)(66066001)(76506005)(33896004)(305945005)(386003)(5660300001)(47776003)(4326008)(6916009)(106356001)(42882007)(26005)(33716001)(186003)(229853002)(6666003)(50466002)(16526019)(105586002)(53936002)(6246003)(16586007)(25786009)(316002)(6496006)(58126008)(97736004)(76176011)(52116002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4931;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4931;23:mr8W3pQg7KopdWRrCfmhlpIykBC4N4Rz4SgBCUC+1?=
 =?us-ascii?Q?9Ztn0mAhExkKgCdRfl8jpTtQFryNYe8JZm1KJ0p1pqwmV4CqiMg4vTy5qskR?=
 =?us-ascii?Q?8EdtqobPvFJkgXxKA4i0XTHIxsxKYJBMuzulzvbz/IQIBiG9BO3mmuhbFCTX?=
 =?us-ascii?Q?sH9Ut7JcLRbHgCJdZc8buAHiyWJuRjojtjXA1xd4TxT96pGB3hK7GNMfVP0r?=
 =?us-ascii?Q?nvTNN5v5C9/TMZcULoIccocyMmtPt+fOxIjYDJMlvNkXridF4BzJypfTNf50?=
 =?us-ascii?Q?S0JifADyZoBQh/Kw1Ji3magNvtIY9ETa+Zdq1+EWGGSUkNmZIKuw8+gHCCt7?=
 =?us-ascii?Q?popM9LjAiKdJGk1iy44zE9JHuUp0RPh74p6eErC/C6mDQPxsHvTKbiapYIsH?=
 =?us-ascii?Q?ybUs13wNQW7uNv8dk+3PLFbyPLyJgwmh3PWINR3ajY4ENtcaGI8+Mrt2vla1?=
 =?us-ascii?Q?H29w7jo0akyqGZe2qzcRqbjYCquDoBQEDNCugrqTZmYzfybUfiQ8XvWvF9/b?=
 =?us-ascii?Q?Fcs4WTwBW8XHcMAsy9JjUT50EbqYH5eZOvapqRlpiS0JYTyF0OENBdsy7cjt?=
 =?us-ascii?Q?zuTi0PG5panVql3Vz5X+vl3mroaEG4DAYy+PlEBvKaZ1URWMxuJ33Xt66Oo7?=
 =?us-ascii?Q?1PaBfp9CpWC1WPnBsCVwXNJKJsNKTWgJfTuT0ibxQRh1KYm00cH0d6F/qpxt?=
 =?us-ascii?Q?qGufEBeylXWpPpeJm3Wf3QZn0vi6mbbn4vnZzo9tzYUNX+zPs5ZbJpj6eoJr?=
 =?us-ascii?Q?P+NIc0kMFerbjT4vQz4udNrtoThF2X8IEe10JC78LQtKwZkstg0u/GnoH+D9?=
 =?us-ascii?Q?GPKNED9v7fbU1A0ZxM8Rhyr/ouAjca9EDirAW0ASvZrk6okeGS7MbvLqQnL4?=
 =?us-ascii?Q?0erSTrNNWonbbaQkz+J4K60ZcvmGLow+4Ehd6pvcWl82pNIwX6pgMaf6h0DI?=
 =?us-ascii?Q?tsNpPgEHTy9IqK1UJPC555cd29faaOQIsQVK1m1yesyE2nMDPEC7GaI3WQqi?=
 =?us-ascii?Q?rkbkO/a8r9/0aHahVZnlv5noNKBni2T0ppCnYUfrZ95FUh6LN/D3mzGfzE6Z?=
 =?us-ascii?Q?0boVZl87rLXIvA2e3YWBaBMWHh1ZJuPT64797w1q1xBpSjjwMKVjfiUf7NMp?=
 =?us-ascii?Q?V5XGKYKHk0pCICpfPqXrWU0hLlf7bM6mzbVuHUVXEm2g7wux1lxu6NDuGh6P?=
 =?us-ascii?Q?fbeDo9m2gPHISkPW9r8cwIIlgRFyHsQNKpi6gwmHccSYvLnfkD6VCahqLIAY?=
 =?us-ascii?Q?/yS4oEhawUayT6Zrte8AlGhosRk2mmCuYJnyjbZKDFMVA//srgva4AnGrio3?=
 =?us-ascii?Q?7yc6oPzokRLoNCW9RoGkONWhov3p3V/qwA8WWAc869qsa5FYGzv/lQG7x2x3?=
 =?us-ascii?Q?lgTOw=3D=3D?=
X-Microsoft-Antispam-Message-Info: iQEwZBMaWvWdtZOMf/Y9UXS+ckyDQtpo7pOUweqDKIxoAoYfKLEfQMr78JyDUybIQXW4CTcFRZtzP/CikTHc0pcjqIl5UWqdKbnYrSBfTm9sQirxTLWV9d7nh/Iy/xEM5h9FnGHfgCWa/UdgNRhu1CX+TUHPkc1S4NKwsc3efOkDVxp2i9t1hHSCSYZO8+GcqQaEHFz3kFvDvSWEwyydcXBOLyhjUJC6Xb9FMqHgwUNfYTzOkw/Vgijs8eD1T/k9gPj3KSlXRUW3be+KDINMYjqu9A1hVsiGhfaEJYLmBtS7s9HCkdRgrGOUd0hRDvs2F40MiyUBFPaXROkoWHfq+qplIPf7N2bo/FLOHFuu7GI=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;6:luuqGYj/j/6oxxWxjINhFCE+N0TAHoLd8MNotv57BeEISD7qpWfa/hIeHXvJ4C4czSOeY/NT/9wWAV1tSf9WFuTUDl8cSZD7/b3rHrcULkJ6G70MVeKkpfV4m7KfWFFWX1XeRskEpCeXsJg2eHs/WQb9+PpJ8a9WPdxzzjH9soX8HaHt/1g0BmqEgpcGxTja21YfHdMNKQph/Cr3H+a75LAL6Co1Wc4z4ISWnN6rEJm+3H47Q7Jw6SgA5eYG/GW9cpgmDMxcfGda3ZW02XS8ltI94OmXiP6mmX5O7ruEizUdJWfsXz3N4Hyeoh/RubiEu8I9Wcs7S5m3X9YPtqMGJeeVjzjqNPHUQwUmY/WguKL0vX98p1ObK0M3SbOqP9k0o/fQnWgqWCWiHat3v3tdS3WqqOlqcQhHKu4YJXSHGysz87LBZ33bPr9jGig7AkCn73ANCej680i8r48HrUxBcg==;5:tmexsE33xrg2EppDEvIW8MUxFGvyC8Hp53/vwqkrlP8hZQYb4mmviWelhBMvl7j2SCw2vSW3+RKPjNTyPATM5fIQQLsmvJONJYyRGWDBOvmfXcBDzYiXkV3sX4WOBuKUvnBKE9z+yObYN54Omuzyw5jTEOt/w3Y4iU0ukrJg7w4=;24:j3Ugy3I6rfiugxK7W0Vu6zzzj4QqwGznQDMbYXtMCzRFlVPpWjhfhWiKaNCArSaSAYR+2MIPyYaS7jaMm60PZ8Qav89Gj0Cr+xu18ekM5aE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;7:4jlygnIOmYewMaiVAC6Zq7Oo6wrX42w+02N+NAibvP1c3nmby/ugMkMuVaTj58XuRjXI84kT1qyFyK7ZWVYavDma4g/hM6WpHR02tVavbK0D8QdZUFKfOwjYe8YLjKY7C/orvZ9QtwSZphFEhIxHu5+V2K3RluTOKnIqoUlru05YeL4ZSKP/LMn13vzDjgKBT9Rfrrbo9A3XEAQ9EjQB/86ZSbAMMCnYiP1Gv2dYM36EmAgGqG/kj66EQL5NU72x
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 22:48:11.8279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e95742-0bd2-4079-b5db-08d5dd493a18
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4931
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Hauke,

On Sat, Jun 16, 2018 at 05:47:45PM +0200, Hauke Mehrtens wrote:
> This variable is changed by some platform init code. When LTO is used
> gcc assumes that the variable never changes and inlines the constant
> instead of checking this variable which is wrong.
> 
> This fixes a runtime boot problem when LTO is activated.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/include/asm/io.h | 2 +-
>  arch/mips/kernel/setup.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

This does cause GCC 8.1.0 to emit extra loads, adding 652 bytes to a
32r2el_defconfig build from current mips-next. I'd expect kernels for
some of the older supported machines might show a larger gain as they're
more likely to use inX/outX. Combined with the fact that LTO support
isn't in mainline yet anyway, this makes me hesitant to apply this one.

Although it is tempting from the standpoint that set_io_port_base() is
an ugly hack & this would allow its removal... I wonder if we could
clean that up in the same patch though, since it's a natural consequence
of removing const & might make it attractive enough to tolerate the code
size increase.

Even better might be if we could use a fixed virtual address for the I/O
port base, for example by using fixmap. That should give even better
code generation but would of course have TLB overhead & be more
complicated to implement.

Thanks,
    Paul

> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index a7d0b836f2f7..f28f8cd44dd3 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -60,7 +60,7 @@
>   * instruction, so the lower 16 bits must be zero.  Should be true on
>   * on any sane architecture; generic code does not use this assumption.
>   */
> -extern const unsigned long mips_io_port_base;
> +extern unsigned long mips_io_port_base;
>  
>  /*
>   * Gcc will generate code to load the value of mips_io_port_base after each
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 2c96c0c68116..153460c531a9 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -75,7 +75,7 @@ static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
>   * mips_io_port_base is the begin of the address space to which x86 style
>   * I/O ports are mapped.
>   */
> -const unsigned long mips_io_port_base = -1;
> +unsigned long mips_io_port_base = -1;
>  EXPORT_SYMBOL(mips_io_port_base);
>  
>  static struct resource code_resource = { .name = "Kernel code", };
> -- 
> 2.11.0
> 
