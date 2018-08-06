Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 18:52:59 +0200 (CEST)
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:46256
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994637AbeHFQwy6D6JG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Aug 2018 18:52:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haXDL3wbdevYD+f8TjzKfNmaWko/wGn3otFljnssdaU=;
 b=D98OmWS+qQIZWhfkmMjDaVLBtlMbrN0Cyp8BX+NHTQfqUIoy07qIBU7Ho59urp07Jc2ad2TX3vEK9xA1cDvqHfluSDReuWWOHf+YMlhage2nCvq4PRJTHhBFoL1g6pjbpTHOAQJy1rhsfmePoQWbwMnECI0MA/wROtEB8J6tK4I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Mon, 6 Aug 2018 16:52:45 +0000
Date:   Mon, 6 Aug 2018 09:52:41 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, jhogan@kernel.org
Subject: Re: [PATCH] MIPS: Remove obsolete MIPS checks for DST node "chosen@0"
Message-ID: <20180806165241.ujj3ulhz37mifebg@pburton-laptop>
References: <alpine.LFD.2.21.1808061223350.24138@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1808061223350.24138@localhost.localdomain>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR19CA0089.namprd19.prod.outlook.com
 (2603:10b6:320:1f::27) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 612f1bfc-ee51-487b-6fe9-08d5fbbd08ad
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:e/AFVUWv1qjJpWArrj5X+gYAQ8nY6kL6a7xsidubQze/Hf336+SpHQWm1Ow/ZOcbyxbPEPWNlfHNtvYiiU7zJbe/UMdBsTqYfRs6uVnQB53V1gavpHBKKyp5Q4zHpJ5ENNPIn7l7yjdgyaGY5GXw7e7K/tV+IZPxsV4R6DQ+lsWUsiVDpr7I/vVHCZXaRoHY/fkl4jJJTnTernwZjzKI6srtC1YWp6bbx8ZWbqJYu5NX9CjSCF9rpY3+kHQzmnMU;25:uv7Ein1AyACe1+MJV2Xog5gIuCtqRe9fX5zxsW5nGfqsXaDRWeBAwqwxvouf9ULB1pqBO0HVIpMPoQNKmw7kgCZB9axfdKB38YgJZF6QtuVgVChCUqevEaVQAOpn1BoVKx34visk6Ooipr6Dbnox6tUJ92DNOs6xHKl1LqiAfS+RHZvfamF2FLa+nzHDGVqhJx9PL2anOEcvz6tyaBbG34n6fv60pPuEGEfIeHzM2R8gRgXcmIO9pVE0jpXf8c7kj4P9PGvAWjBX/FwK/xqfvHCkMslznUzVtLLC/qj9EqG5rs4U2le7crkN9s5HGvJpxE1UMiJ6nKQ44/hZQbp+Ew==;31:JD7jXSZLjU0ZeeNBlXEINV2Z5VDtt8XOVG9cBRxFAilpEgv50P5POCmre2CQp4y1npyOK53TtjR3YargBG8IAz1c4EuYb6HmaC1ysODPGDPI/vm+m8Esrx1Kg/bzjIDSBqHEMYKD66MCmKMane2WKiTGLbwxGL//TkQfQsocCWn63bBboU1z88ONh2yNVLiWcO/ph4n8aGPT36fSJOU41Z0b+ApPH2GRSjYW/o0BSGk=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:eOPQ5OnwfokluVELiIfNLkvll+PPqBDFE/WV2W4COJYTxyWd0UqbDaBEpgE0zwzCviCWUEemh10Q4tJy9PqgwuDoYkNkL7SkFAclcc1mRf7OhdiQWXuSYVmlq5R88WeS1llhvceOgwJxbixyzz096psZEOz6MsLOu0Mo8zPJCOSeLn1ALn8MWpAHypEm67OOHSopwzy0h7WYCajJmTfeHd+ry2/Rvwb5B40jU4Qs2CCq92r1hnrzR1xk0sFD0WnI;4:Oei7+G+akpv39B3YVSax2SOCSD1V9yGzCiX8iJMYcJFqJn95fvkwbVAIJt/nP22wnxNrCgT161CJ4TlHubGoE06cODTiK6CyLnKqzfBdo+/T7CqRwZVV0s4vL7EfyfZ3nk1KNgb86FNBcn1D/umlgBHCw/rPQg8K20wAyX8WXzi3gU104pw0C0wsR0oiueDJliZEumexqEDsK8ImhV5gPHuisYlN8Xbar3wg7YnRTe+I3rAnT/nMpAJJ4kAAIEh+V+5N6fzr+TfETevcWC/xDQ==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4929CCD6CBBCE475D390DA93C1200@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(396003)(346002)(366004)(39840400004)(376002)(199004)(189003)(6116002)(486006)(3846002)(76506005)(6496006)(476003)(386003)(956004)(33896004)(16526019)(33716001)(76176011)(97736004)(52116002)(16586007)(446003)(316002)(42882007)(11346002)(58126008)(1076002)(26005)(105586002)(23726003)(106356001)(186003)(25786009)(5660300001)(8676002)(305945005)(6916009)(81166006)(6486002)(81156014)(47776003)(229853002)(4326008)(6246003)(8936002)(44832011)(66066001)(53936002)(68736007)(9686003)(478600001)(2906002)(50466002)(6666003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:jZX4n3nHdoWI5SbcSrd8qkDKok/xyDlw85aEFFQeg?=
 =?us-ascii?Q?vXGcZ/BxAm8ZzfPcXYbuWIuvdhV8OoB1yYUXxXXx1yHO2remEvtl4/lKiBbk?=
 =?us-ascii?Q?wri4S2w24C4AZtCMD1pOdyJBFXSWkP7jtfw0d7c4sFjbj3f+zjpZm6uE59CD?=
 =?us-ascii?Q?nnAiMPNLzbvLtWCH49dlVHTEsjuN6BgsR9ouux47IUXVPDi0u47ErEZJ3GY5?=
 =?us-ascii?Q?RtwDY/ckZ9EwBG9r8vxkLdI8B7TOUL9QtxBAN0Vlc1XQ571xyavqM0ajncwO?=
 =?us-ascii?Q?eQ6QyBWnPptX8xkMNyQiqZj2vAG2KOs60UBkHpw0Jul2x2nPGJj/Kmqhs+8C?=
 =?us-ascii?Q?saLcauikl7taEs0uCTg6gP4Ter3aD8EVwUQuuKm4/sC7pUo45a/b5TyNpeyI?=
 =?us-ascii?Q?f6NY2ac3jU6jVcuMQW0SWfrnuciDa78k+377MGH0GF27Xagbm80HG7/UvGmq?=
 =?us-ascii?Q?jYryk5QDDQ5y2QqQpoN4uelBjA31wv+LQBqVBsnyIICPH004toedkFVp/Yy7?=
 =?us-ascii?Q?1/n08MHzsRpkiFYNgiEw15FCKWsA1we3u5DGbQ/ylQdxlu1t48J4aRB3eLoD?=
 =?us-ascii?Q?B/pLzaZ3smV/G9kE67VlYrvYD44FkPD2PLpc9E5W9oUwgwY6tKKFoQC5AWYf?=
 =?us-ascii?Q?ucqOnTquznzG+GgYj6Hr4w1aCnXveh6U9pb9PUBRu2yrain7KlJec5ddGGV1?=
 =?us-ascii?Q?TGI3L+44UA8jZCPtOJe2onwU/PEN7sFu8EkB9jdgi0eARc1YrNKorh2mB5nC?=
 =?us-ascii?Q?xvSyr2d90eSqIJ1GKKvWYnty1zO9kEoV3qBAMHjb5RNDcgOglNoR778PJgkr?=
 =?us-ascii?Q?FTrIof1Lf6iBsQK/eSwUoFBdZ8DWvD3G5k785kIdb/fbSX/qJnfcyJr3mCsJ?=
 =?us-ascii?Q?288yo5WdtDb/61SmFPy6uAW7mN9XRcWRpHg++qtEQfNyBhsPBdi8PAGhyhyD?=
 =?us-ascii?Q?BCfSMk2YBiYo+lRUrYdaGwFGw7cI5OnUk/Z+KNKvKCfStAuh2KzdAjmg17JN?=
 =?us-ascii?Q?l+mS7ZmY00BsPH8YPYRyZjUUojU54FkWLEpBCyiFFlQxtweg/aQKNVJ2GiuK?=
 =?us-ascii?Q?22fN6IcjSpma32QRTDfWQVqUPRHUfBzonikbrktBfHtwymGWN0ZDipNmkYvG?=
 =?us-ascii?Q?xifhVGobt+Ii7uMgBWbQa6eC58c7F5OuubL2SBm7QZEqUDOw4HayiXcjeafS?=
 =?us-ascii?Q?tmOdHe+qqjc76TYDQvf7A19ybYBH8c2rLbzzAg/yF8dy2+TSUL2KU0WNxrVl?=
 =?us-ascii?Q?b4bS7mtyc+ku4oMSxOS+Eg2qYM7BcQbMQ+yG7Tyr9ryMNIuuhu/uFaG0nQWM?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: xV2DEVBu86qZHrRZOtXAZjzUNHxAN9THk+wfb5+BZ+n3oaBxQAmZ1PwLhlgAghpiCiKZ65HXZUXk/yLtIwbJ6VefF2nZSsc28V8zxM6Ntb29Qfv7zDuuZjN//jlWb1Uraon4XhQoP/EZtUjQQe6HzWhOZv/GKIlO6WnEr1VY80VbgeKb6oG2FfhbnMSkUiZUyJ2mKeivNOJvsgBWH1Zx7y3HwF/oVdcSxnAiz1+k2X/SVOIN4ZrXSsZy1JLxqbCb5DUo1bj+whMQwm4JWFzdWbG4TZK3sPHTDPiQn1VTz87KwJGY9hOwNkD1Zik/p7FSDNM9TcXMRIa6XUBKbFF1iB1LNaEFRgUfTOaObqzrjP0=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:7AL2y73siWa6jWufe3NAO92q1hxTBsuIZQfPLpXr+4d+AkN/Foe9z+fqYGmnqKU8XXsYpSLJLs8mWrYezf/Ze4EL77G4gROjvzsY84fn3pJS9NdiYNpXfyYpDvqmmFuLMejfFn69MBSlj0OhTmQbTyKfPv/mzc3sJB9yMAztgwV9leJcV8uofq07KaWI2W9dZ5YbxwKnA8kMZKJ/ORx9C8+bsFchH79k4tSPuf33o3e7JIhprdPFXpyZgUYrc/8DvuEcLUgw6pEVSRZzfOknmZ9/efZ7OMhOLtS7w/lqwLhFuidg58WdaPAOvhyMIbKDQSMxlf+ZVliBLCROy0NJRdvVPMtZaKbrfFPfigQamKHpvvrdnnPQdm1FLeqOyYCJQ0UpF6FYDaU6GgzgffTnK1lv7ua/mlW64c1lBxNBgvfzsPkerHC4en+giJwYr4SseV7fmuKdKbTxhUjs/oHH3A==;5:/bahzVVr+U/9wd4a2iDRlkVkkvqjaFpjy7y/H4Wl9ZpxrJBVX9Mj4GTFYDoJDnCi3ndR+EDiAcncrG2dW1i/yvi6OtM3R7ec+9RovDJF+fLRsvmKLT9mij7p8HVY/ZikZ5+358dFml5RPt4s9n/U4svuNQpDn3wAQSC7m1RiqKc=;7:1LaUmwTGqtp0FBxxNiIn0acU945pN/R90CCvKII3k0+lrTZjTwuguh6BD99AkZeOxWTqOUHL1TOeFxcCyHzNimlAUWlCw8fSsSHEqv1RR6cGRP+sSyhJCeuRM81zNZ5FjJijbX0LkzfXukRrVCiBNJis+SeMTfVlIpVlBrmaLxESLT+zkKyn9b/LG0ecUP6etP9aU/jw+fvXFuFqnGBmoxOAguuJ5/g6QmJf4CZrbKwPjuJkV5O2sBJSKX9UdtHm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 16:52:45.2875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612f1bfc-ee51-487b-6fe9-08d5fbbd08ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65418
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

Hi Robert,

On Mon, Aug 06, 2018 at 12:26:48PM -0400, Robert P. J. Day wrote:
> 
> As there is precious little left in any DTS files referring to the
> node "/chosen@0" as opposed to "/chosen", remove the two checks for
> the former node name.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
>   if this patch is applied, there are only a couple more lines that
> would need to be deleted to totally remove all refs to "chosen@0". at
> the moment, i see no MIPS DTS files that refer to that node name.

Thanks - this looks fine to me as the yamon-dt code right now only
operates on arch/mips/boot/dts/mti/sead3.dts which uses chosen, not
chosen@0. I have patches to use this code on Malta too but the same
applies there - chosen, not chosen@0.

Applied to mips-next for 4.19.

Paul
