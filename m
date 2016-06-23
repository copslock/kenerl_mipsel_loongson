Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 14:14:30 +0200 (CEST)
Received: from mail-am1on0106.outbound.protection.outlook.com ([157.56.112.106]:24767
        "EHLO emea01-am1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27043809AbcFWMOXmxeHu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jun 2016 14:14:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ARVlm+Svut3PFVk3TROgdqKSzOMUXM/fu3DuXRAK/Z8=;
 b=riLYwRZEf5r8GkGp8jG0Zgo4wfqZ6F6papx/FB4X+FQy4LD5chbqviS3wY+E1nVtaw/sd+cy8mAychby8ODiQ+2vwPkEVPSF935CyjocRlFs6fvrlwXVvc3fqy3wvf9mFWwIQt3muGUUd87d+HDhwiXQf0dHdsDsW5KWaKNtT9A=
Received: from VI1PR07CA0121.eurprd07.prod.outlook.com
 (2a01:111:e400:7a52::47) by AM3PR07MB0680.eurprd07.prod.outlook.com
 (2a01:111:e400:8839::28) with Microsoft SMTP Server (TLS) id 15.1.523.12;
 Thu, 23 Jun 2016 12:14:17 +0000
Received: from AM1FFO11FD045.protection.gbl (2a01:111:f400:7e00::175) by
 VI1PR07CA0121.outlook.office365.com (2a01:111:e400:7a52::47) with Microsoft
 SMTP Server (TLS) id 15.1.523.12 via Frontend Transport; Thu, 23 Jun 2016
 12:14:17 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.240) by
 AM1FFO11FD045.mail.protection.outlook.com (10.174.65.208) with Microsoft SMTP
 Server (TLS) id 15.1.517.7 via Frontend Transport; Thu, 23 Jun 2016 12:14:17
 +0000
Received: from fihe3nok0734.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id u5NCDsdT004215
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2016 15:13:54 +0300
Received: from ak-desktop.emea.nsn-net.net (eskara3c-dhcp036118.emea.nsn-net.net [10.144.36.118])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with SMTP id u5NCDrG3004193;
        Thu, 23 Jun 2016 15:13:53 +0300
X-HPESVCS-Source-Ip: 10.144.36.118
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 15:09:06 +0300
Date:   Thu, 23 Jun 2016 15:09:06 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix page table corruption on THP permission
 changes.
