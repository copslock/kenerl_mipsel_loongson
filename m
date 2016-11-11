Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2016 08:00:55 +0100 (CET)
Received: from mail-by2nam03on0054.outbound.protection.outlook.com ([104.47.42.54]:44316
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991859AbcKKHAq0dVHr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2016 08:00:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5bcbpJI3iIHgsz3EAPOV0I/cZgHU8u4duxWtZyT6QAM=;
 b=mV5Vcrk82oIKObfoaDHCVTwQCa+kYXmji/MZ76R4r+bpjPdxxaKj4mxlRdLMplpDHIwR/XBcmEwRByUlfypPmWmPdG1kBOcHObhB+sEIPYB4ZIB7SvoTBGOLaj/2TZtGyGzE1Zc/vgcrjuABQQ3nMfACGEVvokOujbroFVyvoDc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (46.223.65.110) by
 CY1PR07MB2588.namprd07.prod.outlook.com (10.167.16.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Fri, 11 Nov 2016 07:00:36 +0000
Date:   Fri, 11 Nov 2016 08:00:25 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-i2c@vger.kernel.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH 1/2] i2c: octeon: Fix register access
Message-ID: <20161111070025.GB15806@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161108071337.GA4601@hardcore>
 <20161110201731.GE1585@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161110201731.GE1585@katana>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.223.65.110]
X-ClientProxiedBy: HE1PR0201CA0015.eurprd02.prod.outlook.com (10.165.229.25)
 To CY1PR07MB2588.namprd07.prod.outlook.com (10.167.16.138)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2588;2:ds4f01NkWTOtPJ4aeQSr8Ze5cOELSPkLiFutQqQATcuyWxDlbswh/p9w1vYs6xeXrXo561IynG2qf2BCrzvDRbVBir8dvq/MMV6ZqlFzQvCBMEpxy/obQ+aSL6vLlx6N8+3Go8t7F4p0KMVJHr29uJcrGGSBQGU2ewTEYnnac50=;3:9kz+8vKtMcTvJtMCvmnr7WqzLxauPVRKCJXKUqq6lyTRBSR5ZAwNpZJuhfm03kFdhRisKHlFeO3B9rWv/6Q2PIUGL2gVmXFzxz/b3hHpxliIKuKLTccKUY+kxfknp82sHoIsnKADySlKjjL7qduMBYFKfG26jqGYWhAirF4e0pQ=;25:4HX5xVZszlLN+8pY1KFpWDp0j90r4miT2zEjT17LNAQXIx/tZ6gy1fbQHv1zoKYNUtg+bDYrAx6rgN43yy8lL2Pth4vgK1M80ifKEuRNtPyGcWgvQjRsJEz4RvwNjk/9QABo63r/6c0/7j9J6hT6TucyUn38XWuUALnHjtUujmB36xcULLUlyKSgVp264UNUw4tKvKaR+jEOBLgobSX3boIFDKhZU31753k9yWPwcbR1NIXqntinyYgK4pUNbZLvtdpt9cx1BFe0kgwbBI+EYvvTiaBmfz4Q2s61LNeHcA3rUFQk8ZXzu6cbCBkaPy/5q3rdOqaosDPMgz7pQc41Yv+wxwVvth1mr+whC5jbOH5sgidYRt5aozWdbqNejwYpDW/Rpfja2zDStuTb6KBHjXvs+VXmYDG29Ybw2hV0gVu3p4CP4zpdileRECcjzchO
