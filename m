Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 07:11:03 +0100 (CET)
Received: from mail-by2nam01on0087.outbound.protection.outlook.com ([104.47.34.87]:32736
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992227AbdAZGKxm0bmE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jan 2017 07:10:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/+Hmgk332uuII5FgJCoBYOlDAF316anISOUE9S0UIcE=;
 b=UUPGZT+xzKJHZfCws75xJcjm9acH36+wFqIU0ZJWxNrr5f4my2ZhSySV1n26XVD00T6U7T40tL4Ax8my5yRUh4NpbSYUfKFGZwbO1Zf3ll6MYwIvCMahYWQ5+nvS7i9YUC6i8w/zaTSp2ArzPquyCRozf6E2bO3eWbm3pGZdnTA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (46.223.66.235) by
 BN3PR07MB2579.namprd07.prod.outlook.com (10.167.5.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.860.13; Thu, 26 Jan 2017 06:10:43 +0000
Date:   Thu, 26 Jan 2017 07:10:30 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Wolfram Sang <wsa-dev@sang-engineering.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Message-ID: <20170126061030.GA2827@hardcore>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-5-jglauber@cavium.com>
 <20161211220434.GH2552@katana>
 <20170125204923.2mxtlszvco6wxjok@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170125204923.2mxtlszvco6wxjok@ninjato>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.223.66.235]
X-ClientProxiedBy: AM4PR0401CA0024.eurprd04.prod.outlook.com (10.167.83.34) To
 BN3PR07MB2579.namprd07.prod.outlook.com (10.167.5.7)
X-MS-Office365-Filtering-Correlation-Id: b89d7161-2be6-4fe6-b7db-08d445b210c2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN3PR07MB2579;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2579;3:NbGOhIfLwKnMoNv3Zdm0wXbUiwAJagQfiUM3Ak5iDEhuoL6O8mlGzJ01wdcbucKi3w6P5g70ogKxn9KT5QQEw4za12LHc+uiL1j115BsOiceS4Yn448bEGJIb9QaKERZhaII48naRW9zsf6KYfyZHVaoiYWmITZs9AXq0A2FKxd7WV0WMDDcNgSH1ScCJkuUIjs0ZfdPLdv4Qm8r70PMSuFg2Nhx1d7jrCuXkH0t4ou4DvJ5fu00bMcUN+70IKPBRPPf/XAcV1rQJvixGi/M7Q==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2579;25:ov7N4QvaZeSuof+wHf6O7DIPXJlo6z4UYujIYoFaiDg10Z5XReDluBeAqZE1E+uXN2y1bMj5e7LTEc8zNwA4UPvy+WmAj3TaPaiWVmI26AOfehjGNZLtgasBLCRlbYUbeaAwr5uFqK7HBi1m6sp2XG1pBxj1D4pGRkEmxLdXbGaA4cSAqasvjbM55Js4lH9AiOX6QQLFWO2I41J88ZWNsBp30bkw+IVl9uNjzjNfg86Me2d6LkcBNXjTdmaE7LA+1ERjIiAnrK5in/zBgoC9LP9JEWqi+j8oSwI2vjzibaXFsUxBNjP/QfmisV6huldRruSDnPw7yh2IM6rv2mXCJ/rqkmqAqDfdSaZv+5rvGjpn/pnrxS09zYQdHQ6ssxYLSTUhD1YDp3i0ONul0TYIugf9E6FUPM7n/gGjVzlsd4FLQEKGRcwq6BXRsesOEeOEmZPlyQoKiiZtifVwV6wu7Q2be79gTmDqBL6cCPRSBGTtdjsgN08DLy+Wz65emMm2UpnPilu0Kfku8eHTZBCUahWozhqrVLlS+kZiRFRR6s/d5fTmoxqGSJ6jhM2GrnCkpwcUlumbisU86cUppNxiKk5gWRvFzPKLHCFYM03KwW8pEDnP9w1pawL7uSuMjKjof3rsV0OV3mHqIpVG6bfirPVwvNErJ1dE3c6N/gj3Vv5fd6FSdt0cRrg0yyx0gC0p
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2579;31:lcHDNDQOiED1SUNf8ighqki4Fm9BQyLqWr7oHUzDb9mKV1FEzXU9eYNgVBGyYF+cCK2a6EuP2At8gZohfpuGB99DCx/Y3Nm5gWjKc+KFNnBNQnTlBHNAk5HCMZwWUbw3QTzYDdfPXszy4a5GIfQ3XMg4F8mLDxKVZIahXDd/6w+qTOrOkOUp6Mxabgctvs5u9/hFG5rMB7j6MYLj8J+gVbupup8KAKqwIdWFhxOqHHtIohexKWo2NNgQZWXRx8Ke;20:38wd9FNIPJ1Uj1/MlJxf2xKKZ1wCqzrfU0OYSVRDk6i1c9B+j1nIVOm9HYDRhbB79kmYK1/nLWL+80VZ892wj/EaZTG0e0h2dyxyeO8wUYcmNw74XparF688n+sND/pXy5VrE9AQ9v2QQW4q9X9Xpl1zPf4hLzXHYgBGHLVEj7P2uM9ZxwbS6s1Lf4BEdx+PGsZrPiJ6yQng8ynJ9I3cXaSLImNYfMamyfQG8u1q4d3V9/BMCqYBdT3bpf+mwmyQgevTIH3Idia0Oztrfk1k50XD4UHehOdoKoWOV5W8tMEXCOCyMb/MuLmqzpliDMbWeZkDyBGpJVFnFOiWWNLzBc3ljE1m8sWMfi1+uUu13eB1zESihWm88npX/Xc4u/fSLimnQLF1u8hW9HV2zqtNPpRmZAivueCIGzAiqXqyf1ly+VeExwjh7Afg3hMbStBvzBWZ21dGdBDz+EbVVG97dcfN2NTMkH/8rTaCcRc6YkwLmm2C83klbMLDQNLWCrqwLZVFrAFjS5e4yFNvnn/ixoC7VYfYPCk1qxLgYJVu0/cHAxB89cGodZ1PRWINtTX3GY5uHQVx3MQWcdmrvghdQyhmzaJgsvlq4zbt0bVgnfU=
X-Microsoft-Antispam-PRVS: <BN3PR07MB2579FED78D0765461768F25791770@BN3PR07MB2579.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123560025)(20161123562025)(20161123564025)(20161123555025)(6072148);SRVR:BN3PR07MB2579;BCL:0;PCL:0;RULEID:;SRVR:BN3PR07MB2579;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2579;4:7jrkwQBr/M3maAZJWnjCamArazbxANntNLTAyc9gqMfzuS/eFw/xnAInNi3nNTKmDJfWTcngIpLROC6/DRndn2FhMiEXLW7aCL4jHzLNwu8PxyUZUiRUQn4gMJFdRr40FXvcSBeMUH37duIEe23Oco8PE1eMG1KuCPM21z9cspH89s3dORN7mS/fcG4OyLGhDOZxYQXJg/VyFKjuL6kzcz7+U4qWjDXe1ITQIHB4zF50WKsj0jXB7EmPTfAyIjpfwTgvq52iMvFYUXBvF9mtXtVQFWYc62lrgU51ZRzz50T1eofZyZ+Hlyn42AsIOrVyRxoRUjwpeKvRZB+JXvUjeHch6HLo3HzOUpuNKgIASWWHGth1IbVbzs/RYUZvWTWaamCqdPUb8w1oakk0quVM5Cif+utAu9+2U/c2BE0IfU0InNagqeUuuM8rfWKCQbEckRx6BXp66Imcc7fXAIvDW/Xac++qhnm266D+IFTTvcyXqvVk1DO4C2c9g6I/AEhd2kBWI9lqvuwlWB9v5ZvqD3KV5fBgCsHFDwzsSFKTSTts7JbXGfOdV43Xowyhq6TUcmJrFzOntmaxhc4lOqKtKA==
X-Forefront-PRVS: 019919A9E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(24454002)(199003)(189002)(54906002)(107886002)(3846002)(25786008)(50466002)(9686003)(33656002)(38730400001)(305945005)(42186005)(1076002)(6666003)(106356001)(50986999)(189998001)(54356999)(55016002)(229853002)(105586002)(76176999)(68736007)(6916009)(2950100002)(42882006)(110136003)(5660300001)(23726003)(6116002)(46406003)(33716001)(101416001)(66066001)(83506001)(7736002)(81166006)(47776003)(97756001)(8676002)(81156014)(6496003)(97736004)(93886004)(53936002)(92566002)(4001430100002)(4001350100001)(2906002)(4326007)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2579;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR07MB2579;23:iaqylRYkA1IW9f4nls8NC6/V0HPXtq6+haF1cNZRq?=
 =?us-ascii?Q?Tjcj4IFqEAC+TJol3glvgkNbJn6kV0/OK7KchTpWWldmmae0gESv15wgkdiN?=
 =?us-ascii?Q?GoEhSVvu0SBn1azkjORhcAElG/WPmy919xRFqNBlulw0vkWlxy6u6VlO3UtE?=
 =?us-ascii?Q?kPglGYwpmNP/DWaBIGOJFhpaox8+znLfR/fuFJOSASHXR2SvVsE/BaDQcbIb?=
 =?us-ascii?Q?h9ABvllYSk3fgA/kRgUbSkrMkaVOLRiKUdmCo+blfYTouvuBYoJ7jWnS0lKH?=
 =?us-ascii?Q?icZ5Vj+ouNEOd9CjgHY2WqzGfxwC4nyJKuPLa/zu57zNX5PRrnwrdOpk7XQg?=
 =?us-ascii?Q?ZxD9iVYEGBO72kONUFNEVUCygwGaHdXu9iWjYRp2U9etBsnTnYEqaLSScuT/?=
 =?us-ascii?Q?VMM3dipIGVddsUslr0FwWIBw2SYj0SnC/vf5fBQAr9lkM34fDxZQHyV5M+TK?=
 =?us-ascii?Q?LEamCI0bq0XngJ/RgeNB4itMFGnMDLzIuknnMR/12dqVyqjJ5GDRzktIYvp/?=
 =?us-ascii?Q?6jiL32nRAg4A9qHuKS/q91p3o4WoPGyfGmWQq2t1CHNBxeQFiLvwlEDon8Hw?=
 =?us-ascii?Q?bNvrKKdqJ98I4lAkscWHKZAEyKUvCkfw8C4YC0WaSCaXcy4sMVfwdrv0NIqk?=
 =?us-ascii?Q?ZOlSf3TMpqPKvQG4OAIE6/x1lwsunQcJ9CQ+2c2jY7f9azE0vRo5AadTDX6T?=
 =?us-ascii?Q?IW3cNu7bDfrIYV267FYzMAyQoegrgCxRjFx2RhtjJprMypqKWYHDC1ARb3WR?=
 =?us-ascii?Q?9W22W0jFOBDqhNjrALzcjGX0GPQ4mK+TyHLtonQ7tR+dktamXfO8MHA5xSCE?=
 =?us-ascii?Q?6bv2NltYGCTqRjf5v+2uvyxsIbZQiVzOkyKQUeTa3jIO+yt4/1bmXhotbUGG?=
 =?us-ascii?Q?Cq2HjJHkUwQ1AgA81GWpsWggyIXzADcAEP3afVFnyHLpXxm13V4kKjSiw/qr?=
 =?us-ascii?Q?2XLKjTH1Flk8DTnvTUnK6g78N5r0dHGqwKwEy34tI7uxffhSD5wo9AlSfzdv?=
 =?us-ascii?Q?VntBiVDVU/Eth/GR37sFrDoy8N7jkB4TxJKxkUUPgENQHTh50x1f8yn7rjXy?=
 =?us-ascii?Q?+xK79MfJxeSQoJbBE9tr+iuc4qJbDOLaepyN9YRsw+uxvrYMsI3h5hFpBVWP?=
 =?us-ascii?Q?BU83BXg935DjLPdegqoNaFVZt4iOF226cxZgSi6H4WXmjCjVsIF+DPDjt3TN?=
 =?us-ascii?Q?O9tma9nCnIamdYTKLu0aS3rQY0w7VZW0idSeaDiiJ0k1riXgtd4hJxy15q7Z?=
 =?us-ascii?Q?IHiw7tYMs8FEkJ1B6OABvoLrOJ7GnKZWUp0Md3bsAUIvorXow0wb1vK71tTL?=
 =?us-ascii?Q?Ro6BwWXsYcbaY/zjn6fZ3pqU9CWixBq0ehuiqW5m8twHf3r/oiMA4BdQ+LQz?=
 =?us-ascii?Q?XZLyQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2579;6:KcY3OidB8cjjZ/Dt06Mj1ncYrM5wuOYGHRx658Mi3WDiJRxa00d7IK0COguHtVTsg3Nqwvtpb4meI3z72FGK7D707FMg9T7urCkLskr8AucjPrLkgKvzsgeO2ltEFypC68+rZ5vp1TVfVwGvmKpbQwmcA4Oq0rfssJPaIacXwMXm3qoko65TScQVvNR1UUpEZ8mCAabAJo8D/G0Khc4cU+572/33b3Ym1YVUQudgUMny/3EZkDq5KeEph9va3CJE9eAJNi+BC4uJDDnQUFWTdZFdASTD3C20q3toLIvsF8d+5Gwbd+R215Orj0DzW6ChoJoFWaUgeIkGJtAB/pGC73ZuXz+jOm5cBLe4gVpD2XXT1fTD1YwDIGSssUQXjDCG9ttSih9vBuEfnv5spW7k+gffNYSL4/OfpyEmLPieYjc=;5:pzqzZ8TjfhOaOAbDBjDFWLVhfbplvTxmeAvpfrY1XJo6y/mNUfC8jlHPJj2u62KC7bdbpa8dSnVCdxdWhe7moChG8Lg/xqFH47haTWhLMJw1PKAALzAjAvvQkLD7vMTXTZqAE4QigmnlwGMfZWEUXg==;24:jX7rN+Obc4KmchE4gPFhBofETa55b/0fHu1iAsAEsWi9ziOKxUS52iB3osG/bX4u4+b/Gfzo+ULtpqII1LCnwPBQl/it+HfyknuZTy5CqnU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR07MB2579;7:WzhgBPuukGRU71swqWga/QwMCX6bpg+IZoh1RGMNrUGUWwXVf5OejWly+sxL9ubQGyskxc5E01R91X3AIfhDAJFtW49yuwmKkou3LVhQ+DYyWvOvwV16r8iQ0Z+hIloVecUMW35xVifomr9UZRYn6frPKXMEyYX6tBqVaMJnYcdVgZ7UkZSM+l6o9IrC+FTXOnBtr/eca2cFdBb2xAg9j1vPBbyoEaAriI0rokOOGPtARI3NpelLwUZyiwG4Kf7Y20A+m1k+TFJilk0QATx8b4WjGMO0bJOsgzoXOG6mS2wfkpkPuBfX3CstfojgKfR5aC0Zdpk02Fx+bB1/n2bYEHs8kw6A9e1/P1nLovchuRlLO8jf2vcH6EbK4SV8l0/tIKeYAoC8JzNzGqyKeKYY3T091az54bSjcYGNvyxG5vYvK8ufJXCI7f2ZjKRn/30a3/ewYuef2XtUFiihdhOWPg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2017 06:10:43.8261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2579
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56510
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

On Wed, Jan 25, 2017 at 09:49:23PM +0100, Wolfram Sang wrote:
> On Sun, Dec 11, 2016 at 11:04:35PM +0100, Wolfram Sang wrote:
> > On Fri, Dec 09, 2016 at 10:31:58AM +0100, Jan Glauber wrote:
> > > It was reported that ipmi_ssif fails to create the
> > > ipmi device on some systems if the adapter class is not containing
> > > I2C_CLASS_HWMON. Fix it by setting the class.
> > > 
> > > Reported-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> > > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > 
> > The intention of adapter classes is to *limit* probing to a certain
> > class of devices. If a class is needed to *enable* probing, then
> > something there looks wrong. From the details given, this must be solved
> > elsewhere I'd say.
> 
> Makes sense?
> 

Yes, perfectly, the patch can be dropped.

thanks,
Jan
