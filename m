Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 03:21:33 +0200 (CEST)
Received: from mail-eopbgr730131.outbound.protection.outlook.com ([40.107.73.131]:7317
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993961AbeGXBV3iE7iG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 03:21:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MivZZiv6WDLp/0Pgwlo34vUCR19zAPQhLG7amuU026M=;
 b=ZKn/zGsAaXVIL6NPur0vIm/F8bCP1oxYcvAVX0b0I6i2DIz8fBVgCyXCHs9zSG/KPcY1Jga3IAjR+U6f2sjwdE37nB0y/Nr8OL3Hz1ex/ar88mPLkocGcTs+dOvo5QDXpGUvoF/gxOHSLDTJBvJYBjaFxhqR5ZsK8BMry8l/hLI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Tue, 24 Jul 2018 01:21:18 +0000
Date:   Mon, 23 Jul 2018 18:21:16 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH V3 03/10] MIPS: Loongson-3: Enable Store Fill Buffer
 atruntime
Message-ID: <20180724012116.bxtzn7g6qmri43bd@pburton-laptop>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
 <1524885694-18132-4-git-send-email-chenhc@lemote.com>
 <20180618210507.akcvvigzj7qis3re@pburton-laptop>
 <tencent_3C127D3D5620B83833D77E8A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_3C127D3D5620B83833D77E8A@qq.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM3PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:0:56::32) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e2871f7-e4c3-4762-dc3f-08d5f103c25c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:l1dbDYhovL9jiZSv1ElOEkVOTuTIG1I2PqTLw1fw/hvejsv0bhSUXRbyAwNEAB1+P7zAOVzdjyEz+/rMCAGpr30b1eGSColb4wMY58IUYWxA76RzrtwAYmibdnqvBIZ0l+nTIO3QurhbiekcIekR44e58Lrqzm+1FxZpHhyZyq3ECZwTJkTUpo9yz4JBRX7sZsk9Kj3Qh3bJEw9bzB1/CR+1fWaZnvnAQH1wYihdyaHBOKfLgKIW7ef6dSUB/3XQ;25:wcYUiRD3jkrKXD0VjU/9zwJg+IYYu0zhclst1FpGzv2rss6INs2C9DudevoTaasKXZ5HoUYEScaqa8uzcjqXttbhbLH6+SkKqDJQGrqEXR0pfBQpr+sAZrh+vfjV/ohlkMXClOfPhda6Q5HcexctIk40WPKOUBMzy9L9ZRlG6yl2nfXIe/vQoJDhsV9tcT1BoKz0ZIgUfzYHDkx6txkSd9fzt/Pq59ziW9ZhYn/rMNSdE24nt8ipx1hQXo1QzjZsVvN3pmG3eJyrzRuNViAAW1WBWPLZoWpVZoUR1JQ/CiOVG0+X1CwWJNrTkLNigsNiDW1mtY8spKHg5hgCT8hVXA==;31:9a3fMzEQrlfboGXwflI6emdINMRpyt3J3xOCfvKRo4SXX/fsaokredw+v4VimlYfuUs3rRec191RmtDQeh/boExMi76hPGy5xxIZ1JBaa7QYpMEggMQ//zIuirHuTb8CdQuNaKn8Jco99Zs+z737Tjo+jnrlNVUzJD+gwxv7sOECpavnP7qkm0nxGOPWvTlsOxztAS/mlj1T3KiGPyvSDjf5GZyVrCSx5ANA0nBx2FA=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:E88jxHThBQJU/VQjlYbuUKdIhBg9uL6V5Jt7W9iBarNEl9on9AoZL5JTlRTQIBLvpN/mXJiwQ6WKXWcqJtGDywE5hJ8o1+dgdF83TDcwDp7M4vtclQ+29bLlvmUT+iwBmr1odyjPMWHc7ga3XG+xToDiKdUToa7XKRoMkMrEQBK8VhBGPeU9AZyvqQv5VVViB/f36trXoRCN6m9OSFN6oH0pA2BExEc0Tg+h1kjkcinvb+QaOnk9J59Vwptzfopc;4:ftXtnWTuudkrqQlYJLuw7BriYJj7/YY+RBmEoEQuEVD0n/kXdjok6EVDYeOe9xNPA2D82lsHF6s8k2TNRSfrilbuoaq5D6j4zYStBh3lBVaUtEMPSNAHLmcBHn1SktwYontlnCsJ44sb3fOqelHlR6k6Txfmtgww0NllCzwF788Af/xTEu4Vhfj+dv0VQYXVFj5Ni/i9+V/zg54p1kq7xog7PpDz+KnzR3hATI2sJw0Iq9BLjlZTz4fuvAH0bo/cTTBP/aP9s4sA5SE9vHPnCg==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4942499C70207B97F565C330C1550@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(39840400004)(366004)(346002)(136003)(396003)(199004)(189003)(4326008)(53936002)(6916009)(2906002)(81166006)(8936002)(81156014)(8676002)(14444005)(9686003)(478600001)(305945005)(105586002)(42882007)(5660300001)(66066001)(33716001)(47776003)(39060400002)(6246003)(106356001)(76506005)(7736002)(52116002)(6496006)(23676004)(52146003)(6486002)(1076002)(50466002)(486006)(97736004)(386003)(93886005)(76176011)(58126008)(54906003)(25786009)(6116002)(2870700001)(316002)(446003)(476003)(229853002)(68736007)(956004)(11346002)(3846002)(26005)(33896004)(2486003)(16526019)(186003)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA4TUI0OTQyOzIzOnlEMCtVSk9rMEJPYTFhQm4wT0k3QVYvbXZm?=
 =?utf-8?B?NGpjdVlxVm54UmNOTDNkMjlseGdORVVHV3prcFpuTlBndDMrdjc5QXVFcVlD?=
 =?utf-8?B?QnBkTUw3c1VrQWtjalRtWk0rM2NIeGtTNnkwaFZLUittcG8xWWU0MWt5MnFK?=
 =?utf-8?B?OFc1Y2RKcTZxbkpkVmUzODk5a2NJeHQvSnhNaGRsMW9wcmRURVdtMEFBSUdB?=
 =?utf-8?B?ZmtaMm9GN0FyeGlpUkhqclB4c2poUFhvMHhNSlZQUmdSWkNnZmp2Qm9LRDJ5?=
 =?utf-8?B?cDBHdlU2UDJHbnBrNmZ0am96Rko3ekI5SVdpVzRPY24ydk8xLzFobmtHMU1K?=
 =?utf-8?B?eTZ2NWJxTUdPRGp3UWgzL3l6eHVGT3Z2KzcwQ0xEVGpnT1BUMzRNTkEyQktB?=
 =?utf-8?B?NEFjM2pqOUhvY0xiZ2lleHVBZFBhdHNmc2RuVW9XWFhCUGMwREJ3bUhrVHlI?=
 =?utf-8?B?L3dPQy9CdmtIMldnWk9DL1EzT3UrQ004a1drd2VGT0ZGUEhQSGRwbFFIODRD?=
 =?utf-8?B?a1AxUndnZEZrMnRuSEtZckZLeFA0dFRWUUIrRGR6VUNWazZPZjlLa29OdzRH?=
 =?utf-8?B?aDhtbWRSVkdTRTJCWTFVSmxYcVU5N1ZzWmhrdXc3YUMyMnozZjhtU1B2ZGU1?=
 =?utf-8?B?b1FaY25JOGw5WDRYd21mclFMZlFtK3hjeXVwQk5YeVVHWHhpbTRrVFk4SWVi?=
 =?utf-8?B?ZVYxOGVQV3lsN051bXpUc2kwTmtOa2FYOWtjR05abnJ0aUpsQTREeG5vcjJz?=
 =?utf-8?B?dFFYZGpDdG96NTNPbWNTVE1YazFleU9IYytQdExwdjJrclJDYmQ0djZhaVZP?=
 =?utf-8?B?bjUyQittNTBEUENpVU1nNjg3K3VhZnNqVVViSHN0cVBWNzF0WGlnK0Z4eXpn?=
 =?utf-8?B?NjFBL3BlQVBFaGZQRFhiK1JwRkpydGtpRFl1T3JZNGpCaVdPaklzZ0hneXdq?=
 =?utf-8?B?eU5WNE9HZ1F2ZUdoNHRVNWdWemxOckNYTFpQVzJkaUxyM2J2UWx1T3pKbW1M?=
 =?utf-8?B?RCswd2NLV3FEMTdTOHVvTTlOdWR6cCtZWkFOV21PVUY1YWxWVlJrMk1DWkk2?=
 =?utf-8?B?ZEtMMlhpNE9FRVNGY1U4bllwQzBaa0N2ZWpEdHdqcW1FZEZyV0xROHdaUTl5?=
 =?utf-8?B?K1hublc3VUo2TEtLK0xFSXFhTDA2eUZIWkI5bE1WZEJ2NWpWWlpLUm54clVM?=
 =?utf-8?B?eXVoRVZqMHhIVEdTNElXa1ZuUVhKa2gwWnJKSXlGM09EdDNZSnNlUW0yKy9E?=
 =?utf-8?B?NG1YQ0ExaFZkVjYyT1Y4TWJHSno4NFNRUlVPOVE0Ym5sU2ZsS3V4eEltZUty?=
 =?utf-8?B?Sjl2SE0xOEdGMGhOaUpTUk5rNlNVZE91cnlEem9ZZXR3MTRJemJ2OTd3TDQ1?=
 =?utf-8?B?YllSZGoyQnR2c3F5T0kybjlESHlSeW1hYlcxdkY0TmR2SXEvamNWWUUrVVVQ?=
 =?utf-8?B?SmNXREtkTkIxYm5vSEdJakxwbVJjWjZ2MWVzb0dwdlBpM2NyVjZvVm5KR3FZ?=
 =?utf-8?B?NGNHWmYwUXpKR3ZYVXVTRjZzeXdTbGpxUHMrS3R5RnY4Q09hZHNkV3dneFVU?=
 =?utf-8?B?VzQ0aWhKNkU2OFR0bmhQaFZCKzU2YlFRUENIQ25VS1JvLzNXcy9yaUZQbjVu?=
 =?utf-8?B?NGh4VURXYi9yM0NyV1M4ei9DaHdBbDljZWc3MEJ1dFNiME5iOEtjMTV3ZGpk?=
 =?utf-8?B?LzVsY1o0N0dtRlBTY1JUQXJsSEllRkFpU0JFMnJsaERaam1kSmEwbExuNi9h?=
 =?utf-8?B?V25RSTU0MEM0U0h6UHB5ZDZkWG5ZZkZOaFFIbGhSS3pGRC9GTXpkRmNSZWpq?=
 =?utf-8?B?OXkvQkdXdjE5Y2J0YzI3d1FLZ3hmL0NFQVFNZkk2dnNUMFJ0ZjVpUUovRzhD?=
 =?utf-8?Q?W+IMwHZAX93tF4QWUhy+YuKd94GRPhgX?=