X-MS-Office365-Filtering-Correlation-Id: 4ed5c3f7-725e-466e-18f5-08d40a00718a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY1PR07MB2588;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2588;31:8hjMXBZAijltNmnGYzuvJOjpnYp7YYQhc1CXzzVf2Jb0Kr1egmXvgqiGKV0nB01ixeE3v4N6kZAaLr2REC19ZVzKINkW2uGsH1Kgh2BZifOeLD8CQSbcCy3NfYD2drvQcF7JmRzwpKvx4Sy712r+XCjUrzdfcqMo4qPjl/K48Rdcv0aGAXDBUo/5I8Ulld3pLX8Sr9+PfCLgKUwSbUv7l0XEPrIc1K+hqxffCr2jVAEAdLo9chZCSU51P3lZDZCv;20:StF75HW1dqdnuERODjbXFXUQ3TAt+u1qoC90l2rPXHpFgffEnPkcZ2/foKw94orLN5vcGdIp77eaXJh9O7sOnP1Z/3Fh1K8XDdpTuKtNurM39eAZzq6evFalJXvTxq2CAtsfdVJeT46wc0fGUnSXBCGinehW48ikA+YSbWL7oQINuq51LEmg5/2HIsR12zdRFiANYXEcnf7Y6YtOsVCk1+nnJU9A85o6rprQ7IQVr3fCRruwAQtXCm20q3DCAV/4I4s7BAAkpS2lJtxi+nBMG6e8fv+imkc+35gScCaWEwG4V672DhrzaBw+3YvKA4la8Mv3DgrD2PHJspHHtoP7v4yogW4Npi+VN1UBB/odp6bNOX4QHgOlG26jcOj0AV5ZHQ8DTpssEH6XMlBcsMiph7JdsD//nHrCMfULwzA8Ram1Me2aBL+yMGHJGNaED2/t2XkRHgfsUtDm3xUfjVrBIVPmUtNQoTg/NUI4Cu4OWWZmZ9co6MfAA4YFKwC6XHZXiVtcPR89hy8+SrL5CZuGOroTFYqtCv718YUvtXRzfembT1yrUQDRkdyuoFJ4/SWQow5FUEkAT5qm0yzGP9+ssEKrPbbmZf169SxExqtuMi4=
X-Microsoft-Antispam-PRVS: <CY1PR07MB258841E62A6B34319BA965D691BB0@CY1PR07MB2588.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:CY1PR07MB2588;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2588;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2588;4:oVd9qm7Z3LIUqWlnvyFMTIbe3orD6V6iWWRu8z/fFKMORIp3cvfZAW8LKsNZmlPDiIFtRuN1YAfc2c438mpCOt1KKbIqlAeH+3li6NxG1YfgOs1MJ+Nmk139xuxOl3TTVtlFkmbIaxWrRti/EnsLL9cYQRrviCh/MOULiIGcUlkzbKu9MlKR8UEmUOvN4JOQQp2Mr+lwQd4dDh9CfQbC1ZfmwNCOeRCuq8L2YENemyCUM7VYr8MBqIt3boB8skD8/JnX/T/H5c/cVPvpRvtGft5PoAyg8/6x5bwooLBRkGw9qYLtgHILfd6nHlSrmcFWTXF4vRLVdHHGTAxGQMGIJ/Jr0e1iQQ7DzPWwt7UV2sMjjn7u7g3zvpBP2W2R9+aQh2xhPwukiTOakjLetN2V+VWinyAsYwqGN+Gez2fiuzyOHS0lNpW+0SXFzO7A9bjNwJEcwz49uivjW8OWmOespEvmk8/SguW5fpO6eunVx6w=
X-Forefront-PRVS: 012349AD1C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(24454002)(199003)(305945005)(66066001)(97736004)(8676002)(7736002)(4001350100001)(92566002)(81156014)(33716001)(68736007)(47776003)(50986999)(6116002)(83506001)(1076002)(586003)(6916009)(42882006)(229853002)(7846002)(101416001)(3846002)(6666003)(23726003)(2950100002)(4001430100002)(110136003)(105586002)(5660300001)(33656002)(76176999)(54356999)(81166006)(4326007)(50466002)(2906002)(77096005)(107886002)(46406003)(106356001)(9686002)(189998001)(97756001)(42186005)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2588;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2588;23:Yl9ebFnyexyT/sBTrCDpsj3xx4ebemA0UcE7xricJ?=
 =?us-ascii?Q?pSLw4tJ5ZYR+H5smCcuZQfUQntfH6+ilSDnUemG7J8xmhW3+AnpXD+bExh71?=
 =?us-ascii?Q?3kURZ/Wwu0BVQoMwo0XCR5ZLPPND4oNcV+2Eef4A3lXV5Fsk7Hop1pdNWOjm?=
 =?us-ascii?Q?YGN7OjQLjIsuAWKWfrmtmAejYf/VCqrwpGZEcMa5QwY1bNJLo+KdwhhXB6Gf?=
 =?us-ascii?Q?dJZ7BoD9MPL43bu8GE8WUGFBEyLaMxk+QfGR4ITvy5u+MVMeyvHFShDoO4f6?=
 =?us-ascii?Q?84UhkgTvynaNiAJ40e9reswKNEao01RjAdLNXt+7SEedAbrb8fO95Geiq9fb?=
 =?us-ascii?Q?6he3Q4POzPqNkhHxrpt/Vca6d9pQqZSY45tqwfWUS7750y/x9rjYaIJD4rW2?=
 =?us-ascii?Q?KV10mf6hxNubsBAVnaSu0u/bokkt79vXN/sgq0oRs1S0osiYpf86U3zYsYzQ?=
 =?us-ascii?Q?5ReY5d+aRCLJoZXfjBTTc6cXPjN2jmr0NMPU4YexJSS3bZSOdhezNAuOlgMw?=
 =?us-ascii?Q?F8dipkrZXv4phByzZ7S73gyt19euHGBI5+jYoGak9PB+RKCJkasQuhU7xt5W?=
 =?us-ascii?Q?Qr3MAb5XVmp+OncBInRigk46M9M+mbqXD2jt28c3cIqheMOrGk/VMKIL4FFE?=
 =?us-ascii?Q?6S15lRbkmgU82A7xkevcsJp6XZCegN1M0iUlqRMaLueRfJ/aG2JMMAC5zBYd?=
 =?us-ascii?Q?kO8ljfzH2Sv0PCjBamXR5/OYLwEE/CDnTmuQqi/8Mmc2KrW0KRE2DjBN+dtj?=
 =?us-ascii?Q?U43JHdtZOhbcj8I4oW3bvqFx6L7aWbG31YHH8XpSqGmoLIrn20omx32UdNPx?=
 =?us-ascii?Q?8SDMJZKZk637GMZH0yS1ocCEzwsu6733gVy2yHAmbxtC7zoqll0KEa0v8Hcq?=
 =?us-ascii?Q?y0iphoODSI/I+hoyM6uMQZgTK6Llx5irnX6eABZU4DdkUq57xCE7jJzltzjJ?=
 =?us-ascii?Q?OhcawYeFz4SbEv89c4DZ4uPkOTUVW2P3Wyy7g4eYjzUGV8CYg7pJq/QRnyM7?=
 =?us-ascii?Q?2Zt1xbn/P4EHEJfa+ClU9+7nOsKXkeh4/WpFSpth8WVMQXAjgBeYSKNbCZRO?=
 =?us-ascii?Q?P7FU/irIG5C0wBe3vt7kD8SWlrVSQZhZ6OibRQupOvFCePusEnBoyRlPN2LH?=
 =?us-ascii?Q?QQT/9SmSQJXNnvK/2S3KS0spywAjf9KqFReWev4gaFkG5TJCMtOAbj/t2T24?=
 =?us-ascii?Q?3Lxhp8ToaKEt3E3jZefVDH4p41ypMQkaNwOcl+C4g2K5NdxJw4cBe5+sD3OS?=
 =?us-ascii?Q?DZf6q0xGw9ITe4Myb0EIc8OKJ+fjiDyKYGPUqpN?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2588;6:Bz+7IOli2+KY0b6W55sGiUUzkQK2c2ciNPpj+ckI2bPo3uXOJRE/DOF9J9fzOMBKMiBvMurokNtboxsHkHVYdO8CVjlOrubrMGQd8TpX0cekS/G6Amgg4OZSRPDMnjQp9Qw3LExkIw50DaDsE8gHINcx+rx1xd96VJwC62Vz9OWTmgALahdpPT6jOIcKORumhWqtFSsT0duSICF7q6kg6GDH004bz9zt7Vn2pKMAyRAqyX67Q+VNHHfMtEJZma4zUPH4H6PPRVjxkwBnATw+fd0YFIof7ZH/fuD0EkGBAt0PAqHGy5ojb+wxz9/O4+9Z;5:FsOnFYb/PhAHKz3at3Q2Xs6nZ5xd8Gygxg77y1z1vU7ptLb3RmCICx7gEFDyJCrPaJ4NmAU/9u/ZtOvDy0VkVZcjJZtQYQQ/Ji+URBCmjGF1uH2cW1AO0kjs7qfZuQui5MQ8O/VAa7xTBIMfENRmmE0KHbfF4mghocq6gXy5Zpg=;24:bL9W8e/4fC4QlLNNzKydrZSz4NXMaRsiiXpXxG8PWbdpZW/KskWbWNgWNWWzqS2M3tschMmSFhxc20aXy//4jnTKne7CA1URIb9Xjn9C9gc=;7:v88EB+2J4b8w4dttD4qqTFGHOInDtaQXTSVDW1ZhU2FuAsnhorxjveU9wCNPbRfoHBN7yBQEOFtcMDD0rJQDVhhzRuE7ID+HdXLLet7TIrETrjb0ctCbF3D1HKolU2wq4u5d4I085MTaL+cb9R9ff/XWYH3NC5tjYMTMH1b25YqMoLAfvg8jDbSmiuY5BOrfPXHh6I+cVN89Usq6mClbZ7Kc1Xz+20YTPuqAlEkELZfayXsSdMbWqHVd4t4pLel3NDChH92AOSFrJl5EN1KSCqzDwHeY9QKl9x9RabIrkplQUFD8j8+m2lDGKCYbclVGmMBVjuvSel3ZonUvAOphBxuU5OWFalLdcRZGI7HkB/0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2016 07:00:36.3446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2588
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55781
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

