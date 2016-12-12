Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2016 17:07:40 +0100 (CET)
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:42571
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993005AbcLLQHc5K-4u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Dec 2016 17:07:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kmo97H1aoKwsFK1e+ikC3N48vtdJCZjecT+VH7gFbbc=;
 b=RdnN8y9iGL55gGSmdMw4vw+s35kQQ607zk74rGoBnrsymYTep6+AjXJellc94J2pbjGuDHKMT56HuF0DuehRw3qB+QeNZ0DgVOB7fvXquYNNANVyrm8epk7zuyd4RpPG0NTyv+bvrzwAGTApNKyy35bFCQneoDGarOlJMNp6UH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (88.67.138.104) by
 BN3PR07MB2577.namprd07.prod.outlook.com (10.167.4.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.761.9; Mon, 12 Dec 2016 16:07:23 +0000
Date:   Mon, 12 Dec 2016 17:07:11 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Wolfram Sang <wsa-dev@sang-engineering.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/4] i2c: octeon: thunderx: Limit register access retries
Message-ID: <20161212160711.GA2766@hardcore>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-4-jglauber@cavium.com>
 <20161211220148.GG2552@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161211220148.GG2552@katana>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.67.138.104]
X-ClientProxiedBy: VI1PR07CA0068.eurprd07.prod.outlook.com (10.164.94.164) To
 BN3PR07MB2577.namprd07.prod.outlook.com (10.167.4.154)
