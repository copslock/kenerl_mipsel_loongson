Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 14:05:46 +0200 (CEST)
Received: from mail-he1eur01on0117.outbound.protection.outlook.com ([104.47.0.117]:52404
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27041659AbcFQMFpLaapA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 14:05:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wDtQAbGml5en3cG8y+lzlKJlZTMkoF0OtyMrH+dy21U=;
 b=MOqhngzL7YYZiZ7qV7FcnGE6CwV+tmbpPj8Ujv8qiva5prLUZ2LUppDSeLszKWx8iizypx5OMb//0in1dmDUe2BZEM16hCgT7KDcAT64s9Gfz/qJpHkalWv3e2BAoOa0NOObhXzKmWR6LwSBQuDIP50AH30bZo6KuCQ5JCwg9UY=
Received: from VI1PR07CA0080.eurprd07.prod.outlook.com (10.164.94.176) by
 VI1PR07MB0911.eurprd07.prod.outlook.com (10.161.109.11) with Microsoft SMTP
 Server (TLS) id 15.1.517.8; Fri, 17 Jun 2016 12:05:34 +0000
Received: from DB3FFO11FD002.protection.gbl (2a01:111:f400:7e04::199) by
 VI1PR07CA0080.outlook.office365.com (2a01:111:e400:5967::48) with Microsoft
 SMTP Server (TLS) id 15.1.523.12 via Frontend Transport; Fri, 17 Jun 2016
 12:05:34 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.240) by
 DB3FFO11FD002.mail.protection.outlook.com (10.47.216.91) with Microsoft SMTP
 Server (TLS) id 15.1.511.7 via Frontend Transport; Fri, 17 Jun 2016 12:05:34
 +0000
Received: from mailrelay.int.nokia.com (localhost [127.0.0.1])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id u5HC2nfu006204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2016 15:02:49 +0300
Received: from ak-desktop.emea.nsn-net.net (eskara3c-dhcp036118.emea.nsn-net.net [10.144.36.118])
        by mailrelay.int.nokia.com (8.14.9/8.14.5) with SMTP id u5HC2mdp006135;
        Fri, 17 Jun 2016 15:02:48 +0300
X-HPESVCS-Source-Ip: 10.144.36.118
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 15:00:16 +0300
Date:   Fri, 17 Jun 2016 15:00:15 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix page table corruption on THP permission
 changes.