Message-ID: <20160623120903.GR3012@ak-desktop.emea.nsn-net.net>
References: <1466117431-18020-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1466117431-18020-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:NLI;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(7916002)(2980300002)(438002)(24454002)(199003)(189002)(9686002)(586003)(50466002)(76176999)(47776003)(54356999)(68736007)(4001350100001)(305945005)(4326007)(7846002)(87936001)(50986999)(8936002)(356003)(19580405001)(23726003)(19580395003)(2906002)(106466001)(33656002)(97736004)(110136002)(86362001)(1076002)(46406003)(8676002)(83506001)(189998001)(42186005)(97756001)(6806005)(92566002)(81156014)(11100500001)(81166006)(2950100001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM3PR07MB0680;H:fihe3nok0734.emea.nsn-net.net;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;AM1FFO11FD045;1:gOH60hx+L/JCqGlSQD2bBHdE8bOvob1mzPcLibMMshDQhqPhPFDsW92/RbGx2Qa1HpMg0YdhlLui7OzLJmSTgcldKVKWgBY1+OLxG4kSE3iT3B4T2gk/rl5RtZhXqfCruEw/0Aac7Pp4ZW8EBokaCrvqO6EWDw3syYi+xoPKiJ9vfNZlKhhzWRoIoFAXpRjw0uiJPubB4fcXzm+fYVevmUULMTJErwZR+CkOfzu1Jge3biCRF4rZwJmqZ2oEen+I4t9K4m0CPNcELVQ4H5+L/vudVVX+SAAwPtK8U3uIIw8NONsHBoHTHnPM7/83NJifWswS5V3P01pwpyIZO43p+1q0lcHd3myeRCNbFKLnyF+BOsnR3Kxhx50ZglOycWbvhWZj1Ezyu9nxTPWOQTDBI/DS+bo2j07+EyN4dsM41Hc=
X-MS-Office365-Filtering-Correlation-Id: 521b8326-e54c-46dd-8e3d-08d39b5fe602
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB0680;2:EFU7ZkU4BNp6yveigTRgCKvuspZz765J/xlNpGs939yUrS+UfJfs0a+td4iUtU30ff4IKplqhMBUVv+7P5FVE6qv6zwF4wrfH/x/uePO6e59fLjG6+ozkRg2Bfyp9+sm3wZf2Y9pA2eoMuuFjkhqCVbE644G2oSSTb0cLC3UjT8GaRlfHqQAxHjeIh7Owqum;3:VHB4HaytBX8H5b9AhYvdTq+Fp+ipvBhbumAKKjkyNBhEYa52iOp2sr62RQfHhp8Vt8sr+PzT1/LHMHvyGz3xg531LlBhqZMMARBWdUY7eu6AklwPbOz1PidChKyX5vERYSz1P1VQcZNvqcGzbJGIbgUBuOsDbWEPUd+h2EvH9xydv/NOw3zb6y3nJVIwqCf1fNl9UG0lzFm25laezhXdLgxVMBPqXEv1YGg8ZAsucqgWLMjaJZ/3oCWIGeITMW8/9PD3k40ZjugGUaZ61ECRJA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:AM3PR07MB0680;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB0680;25:07QF26sEcpGv8pz9ONnjz12qsw+jGOByyd4af1xnp2YMDdIy4/ThCmo3su4pe6KVyPO9Z5SQ7toRRZSaBZdv336Sif84zRW1oKwdYq/gvMKo7eHars0E1m/IgUxvW2Tm9PzaxnUKiUsTLsp/2iXZi3qayFrRhKT4D5nJWG8mMxs/B8BhOhZkqIfjN0P6Cr7jgtAoUEmR8AMZmJROcXMAFHY5ltiggaRUg/QJbP04Mu+vLNlMzTZLSDEW6WMDD3oXPoM4e5O03k55tZgvTJ/GUwsBUr35wvHaDf79sPU4hk7cTFecvVIff8XAFwAYse0e6/h/PVqcj9WjU4xOh2pL7hRoyXsYv5MGfDphO7jiK9b3ev+D3hIXr2/eCrNt/1ZWp56d0ljCXR/WWfWspj0mC1fsTJO+1ywuUJCJpGmEo2VNmwC94hH7oRp/RD9wOZ1gIUGn6PQd2Oiuq6pHV91NuQ0RW7R8jg240yjbkVNVuPRVbBUiSgXqA8TiV+QIi9M2VbVI5bz/tw6/DirFUScYOixO9G426o/jarl+ETek6uoRTe1+1BtdrTcEJ+U64/bciwlX5vQf7DmirIUPxqPlhwt6StJsTjuzBWb33tJW0my6mZBvQsBzCURB//SPDfDrY7K71Q1f4gEyaHRddacAO0/2LFFWE3Bbt+/vRXk/dEiQ8Gu9d9woNmpo/JkPuZl0nDPUaM07lYuXDHxlnF43MirCpaY2Q+jq+Akcu0WFLYWJw4jIuWQYuBhiUTq1sfGQ
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB0680;20:luCZvihQ9+7L3gKdR4mejqe9ySVUvBH4xw94amgcdz8kiYBVZ0sKHUgcLnGmxB7qjNlh0u2MUIM2eCFmYZCJx+MCdToPX0j0v7je95vt536KG8yKLlLnpxALi30BjtVFM13qq9p71SkhY1IP9uFLp7r6JUsPVnmEDplmkxCLq1zSN9261GTYEBUIalCdsWqghnkULrpuBrL2YTGrVvuYokYXl0VyshmU+q6tCKSNk8UWve0zwepGc34QD168G9zw2aIjwZpnWO1Ray4HMBlBMU69kYCmMJjAi8aeTAWmVVoq86oV7aTqB/QQrkHypncsWnAMWApAu9Zo6qRnowZA9k6JeLd6lc5upx10y810sPuvCRZWNtNnWnSjekNqi27WURN0/C2T27P7NFsXPKqgpOnPU79U/51YNENjleahqz5v/dBFBJQ6oRBFQrZz7JtolaHGOUUve4NWBPxZx+6kj2480r27sOk+DyUOCHuturxoxNtHNm3cWHkrQVkewETF5fdAg6fkYFvPBaK4T4IBKRzSah6wWBg1heR6HaFA1jqMWSSk74Nz+XcFOShe93xLrjtEncX620RurDXTigoG/k8gP9ByZepph5gOiRF23n0=
X-Microsoft-Antispam-PRVS: <AM3PR07MB0680B8D02243F9490E98588BF42D0@AM3PR07MB0680.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(13018025)(13016025)(8121501046)(5005006)(10201501046)(3002001);SRVR:AM3PR07MB0680;BCL:0;PCL:0;RULEID:;SRVR:AM3PR07MB0680;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB0680;4:/+Rh8f7H1HbcyBWhUN/v5uNO1uP5HZQ1DDVQwk33+zvPcSd9CI2jSGxQcTu8d24DxGG/wrOM57JagUQuXHDcbcBjBpkW7KxvHeoik8YVERAN3F8xzIRlbOmkFPr8r0GgN7osckW+HeQMqUW3gw6NdP5kDIG7RDjW+JjlwpE/+CyIDZO4ioaQ0/8a/QAjMDHCZYq2j6n7pVlhSmr4BP5/NYDaEGoskMEg5uOc4pmOmTfgK2TrJIXa55GoiIuCRerPjWRplIr2YMtAYWTlNLXN+IGbOZxDOb0cNMFmjVZE/0CHs0qUu4EqyYQUyTV9X6avV2T6JMd0+7ZJSXYvuv697umR+ZKkhbJ53rnGLQxjdqN0yyomuklBFJ78bnzN1umxy+9OXK/ETY0DyB49ct9zamjMvzIitxoQhhAFitF3TrPKtqQQBueHEhwwcsFxLPfTd5XR/nU7A3f7AC/qS1XUiPHmaAAXIZiljXg3SxOH4b8=
X-Forefront-PRVS: 098291215C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR07MB0680;23:Ew2OO1xK8EZdrD73AnqiwgRbYBcsxThOICuTZX7Tb?=
 =?us-ascii?Q?n9BCos/F9WjFdNrHLdO+3ekmT8bggb74zVIXCfYQf23pD4bVi2SWMxI5OeQJ?=
 =?us-ascii?Q?T3WlChR7/CuQrnNnB5LL8pt0vfEKXC4LzdZc4gxef1lAZojlYax60U/KyLJc?=
 =?us-ascii?Q?r2iBDTNGrcvua7D8Cu7qLp6iwDysuWpor480eLVB/QFyUM8kzGFdk+15Ruq2?=
 =?us-ascii?Q?k9VuXF2nRsSKi+ZO74GP5yoiJWvTHpZbwwHegN++DcuFVSVO9XgSFOPcBY8Q?=
 =?us-ascii?Q?wMsTQLL6Sy5UvDMFfcUqGomWEJnjN4d/CM4lsCWjDSnjZZ4G+0sCSUOqbUHL?=
 =?us-ascii?Q?dWFTvIEV9QRvx25PoqmtCHD7gYSKFr1ISVcjTQpumXKN8SDSFCwnaon2ZYns?=
 =?us-ascii?Q?nU9w9C9VBTbeHtu59lYVd39Pk0FdEFYDZ83ar7TiR1ZXrsJMiLGVx6ttIwom?=
 =?us-ascii?Q?5kBGfz8t+wV7V8oFgRLgXwPrycDclSFcKyeXE57FCw5GdnHueJffWJcSjwx7?=
 =?us-ascii?Q?KIwAxr+GYipeSoLAJDOFbzPuIcrxPsbFwtDfWAdrtOmPTIdGWjUpyvaIk7qJ?=
 =?us-ascii?Q?PeOPYqmF5TTa4bgCfPw1N8zg46okVqX8Ks8UaadrbJCswqY6t4W1z9eb2gh9?=
 =?us-ascii?Q?bFPdH7cZ7RO+YnVGVmV4o+vVIBPkh4dYacKLXNn2w97leJ+LaXax6CnlaWh+?=
 =?us-ascii?Q?sTTWPGULhehARsqQhh/G6lQCe4HWRJC619FHNaZetdoExv1/SyJqJfmcSzB/?=
 =?us-ascii?Q?mScKkn/rWvl1Iz9bqFZp3mi+tgpPVQr8gPHo6HI4bV9Sc3ZUQLxomg8oly+i?=
 =?us-ascii?Q?tMWhV+2iTk/l3ddASy0IblV5U8qEz+UNg6HI8jORrgo7e32/byDGCraW6rnT?=
 =?us-ascii?Q?0u3ZdH/FmhZQgycQ+gKWilWe5RE/Yo1VTknXO/bThv1FF8KqYIOX2bZt1UkS?=
 =?us-ascii?Q?V5Vkdd/K8waZdHpEsQZTKvxGZskyaRuVhe02unvtkeP7drtYJi2x9bg2ndxU?=
 =?us-ascii?Q?5x2AxaY0C6auWEfU4ueY7uu2d0dUoD96Q6P2kjpf9USTp2AO3JD5KAU+AArS?=
 =?us-ascii?Q?DLhMSAoowD9yCVzOu3GktapPZzhtNmdO8PGAEpnzbnBgIhj5BYF5Jv6JA6Gi?=
 =?us-ascii?Q?zWNZX5j0jU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB0680;6:+o9kgRFVG3STiLZKDG/zMNf1rGO+dk9dhSiulyUqO5r6Mjr05lvB3FJdWmLc+Ir6LSBvG19giQi4j/w4RUhQ6W64GaphXUr9KERteIF3SEg8VyDsh5OvwuNbclKd9IB5zbw53ZPaNc7HjJr63QMELm87P5Rcjk39DpMvyBq20LoeTN69a7eblNt7+H4o6XXCSynPScwGB9g6uYmvQ/oKNT95Jf5mvcxmZFre58bIW3ecflH3W1Y3Pftku4I//5qEuIppv2shX1oihTUkCJ636sZd3RGiNHzvZU+YMQp0x8mzWh05da2vDVHRJpkrEiZX;5:Ww29cm7sICXxaiTFGFprzljvVO6PfsB44i5819/SMTVeC20WbIdxoeoxDkH25n6n6StVHL/oq4LWkg99qaN4qWhFckG6cvtYOGMbgDuSU/qKYO/tOtgFJMnHZh+xW0mzbYxiNKc6Gw5wMrtPDho/BA==;24:up/qKWT+RwG+J776j70u8eUB39cZzZ8cuYTNvlyyuteZWmpz+pLmTHxThPQ3XL2M9C6/rDOelvrpi0kjgzy8cygvOiUKxKnXFPA231LMVVs=;7:x+mlsc5IFuCIwD1Hb5s7oishdg8aTxAPIR10K+1Dpm8zf0wvqY73+URegHuKM9g4LdHfcI+8sU+Vr82RyAgFIcis+Q0W29d0qVPeX/A0veNwtvF0YnCLV3TcuX9sml2tRHQDn7GTT5PmnB6/XXk6VMT6CJy1QamAnBgAxYU3qEqDlPTtl2bJrpBE/7Yg4rXWF7Zi8GDXqA+cEv2BYjIzmKm3+FjEeMF/Pr2PsqRNDz/aks1QrmR4KlCNlX2Uv/XYOgUDS4c0/AOyuWypeGDf6A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2016 12:14:17.0937
 (UTC)
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR07MB0680
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54135
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
> mm/memory.c:397: bad pmd 00000003ff00004d.
> mm/memory.c:397: bad pmd 000000040100004d.
> 
> or:
> 
> ------------[ cut here ]------------
> WARNING: at mm/mmap.c:3200 exit_mmap+0x150/0x158()
> Modules linked in: ipv6 at24 octeon3_ethernet octeon_srio_nexus m25p80
> CPU: 12 PID: 1295 Comm: pmderr Not tainted 3.10.87-rt80-Cavium-Octeon #4
> Stack : 0000000040808000 0000000014009ce1 0000000000400004 ffffffff81076ba0
>           0000000000000000 0000000000000000 ffffffff85110000 0000000000000119
>           0000000000000004 0000000000000000 0000000000000119 43617669756d2d4f
>           0000000000000000 ffffffff850fda40 ffffffff85110000 0000000000000000
>           0000000000000000 0000000000000009 ffffffff809207a0 0000000000000c80
>           ffffffff80f1bf20 0000000000000001 000000ffeca36828 0000000000000001
>           0000000000000000 0000000000000001 000000ffeca7e700 ffffffff80886924
>           80000003fd7a0000 80000003fd7a39b0 80000003fdea8000 ffffffff80885780
>           80000003fdea8000 ffffffff80f12218 000000000000000c 000000000000050f
>           0000000000000000 ffffffff80865c4c 0000000000000000 0000000000000000
>           ...
> Call Trace:
> [<ffffffff80865c4c>] show_stack+0x6c/0xf8
> [<ffffffff80885780>] warn_slowpath_common+0x78/0xa8
> [<ffffffff809207a0>] exit_mmap+0x150/0x158
> [<ffffffff80882d44>] mmput+0x5c/0x110
> [<ffffffff8088b450>] do_exit+0x230/0xa68
> [<ffffffff8088be34>] do_group_exit+0x54/0x1d0
> [<ffffffff8088bfc0>] __wake_up_parent+0x0/0x18
> 
> ---[ end trace c7b38293191c57dc ]---
> BUG: Bad rss-counter state mm:80000003fa168000 idx:1 val:1536
> 
> Fix by not clearing _PAGE_HUGE bit.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: stable@vger.kernel.org

Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>

A.

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
>  
> -- 
> 1.7.11.7
> 
> 
