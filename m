Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 00:56:06 +0200 (CEST)
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:60496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993057AbeF0Wzyuwtoa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2018 00:55:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCgsPrfyTL+vozNItxY+0I38yXAre1aoWH1KnI+UYTA=;
 b=UEOf7MtgWEntsETx/tuVD09gdK9RP4j+2Cm5VUpJXEI9yen7FvvLB1ao2hNmtnJiGPB6ZwMHRv227uxxDldij1i8+73GCRtxMb4k0LnU4Ba1F6n+TQT2LspNnQ8TiF2Tpxd58BS0eF3wpTTrZDeCQjA4M27mPj+lJ9qmWI/IStE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Wed, 27 Jun 2018 22:55:43 +0000
Date:   Wed, 27 Jun 2018 15:55:39 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     John Crispin <john@phrozen.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Weijie Gao <hackpascal@gmail.com>
Subject: Re: [PATCH 02/25] MIPS: ath79: add support for QCA953x QCA956x TP9343
Message-ID: <20180627225539.kybn5lvibmao6w2x@pburton-laptop>
References: <20180625171549.4618-1-john@phrozen.org>
 <20180625171549.4618-3-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625171549.4618-3-john@phrozen.org>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:404:79::28) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20585554-7e03-4f18-ae0c-08d5dc811cdb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:Lp1HOoac/4GuNGtfEvNsrXnhWUl1RP8gXDPUQ0NRGao7zMVRsZXF16lSCjvCWtO34DyVUl9AS+IeelXAdIYupLJ0HWHl7z8O1I0XIbwDdiyZwkNwF4wC1Op34Qq35zoxWoc6/tzCRS63KGkvSKxp6wq0NJBlXu3fpdCsCBIc3POYHWUpmvvx71HPLUg5HDCSjxMZMLI4fXQFRYyZGl/fSJIzUvzd4aAPPnRiVMMqkHgbMPXpjEYyYveKtCgMubg5;25:+e+rJJz2vkY/eCWYw4ECl8OPrlZ/NHQWrENeiVGisoxXnKU87l+ujLuzzXXQhBLV9q9jLx4Fz6uy0u1SnqpGhmJF+yIfL+USETlii6CsEiX1x82tdO6w1Dj0mnZ/ufjRed7x11twpO6yskopoFyPnJXfi++7YcdrYXUe8YohZsNYZ+ZDR1EZiVN9ymXM/vipgxEy4+o86dC0pweUTPIVLuMFol2xcNmUl9tCwdFH96wkF6cm8gm1UcUIQuPZAPq1m9w2X4bJWlNiQTVwCetScV9ExPgB5vnOZ/UYy2XtlhhmdZQzwgbA62jYJ5v8m7C2gHZ9lNZYSvFv7Aojto8BAA==;31:InEy4fI/eakaQZdC1DHEPYepQ7NxXO+qxCnTXKmA2hpaZP9tEy8Nje7C4Gi8A9djA06Qt42Mq8mLu9g0HFn1bPf2P/bpbrX1Dtb5ZKn3w6H1eNYFX2HwhW+ca1ZOgWhEPrFk/x82Xrv6lgcbSTT0If7AX5/0dOWdSM03k68as7kEiP1kowbb+xsenfIuj3NMrEWJZ2JuFBWkuh/9W106n+lwBVcOT8Xf6zcogWTd1K8=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:oFNlKyvHckqY6hJOKnah4ybc129G4wOQUELDk0kmFi5plerXvdnN9dL5LPJyITSV3khat2iniNaYIj5MGPV8O708Nuo7kbzpq2LNMRhiOdZamlaKfrgj3Wn/ISTtIj9tr7Bn9mDANVZT3Avy0vYzvH+Cq0oDbMna5Jk5My5wPDJyMItRWDyuYNZG7nTzalYB4XYoOXGcbCy4naEJ0AXarbB5EQ7pSYFGbZzSLbSECtiRIX4VxbvWWawB411Dv0rc;4:lBd9/8xv5nEV0gQf2ko3of4AAuwA/8NRZ5+V7ff0496UOc4Rg8phwrNHq99lp329BImMMedE8/4AUrHq9oj54eStdwbuXTsEWMpG8/HAsfGQq9w1Hn6sOg65ph5TUeu8tG6Os54BHvHsHkbkxFc8efgBC7HA7RxXXPDlCrAnrz3BCxIJKupxQiHd3fcP2jjbb5kDuUtRixyOolCjCvH4nzniHHEA/qldh3OUDOivNm2EbZf8DwG55BqOnpZnR3ky31/kkfmJQPP/JWDJR5gYPDxtEuV5OeOYTWnKphnyzdQyARxbYYwLdu8asX9GXQey
