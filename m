Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 19:39:17 +0200 (CEST)
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:61235
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994077AbeGXRjNYmUgM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 19:39:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcTttUqnOa+a5c8YRgVRPv7fY/AIe5UrVQHqOFU7it8=;
 b=VOTG8hztjP7Z8/JYdrlXJ4aqK/14TlrDFCyDfYAOI+CAMgrj+bl8WCi6jaLGNtyOFwyrr1CDbjhgzN1yl+TtRbZ/LUgXbdBJ603YyDsR05+RLSznU9Fqk0Ks4/mUkVVlHa/TAeKE2l8g4/4v7Nt8bn2oYtyTMhXOViQTpIgLn/s=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 17:39:02 +0000
Date:   Tue, 24 Jul 2018 10:38:59 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Octeon: Select HAS_RAPIDIO
Message-ID: <20180724173859.mnr5z3lwf7hno4ll@pburton-laptop>
References: <20180724123200.6588-1-alexander.sverdlin@nokia.com>
 <20180724123200.6588-2-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724123200.6588-2-alexander.sverdlin@nokia.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BL0PR02CA0089.namprd02.prod.outlook.com
 (2603:10b6:208:51::30) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41b8ea0a-e7f9-47b8-6a39-08d5f18c58b9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:C/ePBF+iSw7DvmV3O1DFAOhq2LEqicoFEseC6o3QVwudaxHoUpSVSiohZCNSgr//gC5WWdc3tF48yDln7LSK/pBuuaBRPyoxLYTHqNFYzw9KjO/TO5N+cR46S4PAcULQNvAkZUjTYJLSPPid5qh0snlAgn65Sk9i9a3v6r7Dog4lojrJbyOA1UKPaRIGwQ+jqAkldC446A4bc9KNgED5pimC1o/G2jT5txTae6Ey/kV5ezTK5wfFT/+yQZWbEzij;25:sbO8QDpJjepsDazbuSBTqY8Qih4SRX1A2uIolGs5XgXDbvT4W7/8uZNxnvzIk4UJRn+7HKdal5ZkcGa0LiEGy+qX56M9YsB9Rs7CUx07LyDZ0ugZiRYIO+vy2ov4mwvLr6wQNBqZWPvuQ4pD3pAzi/X+l58/bP3nHRC/4j2Hc5T9XaeyfSizxspkZ3JS2ZAurrPOpm0TthiyDVCHsq0zaPvjrz/ytjYnIBSWiEnDAS7AwekJewrrWVlvzSAF2cozjJO61JsFZllvNFgcq4deNqwf4B+GteYoR59cGYX/Ebg9quJi7BPRQP1oNBo6CGAhCN58ZY/KTw5HUZiA0FrvqQ==;31:eLnsgjwjLvlQC52Rb9ySjUwknJPiyfAYOh1opoHdx6HYeLwGcGoi6DWYRgT+7LJCw4S9xasuIYeEXK2ZWdmNTF5niG0bvRlWxRX3gsYp7ECAUjNm6HhzKYge496M812eEi6Nteb92NOxiiL3vO+kJcj9pGIYktvCKqth32QBsfbEMb2O9MUg1EgbBbi0YReLcHG0nZ3iOyTFCmsw5CRfBI0KWtVOxbQGTKpVDNm1uAs=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:qnME+GEL1UPUquShEO4zNX3qQg9gAK5tkcJtK5WDKNy41Sz8zKWZT4Xq7ZE33GASFXDMvuv5xQM23AtPtqpOToIB+FgUCL8NOkLSqnxnnc0pILbhgq7CzaxozAoZKXbi6KxFq/M/lNNoqmK+vnFwPTb2RrJbFAHUoyPiMJZR8hBtOdh46fadCZR8TDCZWTqKpmvGNhOCLUIayxmSDc1fb7RtMmZkaR6d0PxJUGBCsraAdOjkzXRQTegpRWqVYZy9;4:F8JIw3j1q2+3AqK6dXqxEormQjhlEGxDVSqmcY9nrsGXnz+cewRxQTBYpznEzmfcd598JynsC+0HnuocCtxiNfq/EnOXgSr7/bFWj8OPRZPn0IGRvjsSKapMuJ8C0feRn2qlj7Z7/9KbsyEsftw794+gYD9QggsMC0mj5qZXIgSZywWvnRT/bfQTYfdcInVrrPTeknYLORiY0IwZPqOCtKQbZ6ISYrkDZshHoEkwf64LO0U+WDnDM8KClBjGI4wi0FpwBciM728h4k+QDA3490/aUS2ZI0L4blSN9haahgqSdxI+rcWoGkm4agxhkXsVlXsWCty8hEF3ywrVeTHQ4uz3IfndG/T7uXqnNScyIbgk90ASAUcnyh890Iei6Bf4hdUjFPFzCJUrfoWQmfRKu2s8xdnE7GXNum7SI/qZ8+Q=
