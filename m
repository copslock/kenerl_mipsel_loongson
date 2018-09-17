Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2018 21:16:29 +0200 (CEST)
Received: from mail-co1nam05on0725.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe50::725]:25145
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991947AbeIQTQY35wOo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Sep 2018 21:16:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAbf1/tUxNnteBsF+l2pn/8VM+CUK/1eWdL0BoO4TwI=;
 b=jXBdgAqEJuA6RiC3hasU7hemxPdPwKdCeeRkyTsAY4jekHYzkFHlUydyPN0Bf7VOeUCW2Z50Qtu/2REI+BlbYK7iEZhvl255+LFQ+XLBO+8CtHwxfuwAMgh40XoMqk0yHK/6oplpmm3aovlHSmLNwh7w+qRHovjdk5YqLfsJMcA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4936.namprd08.prod.outlook.com (2603:10b6:a03:6a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Mon, 17 Sep 2018 19:15:43 +0000
Date:   Mon, 17 Sep 2018 12:15:39 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH Resend] MIPS: Ensure VDSO pages mapped above STACK_TOP
Message-ID: <20180917191539.vxsv2vzqw65pbbnb@pburton-laptop>
References: <1536990690-17778-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536990690-17778-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM6PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:5:80::14) To BYAPR08MB4936.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb291475-d45e-4b31-d403-08d61cd1f6bd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4936;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;3:3eUXcUNlRuCjKjCk4hvKFORVQ250Eu9hGsRPHA4848WCq4q+rmKQ7/AUzC7e9NESKIl+5QfvtKHUTE6z+HWkC6AS8TSC9WeuxqTMDWSqONU4008J3nxpaDYqIU4vdUzUljc0UVh0F6FI2ar9MY5gk2SjsaxT5Ww7yGtZaythgz86GnL4mBbOmxG3fZQK0mxTh3wEPYuSeMQa7h/DJC0XD/+iSwxk1ub1oeU/t/Vp07q4RMmzHtPGYpbyA9c3cWpe;25:fGZ+bFUzzVfs6thjs+Sx9XWEdBEI3GVqf+GS4W0yVhAQNHs19zG6HC3FQAU8HrUL7rYAMcqFjTkSXCgRWS25YC+whW3V6f6N5kTVlWsiuTKWGTf3X3sQEjAnrO6WQN4CVd2fGuM7+nr4LW3ETd5HPcneATsB47p2Ar9uRGy5jbvPYGSOXbaScvD46wSCQvNm2beABn06SoNH5JFoLFl+bumoVtppO8+L1788apRIicSVOvVuDA1PXL/1cKBh76tD1r8QMpPP6mec79hnpAeUVtX4SylZkgfLy72mndGS7sYHqGTUcVeAQWXUD3eGsdArRxmWQnT9fBrkAcKjv0s1zg==;31:ONaifjccAi+oi8k6hdtnjEv/stPHgL2FH0WAorui3OoZYjQc/FXtiVvbEo2AQSOm/vQC4xKGlH5INzlYwtklCW3bucay1MGuMc1I7Saj1iDc+oPXlT4fBn8iK0eKlQSTpUmZI1lChc0djdnW/35YNAncekxWkdFE7F07xBJIYdj/iUS3k6WnJ/GE5hqhRp5xFqxQiIBCm7KrKs8F1DXb43XyxiIgK3TFQchRhxOHDr0=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4936:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;20:T09+qMF0GzE5M3mqQzedr4Wc8qfVQzYp9BIyCaUjO+bDx/3giC2l0Frlp2lt1UFFIdUKzGG6GDRZCEm3MSkixCKnA9ojqGMqQcZWEwv6wKqLqQxSvoBeOuewEOv/C1mpkug7zZtIbs4KAD4TlFgqrwwxnWzKImOQGAbcX3/UEpy57pkCijLop2nO5YLbd1nOvvuuj7ov0KF14YWV5tYwS6bO+kPMIFnRT/5Fixgy9Rtpkvvi/r+f2D2i9WR9E8PJ;4:TUu951V3j2hDc7CMj+eF59y0XGpCoWKteplqGF7DdOTCY0V1a17lHE+QTh9CsCxmRwAAxZ+FkI1DqOMX/9RvAkE9XFwOAmdesXfHPlT7oEbJK1TvZU+00VVETL/m8ncMx2q4R9oiqCJqjD9P1lcQVoeYJwJy1Q9sQLNbyIaoycSUN1f2SJ3hsZZShkcilkM7BAWU4q9/8jIU1yzMqFv3F+XzLxvId3SlArzQ2v9Kf7dMZyPeovc33DsLxzAENeZ8B2xIhQYKR3bcPYGbquKQhQ==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49363F4991709BB85F53E0DEC11E0@BYAPR08MB4936.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR08MB4936;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4936;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(376002)(366004)(136003)(396003)(39840400004)(199004)(189003)(39060400002)(956004)(305945005)(58126008)(16586007)(3846002)(33716001)(6666003)(476003)(7736002)(44832011)(6486002)(446003)(316002)(54906003)(5660300001)(1076002)(81156014)(11346002)(23726003)(6116002)(14444005)(486006)(50466002)(6916009)(2906002)(47776003)(16526019)(42882007)(105586002)(229853002)(4326008)(76506005)(33896004)(76176011)(68736007)(106356001)(386003)(97736004)(8936002)(81166006)(186003)(478600001)(6496006)(52116002)(25786009)(6246003)(66066001)(53936002)(8676002)(9686003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4936;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4936;23:RB+c6HLPHIPLAYR6V3oXSmfQ18QWLx94L+1+hWhsW?=
 =?us-ascii?Q?/7ka0l7kNOUxto/X5Olq5VNUK5PVL3tWLWcE12oDVgvqSe769HgnOeyKenHG?=
 =?us-ascii?Q?PKh9oqo3Kfz0DXI06d5eobxz6gIGpH7jLg6NBMDP4KXS6Yx22qmaltTYIe3y?=
 =?us-ascii?Q?K2zwFvRJ/Dz0++/3rPuwMkYmjFj/U/2coMhL0wSLP4sRK0e/tavtPxPq0XtW?=
 =?us-ascii?Q?41hTXPRzVzoLauJ3M1jbE3u01qcbQP+BRGg7FuwJHZegpuE8ZCPlGIKaOCP3?=
 =?us-ascii?Q?/3UAqlQ/YAuhJUI1HHKHKJ16lsWrsOptxFDgS6fDKe8FSlcagEN30RgsPywk?=
 =?us-ascii?Q?LFEr7osEs+y9xI25yW+UFPp4OT0NTHTRDUIyHT4gLPFPqMf7fnq7Gfnwvwv4?=
 =?us-ascii?Q?w+Vxu8niqzPh/QswECKgWU7bUqskr8ZVuhbyXL1fFMzka3rMO1KYJUGNSexw?=
 =?us-ascii?Q?b6oRIjrVZBeIMbUe7+g9QlBg0mH6+dWEEop2nKhM/VSNuOLQk7sHlVYlFRQV?=
 =?us-ascii?Q?SBQ3745xv8DBhMpV2/LYOssUvvmrd3E3Q+dn9DOn/EWlJybKhPsaFAP6Ge8T?=
 =?us-ascii?Q?WT3j+vgjRi0EyQdI+gnxjKrWQmAj/GlcKONxqmo/0/77NXchUGsK1aQbx3i+?=
 =?us-ascii?Q?4T3dCZxXVWlJQI7pbS8t4YUrkA6CyoVooNbCkwYsYg0lSWQXOya9j+IZKJ3S?=
 =?us-ascii?Q?b4+968Ikc7VBmc2oZpFtXUMH5YIqDpOOWQhsl9yiLi67S5WD8AZK/OqJ2qNt?=
 =?us-ascii?Q?MlN4e+f3kt9tPIyHdcln//fT7K5wnUZl7TS1NANdt9DI+llGwtBBt5tMPmTV?=
 =?us-ascii?Q?0spPGEF9NWkoQyAjjuThgQHvDLsO8Q1f8Iwe6Wh2Cek5q+PgmcVA03DYD9oa?=
 =?us-ascii?Q?11y0HkblaDVB0seslTtJYIEjCE76IeALFrGx6EKHXLCWPPXAYUfl14AKgV+z?=
 =?us-ascii?Q?50jlpCo8mGBIMGv2HwSF2YMLYizqaqZb8WLddsCKZ36Pca7k8K3OHGVp0hWe?=
 =?us-ascii?Q?xcH+B7uIlYo+F/agXwkponvHgLb1NAOMX4RTg0f9rkzbXJdm56xMVgDqMfio?=
 =?us-ascii?Q?haIGKkEDgghx7jgWhlXoz7IhZbGp6BFNyu78lOVPdkM5sfg+L4Z5zww3HX24?=
 =?us-ascii?Q?bxupRV0cVN077/irVxKaZZjrUroPSCcIrHfzr3Xe/cZ33nJyUIJ+ztoIfkAu?=
 =?us-ascii?Q?rTOwWsgevehza/j6ufw3jUQsSHvQh85PbqkdAvSAmuVqePhf3Ppx/7oUABNo?=
 =?us-ascii?Q?CNi8bX+quR29foOGvybZJZ9ERwfbkX8jgM6y31WfCBBrfvohAauBPlH0frKz?=
 =?us-ascii?Q?HPyIouLvAcpkH4FrOIC5kipppOPiXufFx8ywj+ttBu8Jm2Z6RAsRk1G3Q5aK?=
 =?us-ascii?Q?0fNzg=3D=3D?=
X-Microsoft-Antispam-Message-Info: YLeAQ16WZo+PLLzeg6YU5J4R1le0mE9GeqoZq7WHVTJPJS7uc75S97j5LY+txBegXD7m7uFPvtx3Q7kmTjF8eXJDG25ZOawA5NVQgMcNgGUfeRnr8iQTKFV+4ea6ViAQPHMSawnBa+V4o4cyIEJC06BiDhfUuJx37vSjfCbxv6/Q/KlI+FzqVFaGp0KW+CHyZqVRNDGW8zKJlCk3d4Na4xO57YdT1dpAKkCs1Ju2x782BzVfciqp+q/fbTzc9gl6HRCWkHIlnTUwnWsrt/qzcoI5zgd1XE9ZUrnLqp4j0VO9jgRm9F7QR+VrN0ow2czbXmdHCeJmuVKPSXrtHt56Yp34i07LP8UqNWFWFp81O54=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;6:jxOJplSBDARaWF7eYuRNGOwx1QRFxgx9ko8HKteKnI+8X3jBI2bMky867jyHDGhoC1cW2onUN/FhL1dGfRc/LA+F0SVGbqL6O/MPngzf5TeWoR2oay5U2Ei9fxdmcbcEbNz8ktBUSH3dQuONTQW7DJP0ILERdKJAIhydmyfFHebpLjEnMdwFSLycBHoIH2vcWhI1bQ0oogQEt7JvJYKdzjShS8tTF/DaHMEIHCbNkC4RZOuS2SpYdQRoqPxa9WFv0oK8jnnQElrAdwm5YKXittm1NT3gU2sDVY0/MeKwkBE5hGtpk5ihX1l9ItJNYPEWcMP14nR3Zmg+wpzCZ8P3a4CpNfNPpYrqq9ED+05XATiRs8bix4p86b/9bYAV/LCLWlzB5lVlcsg3QHtceJzyFutI0fWFGdAnHyP7EGaZfZEpodhTuQz/mVGZmM43bop6kDJC1gIzckiq9ePDi22vMg==;5:Sg8rL6IajZM5ur2G7f0j86YfoR+2KQDNHnX3Vfpd4Pfx7CG7gz09+KoyFgPDFcIt4hy9gXf/MFX4L7ElqGwUNX40dcRe4BXujrSiYDjE8BgUIHasOu1KCfKaW6cmuFtN/qaMIcU9xc3pugDICrwKB5YtchfxBjpl5qh3+8D2whM=;7:bQN5VH0WnqjRo4OoHKE6XMdsMPUv92+J8vKdg5VE4XpOxe0Okgdj525kGH8NWjJgnjiCYU05d1RXhVFv6HU2BwksGcjKgHdWzEqG2pCKTPaKfsS/q0Y+LeJnxOa1mrGSf8bRIl0SS/o0DOzPgGNXvVEmTNjNH62V1aL0ve7MgnPEOdwy6dt5n5tEPVBsbSZM5m3nShjLioCXfVZUyZ7cNkTGoEvQzgoRB0y89UUayhYKbJBkgHwSrFQ9lTazRXSN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 19:15:43.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb291475-d45e-4b31-d403-08d61cd1f6bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4936
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66371
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

Hi Huacai,

On Sat, Sep 15, 2018 at 01:51:30PM +0800, Huacai Chen wrote:
> Unlimited stack size (ulimit -s unlimited) causes kernel to use legacy
> layout for applications. Thus, if VDSO isn't mapped above STACK_TOP, it
> will be mapped at a very low address. This will probably cause an early
> brk() failure, because the application's initial mm->brk is usually
> below VDSO (especially when COMPAT_BRK is enabled) and there is no more
> room to expand its heap.
> 
> This patch reserve 4 MB space above STACK_TOP, and use the low 2 MB for
> VDSO randomization (as a result, VDSO pages can use as much as 2 MB).
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/processor.h |  5 +++--
>  arch/mips/kernel/vdso.c           | 16 +++++++++++++++-
>  2 files changed, 18 insertions(+), 3 deletions(-)

Could you give an example of a program that fails due to this?

I'm able to reproduce that with ulimit -s unlimited the VDSO gets placed
just above the heap, but the ELF interpreter & shared libraries get
mapped nearby too so even with the VDSO moved a brk syscall would still
presumably fail at around the same point. For example:

  # ulimit -s unlimited; cat /proc/self/maps
  00400000-004ec000 r-xp 00000000 08:00 71436      /usr/bin/coreutils
  004fc000-004fd000 rwxp 000ec000 08:00 71436      /usr/bin/coreutils
  004fd000-0050f000 rwxp 00000000 00:00 0
  00cc3000-00ce4000 rwxp 00000000 00:00 0          [heap]
  2ab75000-2ab96000 r-xp 00000000 08:00 44641      /lib/ld-linux-mipsn8.so.1
  2ab96000-2ab98000 r--p 00000000 00:00 0          [vvar]
  2ab98000-2ab99000 r-xp 00000000 00:00 0          [vdso]
  2ab99000-2ab9d000 rwxp 00000000 00:00 0
  2aba5000-2aba6000 r-xp 00020000 08:00 44641      /lib/ld-linux-mipsn8.so.1
  2aba6000-2aba7000 rwxp 00021000 08:00 44641      /lib/ld-linux-mipsn8.so.1
  2aba7000-2ad18000 r-xp 00000000 08:00 477163     /usr/lib/libcrypto.so.1.0.0
  2ad18000-2ad27000 ---p 00171000 08:00 477163     /usr/lib/libcrypto.so.1.0.0
  ...

Are you running something statically linked to avoid that?

Apart from that I'm not keen on unconditionally taking away 4MB of
address space. For o32 programs we already only have 2GB of user address
space & it's not unheard of for programs to bump up against that limit,
so reducing it further would need to be a last resort. If we did need to
move VDSO to the top of the user address space we can do that with a
hint to get_unmapped_area() without changing STACK_TOP.

Thanks,
    Paul
