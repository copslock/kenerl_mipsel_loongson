Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 01:03:17 +0200 (CEST)
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:51262
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992307AbcIAXDJuwRIb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 01:03:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HI17qmO7gzCeXiFyuGl2QDK1Tdp0Jh980wOwXcaV+34=;
 b=MyEKeOHrQdHGvRDDhAgsRL3oEuypKVEunBra7jiVla6JnfM5EZKw02blmsfilT3G4c6XqLVJj7LOKkXtb1o68SyMrQ7P3ZYqMO/0IwETSVkdyrg7hC1WTUM5oz6bTRk8VGDezHPDkI7Mr9EtEDrjq4k/i10zujupu8tlMoEam0I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Thu, 1 Sep 2016 23:03:01 +0000
Message-ID: <57C8B3A2.4080209@caviumnetworks.com>
Date:   Thu, 1 Sep 2016 16:02:58 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 6/6] MIPS: OCTEON: delete unused cvmx-mdio.h
References: <20160901204400.16562-1-aaro.koskinen@iki.fi> <20160901204400.16562-7-aaro.koskinen@iki.fi>
In-Reply-To: <20160901204400.16562-7-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR07CA0047.namprd07.prod.outlook.com (10.172.104.33) To
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11)
X-MS-Office365-Filtering-Correlation-Id: abfbe030-82a6-4f9c-d228-08d3d2bc2019
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;2:4J6Rsoj6+X/XgfrOUz4mPyNh885ZCm69erxJ0mDrN6UOWVHrcnWgrWh2dX3+lY51axjllv/98UbKs4+Sk4cjFzksWMe1If7DxGyYnid/6XlxUXvTwAOV6yivI86I0xr9Cs33yyPe6yFElHWAQbyaGbpL1JEMphF1xLwGYMu6T3LSvh00e6rEJYFy9ylfrl0G;3:t803BaH9WBetMHBQj3PZGoCIjmHtpI7l+Vth2yM0Ijs93b2TjTH9Mf/LXIRqYE1SGPRLhI6hlUArsbk4ljoyZ+0Q1FdmWsCM8p4ZLWk0WBB5ZgZGRmJw6nsZwmaF0ziT;25:Tv/MDpxNbCIPnTVWzUhFvVXO0FPBvVUImtrm0oTbOeoaB3pC+eJ9Rte6sjV/1ZdXApQMO3vmVHaNFIKje3etd18LK8Vab6L2Xl5X1A9tW4An0raQ0kNjhyOYVDvTv4Dlh/+tqRqxEur4jDuj34rm1kxLTrAJtFffiG5nEUAI+R5fD6VIVebVx+pfGZ2PTjd0lTIuMwBcbZtGI4p7UEjQvZ1yfz2GPXmLI0OHIaMWpTrQOozB4uSezPV2xP+tSoF29jsHjH6dCGBUwloI7SXQOzc4vH+d0QXq9y2htkssfGuk8q8FRCjqerpbZJ0D63BNis0BZSK4Y2keZhTwMUMhT6B34f0DRMg+5n4C/MnrkVKZgrIdTrT75EGgjdJ6RCxtHCiSnCEzFmVibs7V7EMlR+kSwLBtz3fq4uW+8DkZ1iY=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;31:O6nxPowKXetLfypzAbvTEqnUsqtjw2w8xLL6S3FDb+HHtrTvWEj/HKt0O3PEmj7BUemrWgjs8wJBx3Arq4yKpirLk6dExkdpnnEu5fdn/wcF2t4+Wvi6BNMjiJ1t90OFfq+FDJWX68AvNynyKN2nO2bdJUvrQcdqwetgDIxi/eE7gqMe4PEcQcPvHHS8TrCgsX+deMVqogzMDe5i3o3ZhKmvEFt6Kgqb+aH4UG1UEeE=;20:J8T1Ctjb7KoYNkG/5zesgAIb2MvWql+yMoAb5PWOySFTfWadTLPH4fF/3mcBrspUaKo7qC2Ropv47vmaf+H+CxQ+CBZjm++t9H2LIkluidB8fyl+cNoZjB/R77lg2lNbiEHU49y0XXzHRThdsdaoWcASZvZXeLsgWw7iJACpIlWS3ONiCUVesw3l/AZr+oQAAOICk3Eu0CEFOjhSgfYGvxjyji/i1hM9ai3pInsc/14e9Uxq+HIUVv5luaTSnpaBoNZ4P5T0R92ZOGrBs4Wvd9VwVlOyOz0kD07MjE4biRxQT/ccyxFVWla5ZHHQAKKk2xgHf0MGJ2ukG/TOUS6GJelTtxGmSsyfbgtmgI2sp7igV2BMBO4+6GlX3CDjgCIdEpKu3J4xWowy0ha8V3vevP9mXQPFWOF4t/fGe371mFhdwBYT/WJZJmdjdSaRHMa3H6TwGZ7VdYqRs6+PDg/rosKr801MmpaPOvQ8WI2QHhC4hBsu0cTleLILteCygbTMy6YRY7M/bK8itIb5mpn1isG/D/SN6mYx88/+7rPz0PErJxDvOAkAVBhlMeOQTyoz6LEd1DgYJuQrwV4SjUvu80MpgifZY7SzY8O6hKF/s9M=
X-Microsoft-Antispam-PRVS: <BN4PR07MB2129977D9360C883171A6E3497E20@BN4PR07MB2129.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:BN4PR07MB2129;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;4:Lky18iAyVpX3pVOcBK2zF+tzwu6mVTkLiLj96n1GZHrbjDphVuvZu6jQ5mgNQAcLfgOs8XjdAX/pLGOsi+XDPHhtqyu2mVQtuYnlkckj7bvIbsTn4xB5nc6zRdIi5GHjY6cXJ45JXoTMlCEX+BF2UZ0MUtuKcdmgg558empb1DdEJ9fshgKWn2xf94MtgQ4CKMUpN+CGxsAtl8nBGBoNEm4Nz1ekb28/fqZFyBfWNu0dnyo+3A5ENh9Vv/kaImz/MAKUJlYAbllnzG208iCeWflQB64UC11Gf0RcXgYwBT0/IFxoB0hnx3onySigOdvNgDabwj5YZr8EmWm68L65f30lugu+/DN93XUyQJQYqfBur3ZG2OkuLr/EwVHP10cPiklcg82aplc0VS6ivPQdug==
X-Forefront-PRVS: 0052308DC6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(24454002)(189002)(199003)(377454003)(68736007)(4326007)(53416004)(66066001)(65806001)(305945005)(47776003)(92566002)(33656002)(5660300001)(65956001)(6116002)(189998001)(69596002)(4001350100001)(110136002)(50466002)(77096005)(3846002)(7846002)(97736004)(586003)(59896002)(7736002)(230700001)(83506001)(2950100001)(101416001)(19580395003)(8676002)(80316001)(19580405001)(64126003)(2906002)(105586002)(36756003)(81166006)(23756003)(42186005)(87266999)(106356001)(54356999)(65816999)(76176999)(50986999)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2129;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN4PR07MB2129;23:cLxRsZ3zJSRktI4RE4+duIHx9NyKkX9T/ZQ1bQn?=
 =?iso-8859-1?Q?bcESwi3wpsJzSIy5ooVkv8kTXKAxml1LIyr0Nral2mlN69rWN/kmhUPsY9?=
 =?iso-8859-1?Q?lb6igLoRonyjMqrntoUszzRAQeLzNAHALlx49luRaxWbjF7yvJtxKx5uJs?=
 =?iso-8859-1?Q?Pzsqg7UPzRM+Y3exdtxrSGixRdlmkFqhuvS7HlAa+LPqJgxoRbHNw58bkO?=
 =?iso-8859-1?Q?ZngUdYe4Za+7aKkd8+NrCrO3xPvG4TWh/r1SrClWRCEBqufh3ljTGowewj?=
 =?iso-8859-1?Q?uSv+g9+rCdtcVNED5hjzNLurJvnSFxo6KQNJVkHZh45wVdpfMJxIM3N2XH?=
 =?iso-8859-1?Q?9ru8HLVmtUIM+mKyrtz2NX02pYpJ5CovP2NusCzoFIL1qr0VY5GgSmnYI/?=
 =?iso-8859-1?Q?XAdwfG70s9g+BKGNUEGoRXrmDqKVgBCn4A9ZSQRb3DU9jvMpyvV6Fug/w/?=
 =?iso-8859-1?Q?SHY6ROfvs8BAAb2kiXbsV1N00q71A2CYi7cpLBRjXYs8hnk8fHceuMn9Z3?=
 =?iso-8859-1?Q?cK9QLf7LXFtzjg8TYT2vDqRoA3wE+JGZ0SqHgmi2TFrrxQ3mKCvMrZRIR9?=
 =?iso-8859-1?Q?JW3S3Yhox2Uk00gXFVLGF8EtO5yW9GyYNlcpKT1XP8wmTgGZoSrDSA+6Oh?=
 =?iso-8859-1?Q?mDLAz/AlZXnLbz5LNKxEgoomeLy2eMsGfUPvLasKyDyVY6rA2kMdai5DEZ?=
 =?iso-8859-1?Q?EqNsqvTmna6arXqebsghm5gF7rFoEB9P5yl6XRKKFOUbSRNlH078D17hpr?=
 =?iso-8859-1?Q?B2nD2GqrJzsjxReXVol0IFF96NpGzrCF3wQfQy8/2QYH8gRl3Njrwm8lFD?=
 =?iso-8859-1?Q?Hcm7VOoVurjY7334bM8MucDEilAMoHcWbRAxGze1VpPw5rHFALyMhRfZJa?=
 =?iso-8859-1?Q?fFr/rC4QQvl5hbwZGDmZk4EEJjzDgLEAZit0yvB+W9BewN1ojhv6XYPz3d?=
 =?iso-8859-1?Q?upWmxA9JKIUt7/SpuF8wTR+BVTpFkoCRO8Ui3cAQelgGLb3MPpfDkL9bS3?=
 =?iso-8859-1?Q?m5vNsIsPjfyotA0IkMiNxgwPPVZVBttqZYOFg62aePkcJ9ksQgp32uFWCl?=
 =?iso-8859-1?Q?5m8SNSQd6/k0FA7yDM7x2QdtPG4LcyqDLHkPIuq1pWyZjBmEaCDMzs/zEJ?=
 =?iso-8859-1?Q?LUN7pPxn3bCEkmLDjwgIjhp4lsuvffoP8beco26uhZBj7seN2GxyxSovUZ?=
 =?iso-8859-1?Q?0rE2QKniySHQwg1U+O2qDeiJqsC63W9wXoAhpSL88USDyjd16XBqhqZO1T?=
 =?iso-8859-1?Q?sVF0XNezmMO9YVbwBFwiDJB9hbmLM95oV9p+qr23DzUSQhkbJKqa6hkNZn?=
 =?iso-8859-1?Q?6pWrqgVIkbtsrmtxKi2KBlvBDQesW8gm3zhF7UYgdVII674aMTbnG9clr7?=
 =?iso-8859-1?Q?6I6oFs90=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;6:ncOxjQqHEGohT19JGrakDkFAL8Z5t55Yj2wk+qLHsjLnZ0K0z7KCeKpIc0YYbvnotd36r9yUkdpnarpTLBJEnkRjVxQ+e0r9VhLtWY4K88pvMcAZpgBrf0HHuK21iJ/ESf650KYjNuDJXzWFea+eMmlpQPAfIBJuUig3STq4MFvG6f5KuC51w8uOf2Qss6F57lEXpbc0MkM1g5Hmt/9Oz6NUhzkyOlG2HOerAR24Iyvq3ZXwKnp3917/qXZDyjIe/2trTV2dNc1mbCadMsZPkEt4fcJLwnYqe/M23nFWa/k=;5:ikW82+h1uz9brL7O7KqeqhzzzSqrhksUklaX8P1vcE/Znlk/AxZ/sqx8MBTZh7mBYJHGKqeKJlItV6DeV5dUuv5jBrF2p1IJsSTQx+hmp4zzo6715dAljjis/GFRBRplCRU+wwmaQk+uv1sACISEeA==;24:nRirNnk3iz3PvviE5VJGtBDzGytSEqgWdZOlWb9m6DaPUqU+IOp/sHXXuq9kd3to75EFOF7f4ay43Lu336ZNlDo9A70f99nvBI/ZUJIuO7U=;7:VO5UJtnN4nEZUcpqrvqQR2cJxuLgYA4yu14WNecgmQKEOjVirofUKhwpKnL3Nr9WmsbxyzdelPP0MuFuxLXIz9uTCQXXKfHOBm72Z3dsnWKa16wNmV0nbQr9tD3ZwjpXg2WMRrDnqkWiyWmFk+I7UorblAddblTFRRLyJEde4vI1Ed+zJcYDPN0BWwxGwG4epE0fUpuwF5YXWOIIggIbayM9obYD4IXa/a5PGk0oCN5R1UoRmgYsI7FAP1SNghLv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2016 23:03:01.9713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2129
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 09/01/2016 01:44 PM, Aaro Koskinen wrote:
> Delete unused cvmx-mdio.h.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Nice one!

Acked-by: me

> ---
>   .../cavium-octeon/executive/cvmx-helper-board.c    |   2 -
>   .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   2 -
>   .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   1 -
>   arch/mips/include/asm/octeon/cvmx-mdio.h           | 506 ---------------------
>   4 files changed, 511 deletions(-)
>   delete mode 100644 arch/mips/include/asm/octeon/cvmx-mdio.h
>
[...]