X-Microsoft-Antispam-PRVS: <DM6PR08MB49380D2B6540B902E6D9BCF1C1480@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(396003)(136003)(39840400004)(346002)(366004)(199004)(189003)(305945005)(16586007)(105586002)(44832011)(9686003)(58126008)(956004)(446003)(11346002)(76506005)(54906003)(33896004)(42882007)(386003)(486006)(8936002)(7736002)(81156014)(50466002)(81166006)(23726003)(6486002)(229853002)(6496006)(1076002)(52116002)(106356001)(316002)(476003)(8676002)(186003)(478600001)(16526019)(3846002)(6246003)(76176011)(2906002)(5660300001)(6666003)(6116002)(6916009)(97736004)(39060400002)(4326008)(47776003)(53936002)(25786009)(26005)(68736007)(66066001)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:izVuWcQwTkGKvCuMi2QSi37+6Y3NcJSMeZyLNbvBU?=
 =?us-ascii?Q?N+48MY6Z/3IATea6ZLlVPiW9TEmcNK9arKSds/qjze6gIBtZQlxCXpkYERRT?=
 =?us-ascii?Q?xs/mDVQF7sbs3+EwKtUaFcHprdbK22RxrYhGCdW3nVrRWnk9y/8VvvXJPOTZ?=
 =?us-ascii?Q?sUQOybXeTGWa4gJ5Ikff+AFKqRPzyfV1gMaBHJ/cojaWKNuCePejSZcelEd+?=
 =?us-ascii?Q?4kWPrcMYSxXmqMvp5RD4+m/BrR72zUKQ+3oEQKcEjKs7vWlgjawQ/xqQPON1?=
 =?us-ascii?Q?6C814xzd8t1U0H28cEEipMirMFug8YnRsfhojMqWhB5YpKEElpu87/Db29Cr?=
 =?us-ascii?Q?y0ZZ1M+2Tl3OH9UBs/V+susZ4LJtLj942X1zOWt0osOEKv9X0rm7CkjWOdSn?=
 =?us-ascii?Q?fr7RjVjrsrw4Into36r3ViSpg0J7oL+YTrIdnH7wp79NNn1UKuYdGA8fXwUp?=
 =?us-ascii?Q?6oAGocAHpH6wiPN2aAXUuT3VjEl511dnr6Ax8YWQlHikkfaAu4Bam87ZxSmP?=
 =?us-ascii?Q?zK9Y35qKGf03dsIDej0u5Yq+fzVeaAOWNY3xAijmPqZh1lUW2EbakF/8Nqir?=
 =?us-ascii?Q?UKLTun8ztZvzcmZCUWgTH0OpVDjxoQ56jgcI2b1qCMjSmcSiJvUmiu7AEpZX?=
 =?us-ascii?Q?CNfaNEGAUtFjMWzWVsbpPZg729sUVnH9sVg7PKLrh/gl0ZP6+DJqX8fMEiUG?=
 =?us-ascii?Q?/+9tvSZKprm/aSy2C9+0MIvYDzh1E5QlC69U+nD5veS6p98jo4OyBIVtF9wQ?=
 =?us-ascii?Q?LGBfq4vJ81C6fQE+2BhuCbmlBydcmhEv/66ZADPXCgqccFGQGqyxIkc3nQWm?=
 =?us-ascii?Q?hn7biFmmPVC6X/WdKxTzHwxxdglArLeV1zy6JU8LdG55ZgOK/eyiGsCw1gCG?=
 =?us-ascii?Q?f2MBEejLK5KVRwgPoJndKk+pwyLItpaqq4JPhhpsNdtxDdtxXoc39X2Iqcmc?=
 =?us-ascii?Q?Krh6X9nSa/SfBZ063YSnSNK8fMS8QNDO2Ju+K1MCnvRXSqfbf2IuB1KJD2b5?=
 =?us-ascii?Q?NVGZrDBtbzRjXUey22/lHhoBagrWnSMWC0/JSoC5GIr21e2qb/mkp8pTCi4x?=
 =?us-ascii?Q?Kvm7DxPx3lzEQcw/A57oc2VcAW6P/bCAoEP0WGAsT6kecjg7f4FxKzVDIK1F?=
 =?us-ascii?Q?NIbH3SgiPvavM0fhyBGdSQqvLV/234BFXrSRvzTI3taWuNzdbSIMRRtH6X9G?=
 =?us-ascii?Q?ymqiEx8/5MLlukfxn3mBnvvEBA6rjRhoFjxghaLDuFY6Hg638HE9I6Xv9av8?=
 =?us-ascii?Q?tptqgiA1SZ89f5p8P/yENgGAcbuKs8+CPY4T1WFJpC6Cl31YM4bpJ3h2+7H6?=
 =?us-ascii?Q?U1v898y3b/hzxKiE5AfNUXXjU3ti0mb3SWRR0T5K1rU?=
