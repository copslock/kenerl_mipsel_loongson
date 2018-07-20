Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 19:15:00 +0200 (CEST)
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:56592
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993514AbeGTRO5sempZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 19:14:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ozx5HndiNqqdEWdUSkTHeyAe7QUzAWfj5H/K21/K9Jk=;
 b=rfU/AwVWhtFnHnRRH0DvN4SBNbGK109VfJfmfpsfsgB0rSyuTng6sScmYThQOnkjJQ7thb8JOBz8iZ50p8jbC90SHXGFx5iMHT04wC3DskBJjBCgf5Xbi5AmfENl6OSpbrGJXyrpRZZGjhl2N9DGfNVxd1ijsBRqooNESBj6OW0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4937.namprd08.prod.outlook.com (2603:10b6:5:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Fri, 20 Jul 2018 17:14:46 +0000
Date:   Fri, 20 Jul 2018 10:14:43 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     John Crispin <john@phrozen.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Felix Fietkau <nbd@nbd.name>, Alban Bedel <albeu@free.fr>
Subject: Re: [PATCH V2 04/25] MIPS: ath79: fix register address in
 ath79_ddr_wb_flush()
Message-ID: <20180720171443.hnhr2xnditipuht3@pburton-laptop>
References: <20180720115842.8406-1-john@phrozen.org>
 <20180720115842.8406-5-john@phrozen.org>
 <828c73e9-ec34-cf52-4d9c-822385f2ce32@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <828c73e9-ec34-cf52-4d9c-822385f2ce32@cogentembedded.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:903:13d::27) To DM6PR08MB4937.namprd08.prod.outlook.com
 (2603:10b6:5:4b::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66b9f45f-bd35-40db-42d1-08d5ee644b00
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;3:Kx90GPSBnx/NTp+aMT0SEjZwLRqwCCP65cm6oAzpWYZ6oE7xAj0VGXnjM9taQSoFJudwg2H5gIDuAaW9uGoK7b+WWZBZudZsEKRqO5ae2PkLsBd9MghWDygDhViwLci45tjKlFnbWRFs+n2s0+7eio3idpvlaEySZb1Labaph/NGO731M2KsONp472g3eQ8JgmpymGZrLOlfIeELiyttQQFElcHGOwRNFybEsbx0u/DV2ed3WCiRLFUumZLVd7Ko;25:daiW5DS26H+eDYw+vm+lEJjFq4/jxB8Ip8rMBPFe47sQYVPGLunh76X2n04x8ussWh9YtfhP+DmhrfAL4nW8GZdkvzavERHQ75+ay23qioRBFu50EgwFMqzHH51mdMXf+gsqsG4fu0r8ikIA3UgdgC+zAO3QlWwlO19RyHC9ErinLSXc39MpCsFbhOSLPHPI/LMrbHPJUnZtc897ZOd6vNHB44LPXOp5UBCrU3f7Hm5daTQzjhY0Bb11aLT6W0MGezxBteu/umIhOeh+aJ5zjOucCUG5uPBFvzr77azzPvG2N9/LLR5RaURxgRR3rDV6PzJDqiF+roTsyEKYuri4Yw==;31:xmKvXJMqTlk7Ax9kn369YKnrsx/OA86zp8ucq7RYhmprRMjllQeqdJxIOJiwpZzhelAcRL9ZbLA9cYvbdjXlii7/+0wzB3GtlHg6a/maEsa8+kTlKyIyj4ekTBjidWHwO1LdKblYUPDho4f3q932fxYOwUKccRPanHJfKnOWlJRPbMaxqV658QCk9ecEhv3vRFOjFrf3hGF395IbfYQMRYTVJ/mRe2Q1RN7l0pHVDzc=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4937:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;20:CLCyM4Z4k5DRa5dHYgxIMrkCOzAq1V42fgUWsGsWackTOET5KjjILc21J8v+usZg4AxQCBBMo21wGn8HkVSz/He1CDlTsUnLr8Fv3S2ULj7UqiKrJBeLmaPo4XLLbfk2jARkbljGp5M6OOSw+5+Y3+Xb4PunNzq8JsW+GBHdWctouZBSSbXbRW325WOr+gfXRYIFAoXs+j1agAXtLLn6dCc7Yg5FpjJnEz7fsDYyT3YCT+XwKtE228y6LIooq3+B;4:lhT9vBFHuka5JrkEXuPxIEYGUEqeRsNqK44fb5e48kcus6PEUgj5yIq9FUcePfNUCwkeKxvfzHSg45O7bYLp6Qecgw/xC7+D7F6BDlPLrCsGVZYVQaNkA4yIgV9DPuzZRhANo/ZZDB53zyOITOOXGEJxOE25HvzvGlnvU1GuqJnhbohtVmdnlkygIgWukadqpthbRJPiTdJbPqPvqDFzhkBpNFfNDOZ+BNns4OhmFtpX5S9gRxbQoSPz+F3XvsHp7ntF1P83FIKx69+AZuvMlA==
X-Microsoft-Antispam-PRVS: <DM6PR08MB49375FCF326E06180969CD46C1510@DM6PR08MB4937.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(10201501046)(149027)(150027)(6041310)(20161123564045)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DM6PR08MB4937;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4937;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39840400004)(366004)(346002)(376002)(136003)(189003)(199004)(6916009)(6666003)(305945005)(7736002)(5660300001)(9686003)(33716001)(316002)(2906002)(58126008)(54906003)(97736004)(47776003)(16586007)(6496006)(486006)(42882007)(68736007)(15760500003)(66066001)(76176011)(446003)(956004)(26005)(33896004)(11346002)(476003)(386003)(186003)(16526019)(44832011)(478600001)(105586002)(106356001)(4326008)(23726003)(3846002)(81166006)(81156014)(53936002)(25786009)(8936002)(1076002)(76506005)(6246003)(8676002)(6116002)(50466002)(52116002)(229853002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4937;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4937;23:+nGDgrBg20G0cHS+bXxhUKhdk28Qw0i8R0GvHoTmT?=
 =?us-ascii?Q?AaOjSSSH8oMshs/UldmWKGqE1TkudGnXl4ujwfzJ5XQQ7pvfTYI3N1Nl069L?=
 =?us-ascii?Q?cEs4DbPFoeNuZuBd1gexh+g3jgd8XUKwyF3SNVny6nLkvua/uDgnGyIqFxBn?=
 =?us-ascii?Q?6vXoXVVJSCksco4fBnDr219HgbN8jlHJ2RUFgs/g5S/2z8rIMdh+eiWycAfx?=
 =?us-ascii?Q?AxjRhcO4QiBvgCvIlefcI80KEreLf85FN96QoyKveIYcd3T+jVk+d3QRaLGr?=
 =?us-ascii?Q?EkG8YHtzY+25QMUGR3NZoebtQm3wztf5GAstYWhUMDO1Q3KXz8aBojPeFGRB?=
 =?us-ascii?Q?pgWR6LmsDEO7FrXN69UhNONTdEy5a91xjyFc8BoGNm3djTWl/RrqP6fEpfF9?=
 =?us-ascii?Q?p5XACLHVzyx+bxxEdWvSgL99FFLpVsNz4I426Ae+dLDzJeUoVHP0ZX5AjrZs?=
 =?us-ascii?Q?mdRc2bIxkh2bi/OJ7VOjIMQ94JosBIO0ngYtGSK3TgHAPpvCLg8nrWhwvYAF?=
 =?us-ascii?Q?rFFBB9yQG3PkeYsob5tJMfxr8iPITD7UQQw6rzRdkEW+BeZtV9oiS1LMhx0F?=
 =?us-ascii?Q?I6sqqgPdYKl/ZvOALytUvzZXfxyRa1cv6fxUIvzuVrzwUH4XpTfR/dfDILhZ?=
 =?us-ascii?Q?/h4mAsZoR3l4wfNSPtzl0cO+hc08SSJT91Tnrc3cxWY2KC2NghqjlBQrtvPQ?=
 =?us-ascii?Q?ZsAggtP951YMw52STc2eF0ELsJJ02LQ7vi8DJm8bjk8jZ2jmSn1P0pHmlaZB?=
 =?us-ascii?Q?/Ti24mOJIsKJiID623XQCkKtzSRYCv9Mtwid4lsiVoeVvAJ76XPYwL68otH6?=
 =?us-ascii?Q?ggclweJA5NdzC8hoglg35QdU0uHFbia0eFKn5EcMTQZIHt+2IpEfNfLEt/Zh?=
 =?us-ascii?Q?QItO+PKQ1C28LrH+xTXAEo5lb2GEiCZ8sSvXf3LWt9p8HbHLqI1TDsoWt3cb?=
 =?us-ascii?Q?zvo/DlF8lv1gWseU6GM+n0B7gnsV2YypcidArrC46m8o5A3PUwcIslCApAHJ?=
 =?us-ascii?Q?QWrF5xN9jSSCH4zXmbG4PfgDqycArvj0vfs2807acCNGFi6t8+Vvor7l5zeM?=
 =?us-ascii?Q?WW2QPvSp7sW86fepOZWubs7NUsVWT/Bh2BkR7o683C7OxFmfSJNpwpr9zuL3?=
 =?us-ascii?Q?639BKVrCanukbFbjtwGh6vgFH2AMYC2Y0YRPWfsR3giDD7uxSwo/3nisljzO?=
 =?us-ascii?Q?ZdWuM5TJf57ClD1VR92Fot47x596Z2o2VHT1oVPFMGLy4O+BFqKOxD7w0cGE?=
 =?us-ascii?Q?N7x9WD13ulHSzYS79FWBTkqBR1a3PFC2Ax58xf/Hf9qstDHYbND+ynDTRQ+f?=
 =?us-ascii?Q?5bEP24rV/bnh3twCmbNi+toCeySGv3tBsCFGHwpbQ1C?=
X-Microsoft-Antispam-Message-Info: B4wyUSJlj9l8U3+0LdsllEy7u96UCdJb+A9UWeDR1Lbo1nx2woOEm6SUrVqKCOctmzBgh9uob1EY8ea/Vg+68BqTEFcHMiIa7pAvC7jNJcKlUDdimsKXSUcHfYuaiBlQGEBi9VStkLF8pMakbXZca4n3XWt0zriEqe5b6ZU+WZjfialbagf66ZvvsW4JSDC6Gml6YA95X2t0liA8q9r9rhNcakItnNGrlDkD2d5Oe71agbiByRiqUNbPgPlXk1XSc+PrzNmiO90eCLNmBfkrk2cC6h+PgtLJfD5TND8KKy87RxrytRol94xAAft1R6FbVaGFEBcI4p6+CD/tQGmDFqdAAf68Ffv3x/K9HsbhlKA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;6:AAWnUaNTh5MjCPRHBKMkPKzUbYwzcepM8VSEpiKc1ZiHMpMqupUgX4A3zB2+czqWWMk0hOSx/+vYEtzrefL31DjRH14ci91UsBzwf2cUuAP/VFMv6TIYPO2ddEfkXtoTSrQJ1v7F+NjJbaa7CcO7UD2BbD0ddSSo/KjajvREj6MAEC0Ded/Gd0sFK83CkPsj27yi1LHTwkNPjV0KgtkOuAd++sz2KGYtD83QN+XAjZQf6zu1b+oCMrV6rkl8V4MOLxLsS+qOuy4Q0gTCiz2P0BfU+j83b0dhCDqc8Rlp8kGkNf5SEbIxHBNlHT9I1mUtVEKDmAwl/1ja467G7CYrlFRutgkokCnF2jNY3wXzBoI6koghKHkGuMQ/POmQoQE9iUyVgEu4Yd7zcojtQ8eBRQtoIMQ+t2d0PfAo/JnAlHEUrfbC8AyRhtCWJHhR6wJfzdZOAZGdJXRerA/VY2YywQ==;5:X66RB+q/TeVeOp9rDeUYclPT16IpbO20UCHCVqKBJJeW6Ic8UZz1tGL5sWtf12rayShPYIrS5bgEePYmJ+4MS2hVX8eIXzX4YA7Ol5Lgo+/is8/KM74sJJ0Yd2llQnvtcJe6a4nNSzlD6G/HoqwUhgiiopNBmQgswY0VmjQ4hmE=;7:Towu5o5yCB4IVcspFwUd4TTwj5SOIASv/2TUIJ1Az4Df58bybwPERh9bVAfPggI7Mkb3iZcN1yPm3n37hN7gLU5w7hYm/UaSNmJ0mJDp6O5YeAsi+cTnQ4ms57QkfAYhBjhcr07GkWzKij5C1Ysx8HOPlPKKqmVxAWJ2kDSCbq3agFPDFrO55XXCQGE+PR7qa2g8fiPmDTY/jJ1S/cb6LdJR6SwxYl2epen1SXpD6C2nUQYwfDXs4+7yI+Bayx1R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:14:46.3830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b9f45f-bd35-40db-42d1-08d5ee644b00
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4937
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64993
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

Hello,

On Fri, Jul 20, 2018 at 06:44:17PM +0300, Sergei Shtylyov wrote:
> > diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
> > index fad32543a968..cd6055f9e7a0 100644
> > --- a/arch/mips/ath79/common.c
> > +++ b/arch/mips/ath79/common.c
> > @@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(ath79_ddr_ctrl_init);
> >  
> >  void ath79_ddr_wb_flush(u32 reg)
> >  {
> > -	void __iomem *flush_reg = ath79_ddr_wb_flush_base + reg;
> > +	void __iomem *flush_reg = ath79_ddr_wb_flush_base + (reg * 4);
> 
>    Parens not needed, the operator priorities are natural.

Whilst true, I don't think they're detrimental here - they help the code
to be readable without the mental step of thinking "oh, yes,
multiplication takes precedence over addition" or taking a walk down
memory lane to school math classes where a teacher desperately tried to
hammer BODMAS into the heads of mostly uninterested children.

All that to say, I think the brackets are fine here.

Thanks,
    Paul
