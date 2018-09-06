Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 19:37:54 +0200 (CEST)
Received: from mail-dm3nam03on0137.outbound.protection.outlook.com ([104.47.41.137]:8232
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994630AbeIFRht5q2XW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 19:37:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4McazhmRT0JTJOh40v8IN7PX5a78WlhC8oMeuXT2OM=;
 b=KlMpr6VlDON4bZDyedf6WKFE2VmB4y0NscO1fxkhK0mIwaao72bfJiW1E87E8IK1DQyFYKlZlFm2q/cN/etzVOU8BIXwC2Sz7WP1f1ly3m3fcb5kWaVgXwA3++OwPYDaXG/ksLfj0Rh9HU+8XvIiHnESGgj9g87c3praBv0ZjuU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 6 Sep 2018 17:37:35 +0000
Date:   Thu, 6 Sep 2018 10:37:32 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Clouter <alex@digriz.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Wan ZongShun <mcuos.com@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 01/23] mtd: rawnand: plat_nand: Pass a nand_chip
 object to all platform_nand_ctrl hooks
Message-ID: <20180906173732.yrh47v46p2huhyrv@pburton-laptop>
References: <20180906120535.21255-1-boris.brezillon@bootlin.com>
 <20180906120535.21255-2-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906120535.21255-2-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::25) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a409793-f712-41d9-a04f-08d6141f6eb6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:vzmfYkHPixG+O+wq62MAYXgujkmVAjC2rwDKTpyjDuLyzaoICyGJlOl+86KFNLlEaz4PDH6Z+zNcxQPHRK0kQYDea87BUboQqZ/Yzd4PNxmodpRdiypfJN9WA33Mc+bSGlKX5mRrc0QDgDMXGLyHTo+6d8JgLj65jmQXtbs/G68GYcrWQLeWZRp0E0Bpusr4ipyzoxC7MPh8Yf6kuJTU/pHU8zwicyCVZDqjKo3IxscI7uRhoi6s+OiWvxUOWIbP;25:SKrp5TSSnjwaGMbeHYbkMAOty0ek8YyOVzhM5wkF3dMVb6MCSU9MGHj6RcseyCYwrzRWYFU/G7EZ0JJShOWmWrkV+hhTU/+UUVRV+BeUAuW6UjwIV2JGUyxgmUmJwFaeFwbkUVCCwjfpFc3NrVZb4CuJfQDlSGCwNQJT7BnSstxyxmUrgKzRBWga57tKz745Uph3Me0iSDAV57CLLoIL9RuJShuihmwzRauFL5JbqOR1HrIoQvaLcUlbOS/5NmRmRPD3Nbytm46rPccH/h6x3Ot0yyGceoOjB0LgVhHCSlKcJnt2Vjn/d4KMCYLQZuqD4CC1ebsVxjXpycPFhVwS5Q==;31:iM8EcaiyyI2TmUybcGhrdL4rZYY3LkzNCDRm5qLzPzjxfejfx/T7AqXuB1GpEF8uO5VSGqRjyu2b2gLQZgus8enFwSP7EPBfWVq1jQtcAfSgYZH35X0E8gSDQX/Mtkoq5AiYT/IUL/WoD6qAgfJMhn2ITa0zTd7WjkuWA676sgYyQrQ0geM1U6xMg8HWaOHSKoVAOSswQNn3YWgR8s8gXVIpCh8IvYVkK4Opf0e91Qs=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:JIDop0v7Dnk1wJ9t7oPt341k+BXaWN7MO+ihyPveP1mTeUt3B9xp0TKeuAYehdv4C2kJhkjWI4RV30buTRsn5GZRgi1De9pLwN+DtH2zNDSTMP0U4Pq9/cHeDZWG8ZBYfiM3HgDX6/wzSm99v/u5pUq1Y9lAf0Wd3V5JiUTctLFRl5LX9LCVHU7cmU7LDP0430uy2uUsJBtjxmHRvucq5EUVsGABKhDH3vP4V4T2gHNlP6mf1+dGzs6NIXTr9Zaw;4:AEDhd7TTj3FgBERGkVG3rnCtifPTc5NL7PfOLreHmsvRt6fM/9giMypWpbmZVFVydkN5AAOgFBqm6fJRQ5VqHOkTLyQ+zvlSiu9yVSBC2GZGwoOHOqZDTLCo9IhgmRwTT88GtzCOz7VEtSEz9g7+97CtfPsZb+Ue4iYgSaQ+Yz0xLSJO7rTOwtTwgN8XaStC9k2u73yF0Y9lbjt577+cwct7wC6QS60gAhe5kJc94SQsPIfiat83zbgxHBFXUg3WnQFBeFUCPmaUV+MIehUymx9C/nYUKoeLbls/ZXMhEoT5dCcXK+YwJWeutitzDdPuoKQKFuBrdb2mEzMXbCaXY9qgQo+2zetM3DQusY4lAC4=