Message-ID: <20160617120015.GJ3012@ak-desktop.emea.nsn-net.net>
References: <1466117431-18020-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1466117431-18020-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:NLI;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(7916002)(2980300002)(438002)(189002)(24454002)(199003)(97736004)(54356999)(76176999)(50986999)(42186005)(8676002)(46406003)(81166006)(81156014)(4326007)(189998001)(2906002)(33656002)(575784001)(86362001)(97756001)(4001350100001)(11100500001)(68736007)(9686002)(23726003)(1076002)(87936001)(106466001)(2950100001)(586003)(19580395003)(19580405001)(47776003)(5008740100001)(83506001)(110136002)(6806005)(356003)(50466002)(8936002)(92566002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB0911;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;CAT:NONE;LANG:en;CAT:NONE;
X-Microsoft-Exchange-Diagnostics: 1;DB3FFO11FD002;1:T0rUHIPB1weO1aXjWNTUZd8sMh+haKQUU7O62bxnJaxzMhbFjPowjBspc1K3uuKoTxIX7C/8aTAbwt49yFEZw+ceJSuI/3L169CrLsBxsHvPFobx/uGcDFjSJ/AINin3wLVJ50LUtGse2jV+TlVtAw2kt4T3Xh4cZC0hx71gBHIPC6SYhq9XgcI+7OBjaDAj1uv9HTnjSQBabEeGGjP4a7cRFkWfGX/WZSkUg9dC07PpIHeSp2PW3IdmjB2kJn9HkY9pKnQyTe6mhMZXSv3sB5XWsh4zirLFaF4cxs1hlpm4H7qA6rHqX3wRvqAVD+P2QMJI4TOtWQSuKo3JMUxJY0L/3pt8mEbfFgvvfj2Be5ui+bNUTJ0aFewsD9srmdMr8YnwR9eZshF0wiIjHwiAMvVc0X/vM5wlvbM6nZMmU0Y=
X-MS-Office365-Filtering-Correlation-Id: d3786f47-72ff-49f9-d0cf-08d396a7afff
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB0911;2:giTEXN/nncuO1yLCQsUgGxTvK2cgFmj35wVEyAhMxYhKhBq30ZjlFL8TkKysBQ54uoNOQXyzkuh7b9nm4R3VyW1aY23cuiH1DBR4EV311y88S54KYTmYkMz1wLXypjpecCmdSTRP8ecMr4k5ahvhnDkW1YwQdR7fZvY6O6GMuNoaenfWAkhIc9W9KD2JF6CI;3:34lx1UrhCmGaBAN4wzFMXM7OriC1LjAA0QQyojuFkpJwRbWdPSGoKpSV81QNo7i1AhT/0qST/11GpIBckvU+EYKKcxOPpV8CnUWmM/CF2iRY22j09XErlBMdRCVcfNDhVqKQce8fcQl1rQK8OyyEzO8MXC3/koL2+sW9i3eo6BXl8kjbuMk3c1PcbhodSSTnxBm8ZCl8n9dNikLlvk4olDz6ORBxiiR52jKq87cKZjiKRxqO2XUMfCAhMDfXuGkQZerO42QwLjEc872mgkonow==;25:kwGpZh41mC+YMtPuGD7ArKb1Qu9g6pp8Dv192Y+EMFT378qwZB/FOodirY6lGwtUGomwONu3v5T9uOi3BD6sQp2NztXhR7vqDENwMxJ5H1hgUn/g4SJRb6CP0uJk9rZoj3BwNwTvPBb0WG+5OQgr25KxvxjRFkkRIABMpKK1iphLdpi30qqgREmxTb77QjOjYJU8BrxV4XoaROMQgTLthEYPj48U5sNwy2kB0+wZtPpeFLJWwc8fD5y4e4ztnwRg5Z+vGYByDEMwf5Qrjlk6lpQeudI68D1X8DxlqNa8htm7++AAlVT1jSNXwSfrxr6C5eY0qg7O5CJ8zvXzHUDjSWeUe+wqAcunUTXe0mj9LvGWKviQrTyGSe2hUczjzA49+lrqcUiQRNxZ7QU1iKQaP/sWlwQpQvW25Q9zZ1BmUQ4=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:VI1PR07MB0911;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB0911;20:6jkavXwcHW7/aIVUq7X8E64A8l9j5H5oUAX7bAARUNdEgwyldA2SThBW/HkB2DhzeSMCT0DkyUDNk6b3R95xfqjKzq8kmcEFYo+PuXV/F2P2VWEajNanSFB6a0EQHPnZfujjAl4t66J+r6M4vCuVPtz+zuWgSdNoWmozLpugM1k7YAiA7XudVsTpnks+TIrrlHWaiYFUUzJYG85izqlI1Xl8KsJmo3VCExD2LP09bXXoj13DkXtyPOTxEEAYvUHHt+FaF3R+46F/D7Pe789uGevMQ4fQPfPyFMxsUCv7BiYu8mq4ZPSn4ZClkmhgiroliDhyWNlLnNG3ZqB2RmpcLur019NyRQ3tuM//QhS4gkCwtC0lNFJBH1T0epK0wmR5fiN4g2zl7XVXDobrevahht+Zi2uL9Amk4BzvdoHvlpqgWarKeb4J50G28qHJTul6mpOtSBGCfYt5YhEr0HdkzYK89ed0NBruz8Ruk9bp6MRDDxSZ9aTjrcpZ6jmjmo48pM8Fdnf04JutTQV5kF0EKjQwkXpH8D8RpFaZpkZFGm2pYKchZOSe6W+njjE7IePCWtyz8z4NikgumceJkz0fxDqRLWt+xKuLDotgr5OfH/s=
X-Microsoft-Antispam-PRVS: <VI1PR07MB09115DDBD11374B6F4D51CCEF4570@VI1PR07MB0911.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(13016025)(13018025)(5005006)(8121501046)(3002001)(10201501046);SRVR:VI1PR07MB0911;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB0911;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB0911;4:gslzO2k06Jjn1bZWAaMxlVFoOnXIZ8Dmoc15bgMdJDDzaKaP25mMTGvTqFeVoQxgt5AN22CocPlmAY25cIIG+zG/sSdcxlv0339Fsye0SPro96AzvXDlV1LJotw4NnKdkYHhl4yBIT0oF4rSqJ8pnToy451VRpb8tH2RgCbK1MUwqJ8wqecVeeImkn5EOC26rGHF/65mCZeFQxku0EYQZ3z8ekoV+UPmu+v+OSbWpxRh7V3WU8jqLleHp3sXhfrWmhfwvbkYngltbKI5L9hf4eH03dyRuCdjYE+3HLiXMmWsJDXcIDao7h2uoijz6RFc0lDCef7SBO/7rZkrALwjLPx8cBFS9XXlLE8ynHOv4Y2WwrMSqMkmeghjBEAsKm8xPakhgRqUZSWBjYguLscfAVoJNfxK7tmWX4ST03BqKuyCiih8J1Z+RUDGeO2UwrB3
X-Forefront-PRVS: 09760A0505
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB0911;23:4qlAqa12OXJg6Y1e+GBfMgb8bCLhJOrTXsw54dyuQ?=
 =?us-ascii?Q?q8Nl+OT0DgOZM8+H5qWYaxyIVCBNtlI9+IrUYTmYvPotPmy/SicKi0c4DcEc?=
 =?us-ascii?Q?QSMm2PWS4hxjCKLFiQSK2+1EEwJ8tIF8qLExw2XyzMTa8fKuP3s/bOj8jjYQ?=
 =?us-ascii?Q?WWhHiYBDSKUL+x3nuuO5FL4EAsS8MfLQyzcVRmG01KjokW+A/79m3zexWYcA?=
 =?us-ascii?Q?o1KrwBaf646zcjf0oqgrk9/chqIVjNei2ixhgC+ftzimVDGY4EHPgYuM0gMh?=
 =?us-ascii?Q?6Mnt+tbXBa8T0G2t5ylTJAupMw8jMltrq384WLYLNmOIDSTAPcaW7spxtkVx?=
 =?us-ascii?Q?S2Z85GzPfGaNd2P8j0TofcGT2NgxGopPvkIwfBf2sjReFeCJlj9NJ+Qgnjke?=
 =?us-ascii?Q?DQetI0XHiVizaEwgIiyV0mdqQsWEklAlrJwqvrhHA7qoCYaGiokZw5Kt5czW?=
 =?us-ascii?Q?N4PhkCuBhxzHSbowtx1OmUspH/Z2iifcsCEPNj8Cz5IYCuo6As5sp8sUHW4a?=
 =?us-ascii?Q?qeibquM3CWluE7PHsa+3Ww/qQJViXug2P6rW5kCVGt2VFd1tBUU65gV+pbzo?=
 =?us-ascii?Q?ysr3nUpQZOMOOCB0oap/eVzd0PMdjw39OtrTSovs++sniKCjppg9s1MixtX/?=
 =?us-ascii?Q?S9y3mK7XcX5tHofD/o6Y7RG7TQIWxZScsaCx0RjbcGtyFVz5uwe+Zev81LM5?=
 =?us-ascii?Q?sa9Gn6OwLfeKf0JcKOadmq5eUo4WHkGiCFthTXmpvvSPr4WWYSOKUPjop85P?=
 =?us-ascii?Q?XF/gWzJ45FaRfNveFhe4utKZiJl1M+IOivgMFR3BYMJ5ls8HuD6ujRQJZ50F?=
 =?us-ascii?Q?FcW4k48+B5zDTBWwZ62Ke1Pg+gfaxhv8B2SRmErkR3UTVpsvQviT7OipGOUc?=
 =?us-ascii?Q?g7r4AsNvlNrH/lW2rOCuXv17Jam3bFdpW2FPWwHPzFkUXZmxsezUzu7ybPl0?=
 =?us-ascii?Q?2LHdw4mPMT9lmRQh0qBjcsg126lWQVM5NEWU4L+ygrq8lXukPFQw/8e3nB/p?=
 =?us-ascii?Q?1po1nz6WOZTGNzViozOzbOTzIju9aj+k7cXhOKOEnbO4SV3jixUMuuP6ZiHj?=
 =?us-ascii?Q?LJSSThUV2Pdv2oFeBzV7uPcMEt7Tmn+N3C/3gYxXcKqnY2+O5WrFgz2katbM?=
 =?us-ascii?Q?54k0DMXxUo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB0911;6:gIH5lfT5m8kvEd+fAQOaXVJnmhOwfqVyxNDm9aNbdqMPetsxYeTTmxxOU2wyRYKJmNOg8r1w9E+A7fv04naUcj5NGjIZx1Dc8/FGN4O430SrX/FIf2i/Ff9PdkYsxLwhNtNOfPPzwnTdcUeqrcsWTCzsNKOwPCcSdwWlZtXlPiwRwilCLHUd89RN81sOIMbFO6VnIkAf3Jg0KmO0E9391wamvM7Vz/3S30qJvxKMFBs9+Hc+V88EAGhqXzdmV0vM1/XdB/qKXZ4Paf/Or5MAq2UWzR41PxE9Lp6coBMezcY=;5:DyJc4yqZkLjR2xBxx+qo04AyIZxO/3TyUvaMB0fxr4e7P/4T+nYcHkU4LkT+V7ItC7nib0k2Tnyb7buDANWHS+1Po7ymUuDORS29dNWah0OiPWZm/RHB2RbZzeQ7zXWPdt7gPFxia80wSQiXwtOQGA==;24:yuihY/O6DgNxLLqHSoj3GX94orcAwyFYKRLPYun2uAREDwasizkFAAIXUAEpGJGwg143m1TWRoEnjRPb2M1OIoxOx2lUyG/qk8aDM4ay0qM=;7:b4qE5ChYIuMkT+F4no74g5HLFudVs+1WBz5vj7f7swdFrI9HPnucjWf+iz5sNQZLhLeQRH9jtdmg+T/KwoCkEnDpDM7+KR2GyLutpkPvX8p9DNUGoEQq2PL55s2e1GdgjKdnGGASC0DqMjQZKQT9RTlOOyQlH5n7Gj4tYhtIbuPiFF68elAnl9GTyCVVvhBBRc1VoTk3LGj4KvjId54IrA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2016 12:05:34.3982
 (UTC)
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB0911
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

On Thu, Jun 16, 2016 at 03:50:31PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> When the core THP code is modifying the permissions of a huge page it
> calls pmd_modify(), which unfortunately was clearing the _PAGE_HUGE bit
> of the page table entry.  The result can be kernel messages like:
> 
> mm/memory.c:397: bad pmd 000000040080004d.

[...]

> BUG: Bad rss-counter state mm:80000003fa168000 idx:1 val:1536
> 
> Fix by not clearing _PAGE_HUGE bit.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/mips/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index a6b611f..477b1b1 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -632,7 +632,7 @@ static inline struct page *pmd_page(pmd_t pmd)
>  
>  static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  {
> -	pmd_val(pmd) = (pmd_val(pmd) & _PAGE_CHG_MASK) | pgprot_val(newprot);
> +	pmd_val(pmd) = (pmd_val(pmd) & (_PAGE_CHG_MASK | _PAGE_HUGE)) | pgprot_val(newprot);
>  	return pmd;
>  }

The fix looks correct, but unfortunately at least EBH5600 still keeps
crashing with THP enabled. :-(

[  606.429974] Got mcheck at 000000ffebed8c2c
[  606.442262] CPU: 6 PID: 6767 Comm: ld Not tainted 4.7.0-rc3-octeon-distro.git-v2.17-27-g5cc128c-12208-g7d9ecdf #1
[  606.473026] task: 800000041f384880 ti: 80000000ed7b0000 task.ti: 80000000ed7b0000
[  606.495454] $ 0   : 0000000000000000 3e000000038ac006 000000ffebba7028 000000ffebb9f020
[  606.519588] $ 4   : 0000000001529d94 00000001204f4236 0000000000000000 0000000000000000
[  606.543722] $ 8   : 0000000000000001 7efefefefefefeff ffa0a0998d9e9c8b 8101010101010100
[  606.567856] $12   : 4040404040404040 ffffffff84080018 0000000000000000 6162002e74657874
[  606.591991] $16   : 000000012032a7d0 00000001204f4229 00000001201483f0 0000000000000000
[  606.616125] $20   : 0000000000000000 000000000000000c 00000000053cd125 00000001204edb70
[  606.640259] $24   : 0000000000000034 000000ffebed8b50                                  
[  606.664393] $28   : 000000ffebfac000 000000ffff808160 00000001204b9ad0 000000ffebed9cc8
[  606.688528] Hi    : 0000000000001001
[  606.699237] Lo    : 00000000000014f4
[  606.709951] epc   : 000000ffebed8c2c 0xffebed8c2c
[  606.724048] ra    : 000000ffebed9cc8 0xffebed9cc8
[  606.738144] Status: 00308cf3	KX SX UX USER EXL IE 
[  606.752704] Cause : 00800060 (ExcCode 18)
[  606.764717] PrId  : 000d0409 (Cavium Octeon+)
[  606.777770] Index    : 80000000
[  606.787178] PageMask : 1fe000
[  606.796064] EntryHi  : 000000012032a095
[  606.807555] EntryLo0 : 00000000038a8006
[  606.819046] EntryLo1 : 00000000038ac006
[  606.830535] Wired    : 0
[  606.838120] PageGrain: e0000000
[  606.847525] 
[  606.851986] Index: 40 pgmask=4kb va=0ffebba6000 asid=95
	[ri=0 xi=1 pa=0041d2b2000 c=0 d=1 v=1 g=0] [ri=0 xi=1 pa=0041d2b3000 c=0 d=1 v=1 g=0]
[  606.890740] Index: 41 pgmask=4kb va=0ffebbb6000 asid=95
	[ri=0 xi=1 pa=0041d26e000 c=0 d=1 v=1 g=0] [ri=0 xi=1 pa=0041d26f000 c=0 d=1 v=1 g=0]
[  606.929492] Index: 42 pgmask=4kb va=00120148000 asid=95
	[ri=0 xi=0 pa=0041d6b7000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=0041dcd1000 c=0 d=1 v=1 g=0]
[  606.968241] Index: 43 pgmask=4kb va=0012012c000 asid=95
	[ri=0 xi=1 pa=000e30e9000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=0041e5f8000 c=0 d=1 v=1 g=0]
[  607.006990] Index: 44 pgmask=4kb va=001204ec000 asid=95
	[ri=0 xi=0 pa=000e317e000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000e32cf000 c=0 d=1 v=1 g=0]
[  607.045743] Index: 45 pgmask=4kb va=001204fe000 asid=95
	[ri=0 xi=0 pa=000e4206000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000e308f000 c=0 d=1 v=1 g=0]
[  607.084493] Index: 46 pgmask=4kb va=001204f4000 asid=95
	[ri=0 xi=0 pa=000e31d0000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000e2874000 c=0 d=1 v=1 g=0]
[  607.123243] Index: 47 pgmask=4kb va=0ffebd3c000 asid=95
	[ri=0 xi=0 pa=000ef2fc000 c=0 d=0 v=1 g=0] [ri=0 xi=0 pa=000ef01f000 c=0 d=0 v=1 g=0]
[  607.161992] Index: 48 pgmask=4kb va=0ffebf28000 asid=95
	[ri=0 xi=0 pa=000e3adf000 c=0 d=0 v=1 g=0] [ri=0 xi=0 pa=000e3ade000 c=0 d=0 v=1 g=0]
[  607.200741] Index: 49 pgmask=4kb va=0ffff808000 asid=95
	[ri=0 xi=0 pa=000e34a8000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000e43bb000 c=0 d=1 v=1 g=0]
[  607.239489] Index: 50 pgmask=4kb va=0ffebfa4000 asid=95
	[ri=0 xi=1 pa=000e35c6000 c=0 d=1 v=1 g=0] [ri=0 xi=1 pa=000e31eb000 c=0 d=1 v=1 g=0]
[  607.278238] Index: 51 pgmask=4kb va=0ffebed8000 asid=95
	[ri=0 xi=0 pa=000e3dce000 c=0 d=0 v=1 g=0] [ri=0 xi=0 pa=000e49ed000 c=0 d=0 v=1 g=0]
[  607.316985] Index: 52 pgmask=4kb va=00120274000 asid=95
	[ri=0 xi=0 pa=00000000000 c=0 d=0 v=0 g=0] [ri=0 xi=1 pa=00000000000 c=2 d=1 v=1 g=0]
[  607.355734] 
[  607.360192] 
Code: de100000  12000014  00000000 <de020010> 1456fffb  df9991d0  de040008  0320f809  0220282d 
[  607.389654] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
[  607.422806] ---[ end Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.

*** NMI Watchdog interrupt on Core 0x0 ***

A.
