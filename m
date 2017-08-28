Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 12:08:17 +0200 (CEST)
Received: from mail-db5eur01on0112.outbound.protection.outlook.com ([104.47.2.112]:10620
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990889AbdH1KIJcLvuz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Aug 2017 12:08:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RheNSGZOLtzyp3G6Oi4gPgzZLDRXEHce785xC5l14lg=;
 b=lMlqO4lUI+G3vx8BuI8Ayy0nuA9Hd6tDNx0f073z1J7qnlM6I41NlGTEXzuFikcb1BiPjLbwhZr5RJbP+yqTpkvt2mvJsUeMhHGhZD86nEf7OwJeHxXd6uZnDpK15qkLmQBqO7nZQUJ3gvkYKLkDmlN3LPe5M35FhuAUzMShGIg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=matija.glavinic-pecotic.ext@nokia.com; 
Received: from [10.144.202.45] (131.228.2.1) by
 VI1PR07MB1104.eurprd07.prod.outlook.com (2a01:111:e400:534c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.13.2; Mon, 28 Aug
 2017 10:07:59 +0000
Subject: Re: [PATCH] MIPS: Revert "MIPS: Fix race on setting and getting
 cpu_online_mask"
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1503476475-21069-1-git-send-email-matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Message-ID: <71ea8331-78da-c22b-d46d-99ab6c187bbf@nokia.com>
Date:   Mon, 28 Aug 2017 12:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <1503476475-21069-1-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.2.1]
X-ClientProxiedBy: AM4PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:205::34)
 To VI1PR07MB1104.eurprd07.prod.outlook.com (2a01:111:e400:534c::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d273bbda-04c5-48dc-18fb-08d4edfcaa43
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:VI1PR07MB1104;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1104;3:hw884jI/UMqLA3UFKKNN/JRubfN+jfX4Z96iO/r4nf1p70w52u/vd/0vbPlv1T0uzqclHDaFeRyQJDay24BEX0Flyi1V/FM48oHjIHcvGtOdnkfVBXE5cB77CM9BDsGJAp1jvEmyZciWiLs7Nhxml1UF52aTEuZbMOQJy4kzeIsLGTCxFJ2PXhWaiEVPO3uUTTRMtREmhCdQgcBposq4rbcasu/HdtIzLKr42kM4X0b0vk9wGQ5dMFkuZpFA2GXs;25:7ut8ZfGsDsIIqiG8itU96oiIuYhDHzRFZ3oIxqJPC0Yll6cbIDZVr4CqSoODFfjn8hMn1FlB0CtVqj5aoNOEw0ST9pf0xIb5+WHeiA53IRmEC3u4zKTvVDDPCKasTVCJznRAvf7BQCf5DIh0ys0AY+2zLE+jOdP7JDmtC3D5C+bnsbdFuzF8Lt8ihaB5LXx1lLC+N7N2xw48bWKUpoT6vHJ3IYosrObFIFtTcFmKjfnPIODQW6C4LhZr6zLYhftGAyORB4i+64wsc2IUeFvUUAniFJwK2mklBwbm7gUlhE1RAssZ4KeSR53BPHRT+nCGdq4vvr5lnYuCBXB6U2H5Qg==;31:p+UT4lLgrOUu+iYP9XWacnxvOQl+3z3vLgQTDkFMEe/ssBCeIcuUEBgM0FhpVyM7Qe6LijDGga3MEag1vLF3kSLQRvvx7hejpXxoItJe541KZD9VHwP0MWumrCzzgR+ncG2MGySwVfE+ySPv/geUBqXGEHXzKGtZZLvbWPftqCeJ4FjrqaFjbctpAxOzhBzEYzgWKAaHjLJsv2CuShUgtOlFIu8HQgQpe9PYa+Ow3ms=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1104:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1104;20:2JUWIl7pBS3mO51WIW2HVAS2UaXw21aT1DZWW6e81mTn2nCmm36ZoyrcG7wb78aID22qqQbq1A0vvqvi1uEOxdlE5V57PdIjXGOAFXxPZ7+wTEGo89HWtTRIDv228Bx4OS4nJ5wtj9GQe24hSSg4DdmHQMjTdlu/zKItzsht5nwH41xCNoQmyj4PnvsL9OFtXRO4FjS7YCi3vNNM9bLWYLpigOhPzjIXl41OSv+6CHWr+Kacu2heD9w/xKv7fUtENy6XWnhD1hn9lgcmhYI80+o16+i8w7grhO89L2t0AiUduZwhc/7wSxys0Erpm9N/+4WgWOUXfBHdhnlLbrZr9u/Drf9hQQFYM35FHwgPmIPcsbfKdS6D+LycZCgmI8WnhlJcBDJ7LfiHiw+j7pZpcM6ku5M8Sh66NvU8/BUo9tS3dW7+c3KQ+249hhiw2KatvyxmoyfdDb6bONaCcximYCqpkgfXkjODMF9rWhMQT4a42wBnGNGd/WKOrzSZHoxG+powb39YIECT0Iv++P09TJ8OYxwKO5dp/1/lLtAXZHiMzyLyPZqsa2D2fSZuZemYcBtU7mATInFZoL0F4b5GYiRbj6TGh43FA1xrAEbwo6I=;4:VNr4+Lo8l5aj2Hm95g4Xh+HMqNUiXoQciaGo4MZ4naPS7WU33wM4p5azxpi9dNsR2y/NMz8bXnKrmT27kH1im/KRmuGQDJjTYyhrzbxVZiXUbcaIrZ3gEtc2emXn1Bw6QrrG/qj3pZeZeHhYmtz3jaZ0irT62HQHFGx28lDl/NobmIpKszLIJmoJDOqi89oM4BbiluTSnwIvsu3ggQAPtPBowf9X/j9F3tR4xpizxbX7LAC1ZyZ80s5wYA5LsfurFZbAolix5N1p9cd3Ep76i0dJtZ5B5sMeCLTdKYHY3gk=
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Microsoft-Antispam-PRVS: <VI1PR07MB1104E8E2B217DD419065B742FF9E0@VI1PR07MB1104.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(6055026)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:VI1PR07MB1104;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:VI1PR07MB1104;
X-Forefront-PRVS: 0413C9F1ED
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(7370300001)(4630300001)(6009001)(6049001)(39860400002)(189002)(377454003)(24454002)(199003)(5660300001)(230700001)(53546010)(189998001)(66066001)(86362001)(4001350100001)(31686004)(2906002)(7350300001)(7736002)(68736007)(305945005)(36756003)(83506001)(4326008)(8676002)(81156014)(81166006)(76176999)(50986999)(6246003)(42186005)(54356999)(105586002)(101416001)(53936002)(47776003)(64126003)(6486002)(77096006)(33646002)(229853002)(2950100002)(6116002)(54906002)(106356001)(6666003)(478600001)(25786009)(50466002)(3846002)(31696002)(23746002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1104;H:[10.144.202.45];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR07MB1104;23:vfisQgrS5UjAm8W/2ictgJidYJAtkIZ6hLH68?=
 =?Windows-1252?Q?zlzp7Uq+NOlHmCZQVQf+FLOLBHXKjFQPksqcbLXUdx1WYMZHk1KAwC2A?=
 =?Windows-1252?Q?6aW6F8cxPt/S2rmUFW3eVgHd1xF1F4i2ODQ6X8xe+6Xhkycb+c/whfPL?=
 =?Windows-1252?Q?jta7IaB55MsM868zmvzuKnwJpurPiafdd69QHutciudp/2OQgJJHmENT?=
 =?Windows-1252?Q?L9/o4xDlOJCE5O4OdvCGA9gDok/LHKNFri2eo4TUvpurjO7Rumfy9soS?=
 =?Windows-1252?Q?5uR67gBSnU6S0TplR7ahOXn6hmAzZSi1qxTXsFHVGsihZbxNU8RzsQsc?=
 =?Windows-1252?Q?i7afjp5Jku+CiMuoxvWMdiYw7YUut5l8eVojIybUpzlwSElFPkMEMfd+?=
 =?Windows-1252?Q?6b/c4bRqzzSC6oM45S0Wk08AbrNCYZHoE97od1DFjRFMw8ikqrP9RHXu?=
 =?Windows-1252?Q?GrsHoAwTBWskw462yjhJg+HdIA522HEcU+R3tbJqmI/ZZc5ibSTobPs8?=
 =?Windows-1252?Q?pRyIdAnFrSLLi1CC2pu4+ewobBR1slFcYe54p2yvyyxjartSP7zqdq2d?=
 =?Windows-1252?Q?CSmuJ1ypke3PWIYWOyFwlvdzDMrsCkbPhdU5EGWSWN/9pna4DvZbQZHz?=
 =?Windows-1252?Q?D8Ll4l/s6QDuGnCIxht1di/LMjhokn8SilN9T98n7uBn3bBHRtmG7+Et?=
 =?Windows-1252?Q?0VmZ9ZWEbhke9n7XvJfapGW5WYFiGnsDZc1MFDFtuTQCWS8kv6FjhSVM?=
 =?Windows-1252?Q?awCqFE4E3GHyW5vg0oo8Pt1EaqGA2DiHTfYFe2xiXfGDYCPNYKAG+HnF?=
 =?Windows-1252?Q?qpnkmFLBusV3PvYghdLsSsnQUVnvLejF4Y4PtoFi6ucsqydNMmohHbNH?=
 =?Windows-1252?Q?VGkcIalUkFrcZ9vYV/EJGXWPg00YhYbVl8jf+ucuN3Qtejq03/wmJumQ?=
 =?Windows-1252?Q?5iNcQzzD7RvKRg0BF1yOWafeaMtLEy5gU0ap58gCLJHfe/DKvGmjkpge?=
 =?Windows-1252?Q?qbKHaiKYIep2m745+QIv0PO3zKM596RBL7cKlq5zZw91QQEAPZ3oZIlb?=
 =?Windows-1252?Q?G3eqHKwd4N5MzfBii4y0pMAJS8du34/sROuwX64iMru7Cxm/jEU/htGZ?=
 =?Windows-1252?Q?N7EwSVbbsQPXUsUmmYg6wKeqp74WIW2IzpLHkoEsmjflrAVhYwTV6aZu?=
 =?Windows-1252?Q?mIKJueFaajnOCIPhBvd2EEVFuat2LWcQKhrG97XTVJhFif7QdlpnibSL?=
 =?Windows-1252?Q?pJNsDlxNLqApFrvZL5XctNWKosdK+mgUDvSKDN3luF0eHY+bifQE4GHf?=
 =?Windows-1252?Q?x1qugLW3dTekm2c1JbgXq6hcoYBrV33gdqf8Hl671SbARNd3Cr9OqW+K?=
 =?Windows-1252?Q?M+Qy0uKqIvmiHbfN1Px3J1JmvHpWsGF/T3M37p7eChi3nd3CMYVOzU?=
 =?Windows-1252?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1104;6:/9gOIsabU5Y4TMoG9iBWin82DwRa2KZd0JzqBsKHUwuXCUdWBb0g9Qi0LiElXi3SWKIOu91XHDJHwxL/d0IqKPXAA2qOKXx9bQioMpolQwi5RRimepDl3W8nKKKSHKBOb8IZaypKVF8kYcVH/balzbzip6P/DS5yXY8c0g/V7Q0ykwOhGFaAvmPawaBveKdQ5D+9Poyij9X4ZPxS3zF+XPyrnnKjtrK05DSDyrpl3wtkgjVpFRdwKOdr3iOP0qtjZfLLOiGv0WIoSoxG7eKmTy21E17gSrRTatBZze0Pd9hWx6JwDm8lDjg1IVR21EV8VeY/CxkVvtiX4E0UsABv5A==;5:eVOL9ulpmZktg0fcBQrlap0pOgxNRxRn6wKXxhO3zFW8EDMzQERCGtcoT6B4Iy2vL6l8Xp3JLSBKjNu8WN8cbwFMskneRS687zeLGnfll6EVSHNJIGPMHHNJ1UbkNBWBBZOm5wkL1l64ofYyDC4I3Q==;24:REpDmu79DV51UDFus1FKQexl3lQQUrfBei7BQNy4h9a7KPPnrpv7DhbJYtI4SdoofoZtoTbUk9GY1BVqyrFiQMktMcoMDW8mE89pxjdsMv0=;7:FXh9zFYf98/UlR1376DXxNpsMyI3cylBeMMgUCeFkKTR12euKBvr95Ayrm0lPS0ZrdEPf0/9bl+0OWWOFBZKLv89lCLwHJv/qHeIVDpOpZQjLSI96vWSAzxuEyz6PNTZDLKk9cmpyQD6Tyvqcf9vN4lmAdA9AmoaQlDqu851JwnWXen828TxCXIhINQmu0co0z399bvclfzYEkVkirjayabmLgbFZsb37TX4LzPdmlg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2017 10:07:59.8427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1104
Return-Path: <matija.glavinic-pecotic.ext@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matija.glavinic-pecotic.ext@nokia.com
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

On 08/23/2017 10:21 AM, Matt Redfearn wrote:
> As noted in the commit message, upstream differs in this area. The
> hotplug code now waits on a completion event in bringup_wait_for_ap,
> which is set by the starting CPU in cpuhp_online_idle once it calls
> cpu_startup_entry. Thus there is no possibility of a race in upstream,
> and this commit has only re-introduced the deadlock condition, which can
> be observed on multiple platforms when running a heavy load test at the
> same time as hotplugging CPUs. See commit 8f46cca1e6c06 ("MIPS: SMP: Fix
> possibility of deadlock when bringing CPUs online") for details.

I personally do not like the fact that synchronization is implicitly done by the callers, it is the reason why the patch was proposed. As noted before, it is enough someone checks cpu online mask somewhere in between and there is race again.

How about moving synchronise_count_slave before setting the cpu online? Is there dependency it has to be done after completion?

Regards,

Matija
