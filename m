Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 15:56:08 +0100 (CET)
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com ([104.47.32.69]:24550
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993064AbcKVO4BMT45R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2016 15:56:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/shknps5AeR+o7cijbjh02hQSHmyUrnIoRr9JdO4JuM=;
 b=Sqrg5ipczm8OlLo73uM3r4Ri0yaUXV702MAcIz3HZDOcdfg43blZ356ba0VM+WHNkaLs4iWHVfAtJQCvUgYbYFMwMbbYFJJvlCTT4rieqRY/LB9Iebs80/TjxW4XvLw6xL9NZAad2EvPkjalPTginc4AlYHB+v4RAzGPHf1Bm+w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (88.66.102.28) by
 SN2PR07MB2592.namprd07.prod.outlook.com (10.167.15.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.734.8; Tue, 22 Nov 2016 14:55:50 +0000
Date:   Tue, 22 Nov 2016 15:55:39 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
CC:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Message-ID: <20161122145539.GA7716@hardcore>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161122120106.GB3993@katana>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.66.102.28]
X-ClientProxiedBy: AM5PR0701CA0001.eurprd07.prod.outlook.com (10.168.161.11)
 To SN2PR07MB2592.namprd07.prod.outlook.com (10.167.15.22)
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;2:0fmilCLQ4bV7WY3973dEAC72AZ97M0ii/HU7xI4CU++QPJt0rKIXp/0seJC8h5qOVitH8Ca2ucR+sv3Z3zlIZ9otv/QJ972tZdZTATSx+vVWLL4Gq6LMIzkHg1s4hB7CGN4+GAb+EzhqeBFc3BZYs6K15MYPx95Pvt24qnNX7c0=;3:niBE5aFq+0HGBUtXIovbH2QU3Xpr2Qd/nsWqzb05tSRj9+FQr1z8nUCVUB22Rr2qQeCD9twYGSnmkfjyior3GYK3SiyPNoZC3CxA6lQ1DoSer7571Wa+vsk45FGu1okFCwjyZjLGAOtSkFkqkQVkhQqjo85/KNogGGNpZJADw04=
X-MS-Office365-Filtering-Correlation-Id: 92bded56-a13a-4142-1680-08d412e7a7db
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN2PR07MB2592;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;25:CoqbUgzBhHi/T5gNmhBQ573YNCIehrbzuiAgc0GyaSduXWjPj56gDsFd9Qk8Lp+FWCPxqKw/zPmqUJJypRNSVnBqKHAtpkpwardXmtsj84f1alBZmRJckepmu+VtxxkGGs21pmKY7L76RLIHKRiKvHUei18LN3Ja/2nqEN4PNYcxIxYs/JerCRmFkNO33yBBN4PcVEe8AUmz04a6t9VC5jwBZRLiRccHk1eL8sTcHE1EsAbAP6jtoFsT1fvlHHVJFJCDArr+mIVCWyPdzoYfUy6uty7KFS2UveqRa/rlINo3G9szv1uzbuBKs1cxT/EVAt+tvjYMNhzdbW+PpAMYrMa4/FFtsPeai1sQowYZwDSslLiThTCDIa3ecvUqIHRy3vCTpDBIGv1qwlD3AzTEOyM3ZCyMr5ty2+yuWZZ9RIk1Kaa8sy0AT7/AzRdJhYwx32INJHGPnuLlnSEkzrAt6YVYx0spwe7CJ+OwCd7p0XQJNFIa9O1j3pnYuGT2ft2yifd2p504S6LdJW3Hcze6rE7++grSEgmAK1h/Pp+Z9tZhujuLqMJVV7oMq6JBUsZoPcggYTG5T2hEJoXQ4Fjquhrl0ZAulQBirBOFZbo2InaW62qLi69t96nSrHCCjVDpXuQ2YljOhzjBT0JRN4vXrQ1iPFjUuUIUsAl3iyWf1pPFvG/Uz1PrvLTmxJj0GouSyzlfU6lPm46IuP/g5QTkYFHB2GdoQLil8zEpdgJJjbOF1GpJxMad6xnRrmn5+KqhJsN/ylFO39wZysOuPWL8Hg==
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;31:NmE1ynlsWQzktBxW6UJgfs2KsTEO16ruIZqSA+I8OAGrma8yU8Mu9pnGrr6lqw3sXUxyvvW9LJMoE7NgVkfex+Bl5wnLiD4pz5nKLAtO5y1B3a9GmdD/egAnNuyAyuJCsn2Cq/IC+J/GW6yrN0qAQNwLaW5hMDa4l7RyuqCz08rUWmif+AUuvFkaPgzFfQkgHPZqBjM6DYYymT1Ij9/usZbkEiELgfmb1BBCLJfutwHWtIwtSFzUJmGRmooco5NfeKcFT71nzOpVRScfW+UEXs+q5o0tcXajq7rpQFETfxA=;20:XGdICBwiWtwrhFZL1NiED1NoD9KnlWSKGaUUy4sBH6Pu/mbtcsByol3t1xjViCm5+Tt0lQtl0OExuP0LXs2z10G2D4qRsUq+ncw+nv5xG5NAcuhmXoZ4Cl72WtCVbf/6TicRNCNoIhVa9+6QqEtMSQ6F6HIYbFcBJ9uDmZ8ip/AF29JROpi752/aaJxfXwlYCHabvGYYDCGVGSN0AT6/cGW2SlPef0TVff7pvcCN5MTVk/Z89WxpObTCFa0tXgbWerpVurq02MvKygCEkNFxx6VnlBglmZYwq1pybK08NeZU7JKz2gu/FaYgeWxSZt88Gd4nvs5Hr57Iu+IIuPTSL2V4Qhpk2ddVpTv+wMcs7ErGqIIzeDhDL2EGXyqlhIbVh4f6iiTKGt7i+TicNTVjG/FeLX5G8n2uLLk8n9MchOnTK7OSKWZnlEJ80O5DQ2sClBnDlvsk9yvCoiVgR6wOXvk6ph9S6DorhWdH4ltlSfALNKK99wJDOm7iNcImhWwZFDdpTLl/Xwp34wPkcTS3M3X2HA6b+R+OQOpeIC3aSO/IkV9mW1639FJCM+siEDR0CM8IgExSsWPXhZmXSFp9U2AOG8Ktw2Dc5sp1+gJ8W94=
X-Microsoft-Antispam-PRVS: <SN2PR07MB259213A5741EB8CBCB518B3991B40@SN2PR07MB2592.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6045199)(6040307)(6060326)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(6061324)(6042181)(6072148);SRVR:SN2PR07MB2592;BCL:0;PCL:0;RULEID:;SRVR:SN2PR07MB2592;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;4:hXCgQ+CQiYUYsdcSTYtRnh5ro3oEExV4Qjzfy7zbBpcWgTJ6ZS0fUVLijlFnoQA5vz2NhtKafVLQANQt1ERNRVW0xsPQiFacexwRAG1uA8hI04/I04pQzGC0djNhy06KTSke8jBtonfwZO4p7iW2P4fjcO7C+Cv3FYAmYTIEDX9bHYive2mo/OGVuGKJ4U8C0+9X3qkqulMZmdBsjaQXmguBhH/zVl5kUSvw/ual40MBlThLl/+Xcpdr1Lk6xTVjahrkPYpVPYzKgsVwR0eeahudTA3B+En1jAz6W7Dpz5bH50nK2aRZaTH9wgWdY5dUZwELb1vnwaxH0OyzN0WsyhgC9GtcDgbUJGaSzuMU4iUrb3NizQE1b97JYUoSgpdFzFlczQEuh7rh55f4yNHCoYiavZoT3c/Bd5ABRzEAU9bNOuT2qynkdKGd+Z6yFpSxPBYli5yz3WfCUXd+H/XcebYiO2ntmLyf+Ro0TKv+sovv0jpDVhYnP/OjQT39/pfOkdDsDpUYrhmDyG9WIrDzFQ==
X-Forefront-PRVS: 0134AD334F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(377454003)(189002)(24454002)(199003)(38730400001)(5660300001)(42186005)(4001430100002)(33716001)(47776003)(2906002)(77096005)(81166006)(81156014)(83506001)(106356001)(68736007)(105586002)(8676002)(33656002)(229853002)(9686002)(6116002)(305945005)(50466002)(4001350100001)(23726003)(7736002)(3846002)(7846002)(42882006)(6862003)(6666003)(2950100002)(46406003)(97736004)(110136003)(97756001)(92566002)(101416001)(50986999)(1076002)(54356999)(189998001)(66066001)(76176999)(4326007)(107886002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2592;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR07MB2592;23:kV0mgR+3yUszHW4kj/o7NEyJttE1DNTjKaAjUjjKm?=
 =?us-ascii?Q?h9N8G3iDC2LWGq4+XJywv9v05dCKczJQHrmbimS9IsrPpOMr39es9mA1oHtA?=
 =?us-ascii?Q?LdW8I9kCF8eOBXBwl8A+O9r0+6ltn5g8TpEJxdPog+Hb06JGsy4hdrKN+2Ls?=
 =?us-ascii?Q?PrvGymIapiwGMievlmDJH1wvjq10ungNV7MH54AVOq2K1eXq7oh2yAQF1Y5y?=
 =?us-ascii?Q?RoionK+ih9NvoAU/YgqtmdPkSmNY09wIr5v0lcrszSeUTk8NRpPErMIHj0B0?=
 =?us-ascii?Q?8mrCavCWeCt37c1CUcxkfxARqC/K3PwQr1aQwra7vv6j8u/j9Q+Nk4qziM2f?=
 =?us-ascii?Q?zXY3dOVSjj9uBXymKNxeNECT4TZ1M2YL2Z9KVSgueclzdURCKiyjWwzb9j41?=
 =?us-ascii?Q?gzb9q6+N9/R8cgGDQi9jCzpMuOW20QJartjOhbNAq2yjgrClCHOMRqqSTCqr?=
 =?us-ascii?Q?ad8qTSegjYhIcWSMNz6WcMHGWgJkAIxnjpW535hE1/uzpaeeuPxPGWle0HGL?=
 =?us-ascii?Q?YEZTSNeWo7+59Jai7DOHGRUs+GHA5cZbCqvLS6uS87BvJUQAyzNe2QSUMxxs?=
 =?us-ascii?Q?QRavfoMLECVDtrNWyecW7bgk6ER4wx0uAg3QQlW6gVfi1Jn5SIBPfdOOpFTp?=
 =?us-ascii?Q?zkdGgtmrZQ/rDC4Hc+P0mZWdAR9Dw47jUm83zExJukSgBj9UarqJnfu+qpN0?=
 =?us-ascii?Q?WsBWyebnXBqur0ZeTvnWfVyIQ6E+ly1x/7puCnhkRCA0QOi7YGNGBjKqD27z?=
 =?us-ascii?Q?U2Fx5/QerDWVvZ6u06B+VuEc4uglw+d0fsWKAANAAdE6H2pcCZyLNG75/XsZ?=
 =?us-ascii?Q?8IpvA8fjJYWkLUaNEIWHG98RrSHJ0DkgJn0MoE7WzxYTI5vJsgRb5uTQ5YUy?=
 =?us-ascii?Q?xM2butrumhVlAQkk/YtNSAP+lSAbILIFTHa6VyCwv7Bue638fu+Ag4H8DBe9?=
 =?us-ascii?Q?2wJ36Ot7MYMjCVERNDvynvbimy1Kvqs9LoWFI0kwo5PYKSdIVtgIy+FY8sgM?=
 =?us-ascii?Q?4kp0MgUXoXQYx6KZ4w3Q/v3scNB/mD7zFvuddNBc9mmAUdT5ApRAz/CWSK0y?=
 =?us-ascii?Q?XQlcCtO1cevH0+ccCRfewcM3PJcLaN5+aKiUPOeJen8wR2Nw+i7/X2zW8QgZ?=
 =?us-ascii?Q?sY4W4UWFz6lMPmHIdt+XsdIzJhgu4GFGMeT2bPvneTpnBXh3xR6vfM5f2EiU?=
 =?us-ascii?Q?vhLwwjez3RWhowHiXq9+K96Oza9i4TjmT48cYyOJgiC4n1SImp3RQngF1aBT?=
 =?us-ascii?Q?7ezOhx6F4ClNg/vThW7R8jytx1gvX93ZS62BoTLN+ctBsw6avh4yfZ6ZO31i?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;6:kA2rIICqBhVJzjUwGfDh3VU4RoZHSIGRE5+CE4dQ5FAuOUj7ybMVzyMYJBrVlOU2q/7IvkOx4kZUXEqkRcvsCigdfiI/Sts7dASxZXrBHNf5UaFCi3JISE83Ag63ii/DGIKtYsEi9xZItMMUd5n89MShI14YxzroweCmw+smYpZaRoch9X/cjgqGDrfosLbTEKkaLEqDyB77dti766x8/r3F1/+rfuHgSgdU/ZM8svTM8dXf4KlEFe+48z2v+aWB0bf0X403r1fZJt1GKIrNIh/Be5Zpuuxzkrvm25Okv2B2ioMxs8ho0MJpIvzyNhFQVC6UZH94yJUBhzqhTLkqsZp9dFFgHZshhz/2eJiGYdY=;5:RLVD0TRjmetSjk+xkNugLRCjVQqPtiVlb850A63YDMw7IpL+zq5BFg/cgbpHS45CWRH510z3gz8sAbbgZezUDrI5jyRFWOBVp1FICtyNpaK1ffdek6EfqAYrvVy6n0LlrPQcaddPr0WU/yBY+lat+w==;24:hqD1Zx5GB2WO/tyXQxb7zrRhls819/oUCJ3UBYcBT4+HXQfXVPppOilPZv07Vukv1bz+VpFnswV/O0E7T6rLMXlyHjpIvIAJPAXlqMh8W4M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;7:i6bkTA4u7EZ3dCWysprABCG8CoOCy5XRZN2cEx2F28x8NuhBehHF8l1hSNm44OzYAsfr9nPkUVGY8BggvAPQnHpsJNExoIMeFM8V7qBkd7HVFUcUNiM0QRZAYXl6Oz6W+HS+8oPOC4+nmT3YfZLe776mS2i641CnYiDceKF2HPstk+HZEtBYTelFvFm5eQUqg4uaLVCgw6QbRDNpQaRXtG5Z76ABqg0EmmsOWpx8q6fekM+Tn2bmLyf131gqktoCRz/upA4Al/wsCi0CEiEcDR9aezNv/vXKQig4w/IFH81PrrQq3NtUbPdChqd5qd3la+h20tBQPjGWXlqqyzwADCCfrQjq/9wiQ0kamJ74Wxg=
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2016 14:55:50.3159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2592
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55846
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

On Tue, Nov 22, 2016 at 01:01:06PM +0100, Wolfram Sang wrote:
> On Mon, Nov 14, 2016 at 01:53:40PM -0600, Steven J. Hill wrote:
> > On 11/14/2016 12:50 PM, Jan Glauber wrote:
> > > 
> > > Since time is running out for 4.9 (or might have already if you're not
> > > going to send another pull request) I'm going for the safe option
> > > to fix the Octeon i2c problems, which is:
> > > 
> > > 1. Reverting the readq_poll_timeout patch since it is broken
> > > 2. Apply Patch #2 from Paul
> > > 3. Add a small fix for the recovery that makes Paul's patch
> > >    work on ThunderX
> > > 
> > > I'll try to come up with a better solution for 4.10. My plan is to get rid
> > > of the polling-around-interrupt thing completely, but for that we need more
> > > time to make it work on Octeon.
> > > 
> > > Please consider for 4.9.
> > > 
> > Hey Jan.
> > 
> > This does not work on Octeon 71xx platforms. I will look at it more
> > closely tomorrow.
> 
> What's the outcome here? It seems we want a bugfix for 4.9 but this
> report keeps me reluctant to apply the series.
> 

Steven, did you have a chance to check which of the patches makes
Octeon 71xx fail?

--Jan
