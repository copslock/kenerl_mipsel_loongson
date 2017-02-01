Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 20:09:05 +0100 (CET)
Received: from mail-by2nam01on0068.outbound.protection.outlook.com ([104.47.34.68]:41594
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993877AbdBATI4wGygL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Feb 2017 20:08:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pRdqWhC3J6LykL+rS8HR2KAbpVTaqjyxPhKnV3PYSuQ=;
 b=TcHsnyFVGrpRTStl73e3ROi1AO0A8aOKzmyOWQpsN49E7RFiukfk2IMcj0Ue7Aakh2urySPOGUtxCDp4KPxIwRA9ktxTML6MRiMRZfBSwNCy0tlb9PMmIjzdSM4OqjjNOIaUJ9XnbfEmNUBtma4dNNvjDvV1Aq64EVv3A+OwZBE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Manlunas@cavium.com; 
Received: from localhost (73.71.186.126) by
 DM5PR07MB3179.namprd07.prod.outlook.com (10.172.85.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.874.12; Wed, 1 Feb 2017 19:08:48 +0000
Date:   Wed, 1 Feb 2017 11:07:40 -0800
From:   Felix Manlunas <felix.manlunas@cavium.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
CC:     <linux-mips@linux-mips.org>, <linux-nfs@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <target-devel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>
Subject: Re: [PATCH 4.10-rc3 11/13] net: liquidio: fix build errors when
 linux/phy*.h is removed from net/dsa.h
Message-ID: <20170201190740.GA10128@felix.cavium.com>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
 <E1cYdxX-0000X5-Hz@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <E1cYdxX-0000X5-Hz@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-Originating-IP: [73.71.186.126]
X-ClientProxiedBy: MWHPR21CA0060.namprd21.prod.outlook.com (10.172.93.150) To
 DM5PR07MB3179.namprd07.prod.outlook.com (10.172.85.141)
X-MS-Office365-Filtering-Correlation-Id: 7d6797b1-3a59-4bab-b694-08d44ad5c0ea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM5PR07MB3179;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3179;3:GJfwGOlzWzZKa9h78fZFTLIcwhY4Ax2Emg2N4BAKI3Drwjzaj0GeCxneOSZ9DT1RX+3Yew/OTllTh7R7evvWRffleOFuJ2k7Hxcr9YGKddd9yx82NJilB3yHch/r+gfHs2MuLG/yD8ISqvF1HPXdw6VMQ+4RhYvF7HiXYoRxoT1joaKKwMXa3aypl/DAtNW/jnY0uVTiW/cYx44MneqXUDX+UqNiDxz1QnbwW8wWmaEVPLyPHBVK5gft8335q0GFGWSEqyTd2RpenUY03GKj9w==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3179;25:wedC13/qnrN5aa62H+Iletr5boZC+edTURT7N+9YE008/iLUaUS3kJ4nl5/a4ZVcmP+/cygjOXr7paEtveCZpF8TGuQx5zpsrXSGHKbVqvEUMVcJ9q7+YYkydWbNNiPkg82SYOSq0tudwtTjcrWvHBq86Pn0tE7tUsNg95WEg3hWFDWrypu6zjoGpOdmlG8+uMOsnuWXW1qhzHPSqV0Pnu1bui3OErosZUj3oQ1oYbicJY/xI/SYl+PsNnxTqP4LCtuRxjCWPne3DGhePb+CLC68pNOZ+wIa97InFrAckR1yLpPjHFpL6x258PHkyENr9Bcdcri/lXikUS5zg32xDi8vnLIhKZjA0dYoHgkQ6TR8tqKWzocoMlfxQbjhBmlkEELsG/tHvDa82ErlnyWWWOhrhabcndSLPMZ8fEsrV19E0bM8Q+FlRqFFudwNcbG+nxKitnKEevXW08CTB+l9whiZtvQAusfWl1UirwsfOhjef2iSom6sGeG/xiRdEjObdj/cr3zQ7WcOjlKpF7ZpdNO2r3JEby0Qm+6PvgAiY26yRyrbOP5Ax7npQEtLj8jVJkNHJIZIJGA+25won9UrP41yP3hhzqkUx723lGHtLKzMitjJ+Ncjd2n9OZqUG9RkDNioXzKBWuW5voxccc2kEqtpYuuumK9I6QlRE5IW+UQIwXpwia1b3Tx54+/0fvsbIwVcj38Vf74ul15Cu+tDgw==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3179;31:stWMBORjxPPfx11uqJgbDWVjURPnF2sMKbpcAZ912hbQpj2/qU/T4y6ScBx2SMgG+P37dD3hBAPFaUN5ZO8z+s0dYD8ZyM8NaCItsdf+x6SVL2/kFeyUvZAC+8WfsoFNcAVuxh/yqAhTieHlMsFAbMds/qL8X977txFtsLRgbI3hU6ZqvBp5Yp0MuOL87JI5TxKE3VDXVeVuoIbgpE1SDCfefTyLiQFlU46mSbPoiUN+FOXtBa8GocRng9zFMZQv5ACI+WIWpx9j3byWybVCqQ==;20:NUoWSG/HMoWg1khN2JyGU4sSYCEsbt1DszlGIV2r2sJdWQ1McGz360r/kUtoxZyVxr4szeB8ktWcO6nHmor79DQInfniCJ1Y8Cd7w/m8CUQ/Ng7J0jvBZvHASw+KKYckEX+TMYN1rJLs/eeqx1Pbn0dOqHMxAt+s4bLDcVh+bWCPU+1HuA7indmoFz4k30CeHw6XcBJaGmc4hLdLDAhvglhfVJamn5xCwMJgz3Gw+xetI1aFAvWtP9SYJXwRX2mNChWtnoHGKkQa9/R8yWvdAq0+8iZAYlaRvfZ30lEruwTyDMnQw96SYc5VBxgSzEbKqOgAEf5JupEDuinYXsWvANiGp1CjS3czTH7ql8o+Vh4U8hPDhAIrGrHfYXYTaoEEwBOD7gDW+3nC391rMtXASgpYFxSv0condYRWHQAl/qMzOGfJZk7M7/5DrO0tv8Ab5AKhnLXCdy7muXJllfmH/h7faDiIgnF6zWe48Y3NTIK0GVKmeJBF4U2kAFpQCdhb
X-Microsoft-Antispam-PRVS: <DM5PR07MB3179A94FB560A71AB10AF299E74D0@DM5PR07MB3179.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123560025)(20161123564025)(20161123558025)(20161123555025)(20161123562025)(6072148);SRVR:DM5PR07MB3179;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3179;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3179;4:wsGzeRXEmkiodJiZ87JZsNaF4yA0bU6Ds8GbikyTkcDAke3NxEslbp4nwoCxoJILwUUEfzm6ejhasBIWVij0yvf+Pkt4Y959DXa4ouBVso4QsmdXZAu4iQHgy2AVb5xZ7CURudN71HyZM5zK7WFGBPb4CRn8Uy1GHVQR349sc7SZcUEHXlPzEDIf14nC6GUay1cGavESgDZPWOHqLcYxTG8p5s4v7rwr/k5yqVv7w+wdqMNmz7WGLXy7zsTd7fdPtCAWZOCFbRyvzZmB1CyzZQ0xXswI0I1Wh+y4bAdaHwgyBtaqdII9kEO/4mxn0FdXplE46ViU7PRzA8abfmpNMM2QzUlyjNB99ow+hY2JZ3vuOGlhUmIV7e9BQEb1BbjFBZl35tpSAK+NniPrafLTtYXt5L2Q0hCWtbYnc/T9zgtybHnr57Ur7S7oMl1YlfcpYUF+hRnmS+J5trN0oKnO+bby5vl79xDfgDW+8jVg03F3w4A6gkIW3Ysvk9jP0GzivFEJez29NnhBURGAlvTftrkNHfYjbcYXzaS04PEICWEidl2sxpwS2YQ+TG+FCWCUrLrR5lcjepbZiGTFmEcQ0miyEC0FekiwNNqsw4n/NoA=
X-Forefront-PRVS: 0205EDCD76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6069001)(7916002)(39450400003)(189002)(199003)(92566002)(50466002)(4001350100001)(68736007)(42186005)(5660300001)(7736002)(110136003)(4001430100002)(305945005)(7416002)(33656002)(83506001)(105586002)(46406003)(107886002)(81166006)(6486002)(189998001)(39060400001)(53936002)(106356001)(86362001)(6116002)(54906002)(23726003)(81156014)(1076002)(8676002)(38730400001)(229853002)(25786008)(97736004)(2906002)(6666003)(2950100002)(97756001)(76506005)(6496005)(4326007)(76176999)(3846002)(50986999)(54356999)(47776003)(66066001)(101416001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3179;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3179;23:6JBgtJgiX90+IlMSc4U5mHo4h3Z6iXc+281HNYPNp?=
 =?us-ascii?Q?1ozrqrp8gDMzt4MyfpMnEwXWjh4hVsDykI746pUt2MCJOr2Mw27OqC1fWA/3?=
 =?us-ascii?Q?6I7k4QvkI3S+yGrylxDotpQ0JqKSb3sUXJlRxpgM7+mpZoyKerheL10ulRNi?=
 =?us-ascii?Q?ubRAxpjDqcbNxp/hwSh7JSB6NG6zsxfuzax+hgsrW78TWIeLS+ZlrrwtXqMJ?=
 =?us-ascii?Q?WqwfP3qN9GNoMEA96eRFucglPZtmo4H17iHNngGmGSujtje2Xj6EvYDAQly6?=
 =?us-ascii?Q?Scsb0lL3XYru+rwAn7g/8hRKf+BI9G+HGpdkqGInZjOUVCK79lbORl/tu/iS?=
 =?us-ascii?Q?YRRaDKvD4BHZDnTyQOC4qiMR72wzPViUZM0pBHvS4dxiJ2cC5QiyyA7XNCIa?=
 =?us-ascii?Q?D27dlqBpg83dEVRzKPSClTyyrotOMpJyidr/zQm0xtUoiqAwceksTKvtI6hy?=
 =?us-ascii?Q?wqBYU7XhLbx00XQKG34xDFsvK/54MsBJRVsuULXw5fTev/caGA2ki0GLgrOV?=
 =?us-ascii?Q?Ke5NMzHaARuXvjZ7DApa4+3iUxA4PTSMXYTtQW+vKzzES3zd0XKA+lsHLFxJ?=
 =?us-ascii?Q?MJEJXi4cRI0poQtLDW05dg/82arNM34ApXHGVwWuBTEEsaSOpNLWlC4/ulWw?=
 =?us-ascii?Q?abGPBTSq3qjYJN1Sc/jl6YJ8X7rEZiOne6R3SFSzi1lv9H8Z45Dv9RFSnZVP?=
 =?us-ascii?Q?rXUdpXy3I0rRysxB6t7SxzcIiBFFYWJuaG68keLu8VkoR6LnGWeGc9Erj6Rw?=
 =?us-ascii?Q?+RpXxwdr73WuCKmFz2sHGJN5iOeZNJcmIdebVt5ZN3JgorkAQvpOz5DmznkK?=
 =?us-ascii?Q?fBN8MvHHzSzfJBR7qrzR88KTei97eK06BhjXnW+LN26RdAsAReB1gE7/Gk2l?=
 =?us-ascii?Q?Iw94h/x8C+TkD5ED/zwzUOUh5cbJZaypgA9/uRMNTHK2bR10evc+4opKvMGo?=
 =?us-ascii?Q?W5Xt4vQMDM17TkqJOt6CvtCmWVk2KnPqf3T3G2G33RboLG2NJ5jqv4P0dDtw?=
 =?us-ascii?Q?lbbzPvMJJDXdALvTurGul4XVYDTfpsZOgzob3YxrThLS3951pFWMReDNXXNu?=
 =?us-ascii?Q?0jy1FyysQUmExB7vkeyyQwO0dthqAhyGMdXE4UFhZRqKng58fi9sXRPhpGNW?=
 =?us-ascii?Q?+CSAJkTQAkJsRrBdj6UL4TzIDLbufJMejXj4lLmC6LgbA/pbLxImwUIfe+Yr?=
 =?us-ascii?Q?yahTSSeg94sPvkaRYm56wTtewtZGYoyPmHKjcPXkc2l4O+1DFb959C9ZLySs?=
 =?us-ascii?Q?gcj3TeDiAJd0d88j9DBPtg8vxtj0U83IP1CR6ophVIXgVwyMLrhw6Cfo7PP/?=
 =?us-ascii?Q?uXsPDjZ5g/0pKB9cWCXqLTJdfxT4IBJ0gYmGDuwL+A4?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3179;6:EuRNaHCBg0d8CVclvpLRVUdYa79IpeK4YFxW2+y+mbm0bClIKA5O9DD0KuhxeCyDpqEsYnUvXg8EGWhQyhqlIREwW+thdAUu5bXtk8T+5uJnSDiSiaz+WUnR/ivGODLnN7pYqhv2D40Fos6sgnsyRBd5wR28YD1h9jhgIjp/pqK+jtfhGdw+3AIPBZTN7SIVdWuzCBWn2WEDgewYleFjIHV9CmvQ8T0RezWgNPMcZKcGQ5zPj3LbfXQBFKfzvGGJXeH5eSZCbJ7uIASv4WufqQJk+gwXYcemHQdGG0DPML6bDUB+GUh3GdqGVNBdWmTuLqxFO5SDI92OGjCKHjxQRFkGLf60Jr2ZFwpxnDWARD331G4cI4wk4rqyhwfb7L7VnU0+lIpbp0AnDiWnJKLu6YEQDF01o2MBUS9fo/lQMz8=;5:CvqSfNXlYZdJyFtL+eubFdDsvt2tKQzMMsfJW6Cj51kNXJn0dvmDiX3PjO8ZSFF8KFX1upphZSRfyI3d+9xQDd5lj/FgyU4bDgFF1Ag47419g5TKJlmIx4qFCmcDhOM2io7TrrmN1jnIBURjHCCMQw==;24:6dmrmINFGckxrK0Nm6Eb5TU56rw3CBrO0eItAuV5xoaGJMe1ycH7/slZCN2oo5GS5p0LjmfKxh8T9zaR3qRMP6clfDmvvDqAHBIwO20+A18=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3179;7:o5yFQoVjjZEzzEDqqsnCjB9pgxOs+9irFSjU8ZHSXKjBmV5hpBa0Gh5ng8/Wk6lYFHHJYjHfy6zr3d5QK/zK0TFB1OOxtsuXl/mO5gLD5zle2opM2hIArXC+u5pFsU578ean0HTONmPlS1ukV5BQ0JOr7gOJMsswuK45Huo0JdAS9/BqT0dk69zuT3zSTLiWz5tNGikr1MiXVU5ocWhfipOoOH/E6WA02+jM5A/CSF9leQ7qKeSc/eeN7sCoUCNkr8vrCM5sv/vIQl9In4MQIA/XgmD7n4U0+nK12ZIDDxRTuv+3Jfj9VzT3IC8sxULwCOzFA+TJNtQpYs1FGMW2Dy6fldQ7hfqpGSHjwuc/lISi2naohv7ozfZstEeyn5A8wFPlKRWcWInhIyngzNRLlqhahgEqxjpShGqAE8OfgEVrBKk2v9+vTCstKvMMQcNpjo3dfi7YpdCp+36AEpQF8CJBsjmYtseWVrSdmZdsw3GAQNDzl+kBswyzii1KA0TpN0Cw47nCqB/V6CUuSOkWZun+cil8rfGMWOGlc5FeGibV4Jf3o02lfsaIu+cF4EVF
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2017 19:08:48.9538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3179
Return-Path: <Felix.Manlunas@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: felix.manlunas@cavium.com
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

Russell King <rmk+kernel@armlinux.org.uk> wrote on Tue [2017-Jan-31 19:19:19 +0000]:
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:30: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: error: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:31: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: error: type defaults to 'int' in declaration of 'MODULE_LICENSE'
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: error: type defaults to 'int' in declaration of 'MODULE_VERSION'
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:33: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:36: error: expected ')' before 'int'
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:37: error: expected ')' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:325: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:325: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:325: warning: parameter names (without types) in function declaration
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3250: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3250: error: type defaults to 'int' in declaration of 'module_init'
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3250: warning: parameter names (without types) in function declaration
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3251: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3251: error: type defaults to 'int' in declaration of 'module_exit'
> drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:3251: warning: parameter names (without types) in function declaration
> drivers/net/ethernet/cavium/liquidio/lio_main.c:36: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:36: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:36: error: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:36: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_main.c:37: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:37: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:37: error: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:37: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_main.c:38: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:38: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:38: error: type defaults to 'int' in declaration of 'MODULE_LICENSE'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:38: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_main.c:39: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:39: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:39: error: type defaults to 'int' in declaration of 'MODULE_VERSION'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:39: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_main.c:40: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:40: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:40: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:40: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_main.c:41: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:41: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:41: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:41: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_main.c:42: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:42: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:42: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:42: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_main.c:43: error: expected declaration specifiers or '...' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:43: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:43: error: type defaults to 'int' in declaration of 'MODULE_FIRMWARE'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:43: error: function declaration isn't a prototype
> drivers/net/ethernet/cavium/liquidio/lio_main.c:46: error: expected ')' before 'int'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:48: error: expected ')' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:53: error: expected ')' before 'int'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:54: error: expected ')' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:57: error: expected ')' before 'sizeof'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:58: error: expected ')' before string constant
> drivers/net/ethernet/cavium/liquidio/lio_main.c:498: warning: data definitionhas no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:498: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:498: warning: parameter names (without types) in function declaration
> drivers/net/ethernet/cavium/liquidio/lio_main.c: In function 'octeon_recv_vf_drv_notice':
> drivers/net/ethernet/cavium/liquidio/lio_main.c:4393: error: implicit declaration of function 'try_module_get'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:4400: error: implicit declaration of function 'module_put'
> drivers/net/ethernet/cavium/liquidio/lio_main.c: At top level:
> drivers/net/ethernet/cavium/liquidio/lio_main.c:4670: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:4670: error: type defaults to 'int' in declaration of 'module_init'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:4670: warning: parameter names (without types) in function declaration
> drivers/net/ethernet/cavium/liquidio/lio_main.c:4671: warning: data definition has no type or storage class
> drivers/net/ethernet/cavium/liquidio/lio_main.c:4671: error: type defaults to 'int' in declaration of 'module_exit'
> drivers/net/ethernet/cavium/liquidio/lio_main.c:4671: warning: parameter names (without types) in function declaration
> 
> Add linux/module.h to both these files.
> 
> drivers/net/ethernet/cavium/liquidio/octeon_console.c:40:31: error: expected ')' before 'int'
> drivers/net/ethernet/cavium/liquidio/octeon_console.c:42:4: error: expected ')' before string constant
> 
> Add linux/moduleparam.h to this file.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Felix Manlunas <felix.manlunas@cavium.com>

Thank you.