X-Microsoft-Antispam-Message-Info: UKkBEQWNNguoJy1o0T3HDYvx2hs93f1HrCuEC+8jP0PQL7zFM+c4iG0k5ZFIcIsF/JiX4+e6yC/bQbb9IRCBkUcZE+M7uympnrFX5OUWzY1UTivWAKIlMjSZNyzTCdnAQAjAZ1Tv2n8MJXrGzwctTtazaiXaoqiSD3rgDLoSznBDs4PXrSCudx3JzzXL4yM/YvFubPVoosCmp+X5QvEnnRStb1exhMGx1LrqZcy0sca7S7Y6xhZNix6muwFtOw69yvHPdcrw/8v+GXaUgN5emSTWxmnMvuDvR78VeJ12zjrTsddRQj0kxb2K8O4DOQ+zxA4dhiHymkMYYUi9fiUPOem8Tum0dTSXoFNAjr/P0Hs=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:WyfLbvbhLyr8LyRCcoP3jSURSruAqcM63Yi0xy5qHuBk+qgzqN6S3Wp1jgJdmKQBspjgRViPFdn8YiBDCBlmJhC4neUnMeBH81fkuo1rSMXG69SjZMD9h09vdeC0pGIzi1wTeYG7Tud/1zrCgBEKX1oXGAr5iQoS1WTU7fRf5hW6ecPOTqEcALBAq2Kxi0J5wrt8RnuFCh33928stIxB5bEoz5owHjHxcztzeKWXmpfKWU2JNOkpJf0SLtjyvH9gS5+sk4Z0Lp2yFZEso/sSGseiHGib61+lJ+c6g7s5Kr1RkWSO5QXeqMq5SnLE7B6rubycH6zsMie2Yjfzw+FhWHqoKAlXGqLfDZtR7f5Vu/rRgi2aElfbiVw9QelhrYHWhjdg8sgHigvglJXNMV0btx/GYxzgO9fYlOVEC76d/6avvOdDV+xxps+A4OFSYPlLaQno3mWKSWzCkrqibMo5tg==;5:bNR66ewq88DvJYEOqCU7rSKcp15u5ToC4Twx0JYcFHoYC8eNLejZ1ijuQNl5wI5AQylKywAPQe2GfZu24c9+i7OcQMB6G2fAe9A1qVAVvpvkJEA2e+9BpNHf7f597MU+8GHY90jQgqhdvKzqJiTjW/CKKh3jZ3oSVJHZw9CI+FY=;7:8iXVs21EwJtVGrhlXSj+rCxnhAybzkBFC4aq9d3lh83Cp+MC8EXXoeSyL93mTEt7n3G0qAHNblk/LQTnYV0bYKXhi5xLXd/a+ofB+Op+uyY2P+vf4AUY7NGimfq1oMU/wHNoYtSlvNtTjkDeYIEpWQ04696Ibg15biGqGFe4gtf+n+ew3msTXKFHAs7IKojv6q+Ra2BtQLvUizWZpnoNPuB8E9TRXVvJNyYgTByzNGhm2LJkq8h8lX8LKl2YRT4l
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 01:21:18.8843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2871f7-e4c3-4762-dc3f-08d5f103c25c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65067
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

