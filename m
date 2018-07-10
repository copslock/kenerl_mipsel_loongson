Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 20:52:34 +0200 (CEST)
Received: from mail-by2nam05on0701.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::701]:35264
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994710AbeGJSwZ0cxY7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Jul 2018 20:52:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGtLrqpVWtyUn9MBp87C3tonYuxnGF9iw055JMlN+6M=;
 b=rgu1UOUlpScUJY7I3aYDKu6NpW+fSTROXVZDH3TYXAylX+tsb70GWapQGPxCJOxzYPNwIYLqv9ft06XqjqqSUxypKYSdQDgJ/vYyePPDlJnDlEDRCsBhcEFlq3iuSMmp3dM87RxPgARYWB2LxNdwvU1uWFL6m9QOJJ7nwtmkCUU=
Received: from localhost (4.16.204.77) by
 SN6PR08MB4944.namprd08.prod.outlook.com (2603:10b6:805:6e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Tue, 10 Jul 2018 18:51:41 +0000
Date:   Tue, 10 Jul 2018 11:51:38 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/24] mtd: rawnand: Improve compile-test coverage
Message-ID: <20180710185138.mh564eehyfoaggsu@pburton-laptop>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709200945.30116-1-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR12CA0069.namprd12.prod.outlook.com
 (2603:10b6:300:103::31) To SN6PR08MB4944.namprd08.prod.outlook.com
 (2603:10b6:805:6e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6412be7c-b87c-4f2f-619f-08d5e6962d3e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4944;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;3:mlcMIHYrA5GN3kqLkdI9YXNETi69SjGLIANyrtXesm3vPJuIcav3C4dGOBRnf7B4dt/AxOo21oZJe4J8hp0kfaXdsZEOSgmWZ5Wxp1arTGA/tgK+hFPtzP4Q6BA3moOPIRTJZb2v0RIIecWdLh1fejhcTIl6Ne9LlFqXm26MTo7lKxOigum4Ge7S5+OHK9OrBNuRjeJJ2en0Llzatav6xPtnoEZIJtyt82Pe91DMQ1NWdIDCcXtzQ/hHhKcoHXEm;25:ln1lBeTGOkBvhBUJ4a0HGHGAJmANzEt3tXd6QG/iarsmtd49o1vkmRRpJa8TcOuptWqf4s8eFrzM4thSmPyntVpBsoZNUlpwAuKBvLDQmpxPlYenal5UH49+gKM8KvQDllC65vwT8kmz7S1jgRFQdYPKuCUDMNfqDoytdLKB9e+su+/w1aRhAyb5/06dTy4RrU8NN3eBs04Ap8xFjzrlIPu+uvi+00p0dotTR0GbJBy/RDHnWf0bdDrR/F9F1ArnrtO2RjL9oW4rfvqF0Okdr5PxdLPq2qfT4bHS8WoCLn3z7yW8Yf1wYpI3sPVrK31VF4WACp8s/zNc/1mRisxLiQ==;31:VPlIvN4fN1A2sw4CuYgROJr3ie0uimLlQrj8u3KOj10ERC/GYYC2QBRAOHXWJy6yp8DGxMI03M5J90F1y/MB9JqjmMAz1VWiUcmH8J8vmQM1xNHBdZmJEIxNHNSq6mCXxiWhavCKWeN792DmQ5ln55taWtYjlsRzkmUerI3KsF/91wCihsxBid8z4RlV01rIECXt0cM0qk7+G6cVblIKo1ZpqNt9fMig7YT+FkEaHnw=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4944:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;20:Ls6iFqjwQNu5tFVbyDxPfwm+utkFp0wNgePVzKC1KxnRIYx4AePL4y1QxQmiMQcqKm03CTxAa3ayCw7aDXiU08E+3S8cV5F0HpGhXGYfheEedXzWzBYHEXuhPwzBgxyl9htXVQRT63BStK02eJuizTDnwRqJnjh2Ncuo+MbHG1T9X70cZVqo7h+Vdec3fQeoGadTcLoStBeubaIUcOMRlCoQBCF45LwrnrqHmhF3xu7MWInsH/IBBRqYM8pcFIBj;4:uuKUiZZNQtZxpcHMKx6ti0/zD2bCZ0g0qkllrdWwg9/icjZpsg8fmqBrVNpSDVYAxsEvKz/ALW7iv7C5ac6tKmEes5jXtCntKhD2M9B6HA1rDtBKgd5+wX+ctxDiog8BLzNE996AWaH/G3cm/xgqCrR66eWIAsWrHzt9QqDDhdcwME/Q2pgr6moGrzg/b2mrNB1v5/5VpdqsUoM7qHLfGVzsk2RrViNlEwio9WnqnXVOBKvtWjj/r4SU5/0fs4LAs+j9Ff3RdVBxaoAZNzT0IA==
X-Microsoft-Antispam-PRVS: <SN6PR08MB49445AA73A6B43A2AFECCF9DC15B0@SN6PR08MB4944.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:SN6PR08MB4944;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4944;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39840400004)(346002)(136003)(376002)(366004)(199004)(189003)(54906003)(26005)(7736002)(16526019)(39060400002)(186003)(305945005)(476003)(52116002)(316002)(81166006)(33716001)(6246003)(81156014)(8936002)(33896004)(76506005)(486006)(6496006)(386003)(8676002)(2906002)(58126008)(25786009)(76176011)(42882007)(16586007)(4326008)(9686003)(53936002)(478600001)(7416002)(68736007)(6116002)(66066001)(3846002)(105586002)(6916009)(5660300001)(50466002)(229853002)(47776003)(6486002)(106356001)(6666003)(956004)(11346002)(44832011)(97736004)(446003)(23726003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4944;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4944;23:o6N+24WRCt6Cly6KurSZsB7oixETRdjTLSoNGgMX2?=
 =?us-ascii?Q?QJnKDKuV8ISF+OiwNS7qJzt2HeQ37CNZIos2NdVAsYGF87NF1x+W8VLowwxg?=
 =?us-ascii?Q?zQEewFnIUjF07v2MM82xw/zkZwHxQueSU2diiuD+qcKYOyUoT3o60/3QaM65?=
 =?us-ascii?Q?0A17NmpI1wEtq9qt5h3uhdAa/l1Jdke+cO/ItViDeyxNxD80KOTrK1xV4QC7?=
 =?us-ascii?Q?4yG6qw1UZDN0pYxaxIhK+8f1di13eBjnAsOitfLsnLYxGq1G4DUUeN6JB74l?=
 =?us-ascii?Q?IhMBL9qVAmTY9rpG0quEE7YlDpMGO1lUiNGEzRdBotZZUvLvz32VVxTXOaGt?=
 =?us-ascii?Q?SKOIL23Yq0pYgtJpEeZ42FGD/ZaZh8+UTNGvIhDXKTKU+ZooknHd8QdFvpeu?=
 =?us-ascii?Q?i+CcwVbe3G9j1gDeZ7TRwfegyQ1wqoiJ2tlqNw/Izngj8qdmuzFYB90LVUOf?=
 =?us-ascii?Q?lV25rfTUk40ND0x+3SNNWhZWllKQlYKQ3QOmp+Ye/3NrU9K/iBv/bblLsk3s?=
 =?us-ascii?Q?ZZMhtphxteWsk8QMESvu13ZAHHXtSHffHbVuhzcrW7+4aLCt4MoZHxd2jFJu?=
 =?us-ascii?Q?ytMweHnDfyhSTTmxVwEoI7CRdn8ZmJRrjsVomNHfL7y2GXsGM2D5J6ivpHtS?=
 =?us-ascii?Q?78VUWUFw+DrLKXHpTSHm17uQEA0Ok6Mpypn52CJuPNVkDgUqx23iUTh5bJ3t?=
 =?us-ascii?Q?uFjDrhnnDhd0k/7PaA0UX7qk0AYqxENaw13gpDvPpDEdZmCqzyFQwwwlIYsf?=
 =?us-ascii?Q?hKdVZBt5Celeq3DYYss4tmYGPio1SxYRcKwV819WKDkUg8ZiUMvX2xvrugA1?=
 =?us-ascii?Q?de8PjOrH7NV5U31SWxFeG5t8RHEvGCSPKYSN+RAjv2zQOAe5FypEjRwarjg0?=
 =?us-ascii?Q?QSeytUR2uJoIHz+3u/cN4wXDC1CIa07rZZflspAO3AXUtmXlM7GdzM8iP+GG?=
 =?us-ascii?Q?oHIfq4kwFuwQkiUwFbQM15g36zqfJZnfycU/I95IcZz/syRi5AY/bhbY8iqt?=
 =?us-ascii?Q?7uYIG81MxN9WexWIlDV9bN3SaIODIy4hylDUAOBgWaOqLMl98Ai+9GpYb0iO?=
 =?us-ascii?Q?1g4VG+vYOGjxp1RS6q7FA8T2vf7QLCPDK0pF2dYgCQBiY3ExosrZ8szor5vt?=
 =?us-ascii?Q?X+/tWPzkjhqrONfC4FClBxG02ReMMmjv5TEkQVL+R6t104eNf22l7nCBl42Y?=
 =?us-ascii?Q?drEU5/yKqoQzGWeL5oSNuGEFizuJnAiGWEZVa/k4iDiHOfqJpQfGsAem+9Py?=
 =?us-ascii?Q?GRmDYlVMiPqKefys3KzN1c42Oe3+wSpnG2exYQqi2xfhOJoyJaIIBwls7rJB?=
 =?us-ascii?Q?CFDStljgJMIMd5rDSdCusOCEWktlzg2tep6Z5L2fQ2KlsAc/WAvv7cD9bLCd?=
 =?us-ascii?Q?gc6nQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: uU4lGhFsRK1L8KOEMAQ7an/Y3/vZp0tZsN0bxf76/y0PBVka5PyKlrbLzcUA0ECV1pDNjpvxfqw3nMMHKisuMVT356LDLTJDsXH6Fcw034124hlCEhVjT9Y7xvoNdDW8F5zUZ+ygVwCXaiG+th+FLj9PaNfD/aOLp5qr8N8PvxZlLzEMK3q2Wk9skZ+NilWUDlcWRTGjfTOTxAQICBKNdUKzv7r4Sn0/YCsvnu5NIvX8nIc3zlaPTOnr9YGun+6zZP+rnKDoI6i53KAx6sDSe2NvZCqC8fk5kY7q/3FlxC5g/oEHTxnIXVh8xqECH9BcikiNqFSrsR21KLltJpGXav0nysPIuJwfQOcNdN9A6vA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;6:BbXF7mj5/6B6soEqTctcr0q++ADNU/H1ncBqA5ioJsJ4RL8wvVhquODB7XlVSYZOEgICwBB+QBpy3UXS6frNgBwV/7jdI1oCsYCXBRNG0OBgHlY98mRcoca9VkJT3OZA/nDgvhmVhYOnV8aG/B1s+Ill1zgKTUtmP7ygL3apvMtKWjIjLD4Zp47+wa4hGQeptQ6xMNwgwaVT9zbwT1VHpvMTNfFM7QJ2q3b8/O2L7evoAJ4bkof2v7MSZoVsh4pgTyP0cXTR5N8kTNqHuxSy8I6H/EaL2xK2qFHqPNbDpPVkilxUWO9fnt4ECRP9sitQp25kyJj3dyBRlg/3/ECn4mkupCF6EF2MqHyZuXXftDZn1gxQzwL6L7Z2qSIhX8Fg5g9jqHva4uYb6bfnCsaULxxDRslPaSMCahHk6NCKyKnxBoKnTc6AWYfWR8GTzhW7NmQE3dJfwla4sM/9llKGxA==;5:zz3LajxizC7UtGY6hvyAH/NutuMwKJbA+x3eZW0Wc1ianTu8d5h8pvMTVdCeapk3/YN+wD8EQZHHG4szcVLgHeEHU0mgFz89wZCeJr2kmVjTCGj3TTch4LqWLKqdFqSOTaFgqOwuD6Qegz+p/SRY/ZRiUB+HB5rseyJLNwoUuzw=;24:/krdlgghIQDyOzs78t5XzBk+hfi9CRSrl6YStPPuMZqJJpb3Kz4rcWI9NF49bc8nS7B6MCkkBIl0D3nvIgRoj80sj1JRbLQsCUt9b7QHAQ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;7:j8ssVKu4qAUsXVcqyB75KYlSnQzirGKqANMvrXEn1OdiT9wezplZgaPSBraXEuMC40zqeaI/8Hqjxx65rBx3Q+Jn4jlXFt6a8Bxn/Fy9I5ATOxvjGL34RsAe899+j7JK/TCswhPgRFd7AnXGhLw4Tv0F0YbwNQBbly5q7fANojqtPvHpBgEjGrp2MkTiaHoRuz9Uw1943SjZ5wjr+miID8Ck1VHbRFVBeSTa6fgYrzubX/Ko4qh05J31qkTJLacC
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 18:51:41.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6412be7c-b87c-4f2f-619f-08d5e6962d3e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4944
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64766
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

Hi Boris,

On Mon, Jul 09, 2018 at 10:09:21PM +0200, Boris Brezillon wrote:
>   MIPS: txx9: Move the ndfc.h header to include/linux/platform_data/txx9
>   mtd: rawnand: txx9ndfmc: Allow selection of this driver when
>     COMPILE_TEST=y
>   MIPS: jz4740: Move jz4740_nand.h header to
>     include/linux/platform_data/jz4740
>   mtd: rawnand: jz4740: Allow selection of this driver when
>     COMPILE_TEST=y
>   mtd: rawnand: jz4780: Drop the dependency on MACH_JZ4780
>   memory: jz4780-nemc: Allow selection of this driver when
>     COMPILE_TEST=y
> 
>  arch/mips/jz4740/board-qi_lb60.c                   |  3 +-
>  arch/mips/txx9/generic/setup.c                     |  2 +-
>  arch/mips/txx9/generic/setup_tx4938.c              |  2 +-
>  arch/mips/txx9/generic/setup_tx4939.c              |  2 +-
>  drivers/memory/Kconfig                             |  6 ++--
>  drivers/mtd/nand/raw/Kconfig                       | 33 ++++++++++++++--------
>  drivers/mtd/nand/raw/jz4740_nand.c                 |  2 +-
>  drivers/mtd/nand/raw/txx9ndfmc.c                   |  2 +-
>  .../linux/platform_data/jz4740}/jz4740_nand.h      |  4 +--
>  .../linux/platform_data}/txx9/ndfmc.h              |  6 ++--
>  rename {arch/mips/include/asm/mach-jz4740 => include/linux/platform_data/jz4740}/jz4740_nand.h (91%)
>  rename {arch/mips/include/asm => include/linux/platform_data}/txx9/ndfmc.h (91%)

For the MIPS-related patches 19-24:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