X-MS-Office365-Filtering-Correlation-Id: cbed6e89-09fd-4b52-10fa-08d422a8f672
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN3PR07MB2577;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2577;3:GsTuZpORXe1MnPPaAEgguVI87Dh25lsiiwMyHpbMEqbaSk2S2vlmHvMBMSMP2Qdf/WZ/wB7E5ezAqZJnSaj++/j93OuID9eAJ2DFjnad3z1uKUueguQ1j1us9Sh20WznovAfDaefJGG43xeazzwkN/Ohq1wZZbmxThjZz6a2vL5l0YRYk4C1/JSjfUutScjVH8p/hNIkxxnXW58/CoXuy9w9zhhSpccCPVyNU652NpEWO2QNvuuHn+wrosnOJNh3/vSxpdqUDURQkJA/rqvHxw==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2577;25:SheQPgFOgmUbr/cpGmz5GyvmzEag1D3oq2kcmT3P2xjzCJEOAyfKVig+RivrA6THJzW7N76INS1LwRDXzN6enabrWGt2rU4bGXae/jw3LXUYcGNUpZhi0vtIp11OqqlBTEpT41j8srHaJMw0i5Xa0dVGt0NJi/ddTF5Gphqs1qkYd5pB6csfaYJn4WnFrvtLk+GDpOHy6WQi9FfQVrWUPJZBO5uv2VeVjbn85LwtLyLH6TNkRD9y+squR92OSZE3gpSlUQaCYKpdRlkrYhqG5gSv+Sjlef0IElCU5KEnAHpIthRhFt1DOXwvhGw7F9mNjkwejuvsVkAsVBSu5GIDitXpFwUTXAREZux4hK3K8EEk/tnp0FZacG5N+W+xbPANu9bTotaYbyMKGfZg4XpxUCVauP/8GzxdadZsCLE6De9iUdGty0/RGLF5+z1bkP29UcLtm7q6aocuPJNQE3Be/KBAyAsFu7bq5cecxZHqwpYdpUf1iYKnDHyKoaPRhrazIBkIn6HM8Ae0pqSSxji0YteKxhZnrO6Ei5Mh+VFd5GW3unNzeu5CKX3+z67cfQG/J47gtzsrZT4WlluJ+pv5BKJVDD1Y64c8bG/4cIb8U1UbDLP94NFc82xhmCtX8XQLc/0vi03Q2wcjLhdCeemqc0GTDus/OajWneYDlD7Xet5rRPAF7Vt7ybZFgdEkfhfuRxajrGb15oNtWH30PTzESarNifDcFPufjwS02CAIf5cgxXF+JfZeUiYgOaFMP4owwZNM7LVPQcvmRbnISPHNVDP86dh/ta5WSPDslFT1NbE=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2577;31:MuECSxOY3PsFGNTrwA/eZmdLeaUZ15aCZy/PaZrhhBB7mlvo+u6u8SMScDjlCy3a0J9597wOBA4pwvC0l7yYacSVw2Rj+8kkgQmdXLav/fteCAz/NRBq3wf93ajo9LRU3bOtO1WuDE/saaU/4IsF+B7BYGELln9AyM1ln7KRqw7ilhd41as6/+v1MpVDpWYMWX6+RPQWEizYmUsdR7LBEX+hvDRdgt2ivbERJ4DA2UzUjBwssYEGy/rt4gwVWgIls+g4U4ZvrDCNHmUB2nKT7g==;20:rZNacy8lMcH/3DdOHyQk5X6s3JRfje2YYC1qY6ykA5jZTaZPHubyskIAEhywxy16GMN6HfVmmog9eIQ7uzYvb+lLYWAGYB05SlcAyG18+/lVzaZZtDr12wgB6+Df5D4puHnThwQFdA2S3wZjfMod6Whl29hi7bDYTm3ltqzyQJuF7x01UDLIjxyWQQ1IZ4Y+ogwQ4I1JErHUoSFbh5D6BEF2MszkU7W/2wmE+uxWU7k6EbqSh1wdMtFm9lDMdJFhop7zsoE07cp+UMf0Syq/6Xz86IpNBXl3xJj0KPEbX/qNcMzZhNNzyNBPNfiUJGAUrjk91mPW2SOwRHZzth3u8mJDLdAMVQAILXMSnIsovQX087nv1xjxPYX7tgAkq13gB6oXih6XrDBawVtgLDigNxZKc7/zq1yZ7tiYQSGu0+weUpjyRK0rZfZ6S5/6L72PZ1mEtpUP7EhQoJZWshxL+UKrIQ6OcGh+FIA9VLeAsiuBWEgQah7mRMhb7KLPbcN/vmv0PUdqZYJeRwh92YKx8rN2JlRqa4MuAXorxE6dLY1jWalDw9JLhNiNMSQKEvvCRok+xHZqWb0a3VzPNEg0RLJTxz22Td2fpNO4cNHqErE=
X-Microsoft-Antispam-PRVS: <BN3PR07MB25775638A5F2715655FE50D191980@BN3PR07MB2577.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:BN3PR07MB2577;BCL:0;PCL:0;RULEID:;SRVR:BN3PR07MB2577;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2577;4:vg10aJc2JCnfP/DgUOkRgljwBwMWr3C6N8WGt/4CBwTfbkXAQVItzfSlw4P4SWI1NTcJCzAZlcQrN29g+YtR9eEHqsWbGmaVXOotKlSnF6ror15UdLOwMVI/8lrOUmpE7+kvX3WStgumTi8i56BU5DgsO6UQkmo0S8j2PsYrLoS+7lNRRhhmORbaBuHt3OqobM5XSq5LlQey/8Ar1lPByF7y5qcTD7/f5/KylBA8tkWmJo3EJnC6d6bPrvG4/yxvzYkZQg0gBcuxjFh0M/anlmqzKNFNLud+WsmaZyGBTjAGxF/fH8/HWv0g9PdV2MxwaaWQxkeT+i/VmeyN0moTlOD2b6GTJNJ5/9DV+RNUQXR5vHHgqhTGf2FrRRyIhU0yQW43seGC9ONKRzgdREHt61HAMOoHf0wgZOKgurzSToiVxryzgW7jVBvd9QXlvV9284GDTuQb9Dncfvlr/0CQol6CnrL73vcgK/kUCAULtu6S0ZvHmVHfvZ6Qij0UMkoEn6aEXxH/8svlEmbFUyyOqBTyhhv4uKr/c5dr23q7QY/D0dujA54XzMSCpGzWCRSAksK2eYk9AjL5nIxLCq1Uxg==
X-Forefront-PRVS: 0154C61618
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39410400002)(39850400002)(39840400002)(39450400003)(199003)(24454002)(189002)(23726003)(97736004)(107886002)(1076002)(83506001)(33656002)(4001350100001)(189998001)(76176999)(4326007)(66066001)(6496003)(50986999)(54356999)(229853002)(5660300001)(6116002)(3846002)(38730400001)(101416001)(2950100002)(6916009)(42882006)(97756001)(2906002)(110136003)(33716001)(6666003)(47776003)(4001430100002)(81166006)(92566002)(81156014)(42186005)(9686002)(68736007)(106356001)(46406003)(8676002)(7736002)(50466002)(105586002)(305945005)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2577;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR07MB2577;23:kHGBCBLL8za+LQpdCJLxUNv+FLWmdXKOYsHjkdNtZ?=
 =?us-ascii?Q?6YcPP+gzc4LrYAVGevJfmY8sHH3YFdflsY87oVY71WSGp/vZ8p9gUt32R/Hh?=
 =?us-ascii?Q?5d6S4/I2A9nEQ1wGcDCPzUFxBtYdr2Hc0GQabCGkiqrqiP0e6F6HWtR7DC7h?=
 =?us-ascii?Q?EDK7fXkSTR8x578DrGx9mrfpa29ExVtN6hQHEyEU/7e5KCfvE/RZpFgkv50d?=
 =?us-ascii?Q?5qADso1UzSR9+5U8TZ12VHZi8XebgsSyJ34bhZ1EtRzjjXtjQma1m56utqoh?=
 =?us-ascii?Q?y2mfolXfTJGe4gpl01ez2SEqRwU3znwRazpKX/FtmBC32gxBcEO7iT3PJp3H?=
 =?us-ascii?Q?O74STYbB1WajCU1YaEGImJepB0Um1nQldZt5vntUHnzDqTwDrki1/IelOIXG?=
 =?us-ascii?Q?69zdNC/ktslv/YW0Id1GlD5lwDnOA0NoMrNC+bfNIsDC9eq5qZHCgHnR3/js?=
 =?us-ascii?Q?6jVtLPXxlWDn2nC1GckqXGAcFUi8aOokzl4cvrr0zkPel1eNHYAz4H7Xv12f?=
 =?us-ascii?Q?fyv1Z4JaAdJ36pD3VbLgWoGKOYcxuEAqZLMGOmvDUyUv30pV1EsaZ+TqXlc9?=
 =?us-ascii?Q?ztOUg03PxSv6+VaGi+KZv7ctrmF3WcbVPapArt9Dkh+O2VD/SR3we2TUeRrz?=
 =?us-ascii?Q?8UfaCYMlBtGGXLNz43cAEs+gOiAWTtNiANOR62bQFbXLl2gcMM2Un75lHQtl?=
 =?us-ascii?Q?pG/dFk0vxy3okoWy9rZ5vBdsAEDszbdjRwtAnd7YofHECWXlkMSWo0b7dVkK?=
 =?us-ascii?Q?4uLROGFgb6CIXcDlSqGn1h8uuXbAL/RDI6Vd8xDXeIoCGwBvnpAnNQN7yD2A?=
 =?us-ascii?Q?HIqs9biVx8jO8GnhNcoKGjdsOJjPxAfN2eTgG9p1S+IR77sf9YLCSgQFIv87?=
 =?us-ascii?Q?QkSZKor4sWrU8LaAGKq6YTAoaTB6dKLpUK7LCPDnlQMHhb3K3nnDQWjF3LUz?=
 =?us-ascii?Q?ANjZaitqINgfBRAZV8XSjiYEAa+ewQAGnpUQRheUayEIHJC3DHkSwNz7Hr1U?=
 =?us-ascii?Q?88PmsD8OmzyqD/WuyihaEJclU53UiMdnTzMGHjCgHkj5jQUp3ucc7ttw/rg9?=
 =?us-ascii?Q?Kk3FpqRY7Yrc+Q2+l/1VA6mbkMwXguB9DkrwZJ13GBVZXM/t3tmSTdbCPSCB?=
 =?us-ascii?Q?ZMJp1/aggU7EUJQaFm4CfNUIUeOmVNYuQvx2lSDX8n9cYbuLyfIgxlRBkjMv?=
 =?us-ascii?Q?4GIs/ko95KXoRmwiclLaymcouxypXWbwaTHpuTU+uoc4J0fPaH/9dGE5QbIh?=
 =?us-ascii?Q?DBKJ2M1luDQfbdIyUyKOhCP8cnj27utmK5Dq6UR3YHsQ91p5Kjo2yu/095F4?=
 =?us-ascii?Q?1Yolz5Hgf+8xaUl2s4n9SI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2577;6:00M7ZQ2W7KCdvE30gSE8xEmPm/xL1yzsELqxn6X8vBCwmOrV1WabcAM9iwm8RnHBAfN4IIkkg9nd59Ek+9xfeiryWkrTZInO6BPZqsLlFQoKY3h3cW+1x3M/6Gubea9IrQADZqm9xKn6AST8bsy28vt33oDnyDKg/LH1E6qT/EoNW3w5X0+4wyvERkqYMMCMTNR+oAYJnZwnU9uO/wAU3KXMzn+5v5qOlYEpdlKK70pZ3ixSso2zy4QEi04ebZGwb+XlcoBED3cTj8szt8GxhuzGZpu9JyXGreJCNGq/IZxV1ACbbXustMtR+hlJaVvBYKRwP5i2swG34A2AvprrEoQbC6eaDEjDsJesoo0s0EtiVvcMCYmn5mpD8O71e9S661Z920QFINbH21K3mztwph4MF07dioNTeAA3HO6eYOs=;5:U9ubstxyM42klsHssFeDiLa2hyrhg7mQ7LDvjUeVGpjgwRiE1gHf34Xoyyf1FJBIzkZhQQwRZ9KDQi6Ab2IGPinocVVylPsjs+e/4V2a/REp2FhdGb8GAaaf0zpSkFWwokSVHpV26YIRNDEVIMC8bw==;24:B6IAc+fNSnOmFbHYsU9Ik21qIZVdQKjKB3SWGwxO7sLynbUPDqO8ROeWL7Gl7b1jFf6ldV6QwbnrzWq1I9/FDl42bnC5ngKgc9NuqBE6yUk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2577;7:5Efw7qC9D8PRNMnDHePkaKUlyeOTvfzlVcWkn/UKiBbI0zxVDUBOugScI0wuNsEX3mZwANqRhbRK1oe3imJggc7SdwRin5aZdwAk30O6hBA6Y4hmi13eX+INVT5GbtHkK3GznGMUP8E4AJ8orhk1XzZLGIV0ZLJ/LTt6zQJR9pEYAqkmRLEH3X6HuNt6qrjn9x3ps1yhdEAM+KlaEbqdOSowTy1BTc/SqZEOHetfDHIcJxWlr0Bit0HAd5ru8PXX1Gk1t+PHAfVQGzm3YqpDOPEi+3Hu4wn+XB0Cge7MnO/zFRztmSJ1+m2gHpIYOfIOLfC0dydsr6OnXeb2dfdY15eLGX2zfUzcVcV4B3iDqQBTN5WRnKeKI04IDZ4iS6qn6MpB9gIth5EHxfE5jeVzfwqeutBDzm8Icsuae7zNPgm4bAGgQzm8Ua30K70B2tCujkiBuL7ZtCQZAEBbHyWCzQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2016 16:07:23.6741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2577
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.glauber@caviumnetworks.com
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

On Sun, Dec 11, 2016 at 11:01:48PM +0100, Wolfram Sang wrote:
> On Fri, Dec 09, 2016 at 10:31:57AM +0100, Jan Glauber wrote:
> > Do not infinitely retry register readq and writeq operations
> > in order to not lock up the CPU in case the TWSI gets stuck.
> > 
> > Return -EIO in case of a failed data read. For all other
> > cases just return so subsequent operations will fail
> > and trigger the recovery.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> I can't apply this one?
> 

Strange. Applies for me on top of 4.9 and also next-20161212.
I can also apply if back from the mail. Is the mail messed up on your
side?