Please stop top-posting - you make it difficult to reply. I know you've
mentioned difficulties sending mail from your @lemote.com address but no
matter which email address you're using you should be able to format
your email properly if you're using a suitable email client.

On Tue, Jun 19, 2018 at 02:50:36PM +0800, 陈华才 wrote:
> > I think it'd be neater if we did this from C in cpu_probe_loongson()
> > though. If we add __BUILD_SET_C0(config6) to asm/mipsregs.h and define a
> > macro naming the SFB enable bit then both boot CPU & secondary cases
> > could be handled by a single line in cpu_probe_loongson(). Something
> > like this:
> > 
> >     set_c0_config6(LOONGSON_CONFIG6_SFB_ENABLE);
> > 
> > Unless there's a technical reason this doesn't work I'd prefer it to the
> > assembly version (and maybe we could move the LPA & ELPA configuration
> > into cpu-probe.c too then remove asm/mach-loongson64/kernel-entry-init.h
> > entirely).
>
> We should enable SFB/ELPA as early as possible, because it is
> dangerous if one core is SFB-enabled why another core isn't. ELPA is
> similar.

Why is it dangerous, and in what circumstances?

Based on commit messages & our other discussions about the SFB my
understanding is that it sits within a core, between the CPU pipeline &
the core's L1 data cache. Why would another core care about it being
enabled or disabled? How could the other core even tell?

Thanks,
    Paul