X-Microsoft-Antispam-Message-Info: ZBB96YaMLjXhMRzoqTUtfEOpU3/F/qUUBIkDCedWGnsfizjcyIm55l+60JUFUow/w2YjHt0HFmLTlZiAdIn52S1hhRc76AQ4Oj+PLiqsHqgyb+uOoVQRPMRiYigWddLKLJZhAOQkC1ErSY0pFl6vHBsT+02dypuoSYQ6EbwJVyFZMwTqS0mz0wf9cz44wHIZEjsO+yinelqGcj96hqucnDmxcP8yZPXZJEVnaBIITMZYzS4Wz1yTB742JqMfFF4HOsGC5PNnyiq68uM/3RzSSCZ1EffLtkoe3fpkYrq/bjhGxcuxcIG2xie2Mr2kc00OzVkXsfu28Rg7Ef1yxHHp0KIKbEn6IG3vT5Kup8/nedI=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:Of8/TSF7fzKuRWatAhKvgnulTqgVGD6arMISxcJjnxZWu6DEzPksxSyT1VIs9dIcnY1m34oiDX5tTyvFFhq/OH4hen6IV4k/aEmUqdwfiBEbgTyJRzz+amuFs+nWX45qRJCcVd/sU457boQGTht0BE08lYJvZ5jrYGzp06oyoYOLOOC/A/z1SFDd0G6PsOgYumcDAI6fnjKceynt9SSa3uDLF1OIOEwhiMt19wC5DYWOL+kS41tuKbIC6u+72HWtw2CGfhpqcFT05x5JL1qvLRNXnoFPq36VChB8pJWKD9b2u4uXkcdvSy5M+vSSiJ+Mx1m3bIXjeoUUhUfd1UmgUOF3u73BlTC5Iu2euOonNLOJ9L4XaZG8JQJil9pXS+EC2DP5cbErM1Vu8vV31JxayZMnih6E8lnDpCMJYCqIOP8p0dBoZkDEpzxJbRQGbMSHL09LWKi5nFWsF3RzRE0yAg==;5:4mtX9UlWT//r/JqQOeud7xi4n+kjPxHteBlbSQf+GiVnzjr0PHNOygyxw0AKzOIAfyM0vH4LGohR/i6lr/UfqNrBwyA2RaOWI11hzgb3aaeR8I8NzYn39OqyNeqKUYS2d9WV6wXoxdiipg1rrPwyTp1TzYTuWnOdEZ6kf4vauc0=;24:q9wS53qVLKWnI7aXQnmhFqhtdB9TGMTXq8Ck64INwkE5h+fgJNTYmTewpvn+/zYNgKnk13/n7CnQA25nWdojpCcTpyk9ZHwhEDvZcn0M6fs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;7:v9w/AoJgZwRtm0ZiXwbm6rHuM5PvZSYEOpQ7ZBuwzfKsxf49OoVs/RxMFPejzOq9Fc0TU20KRL66H/V0FgAW28gtCjVfJ18ZzLN38WYqwcO5vWieLfU6t+N+kMPSU7PNUx5THlwkoXH3usVd1VDHoQCz70NhOAycl9tM1IHoigdYDTt1grEsVo/fasleMxGAxWAFUTZnvHTx8jeXijAef4/tDGCVSJSkVoRoB4q/z1F/halF3O4hkNStlyUrVJq/
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 22:55:43.3002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20585554-7e03-4f18-ae0c-08d5dc811cdb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64472
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

Hi John/Matthias,

On Mon, Jun 25, 2018 at 07:15:26PM +0200, John Crispin wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> This patch adds support for 2 new types of QCA silicon. TP9343 is
> essentially the sane as the QCA956X but is licensed by TPLink.

s/sane/same/

> Signed-off-by: Weijie Gao <hackpascal@gmail.com>
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Since this is coming via you John could you add your SoB?

Thanks,
    Paul
