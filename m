Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 23:45:22 +0100 (CET)
Received: from mail-he1eur01on0066.outbound.protection.outlook.com ([104.47.0.66]:9824
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993035AbdKAWpMs8VIe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Nov 2017 23:45:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sondrel.onmicrosoft.com; s=selector1-sondrel-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0PV7IBV+fpppqH0kopIXYAEFemryU6HUyUV3In+xMg0=;
 b=rRyB8RA0TcIjqx+6e/G5qLDwOq5TDQ28F3apeKODaKMEPkyMfba7UOqSxBuQ1smSRzrHz+ueaaImP3g4dJMs01W6JyOpDTHyFKH22mq34A47C1bgG0ijYFAkIr/kgUVJm48H8R1jjcgGq2JUJKGhV4af1RdMBidtFYFOSTQ5Sfo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.hartley@sondrel.com; 
Received: from [192.168.1.189] (82.16.158.201) by
 AM4P191MB0132.EURP191.PROD.OUTLOOK.COM (2603:10a6:200:66::10) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.178.6; Wed, 1 Nov
 2017 22:45:03 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] MAINTAINERS: Update Pistachio platform maintainers
From:   James Hartley <james.hartley@sondrel.com>
X-Mailer: iPhone Mail (15A432)
In-Reply-To: <20171101222526.GF15260@jhogan-linux>
Date:   Wed, 1 Nov 2017 22:45:00 +0000
Cc:     davem@davemloft.net, linux-mips@linux-mips.org,
        James Hartley <james.hartley@imgtec.com>