On Thu, Nov 10, 2016 at 09:17:31PM +0100, Wolfram Sang wrote:
> On Tue, Nov 08, 2016 at 08:13:37AM +0100, Jan Glauber wrote:
> > On Mon, Nov 07, 2016 at 08:09:20PM +0000, Paul Burton wrote:
> > > Commit 70121f7f3725 ("i2c: octeon: thunderx: Limit register access
> > > retries") attempted to replace potentially infinite loops with ones
> > > which will time out using readq_poll_timeout, but in doing so it
> > > inverted the condition for exiting this loop.
> > > 
> > > Tested on a Rhino Labs UTM-8 with Octeon CN7130.
> > > 
> > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > > Cc: Jan Glauber <jglauber@cavium.com>
> > > Cc: David Daney <david.daney@cavium.com>
> > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > Cc: linux-i2c@vger.kernel.org
> > > 
> > > ---
> > 
> > Acked-by: Jan Glauber <jglauber@cavium.com>
> > 
> > Thanks for spotting this. I think this should go into stable too for
> > 4.8, so adding Cc: stable@vger.kernel.org.
> 
> Shall I still apply this one? Seems to me that 70121f7f3725 is still
> under discussion of being reverted?
> 

70121f7 needs to be reverted, but it looks like i2c devices are still
not working on Octeon after that. We are still debugging the issue,
so I would suggest to wait for some more days.

--Jan