X-Microsoft-Antispam-PRVS: <BYAPR08MB493347015DDA3E71E7B6CE03C1550@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(85827821059158)(109105607167333)(195916259791689);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201703031522075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(105586002)(9686003)(47776003)(52116002)(53936002)(66066001)(6496006)(76176011)(106356001)(25786009)(8676002)(81166006)(33896004)(50466002)(6486002)(6916009)(229853002)(8936002)(4326008)(6666003)(81156014)(7736002)(386003)(76506005)(39060400002)(305945005)(97736004)(68736007)(58126008)(956004)(186003)(11346002)(14444005)(446003)(486006)(16586007)(476003)(6246003)(42882007)(54906003)(2906002)(1076002)(26005)(33716001)(478600001)(316002)(23726003)(16526019)(6116002)(44832011)(3846002)(296002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:6wRKi+NRKcCK5rZxNRfWpmpQmYh5CaDbk101fNC4o?=
 =?us-ascii?Q?KX7yE8LxXa1m+8BWzjA380KsQmO86UuBWbiuH6lrxb1yB5o+rN3FMMBpp0gv?=
 =?us-ascii?Q?+kGoulctQPgS5eAP3/HMtKRhFacWDurvwgfD2usNHUH3uc0MHVS7pQIJsbcM?=
 =?us-ascii?Q?uhBm657IFVoZIuWV2kmpSqYWWWXTQQZlczplQI60bIWWy+vBHvHxFWmEQ4uG?=
 =?us-ascii?Q?PLKZb4gp7EQ5lCvp1gtngQwjH9eFFWkKieGeo4z+H4Hwyr95K/moxA6UyKuK?=
 =?us-ascii?Q?QizyBHavGvcaGlwELAAnChnY9TWcwewFNF5sNJt4xrQpyBh53MG5CVL5DSwo?=
 =?us-ascii?Q?vf8kJ2EK4UvA0RSBzUCLDtnCLk8GaFiJHZ/UKYXaL+7npVWex2GW2FfqJDry?=
 =?us-ascii?Q?aDDkPBV0/FX8COmX+lNcNP3Q/Y4czk692OIV2RyrE1nj2Z7M8A3ya9E7Jq13?=
 =?us-ascii?Q?Y084lQRNyl7ffO5ncV+n1CnMl0d6+kDYjnTMGj2xlpVcE0p6ZapslhjsvDYt?=
 =?us-ascii?Q?Ymri4SmRY7pz3IltP3YAPHJEllO7JIMNCv8NRzAQTSCkSii9vQXujqKPfgaG?=
 =?us-ascii?Q?9YbasXJASzWi5bZxhIx2lFyvayoxVTT3h3myB4IsQeLXn4qlsLA3b12mWhS8?=
 =?us-ascii?Q?xd7iu8Vog2ILeuRYNqvQFpeMw+6aUXPnojKR9dvnKBWlzMVa8y94H7LhiJHn?=
 =?us-ascii?Q?TLnrSwxozRxR8sxSjmSdSkO6RLkvGzqXWyStFDkDFIC1TzmiKq91JPlQTPPO?=
 =?us-ascii?Q?/FoYAYFeLxaAESV+HpxRzCVCCr6IePT64//xJIjviZAz3EdYDbH3XFzNbQxX?=
 =?us-ascii?Q?6uwunDzSZfDe7K2ZJRsefxvQvwMTPchyVO+zDTNGbSQh64HA6ZzynRhrDh9C?=
 =?us-ascii?Q?zpTBhXET9u8D7tvJmXepLyU//87NR52xN6AroHdhhHzzElRE67/tjHddFdlQ?=
 =?us-ascii?Q?F4kT5SntYbrsVcHzBwSL827fnHE/XkKo1F+hrp/uoBGHgqJeatdytUEglESO?=
 =?us-ascii?Q?fIr0iEJcFECjXmxWi8HT32RnEhN9WtLBfHwq51W1hqaYrMtnt1kXiTGSsUgR?=
 =?us-ascii?Q?oFocG/sCCzuML7GZri56MVJI0TA4fuCmXLrc5KnqHoVcRTRmmnpy90FmFxlj?=
 =?us-ascii?Q?mX9h4SFV/WTthdyQQYGa3Zhm5HNJS6CgT2/44NtfqhXfpceAvUY11VceFIhl?=
 =?us-ascii?Q?jK389iI351FLHj7a9JTYL8+ADGR3qxZkmEO6TVHWYfSPvGxcw2cR0eCpqb6q?=
 =?us-ascii?Q?2mLNkrcmkAOk7bMR8XVFaVcMso7SuMk/GnUGlHr/0P0wUIKbyMWUtvgfqTk+?=
 =?us-ascii?Q?5DSiW447ZCoiEg+phLPoIBFPxEfwXTMAq/rMHGRh4ogcNigEm6FhWhTliowY?=
 =?us-ascii?Q?MfUm1wShz8Qlog6jWDrltpCSso=3D?=
X-Microsoft-Antispam-Message-Info: o9pQENvneFJIG2FInN+JXveZabO4Mdrq/Ftl1KOG0vCNwstUljx/5jcMf7baTSs2FgFKceg9wMhpkBDBqW5b6b5CYXDs18TIbU7ode3+hv7EntVeUFmjQEhCfhnE9oi+im5m9LayRuGJBAr+zTfTvWrZHpIry3awUCvwQucyJF87B5jMa6Cgpw0ihKMyiBKpb1NNkCEaE/Lqywgcx0F2h1mkb89zeF77t1xoSAhSplbJZM8qtngGZovXIayMOZFh5k2XBLrAgFwWyT62g7lusJetUssTc0HQ8SXB0SJ8RqVPr6l22qAefb1kWNEctK6b60zMBfCuwAB2Ok20JkC76diaKhsOKtw/Dpinn+r4k1I=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:3FRlFbIzA+nWSmR2NchgJ3RFAH4eKudC16m/3Kic1i9cl6Seq5FG4Irp7gTeoNSF87Nfs70QC8D99jcQrUfzq+HGFHqN6/Eoxci7yig/SmWhA/sftH1aNYgbUXTPNu2nUxIg7mNPqnDrApYgWfKfJxbHxlJGp/EWbGDK1mdFJs7wJn5ecmpu9iNgatVdFa0RK+hqVHznDeEtkoyMUUT2fg04Alep6RKyUA58/E7D6ujtezHLGvqVmxvj1AlhzpSLn6HR4OCKLJxR/s18Xa9jJV7e17aiI8ShuwjIOF3HkwOZhm+Btu1dNz0c/1KmcvFb4qxsIVfEs7V43S2wuVqOhQ+gS3roh3pEgfT0hX9rKTNTV56ZMXEZTusOBKkvnEj/A42FXiasUuThCm4l2opoa2ziX7Vj3vA4rIP+2mvQerj7LFUU8y3cfGPIFyQsYwy2u2VzuRaPXmyYbBnlXTmZeA==;5:vX4quKXISGbajjoES1b6eGnW0UKWAaEQgnYqVuMnaNeDUVcO/amjgVFKtKe9m2lzEDVwYXmwZWfss7ug4S+QwYk1PfAvBByGB68+MxQbwvvFXVFM+IoHwSIC2DDoXj2Q2Irua7nlnXXoDiiBq9F0uSPIz0MPDSt1u5Ht5cRf+D8=;7:D2ayuAQ24W4Gv8ShcwD5/1HV7+90q3zbIB01LIFMB4oUyhQ+0QJ8wKpjSYi2iQN2nvNcwzyv8EWJhzlq5EDay/sQTrac5tcVvtGpXIkPXjezjooRP+KUHVwCrH5fEX0HeNSf5PKqJEI1oFZJ6wWm+fc97TAvWrdp6mQC4jzOOALH0kUgEhgnzqdqsRKSfme45DJh+JU7yTxR8HRNG91g2htG2FqDW//xDnrQIsS8NpcqMjKPR20Gt/Q+dawQ7wIs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 17:39:02.5622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b8ea0a-e7f9-47b8-6a39-08d5f18c58b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65089
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

Hi Alexander,

On Tue, Jul 24, 2018 at 02:32:00PM +0200, Alexander Sverdlin wrote:
> All Octeons starting with Octeon II have RAPIDIO controller which
> can function even with PCI disabled.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Acked-by: Alexandre Bounine <alex.bou9@gmail.com>
> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Thanks - both patches applied to mips-next for 4.19.

Paul