Content-Transfer-Encoding: 7bit
Message-Id: <472FDA71-132F-4DAC-AF68-A8AA971AE1C2@sondrel.com>
References: <1507745492-13349-1-git-send-email-james.hartley@sondrel.com> <20171101222526.GF15260@jhogan-linux>
To:     James Hogan <james.hogan@mips.com>
X-Originating-IP: [82.16.158.201]
X-ClientProxiedBy: AM4PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:205:1::44) To AM4P191MB0132.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:200:66::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c75db6f1-87a0-4a54-7d0f-08d5217a310c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:AM4P191MB0132;
X-Microsoft-Exchange-Diagnostics: 1;AM4P191MB0132;3:gDrXZpWuW1EhyJXNYI2D2jXBUxIgEwRGb60dhK4w2qkpMSYIPWKWAdhJaDzrvoDQ7Ox6ENG/fNwl9aXftAtRHlBiITTrh0zAKfM/7czLT3/aT0tlZhvOiU3Jqfj9mFRHKyNcRUbGhldehpQE823bLD8e1u6OWDUL52u13FIwj4TjVxcFy3ENCmBtYRnJjsu2mCi64MeoKmp3srTSwz4D8sZvXwyD1L9uDXOk+kBZItYi/+R9ER4yA+L/n9/7U3oT;25:pwcEz05/0EXUrEjLMkOTgaI/Klpopq4lrT7n4khVCnuJzHmfGmyOcpY8caLtvqKja8SUP9mBy0yZVQP7FPeZHhB2DwuzrFX3LWJRmnnRnSAme2P8ezOoRf6G+6i6ZYxfC1GxsOXkgHVx64glzTbUXi24187h2jt7hzvAk/Hp5s4vnjn5TNRptRaJC/cugy2CbBW0NpMtzUY94fHJQemnhWq5YeWJR/9JPs4g+gRcOb3lzDSsY7UWcdRiE1B75zYdX3cogAEWenVnqMD/Z8cfbeEhWBKY+oERa/JpSarioF3sQCsqJa59x+KAw60xSA8Au7RX4BWGC/40eyZ1Or9YOg==;31:kQWVzmEvknI8YvJ1K3f1HM+II8NBGFqK9Ox5PUuuN8OPRRfL00gZzF1ihYIpB3vjLIGbRXSEMH602a1o8bHqIdRF0ELG0fKdx07Es4JE1ay8u1avWfLgk3J1eZcco975qAAQ0BnzLdZPLUlWk/6kqZRBP/z7gklDXmFpCg43oXC2SNpoQipVNa6PlDB0zuPT6jP3zu16x3pfrRsfSk8DtJxRTn4ROwpd9jcRo102s4M=
X-MS-TrafficTypeDiagnostic: AM4P191MB0132:
X-Microsoft-Exchange-Diagnostics: 1;AM4P191MB0132;20:GjpqMI4KQgwP+W4bwy0rMHvxpI6Uj1FKNb8PvHeYOKrVjfTfWEdUqXIaYYTYEcV153LkJl4DVRHF8jQSswBKFC+JLZdKJN2puSSf+ymY+LYHbQBJ0xIoOElaZHfbfgeGHD0GcVJ8HWalpwsbMnnR8oZyEZoeOyjHGrE2d79NVuZD4RgxIiMwvHwwOCajTbhEsErD6TAvkXv0BkTzwj4Zrbn1CLK/iY33zCQLXvNqEigCIC3NB0Uhs+G1VdzQ+cTt1Y7rU/sffbmbYcXx3KAlc2ceUzMs/SoV20dfM0Q8vXZK7F4H9hhclZbfFBvtepu3PixbYLlxL7f/Dn2sIddGwA==;4:hW7yCYaMUYYBfVxNkM5OmEYC1e+FScBLXatRAN2cwUzclAMxuTH1myvwPagR5CzUgqCFdaycHpp8ZrS382g2SkZ6gOvrveeHqrX12wVjxCDo1ME+T1XoJL0776avQnU8g/F0mR0q/WQmOkw48GKsHOg0xSyhmR3sNDNHb2FSvVUI0PuZ+LYdCkpz/hth4VgAEfY+rp89J00PubJKpP1mFELJwRq+F4Zqq5u0OXZOUW+WomyqeEn6eQzv+ne7ULGm3Esy84QNOfmg5uXTPdhywQ==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <AM4P191MB0132432B95FEF6DBE56D868EF95F0@AM4P191MB0132.EURP191.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(93006095)(93001095)(10201501046)(3231020)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123562025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:AM4P191MB0132;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:AM4P191MB0132;
X-Forefront-PRVS: 0478C23FE0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(6049001)(39830400002)(376002)(346002)(199003)(189002)(24454002)(8936002)(16576012)(117156002)(83716003)(81166006)(81156014)(16526018)(97736004)(305945005)(50986999)(50466002)(53546010)(76176999)(316002)(7736002)(189998001)(36756003)(50226002)(86362001)(230700001)(23726003)(101416001)(8676002)(229853002)(5660300001)(6486002)(105586002)(33656002)(6916009)(3846002)(2950100002)(6116002)(478600001)(77096006)(68736007)(47776003)(6246003)(66066001)(53936002)(2906002)(106356001)(4326008)(25786009)(82746002)(117466003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4P191MB0132;H:[192.168.1.189];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: sondrel.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4P191MB0132;23:u6togiLRXYlIftno4wc+Gytd1+RqaS8RJZcvDNXES?=
 =?us-ascii?Q?4jrewNiHiegzFyl4nv8JaGjPW7lzrHoiHzW93c2ijxbioKFNyrMtirBpz+N/?=
 =?us-ascii?Q?F5PAxaMgatDe5hvBz/RqSEq1TJKZ4L+5kEUgwBV6HU7lq6qmgl8dZpa4yNfR?=
 =?us-ascii?Q?qrJbMcglti+tfNSdST0rHaLW170kx9xCQ2cEuiOKMPFrvBMrJkzkNCMX7Zp7?=
 =?us-ascii?Q?Sl6uQwqWrfxP18sjXKl2aPq6u6AhpWjmJUZXWJ8bAUjTrNe4aRUdAeRaQMu/?=
 =?us-ascii?Q?ftXBBh6KAsJl1805oThrnpKDbb9ILf4OcwFa9NVvCStNrwU50WNK6DvkJ4cA?=
 =?us-ascii?Q?5WGerv8hexDesFxbQY20O/2XjI3Nk99wkghaVE9OR16nWbnlkbPq7thvoT+m?=
 =?us-ascii?Q?x9+Vc0eMm1aGyMN3gRD+AacsrfC4TtIVfkXQ7sOlrF9hzHCT+4smd3fArPW5?=
 =?us-ascii?Q?8p5SCxXMdxaZclwHpkI91D/wO1TYkks3/dj4QOmVhGuAqWFE0fi1U7Ko8jlg?=
 =?us-ascii?Q?Y2aqfrAkpxpl3zRoIKAWY8XW0s4Uzy3Zvu04cBLjcIJREF16G7jO8neUzgyO?=
 =?us-ascii?Q?Jju9BNmL5wzInmBKBDHgDX0SiO5o+Imi8bGwzCIec9/UR9BlSf17jHYpEgji?=
 =?us-ascii?Q?TQko5i+sTrFCeYGYxdVOINIZ0FXzief2JXGHt86OenGxp4vOb/NTtrsdnZ5R?=
 =?us-ascii?Q?5s9TXvIrpoUxldLJzGuX8UmdVpY0MaERBD3Ss1dvtLyTfOTGYuKPKCoKI1fd?=
 =?us-ascii?Q?99YRG1SjwpkGHNtkSpr58kfTRVyXhs6vvczGP7KWoWZWTXHef8cHoNYZ0xNU?=
 =?us-ascii?Q?nnu+4jrY2PcM8Kc16FW1VBImG/tiuths59b0SaFJ/QTUP+2qqL5+iNG014BZ?=
 =?us-ascii?Q?8fmHDs9ot9YaxI0oUZyXVfTL8ZF24pcBpV0cyJdJPba0cnPgysISukKfIjIn?=
 =?us-ascii?Q?WbQhwMsmeymsGc4fpGb969HryJQMVYEcgjAcRb3BG+Jade6xMJGRwUKax8Sq?=
 =?us-ascii?Q?2Wv5vWw2WQZ/D8YY4tQRuu7FO4LSRU2k1GkiqC54DY5jNYpoyL/zb3LihOeG?=
 =?us-ascii?Q?gzfKIjiPAcoWhlCDi21PlqKzWy2ZjF773tMJY33+5o9U9Aox/FtjYZNoBZla?=
 =?us-ascii?Q?B+pn9ZLWYs7gftkDFAuBiLRoMu6AeUABjhFyaDiBbDTNd3iaZQhP9g37V39p?=
 =?us-ascii?Q?GA2PPIKUqOU8itnv+tvRjKi0fPgIovP1sHMnys1NtqJuMaPTAf+Et9Pvw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM4P191MB0132;6:7h+2wPQdVy2/9Dx0fHABp4VHygVB74ym5qL6P4LYPKhtxqByEFg36HFJgTvDDR4xNqbbAuQSWz43gzyHWlhPL364ZJVQjzKLgxLN/hszlRnVTcg2F4UX/TEA8GpV583zXXDxsCv0pEc32T0Ni3QLFBwGrUdopS29Zi8Lb7oONvsASfZOAU1awNid9OkffOCj0frVyD7YbZTCV2A3nGAHtb66gU7EoON8ZBa82RegzLwdefYNCtdkRiCa7yg6+cgSsuzFvirS1vS9LYZkadDIJw/wUv9WgFtn91/y0POTZumS6LrqzCC4g486HgKyKQ5FRrlIL1ZR5d5GIrxN+/7WOyZxJ+6/vrGjWso+uo7tc0s=;5:jqBe1Snk906Ouo0Cn/32o5s3wGPJO5tam0B45hbjLhx7AT3OF3kCIehIZiiF5bRs17YfGyZZy1KQ3taWzihW/63vKWwYB7Q9M6rjaOv0NkzRdlOBrebE7jYMmkEChyIrxhaC0iIttAOdsFA+w6ulm6uxXGdBnVdj3YuYb2kEen8=;24:AqbqHweib/WtHdruCokn8+vP2PFeK+Hn3555Al65u0VHsrgRQUsmfddSINgOgea5mNZq6OdnoMmtwKsOJzvsLVphEUtX6PqI3TRi7AFGy5Q=;7:fyWJVq+Xo4ReLjnfzCgHV5dZcgS7j9P1LLVFo6QpJNDORcLSfehzqPlwSfdqN5jMSKixyRjlezkIddK9ArKk6Ff4k9Uw+89KsFyyqbJJGVKuys24xVWZYHoQOp2FO0lD75fUU9v16f9viURKlg1UQp8yA7jAKwl5L3fQPo0xNMG4IEz2kCxvVzb1ImgDBH2+cHCmcSZqhBn66hrvsFjWnlLKgHG0Cwp4Kh4Zkb49XepaGybhan/wUHZ/Xy2Cu9xn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sondrel.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2017 22:45:03.5109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75db6f1-87a0-4a54-7d0f-08d5217a310c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4faa3872-698e-4896-80ec-148b916cb1ba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P191MB0132
Return-Path: <james.hartley@sondrel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hartley@sondrel.com
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

Hi James, 

> On 1 Nov 2017, at 22:25, James Hogan <james.hogan@mips.com> wrote:
> 
> Hi James,
> 
>> On Wed, Oct 11, 2017 at 07:11:32PM +0100, James Hartley wrote:
>> From: James Hartley <james.hartley@imgtec.com>
>> 
>> Neither of the current maintainers works for Imagination any more.
>> 
>> Removed both imgtec email addresses and added back mine for
>> occasional reviews, also changed from Maintained to Odd Fixes to
>> reflect the time that I will be able to spend on it.
>> 
>> Signed-off-by: James Hartley <james.hartley@sondrel.com>
> 
> The author (@imgtec.com) doesn't match the sign off (@sondrel.com). If
> you don't mind I'll change the authorship to your sondrel.com address
> when applying this.

Ah, right - yes that would be great, thanks. 

James. 

> 
> Thanks
> James
> 
>> ---
>> MAINTAINERS | 5 ++---
>> 1 file changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ccc5181..5ccf3b5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10731,10 +10731,9 @@ S:    Maintained
>> F:    drivers/pinctrl/spear/
>> 
>> PISTACHIO SOC SUPPORT
>> -M:    James Hartley <james.hartley@imgtec.com>
>> -M:    Ionela Voinescu <ionela.voinescu@imgtec.com>
>> +M:    James Hartley <james.hartley@sondrel.com>
>> L:    linux-mips@linux-mips.org
>> -S:    Maintained
>> +S:    Odd Fixes
>> F:    arch/mips/pistachio/
>> F:    arch/mips/include/asm/mach-pistachio/
>> F:    arch/mips/boot/dts/img/pistachio*
>> -- 
>> 2.7.4
>> 
>> 
