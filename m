Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 02:20:14 +0200 (CEST)
Received: from mail-co1nam05on0715.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe50::715]:18432
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993937AbeGXAUKbo65S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 02:20:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbrMO1mBBTvNE7g2kJjOwKqwWACzRBpaxfqj/ovGEOc=;
 b=Zpj9C80wDltQmBx7XkrEU7hW811cnUUn7SwynNK8jZafs61tIxwnK6stJicKzb9ABEId2FREs/mOilDxvOj02vmB98v19jdmnNpZakZ+Rp1mfa6QHyzFt4p9vkQPzE+zxhmbF1JHoQvh+IIVSKqz1qj12QNRRwuzToXibbA3L60=
Received: from localhost (4.16.204.77) by
 SN6PR08MB4944.namprd08.prod.outlook.com (2603:10b6:805:6e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 24 Jul 2018 00:19:25 +0000
Date:   Mon, 23 Jul 2018 17:19:23 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 1/4] MIPS: lantiq: Do not enable IRQs in dma open
Message-ID: <20180724001923.d4y7eth7k3ng44lq@pburton-laptop>
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-2-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721191358.13952-2-hauke@hauke-m.de>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0042.namprd20.prod.outlook.com
 (2603:10b6:405:16::28) To SN6PR08MB4944.namprd08.prod.outlook.com
 (2603:10b6:805:6e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17495510-1a78-45fb-2998-08d5f0fb1d1f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4944;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;3:IK5f/nztZ8jbQEwsJqg9AqsFs6ga90ZdYFHGxLdvokHM5459LkEkFD/YkMvmxmjlqEKQ5sNENxXhaiiR+BvgPHCmiFW+RdgwRDU+ZCB/pJJ+JwWbMhy/wN0ZYcjKuoTgGJiT40/H0tqXNmBp0ZsTwZnYsrvewbyH92XU9QpbARChvF+VGtl5MACqArOMyRdO1swH5E6Nw5+KfcD3ow+ByJb3z4AgzPSl/F9fawTtm/Vqvp1UKHoYQ3lf5VjoPV/e;25:AJpxj7DLN6BlMVlWTQXdgzmZNnovMeAVt7dTSp6dVtuVjOkhR9lh0LR7we+Fr1Ar8wCUa/E96KzH8InfuXbKEoB2TrHeBmA1mAZ+UTl4BYawonMYzmJIgDNovQfOKGN/9Tvu6SKbPFTRayBKl0vDU66kMRqLxom65JIxvgCvAKVo9hLMB+NfRsXIWourbJ7bUjeFMy081wgn26hnFqKKYVv0vhexLuk+fIHiEEZjxOKg8sAqfiug++f1lLQH26BQUgZK653HUEuFlHba/+Chh6Xspxu4Lx/Ui8peM28YUms+Z8CzAUdE/OHfZw6Urqa9yJ7gAMy6aPkTOQhU98HFdA==;31:pFwnGVu23eTPq79wXSxhMoLISp4JOCRmEMSh0848Q6U2TXd4YrVK3tKLcGa217PI4rp869/qINOb83Magjom73C8NinvG5wwCteBhsQTgKyrFY452ZGLVFuXKI+l5vVHDu3ZiktzgXDgCck4y3/hXN7FOs1qFeVxMuHZu0tOsWe91jT1UlTg+rCuMIzARbOlmUQpcSB0wp9u+M4DpGI2C4XZ2suJ0pQdgwNrJszF1Xs=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4944:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;20:3cyWzZDUfTtjJOejnad1A4BM5zfP2lazifG6ecRkNtFpisVk6s22PxwnQX5i02ByzvH2nny5UFnNqecHHhXrw48sDC5ZJJ+fKLSoRJSl4EJkSZnA5jGqBGPMSbfXTTLPdeVPARNvgriFuhbg54iBUre9jtLz2gWF8bf4HQtwzYGLHRHlPs0av2heR9/6rYZzLKOJ3GmygW6Tk6KH4A5B2tIArsI9tmOXzGScnKjwzRu/lIDfoBNQG5zPm/+V/uNd;4:b76OMjrhPRnIg5r06J7PqWuIaMnXNuPdQ0fTpuqv9oGNtYE63LckgyJQFxJvY8oiN1XVnUNog7xPWispClPgkxVMPx8DZNstCoTKqt1RaDYGnACxGq7/ccIzE0VyZ7m1BW37v7iFQDsXiuhjK43kmRBatTSkKepGuamo4C6frAMW1Sx+CVFPFKbUgHzWj7OXRFLjVTZGp7dBKWGUX4JqKwtr0ntoTIPUQWFCKc5Trpx2PGZavMrGpBu3Q8OAVsxNc7959ZReMaHn7DWgyBXkqg==
X-Microsoft-Antispam-PRVS: <SN6PR08MB49443D86D1C32E30A7083823C1550@SN6PR08MB4944.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:SN6PR08MB4944;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4944;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(366004)(396003)(136003)(376002)(39840400004)(189003)(199004)(229853002)(186003)(8676002)(7736002)(305945005)(81156014)(26005)(316002)(16526019)(76176011)(52116002)(105586002)(2906002)(76506005)(6916009)(5660300001)(81166006)(23726003)(106356001)(3846002)(6116002)(68736007)(33896004)(476003)(1076002)(39060400002)(446003)(11346002)(33716001)(6246003)(47776003)(7416002)(44832011)(486006)(956004)(53936002)(6496006)(8936002)(14444005)(9686003)(478600001)(16586007)(97736004)(42882007)(6486002)(58126008)(50466002)(386003)(4326008)(25786009)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4944;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4944;23:IxirFqHFq1jwZXudVQ0YXAD+2m6+8yIVgOBuS+Hc1?=
 =?us-ascii?Q?Ho5ajQr5uZfVAAZ/bTciZdw1s6ldcEX0yeh8qLBRLjPJC/D/+0/UfdZWuJ7H?=
 =?us-ascii?Q?D95Y2Rnphh8lSanXfvfIISIXNlENWjVnqkEb/kPTwMSrwSSW5RIq29hb8gQM?=
 =?us-ascii?Q?YlmIiOIVEr6XXq9G2K3SQNPIm070+HMervNG8FYE98hlYgVJWMfUPCmPP0vg?=
 =?us-ascii?Q?RlFe+r0j/7L+sfWzjQO9I5kZwsdMdccoivDOxYcbyPdUbSD125B4VCXTrpVH?=
 =?us-ascii?Q?QUAyMhACUQRP1qapgZCjnQ14/oHI8hW8bd1GSI/br9AAI6t62wiM7W41qoqs?=
 =?us-ascii?Q?BBBVM/hip93r/g2+q7PrOIsHc8bj0l7cKuEDvDBsh6F/bksb3Z9NEv2Mca01?=
 =?us-ascii?Q?i2SX6/t3EtfNoSul18ggBIh6P9z3sAKgVu7I5GHm9e/3CK/Dp+N8gVC0wXW0?=
 =?us-ascii?Q?GUaIpYSR2qc9BBPFrlQfgahOYGcGyvVodxLAgivUm26YWjxFZ0H8tgh46J38?=
 =?us-ascii?Q?YLagpL9VHF5M3vVDXqTMCcXCSeocZVJHjiXmUdUNoMTZb+c1BGo7A3sJ+KpO?=
 =?us-ascii?Q?A1G38CiXWKOTgjXzIbuXlYKpCYE28q8bcluPw7+Prp0JFFjHooArbrQXA4HR?=
 =?us-ascii?Q?WjDGl7kiY4Lr70BjqqyQeyUpmDNSe1/xFcEGC1yrdnisE/k5IKEnLbXAxTrM?=
 =?us-ascii?Q?V97bbNuwCr0AncvcUH5dVFLIvSKaAWProFklFI0kZVGZlwjr3yplgIHReD0P?=
 =?us-ascii?Q?OstFsNDGjaeDlu8nW4BjcF85BXYtbBJZFbrki6JvXyZDRNf5P04VkN3k0Egd?=
 =?us-ascii?Q?mihMBTPkGm0q8qL+ISjftvZb2QzLKrnkXIOmNvLkRNCjahLfi72NbFce7Z2c?=
 =?us-ascii?Q?SCz/IYiImUAdhKKDH+QsOTmIQuCPghUko94FKQmeE42lw7PAcyVjUM/BoY6C?=
 =?us-ascii?Q?nNkkNEsn2Rhf+knbT2KVcVWFEOLayHjREUivKaNuoOE6kYOuRO6TDuOiul+8?=
 =?us-ascii?Q?mCkuNAsEs9Yl4tqPtF5549zhH8cSelzCJuXY9VQD5bpA9o6vtkRvKwc03cT3?=
 =?us-ascii?Q?ib69v/BZXr8++MzqmUQ9ts9TrPWhJO7MAPwPkERw49MEINSNQZbDjMxqrnlk?=
 =?us-ascii?Q?bLMbwMuXBBMOM1DkAWkj0vT2FH5vRGY6huftLlYOo1frA4POzykSIbVWhV8X?=
 =?us-ascii?Q?JkLNkKspPmHe/ewpR5eZUnuE1XUrMnqC6sNcf10+UKOP6i0Kt7YrgoqKOcyU?=
 =?us-ascii?Q?DpR988Q+a9o/BajRqHHm/wuOa4WfmzGBEpmGz1qtQWzWHVQJfld2N4Due0ev?=
 =?us-ascii?Q?K5Pe7PpmGZW2wT/NfPm5Oz8gorrun4WiOGMOtVPv14p?=
X-Microsoft-Antispam-Message-Info: ECQBMx4xJENk+Z9okupT3Hzi5sNcXnrV4Dgyop++3O4rR5V8+QEJHuj7VdVBPtJneDiZgkarctxgBYEkqGBMS58i5ji676PnyybO8UP72aCD1VYiPAGYvNwZhDKBa+Fj7DiFe9ziMrhX89HtbuXZZ6tHeZKs5oINSBcNYTi283wbUi/pR+4UGoczV1ZnUL4ONHgN/UBI/4u/dI3/Pe05y/aR/gK9SrGQkdMmKV2Fco2nZNTbylpmQLEQHDVX7eCH24luQ/AsdjrKU/DaEHJrssbB2oaDYcCMo00H4ZEeDASm+Yxhcvdjj8csp0q8hmefYlGTPgfNjSHF7rTz367NMGUysv13qupbbM6Mmbo/Q1k=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;6:ZDjPq4FECLwESj7mf+EgVryghYpM6Ygx9qSkcXg/+ofFlkGF5uNbn5505ocA7tYJZ8kkHyh2ucO2iprRwaLj7Dui/ELSnELeuIu7BII7w4BBArbH+RrPE6a6svXT2DGmaFVTTwRyRaC03Y4QiYLOF5J3Jzmp/XAKXqw5vMforHTARqRYCdvCAF7JO3+3gWkRYFtAG1Y5lskvAIcygAqDujOBfa8CQGsaWuMAB0eoIgb4XvPlteu78kdovJW7udsi83EHymJ0SCvmI04xkCpzGJfX5a6x1n3RtPlal57OtU92yApLvqVl5gk5WS3vNQR6JkeYG8ihDYzsHoOnJZNM/SrvpwoPVFDuQniv+mpnVs7icmzu1KKYaHUBUHXJm3g1LPzymohEOrkLntM+nbSMZkzqywvVbdemxxFnxc8+P6kvPeXlHQ2KF1SnTwimYTPuAdhynOzKdnrI8Y3xFQCP6Q==;5:zP4TILF1aMDwTb+gKcWLC5Wcppq+mGQ+4l0GfTGbit7QRsw3GBFfvQZuWspW89D/U/IAOQFr4UEpV5IMUBAhZuVYOiL2QdnEcsXBS+n8YJrom83tbnuLx2Y8did0zRuiZwNoLSlaA2EehWHw/BhoIMngTGLQ8TJ1KsnVZxSQdJA=;7:U+Par8stMTD65XyOxOeWWbcAuJdBLEMels8w0kKqAmy8suUCBFKAJv4C+Pg9h0c6GMzs8Yn7imkV6FLhqQg2IIT91Z54c8Tt6vLaNJZZ/Xs6WRUCIFE8DOelLjjmdD6bKIrcV9bBKPS14ngEqwlguKFqvjJx0+6kHxm0rzgsDBlf6iWBPRQxNZ0Pl345+UPGhfSmPGoSFs+E9/0NrQHD+N9bL/bs9QycJovpGoTOqhWn9sKine8qBPiyAq9G8Hs9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 00:19:25.6370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17495510-1a78-45fb-2998-08d5f0fb1d1f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4944
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65064
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

On Sat, Jul 21, 2018 at 09:13:55PM +0200, Hauke Mehrtens wrote:
> When a DMA channel is opened the IRQ should not get activated
> automatically, this allows it to pull data out manually without the help
> of interrupts. This is needed for a workaround in the vrx200 Ethernet
> driver.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/lantiq/xway/dma.c        | 1 -
>  drivers/net/ethernet/lantiq_etop.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

If you'd like this to go via the netdev tree to keep it with the rest of
the series:

    Acked-by: Paul Burton <paul.burton@mips.com>

Though I'd be happier if we didn't have DMA code seemingly used only by
an ethernet driver in arch/mips/ :)

Thanks,
    Paul
