Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 15:38:35 +0100 (CET)
Received: from mail-dm3nam03on0075.outbound.protection.outlook.com ([104.47.41.75]:6881
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992571AbcKIOi2amykE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2016 15:38:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tUFZVqVLGIGAOPA3dRybHYGIrCjDsPv1q4Je/7bNISo=;
 b=PgvJi3CCGPeCBxurbHgInKKffQCsJofjOb/wR3uGjvqLbyR7pSlrrHVzaAd5UazGUsLdCwP1Xs87n6qfrrE38tIzpDpiS76mnOTFVhrFnYpDK6B5++KBdFG5nT46795jPZDMNLJNrNM1ROk4HL2WLSyYxGDfcA+5UJ7KOrKRfWc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (88.66.102.28) by
 CY1PR07MB2585.namprd07.prod.outlook.com (10.167.16.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Wed, 9 Nov 2016 14:38:19 +0000
Date:   Wed, 9 Nov 2016 15:38:04 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Peter Swain <pswain@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Message-ID: <20161109143804.GE2960@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161107200921.30284-2-paul.burton@imgtec.com>
 <20161109134103.GC2960@hardcore>
 <1595446.2T31j1Ekg5@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1595446.2T31j1Ekg5@np-p-burton>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.66.102.28]
X-ClientProxiedBy: HE1PR0902CA0021.eurprd09.prod.outlook.com (10.171.90.31) To
 CY1PR07MB2585.namprd07.prod.outlook.com (10.167.16.135)
X-MS-Office365-Filtering-Correlation-Id: 768b4426-61c3-404c-d0e0-08d408ae0dd4
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;2:Nm8Q6q5sxbHJ7wkGd8YI+EH+vpM8loGcXBsnnUseinPxmf6Ws1JPD5wXRgN2BUj8sqEnlOfnZr6yLIJMZs99aAgJimrLhUQg7hhcUQleSOXa3L0YdBcC0y7TqOvakXgZK1vsds3gItlLznBwroJpDCK76FeZ0N7y8pnpRRS7AmoTqNFp0ixtYIXCbeOqnoVWA3qSVAListIc6u0Z4F4QGQ==;3:AXZhhnWuNpGIkQANB/8wWfBVEXCjZZDoJ/aXsSaJPFa17PJ8+SLJUVK3OaRjT7eJloCB0TKlZp6oG1P7Scq2ODOZRBeQ71g66eoQx1aABqS1viDGryeef7ssMZDoXJGSbVXSA5graWK4yP+L6H4Oeg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2585;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;25:uNAoSM2kZ6hDJ+vTLQsxHOQxFOfTPcssv5FWaN7nGVs6j5Tu1thebRfi51kvU5m5s8OVy3Hg3zt8itJJtN3vVzZoVydLOttplg1Qe4q8nbeDGdPiqqsUHG7Ir/hH0EPHfNSThIEEIA3P8GGsZLc+Se14Iwgg0biPiAi1cSDocXQ0dB9ZDdW6TurilGXcXlWhMhs6SFW3i87mzWUc+XLsp1jCE9+tQ37WDJcnrnywZn54d4gMWXp/wccgkTHiUg+a8dJP8boUrp2tcw2a25H0tJxZgO8lW+VkhtvJWIhkgra/zFSiriI0YesVUIxeWX+HPvCFhVjQDH0eG9fzXJ7cV9mPb9VtO6S1021ISZGslUx8xbnYp3PBSnHAsLquoxXCzi8edEnWdmvMCUPqlLcLJhZ9N/5+2hzNaV+ITElO4Tat+T3zUlVBp/xeVKROxdUPsTJmOaTYemgF47qFzUHHkg3XRDpYkSKEmVucPziNl97xkcX+ttf3fm+yvlNIGezaEJ0z575FTXpPmCokjCs9HQjt6FPW5flZKff6CWoHUFNYqD2WIxMQwlB3B1DaWEKlVxKgczmF9J6e/xNZjPzyV2wGm8aaXsH/J8+v2jWQe3AmcmygkBA7ihHEl4MXMUK7KHAeywY6zJtpirnEb0EWi2PRvijb2J6wp2A7xySPj88CjZLSEjMEgCF7OVByjf0EKBQaxoG+BuuWOyuGi5YXmXljRsLGvpAaeHq/l8E4GUkXSrx6BCN/lySQ8NwkZtG6G9xcVwJ3iM8ARWivTyoC8A==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;31:rc109Rfv4uD1JWpBcMZJL0OtjneSa7vbSql4R2Y8z+CD1fC3EdzxiJjDcCdzYI+u61NH6DY6g2j7ZaGsX7DV8dCfTeZos4+80MCzmgDrmqbqsQPRmqrk7W+I3Yr91PoQRp+H0P7y/R97jVxxlFnuGLIptjCHi9PXlGZDHzaUG24rTeAhxcbmTSegUl8dMYHrd+ISB+vFTyJtj+p7FoNiu8te5bv7BKKXhuRKUwHsNIhgTduFLKe84Jcb/0lL/na4esuZMljYAsDp759MlwmLzw==;20:GtoNBa/tPttj5wUbhdfLzZloeMz4sEKr/tgxcBtHjhEe6JsU/V9ep7S8LqJzDhIMh6EzJYAFUVzg6efMDIwd6LImjQHjPEXAs2GmTnYK9Xj5eA+jOPaOJmFoW8oq+WJF2LJyHJu3sfRa0NMz1BjL7s4k06JVlgaMvFwj0R+CgsnwVLIv6d4XB6l41DgyujmpHq4156AIeiBFbNrA73PvyHbD51EpvWs7HhTnZaC00BauNI31dciGKuOdymKkl7oezjExpqKMeAJrfFpgLTSdKGm+LfMjZpyAQ8PQlG7mFAN2SJWkvoMQOD6Om/kC0dfKmdp8QEEv5rGmHljGIJQF/YcI+myx/u146QGH+l1Xk0RpP9VBBwOxAYwsan8vit1wYB1urB9Ju+mEJJJtDLETSLO/8vvH53ZZYpWLT0A5jMpr+fRei8ea4SrKKsyGtP+A2kNbWzkbsAQwovjko5UYOgrvn6H6Us1YcgypXyGagZaTzOy2ys5kHTRz010vAgmZ2SpwruSuG2LIMMzF939rxzt1pMtnyc+4jKCmbMik0wS0h9y3tSA4dKx/BN3x40ju9LIwl7L0yZ0usirMqTmjRLppafdTdQGDXJKH7DTA8Ec=
X-Microsoft-Antispam-PRVS: <CY1PR07MB2585CA844B2C0CC3F076DC6A91B90@CY1PR07MB2585.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CY1PR07MB2585;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2585;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;4:Rzt5jX8WBCPDwBEJgFLfpTK0eV/4MygM+7BBRtf/qHLve6IInLKLSbSmNyfLZmr7OYcuRUyWdg1jtzfS57NRXa2W2GpepMvh+m02mJzP63y33vvsXyID/AJR6HOGiwoBdY5n5G+0qTZJbeStR4DF+AH07XEA+XWwMcGiMUHh61zEjxrCG/o8sE1SMohCcSEu0nIdtmVqbO3Ixivycp3ZoEDMmM+cGZdYNdxTwT5g4xlyxBx0R/J0GMaLqOrsQrf+gBVmkWq2PLwDA6Ttj5PXyaBgA5FofYCnRYLW1+RiXjV4fJTPuCYRrcA0rn7DI6beI9gahqXkByTRhNMWV77h+XrPpXIDDZg1EaKisqoi+WtTB9qtWR/dgeKszv7d0T8eq82SSmiLJFzD4h2cXwSjwOmJ2rxQLz9g+pVNgOWbgRnBdXp6MlIErhhouANfHxDWQ7BgpwRKbRBJqQEcoci2gA==
X-Forefront-PRVS: 0121F24F22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(24454002)(189002)(199003)(47776003)(1076002)(8676002)(6666003)(50986999)(93886004)(42882006)(76176999)(6916009)(81166006)(81156014)(68736007)(107886002)(54356999)(97756001)(101416001)(105586002)(33716001)(586003)(77096005)(305945005)(5660300001)(3846002)(23726003)(6116002)(83506001)(33656002)(4001430100002)(97736004)(2950100002)(5890100001)(4001350100001)(50466002)(189998001)(9686002)(46406003)(7846002)(66066001)(2906002)(4326007)(7736002)(42186005)(106356001)(92566002)(110136003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2585;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2585;23:BK+kvdC+uS8sTUyTIlvpKtRfmeBeWwjJfpVd/XC3j?=
 =?us-ascii?Q?9yO4cmR9YSbiZ+5O4JSQNmCmSQLUe7jfiLGXeHPLu1FWda73uIZWnAjiFQgQ?=
 =?us-ascii?Q?UHyDnk0iCsAxSNSaaXgMzM1pFCxvoqIfF/dFc3TJCXyNuBqO8CSSJg/NBn/8?=
 =?us-ascii?Q?tm5BR0wfbRfGyKh7R++qUOYAjWkmBfZ96NOQg6JaTB8fe7GndYcAL/FXwFor?=
 =?us-ascii?Q?oEEnr2TF6jhR4qcInv2BPXxywz04tO9P5Wr6D9phzd11rYhnUntZNARtjZvh?=
 =?us-ascii?Q?cI3bGrUKkLCwQ849fh9Qgm3qpnUi2T+Uboe8ri+QKL1xJH0r/7V+9Txf/xwq?=
 =?us-ascii?Q?G7J4njrzdxS+5g9WglmoQ82BUm8dLqgBJc+M12WDhkbTD9qYZ8X15TgjipvH?=
 =?us-ascii?Q?0lOs6FQtnmDjD6mcoeMNs3G+XFbQpcyDcJs/B1Ya7gnUEELgnipra42mus4a?=
 =?us-ascii?Q?wneYcS/7sEOzJxNRwI+uWSuZEldXSbW3vh6hsAMO97Tb2G7tVeWLtbmTCT2q?=
 =?us-ascii?Q?wLnKCbxqwHY6+wHKRmnHWC9/j587TAjqhmUMUGQhUoqsgeRyV0or6Qq8gUdS?=
 =?us-ascii?Q?xoFCqxvTCmIJPbotYWxl5G34/FgkkVSX0gL8++9Ic3nJVHlqOEJS/1naSUtT?=
 =?us-ascii?Q?4fP2CKARcTjtoJ+cv6guceHSHmMitwnfBc8GMvQCMblJ15wYrcoYlO+rbmd7?=
 =?us-ascii?Q?iXFI0buUfTVu+NAvVCPbppqYvL/JCcNFDFQ/wzNyLzlA5qAruZ+VhQzIu7L4?=
 =?us-ascii?Q?GYGiapHFlGYnpcyKcKmlTLs8rgcCawsHjKrhsPWsfmJwISPtVugGOg0wsac1?=
 =?us-ascii?Q?KiUaWhKWm/P34cp/DWC0XWb9oVLMfZV4IUis5xzeHov56r359b54VuNV41wY?=
 =?us-ascii?Q?J4tVY3sG2FeVPBkobjJw7KEEgHQfjCvFgyK5HsxUwABPzEHvPdshJ2H7bKRk?=
 =?us-ascii?Q?2Y5+4x8/vY3aSM1ter1kQN2/wuJM481bZKTvxnFoTVLQCATwPPG2YAwylZEN?=
 =?us-ascii?Q?imh1+XQLcEI4HonDCrdj98FMIFDy3kzg+CHL4n5gNhmI5l5uq7I9lQf9xIN3?=
 =?us-ascii?Q?AWYYFxap5uwLddm2hHTgui1a3kvQjpNOgckmGw4+95NV/zA0mLia8wz5pO2D?=
 =?us-ascii?Q?iQk9tu4DK0YoxRuB7VEn1bIr9x3ud9N91AXKyoiQCEYHIFOaRDujok0CugM1?=
 =?us-ascii?Q?3tJw3cvIKbsLJQYZ+bo2JbEHpW+IsSXjGoRrhy4dnkGwtBSfvq240f9s1UOJ?=
 =?us-ascii?Q?bp5Fd3PZD8d6mqGsNlAxamalMEDiRMP/ACxhoBYicW0XRUvRVp6hCgQ85YHU?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;6:NQuR+Wx5cJXDIgu8XuXWBjOJDSv+618avEnH4VqkJSuBETbGCvtpDfz8enoobHP+Kc2FD07RcLF0mz8TifiRFyi0vOlUQfstn9RGnlL34/KcRotZgP3ODIYImWvphac+RO2ef3DvOGMH9Mu3vYCkDstbLEchrZS3b9DD/XAYHMj/v/O++5RP61twuLI6VkryWaKJIxzFRDA5uKaBj6o0QV0wIsG5diR+3kiHTsitjwr0g56qacxUZp+ini7YnY7bLJbq4Q/4a+dsQFVdg3srM4duaSMEo/OOlTVKyo39ScTbZ7uLzIOZ+WNq6jbsEEEN;5:JwwNgInmSmGDc3rn1A640eIr1uNyd+mQpL8nfhkEn20rKQ4yEliOY7f4lbf3Vu2WupIjp78OsC5maqvgXQlB8Q79ZKG5mjHhudpuMi1qAmWn6lM27D5wHWt1GYj9zHz8w4fYm8TebVVUR6WIUKSHLEdohjtZcXoLpTxpivOkZRg=;24:rplAzsElOeKDj5qcFlBODuFNH/NcFgn5NzC7XR+yyhFaJMMhb1XIuCPgB+xbmpgNTQIF2RVwcCcbPubYev5LtI6bEcg1aMZh6I5KZfu5GwY=;7:W60yKQ//0pj6UkHzOTmMoqf4nLCvDdwXEQskzWZkR0LZWMI4D5fmDLXyfv/HS4VatcxOi5yltMh6KOkTVJ3LkBjh0j5XOjjK4k/pewHvpiswbYSvaKNa71dS0YRfxRUItJXqryneesTRviyI+w1EwECcnq0oskLzB+q6IAEUV6gRVUQm+JJf+K0yC7j+8eT1ooi8tJCPf6lB5tmEC8hs+KVp2dpgACRz53BGQ16JG5OOx1qegTi5c3dhcbI/bwUvdLvRif8fYYU+5vsJWcIPaWszBnoRgAXFmjg7GgurHovcOvUyiLScYfFcDzoxykcC1kDEyRnw3tNNYkq1vrb6PmpCVi8tFycQEInpDObP6rw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2016 14:38:19.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2585
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55744
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

On Wed, Nov 09, 2016 at 02:07:58PM +0000, Paul Burton wrote:
> On Wednesday, 9 November 2016 14:41:03 GMT Jan Glauber wrote:
> > Hi Paul,
> > 
> > I think we should revert commit "70121f7 i2c: octeon: thunderx: Limit
> > register access retries". With debugging enabled I'm getting:
> > 
> > <snip>
> > 
> > This is not caused by the usleep inside the wait_event but by
> > readq_poll_timeout(). Could you try if it works for you if you only revert
> > this patch?
> > 
> > Thanks,
> > Jan
> 
> Hi Jan,
> 
> If I drop both my patches & just revert 70121f7f3725 ("i2c: octeon: thunderx: 
> Limit register access retries") sadly it doesn't fix my system. A boot of a 
> cavium_octeon_defconfig kernel with initcall_debug ends with:
> 
>   calling  octeon_mgmt_mod_init+0x0/0x28 @ 1
>   initcall octeon_mgmt_mod_init+0x0/0x28 returned 0 after 67 usecs
>   calling  ds1307_driver_init+0x0/0x10 @ 1
>   initcall ds1307_driver_init+0x0/0x10 returned 0 after 19 usecs
>   calling  octeon_i2c_driver_init+0x0/0x10 @ 1
>   ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>   ata1.00: ATA-9: SanDisk SDSSDA240G, Z22000RL, max UDMA/133
>   ata1.00: 468862128 sectors, multi 1: LBA48 NCQ (depth 31/32)
>   ata1.00: configured for UDMA/133
>   scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDSSDA24 00RL PQ: 0 ANSI: 5
>   sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
>   sd 0:0:0:0: [sda] Write Protect is off
>   sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>   sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support 
> DPO or FUA
>    sda: sda1 sda2 sda3 sda4
>   sd 0:0:0:0: [sda] Attached SCSI disk
>   ata2: SATA link down (SStatus 0 SControl 300)
>   random: crng init done
> 
> As you can see octeon_i2c_driver_init never returns. Are you able to test on 
> one of your MIPS-based systems?

CC'ing Steven who might be able to test on MIPS.

> Thanks,
>     Paul