X-Microsoft-Antispam-PRVS: <DM6PR08MB49385904A6B9C884A9808A77C1010@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(346002)(376002)(136003)(396003)(39850400004)(189003)(199004)(54906003)(66066001)(47776003)(105586002)(106356001)(76506005)(14444005)(6496006)(50466002)(52116002)(9686003)(33896004)(3846002)(23726003)(6116002)(1076002)(44832011)(76176011)(956004)(53936002)(11346002)(7366002)(7416002)(7736002)(305945005)(7406005)(446003)(68736007)(6486002)(33716001)(229853002)(486006)(476003)(5660300001)(6666003)(6246003)(186003)(39060400002)(25786009)(4326008)(2906002)(478600001)(6916009)(26005)(316002)(16526019)(42882007)(58126008)(8936002)(386003)(8676002)(97736004)(16586007)(81166006)(81156014)(21314002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:AxpLWMeA1icoSk8/e6nL5V0rdIa4eXs+bS6ndrKoO?=
 =?us-ascii?Q?HiAKEhDCRlvPA+dyDxRqB61R30JaewsMNqZFkIa18gRKxTDtwNpeGKruhzX0?=
 =?us-ascii?Q?BgYabH5TxPaGUOjnvt1O3pmlgj4HZczEn+nmZhmFdQiKBcr1Fp6B3tg7tCOO?=
 =?us-ascii?Q?TRP9xVtX4YTHopRwlt++wd0qaWbDNE2Yi3Mz71TJkrmGmqXKG58DBWUq7t4z?=
 =?us-ascii?Q?I71ouSHdlIr4wCFM82VHwMqPB0OQitBAll2ufvZ35XFjeBQCXd7du2CnBeVb?=
 =?us-ascii?Q?J5pc+z0vMduSlPGvn+/o5XOkLXJWuu2NGA1zCvF74tyKKsHgzSVFbq9TnJ35?=
 =?us-ascii?Q?wgORdB0dqvVrYsQ5C3uqcP7h1OFgEt/xXLnyMhmRq/VWPh9FKVdZve2i17We?=
 =?us-ascii?Q?odSlM20v7iu4vrAJua/yd0OAdV7fUpKF0ieKVRGyRZtokLQR3wwE8mHNmOoI?=
 =?us-ascii?Q?nowXPdSLX9vNQr63rYj+tj4GSMNVt+iTuMnsdRIS+S3nKrb9rv86OB08ZATU?=
 =?us-ascii?Q?ATk7MKC0nFGkK3YgnnzRZHqHGHe3y3iG6o1qWZGtdJ3doTMNV4CjLZOVq3YI?=
 =?us-ascii?Q?HdOQLgsx0wb7TSzfxtRiupqvfDorsMzXerrCpzNziyAPKnzP63ulIHlmibZJ?=
 =?us-ascii?Q?4+SG3wVZXkanduFcIbsw1/6ankEcZKfDovwDvGgtBnBMn6BCjWYN9/1U4m/V?=
 =?us-ascii?Q?RGlZAXUAikxaiK0adTQVk+oOxXIgm5AG78UpZtx8SdER1BHGL36u3m9MGLdw?=
 =?us-ascii?Q?SXbW8xhNutZTl7mvSr6WJbUK5gTL+jJbnU/b5BI20OXNXwnnSM1XCkkrmNa/?=
 =?us-ascii?Q?7WK8FsoOSpbkjG6IYJLzJwFlKwvZnf+mtGAZhEqF8DzTe0JSk4zFEFe/KYTw?=
 =?us-ascii?Q?+4V2EjKWjMBdH8FFJxGTv3mZ5/LINt/k9qko9uwaZ2rGUBB49dxh4e+SjfXB?=
 =?us-ascii?Q?SIxiZ3LUlQzuzvJkLwNZBAuL2zM9PPAj//3Wy/9nQeJUILixLmQd27Dczz1I?=
 =?us-ascii?Q?4p45vBfZJjGMgBGpMRSeiSipzOqxB2xKIV0ef8evp9l+sy7/heMGdF85XpND?=
 =?us-ascii?Q?+lW5TVANk44LwtjfIrbzAmGqHJ/ff1QlKIZ8lg49QVJLe5JovAjddbOAc/ED?=
 =?us-ascii?Q?GuNQK21clj3QCv4wVr0pD6p7EbjpJ8yMYzu2uw890te9ORwcTJu/1WJk2IRc?=
 =?us-ascii?Q?lHGqYiQ5Y7Fl+fcUDsISBlUzw6iLK/QXUNJf2Ki7I01REXMNBaNMc3bvYrLt?=
 =?us-ascii?Q?5aQzY5w0hUCYieeAFswsDNqgpSpcO7DZE/UW6theLKdwRkvcXF+BACQ62tZH?=
 =?us-ascii?Q?NPFFChkNef2CzM+81J1e0lP+pVsGvabJn0vkxTP6/JsEMnEUuOwko5919Er7?=
 =?us-ascii?Q?DwXlLxj6d3SxvDocpsxnoo0tlsXbeSxjzWFIfR+sOiYYm6bqWFlweDWV+d9f?=
 =?us-ascii?Q?knkvT4CoYYJbMBrr8hSH3zRJ1IHoHEjj/WDaroLHWpjV68fzI9e?=
X-Microsoft-Antispam-Message-Info: xQzphVLVC/iLH94O7QP+Nq4J2gAn2HOWWchyJzjLYOvEDq5JKNTvTjZtDjAE8or8+OsFcpKRPdn8WdiK+yEBuEMXY9ND1PDpzByMHXnvKJm4PnUDJXYLW+CDVYKqSHn3My0JteHyhGX1Pr8025tlk5WOWn+IiL+7PVOl7iKaEHFUVDdyL9wmaPw5XnmPkCVquned89unDG30XXtv2ncoBM05CT/CbjJNAypPHZ0FQUXZV/uE691O8haQNtFTG2JcwYpeoQ+DheIF7FS+uwDkzOuinomPpTGFv6nSd2QqMVUM1X0pO5a/Rc1K/43fd4YLL132r6VklM3JVfpogkIlVimfh3CwUKYjTgjWfcb82Kg=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:Lg4iHUORMaj5wF7BiTq5HRL3nQaDZLAMEFOUun7dKsdcTA0JCWOhgPMeisjs0Gk6Vifm/KLHUPquLUtDSVCI4jU7rLOodf1Y/P78+kj42VZVJ2hqtRKtysrKtjYtsycI1Nz4eVihw4yVEKVS1q568zvgL9YIAIathWsuYntr6hbCIicsIHicCsLvUq6bcXP0bQA7CCsjuJ/EWzx/Ljh+GjNjLue5VzMs6FDtQMi+qX2xJwewlc71FuRYPJJAMv6uDTxRDlNKiwQ8YMbh0MsBjPaOBrkCbbICQ5pe8g+dxfv4w1afdd7v0DL9SkPIdWOcaYhugxcL9W5J0aQd/4EbKYxmpmcFHcuWbDRXTToOWbz1vsgKvKiAmodruPNnwognrGJxXGZFRlczhBlIr/sXV8yXfJa59sTQOBasHLMlzkXdim3yus6gt6ZEwpkfhHFEXLkHFokPRqSoz3hwxj9kSg==;5:awu4HT2zFrYjGsDp5xq98rgjjYlGx3MZryvDYqd3rMJjCE5ntMkgKZtZddGpOLF3J8XHcnkj8wywdSQlThSX18wmtKnJjEPeDRDFGXsWvVx1MgMuVHX5qgFWLHR+GtOixeC5S80xVe8Snx+6zp1CKBn1kGN70iZJ0/pr2dnXQTc=;7:tNg21WGhjl3zUNDy+89uhsj7Xc2myWxw0zu61sDnIB24IAZ+kfApIah1ecizzFIeRCt79yilvm5xNXvnT+WtFCpszrz162H+WsX2prQMAz2/VIjr6yAhsQzHaHH98KAW+y3cFbtXLXI5zpCQo30U7NoA0tGH3wQfBzb2qCBcko/U66nUw872Rax+B0GySYrDL/pmco2mniSjz5T3HkE18EjnVc8lYH30EQvR5WlZGCic7goFkCVDukmm03aXu8m7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 17:37:35.2577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a409793-f712-41d9-a04f-08d6141f6eb6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66073
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

On Thu, Sep 06, 2018 at 02:05:13PM +0200, Boris Brezillon wrote:
> Let's make the raw NAND API consistent by patching all helpers and
> hooks to take a nand_chip object instead of an mtd_info one or
> remove the mtd_info object when both are passed.
> 
> In order to do that, we first need to update the platform_nand_ctrl
> hooks to take a nand_chip object instead of an mtd_info.
> 
> We add temporary plat_nand_xxx() wrappers to the do the mtd -> chip
> conversion, but those will be dropped when patching nand_chip hooks to
> take a nand_chip object.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Krzysztof Halasa <khalasa@piap.pl>

Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul
