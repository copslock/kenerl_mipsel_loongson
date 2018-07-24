Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 02:14:26 +0200 (CEST)
Received: from mail-by2nam05on0712.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::712]:46567
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993937AbeGXAOTqiiDS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 02:14:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eUUUvBtiyNIABKAWqn1t/KKGyRIED6GyyUbPgui0vQ=;
 b=PFuEq2ZcY17HC+1Q1GgFI3Gv/OeOl2chNSUf/H63CjCCaLVqripo6tm+tSOZN4CJtBByOdJHIVEf7v4ljWitL8UKQ7TpfnMdODq1L4Zvl3ONxUfJtVxaUHZJxz9CqPF+DSbd+R9uQXSmESU9FBXsi/C8fEq6GGZHE93NrH882eE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4940.namprd08.prod.outlook.com (2603:10b6:5:4b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.22; Tue, 24 Jul 2018 00:13:35 +0000
Date:   Mon, 23 Jul 2018 17:13:33 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, jhogan@kernel.org, john@phrozen.org,
        linux-mips@linux-mips.org, dev@kresin.me
Subject: Re: [PATCH] MIPS: lantiq: Use dma_zalloc_coherent() in dma code
Message-ID: <20180724001333.geygvxatpzzpyptm@pburton-laptop>
References: <20180721233057.10713-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721233057.10713-1-hauke@hauke-m.de>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:5:80::49) To DM6PR08MB4940.namprd08.prod.outlook.com
 (2603:10b6:5:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daae534c-75ff-4f54-4ea2-08d5f0fa4ca0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4940;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;3:EdP+DQX34WzDXsgpuEovieTfmyQo7oDu2gUjtoFup3eyRUE8TM5gq+HNzjYjhS6W+dIeZpzmybbs7DWgtCL+Cj9sISu78LgACQQ2gTJUGB5cooHQuMuDnLAHASWMDBnB5gvZ5euMybh06HqCWIhqyM8MDe8Ot/wgtYHzQVJojmmn1PCcbkWNg6S8F2rEfxAc5nVmvtgtpG2HAVcDV4rY1dPX/cQoT7SSe+X4tfhcMonyp3rUHSE/uGfYqECFGwtf;25:WW1qkZO5Xs3TdTVwW5LfgM3UI5DaU3UjHAJIbG8JdQpIM8lWqXR2pXpgremdVjMi/7OsOZOlespb2nMgZl4JKJ15Ww+zgJgxoVVJFZFjdzvFNXzepI2byH7soMuypPLFkrrSZ33mf0r8U3Ciw3cVq4dv7pm/8NpQUfo+G4j/dhrC/wTlpp687SshwcNAEZztW5zEmrpUVbtbvsSxx0XBdyvRT+4bv7rcQlMoEYeieGLNMyaioKJ/7qDo3/dnYyIQZskiwm8Psb6KTJ5NL5tfakjasI7X/qcgL2HcLpA6hPSQ5BKX4PzS/Pma/WuZEWQtiWsfp+F+0v/+drKMHojvow==;31:Nx+D60DIp1tP1WZ6za7rdCH3rWIPBAT3I7J1u+LV4KEqBdhjUC42iwyFCUvTqWwkQT+Pu9Ar362j6kTLeLM1aCP9I997SNl+mh6A5NcC00oWpi0FKeMhnOGOGwueObSn9xBaOIo4WRbCRu9sHyyUFLMGQzz4sIrW6OABBWDTAHENwNtxPb1lBdUPVAmVgBLTuwI/Y//B2CvDcSbtBvyHZjgbRrDNrJCbyrTHdmtVXww=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4940:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;20:ykc9x78Y9OX2oNsBWdpD5zZ9wP/6UF4ffo+EFF9GudkKtkxauCshEPkW7kub8cVTd//6gtrfqiEOKv/FUP1YU5MM5ioZbQGI3S+4+iSYXPsxXVg0gxGObd3NA6vwrLadHZcVQzIjIDjnmr6A/UtXiYqYHC9s/xHZTNmGggtbgAXJY8bkqlQIW5Gw2fuHNAsxd3tM+l/Q3CjZPlbJThTdxWIIz1ADaRAq0XsJe/vLEsOV9eUa+t/VeWqda/7c1PId;4:O8J4tFkZi0UA5GQd7DzNay5Re/xk95P9QPCqFimOCg4S9d+sw6sVywTG0ylUSn8UTaAV2L81MFKOOYUocqBvhSZ5X9W/7VWPYdv7lFdJuZGnT4m1Uno7z7LMulP0vihdAyuj6HGwQP3J3v2QxTkw92LvTXVLxKWYBYRk4bclqPNT9uvL7YucVP2IaEco1cMUDTLhKbNpmEYv+l2eFc+u8j0QBO1GqZLpSm0yRlGrI4kpVxYxyKzB2jl2C7i2ddTTCTdCu8STG3IqvVHgMkwLHw==
X-Microsoft-Antispam-PRVS: <DM6PR08MB4940FF8BEB40A1C3BA338AC3C1550@DM6PR08MB4940.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4940;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4940;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(396003)(39840400004)(346002)(136003)(376002)(189003)(199004)(3716004)(8676002)(1076002)(53936002)(33716001)(8936002)(2906002)(316002)(76176011)(33896004)(58126008)(11346002)(23726003)(68736007)(446003)(16586007)(81166006)(81156014)(26005)(16526019)(186003)(42882007)(52116002)(6246003)(25786009)(66066001)(76506005)(229853002)(476003)(4326008)(97736004)(44832011)(47776003)(956004)(486006)(6486002)(3846002)(6116002)(50466002)(6496006)(7736002)(105586002)(6916009)(386003)(305945005)(5660300001)(106356001)(9686003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4940;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4940;23:9IdpM/hv4YQwIYlCwRtVlYCKsOZbudVyfze4jW9no?=
 =?us-ascii?Q?yLz/8m38pOMm4i/pMRfKM6YirK9nuq3FkXOpH2gVR+uimQlMw0Wh6lwf879o?=
 =?us-ascii?Q?oOwcxYx0I63qJjEyxIAelLkqxS02JvSLK8ZCHTBjiVAlCBb7kC2t63SYbw9v?=
 =?us-ascii?Q?FS2lqsj23o+ax7V/aPRu8yuZGIppPDs3xq4iHOy4AbPA1gW0aVfc/j3oFqZ2?=
 =?us-ascii?Q?HeJIGakrgPtZ5Mc1luhxp7e+gkDILKF11IlMwEQVj2dv3toS005fLVP0zRh6?=
 =?us-ascii?Q?KWVVLeiTzYpSC2NIsBtjOIdwsK887QE4po1glDgL6GxUebPINPAAtKhiKYOx?=
 =?us-ascii?Q?qYTaKZ60fpoztaPuK1EvXKz0keQUptnyVHXg/p7IJ6Y8lKtl2mDY0EkoZVjJ?=
 =?us-ascii?Q?x+V+cz5qhln870yMLcHW7TYUr5hiissXi0MAKU03dUKYxR4jUfgi+wXBMa3m?=
 =?us-ascii?Q?2neYolIct3G7/8fbcsMbUSv9MqPLxRgskzeWRADYyai1prpoIO0AYzMvWXio?=
 =?us-ascii?Q?p1Y1t4fU2t9vrBounYv85YRJT2l7A/4T/yMbpRIRmdFG3ILpUOHlHRC+8zIj?=
 =?us-ascii?Q?ZBv2BnCI/CHxgqzLbZ5SoHNhSzmVzjyxD50m1JcrP7wb7Orui+x5wtQcx2bg?=
 =?us-ascii?Q?paAgWrtguQyH3dXnCWbkKpAvzxitJxWyxEd6aPOlLoRqqr5D2oFriMMm8fj7?=
 =?us-ascii?Q?IvPFYNIcSVk7zJdsxOAbnKYXxJr7WVX6aNrlaVOVOMQeOlBfBg7r2nkDHPn4?=
 =?us-ascii?Q?lXqM5BNNuPJrg7Hw6kqM1oEaB8ziOCpsBeewMshrVko80oBIdaSaY/IAMM29?=
 =?us-ascii?Q?eeDOz1YeQy9SKFVeXe4bSdwL/LUIzUhr8kVD4Aoy08cmgIH+ZF5wQ0zy+W50?=
 =?us-ascii?Q?iMt0umhNA4/amWwKEdyGr9VmARMiGnL2VB3rXv0qyGvZbhKcl4MwUit4+g7H?=
 =?us-ascii?Q?86fzZm/z3uicqP/XZ5/PTmWm19QF9mqg0jE/Y2HowEVb8M0Q2yuAq2bFYZrK?=
 =?us-ascii?Q?JduAoym0gi50QOSDTsVVi5a4Bk+31qz6Ji+V+jCpwv620VBFQLNj1ppUYK6U?=
 =?us-ascii?Q?4blLJkFb0E3JnrhzwSosMPitiN2Fd65e+99fGEg7lX0wT0lOnM0hTmMaXvHY?=
 =?us-ascii?Q?Q4jOObkdJYw3leYpOj1csXJ7XtdtkNDQAJc3/f7O3vclPArl/u7WxmUGpeY+?=
 =?us-ascii?Q?KBvyRN57WGg8Cqv0Z28H/Og4F2bFgzKo/XsziKB1v1Tb2neDinwcZM/KYtOI?=
 =?us-ascii?Q?9RsqTbZk9XXSopwtfcrEhz0f17ymKaZ7s4AEtBn5hXxh7JAtwJxBj+Azw75C?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 3tdBgVXfraPYJvYoh3oHR0Mk0qfjsk7nWP1wyHZVw42PCFQSWf4QxLMoS47KFAdqMC+R9e8EbmTiCVuv0xhn8P2YREXa0x9Yhh5bCNdSsbOdUj92/McHaAdiDwn3Y5cTPPNPUXjGL/GlOSdd9eX+Ut4oNQxEi9s2iaLvhyW0b2Ggv7RVPmiEsUFXLDhSSDv0DBCyNc+n7xkZO7DMZzUR8mJIE43ALP46BYUE1AvayRmwduA4CjiboIhstU7AXKh9dyw9Q2BsHm1p9YCaQ585VeOCkcRkDraORh5ZooTHCQALUjQJ6YNO/C8NHMLgj64cgvuPvEmHUtOOspkZKAgtTLc/WSLImAjtqtEHo5enpXg=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;6:OLnLapxzzSpX8Ivxm5KyY7/4fhMGBC7vbkrw1kZgeuFPNwzGcNq4GjQspe7X9ceDm7w+tePKjfThgqKBIAEGUvufu9b9Ds+tiBYugZNnRm38Y5lFxTDUSDqQBkdDDwXHN7NwYbVJm7IkLDQAjV5OBdDnX7xute1F2YdkAbdOwgLpFmEzCEqDnH/56Hzfv3PJGbQ/QmXhLKuVACKPvpH+DPhaP4JfUQY3Lzb7DrMcVBM6byipggt7rzNRS1GZurddtW1nE4w/9Ec+mk30eQGx7B+4OnsEbd363RsCl/Qcb7asUG5dKAfYhL+taXtRglaI9rtVVFsJnmgTo7KG6+ktTzWjWg7FSnSrgH563T+xzfU38pDA5aZqoj3z7C6p9uX3LAjVMkkXxnmoFA3iTqO5M9aRjU7v62FOx+2g3tzrQ9V5ubhIK3k88DMtK/bybKiF7PZc1R0DKSbc8/JUDCchng==;5:2CpvQmZMsxyTc+OwbPpNzMfikg6NdyXnG+5MHXY0M4Q/svMvkd4RswaRs/eamuZ7TnmR8aByFIL4nP5LNak0JanlbzxCciAvdEy+fm1gUZsVkc+Rdf5GutIiWZ6uGouQFwqkYgNgBt+xurDvz7vBl3yunMBl5vK4LQg1bvqe3mI=;7:NUhTe3lDBqG/aGoBpBcQP17PnGn9p2Au7t/L+TIswyIcDDuvGLBJNUgb8z6ZmO4FcLA4fQzXTqKwgFp+bFeUOBwbSzlKInO4djxj+ULDZd5ZpfqzcwuBhcrKze0a2SDRrQKy2wkR37BKk8VkiBMEo7yLlZ1lmxa9GQaC1kuvKqgCfih8hkQlLqkSxJgShn0cdFGwpxhkxpi4PEoRBdUV0gR+2k3IK6LoKg0C5Y6gwSkW1d0+cbivN90884eSVYQv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 00:13:35.9138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daae534c-75ff-4f54-4ea2-08d5f0fa4ca0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4940
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65063
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

On Sun, Jul 22, 2018 at 01:30:57AM +0200, Hauke Mehrtens wrote:
> Instead of using dma_alloc_coherent() and memset() directly use
> dma_zalloc_coherent().
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/lantiq/xway/dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks - applied to mips-next for 4.19.

Paul
