Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2016 09:57:39 +0100 (CET)
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:53280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992105AbcKKI5b6wyZo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2016 09:57:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cAHAABA5pr2Alq8Aco8FhmT5dUnOs8nETlQPJVcXfE8=;
 b=ZebFWQExLbI556ivkm7Vld213mhxcpeFDKICk5YoKui6M6s0MOLdMDVAjXONO/Hgh30r4QhJ+egcaCbT47dcBNpVoLErdn/EWy/y8Nlg/fkMT41wH9pG5fowl3GgoFyiF4n8Qa5Xt6hXOeP1E6j/6csefQZ4bmuKQBxCVfQSGeA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (46.223.65.110) by
 CO2PR07MB2582.namprd07.prod.outlook.com (10.166.201.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Fri, 11 Nov 2016 08:57:20 +0000
Date:   Fri, 11 Nov 2016 09:57:07 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Peter Swain <pswain@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Message-ID: <20161111085707.GC16907@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161107200921.30284-2-paul.burton@imgtec.com>
 <20161109134103.GC2960@hardcore>
 <1595446.2T31j1Ekg5@np-p-burton>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <1595446.2T31j1Ekg5@np-p-burton>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.223.65.110]
X-ClientProxiedBy: AM3PR04CA0109.eurprd04.prod.outlook.com (10.163.180.163) To
 CO2PR07MB2582.namprd07.prod.outlook.com (10.166.201.21)
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB2582;2:AVlzDxJU6g+bPCu+Ds5mSQ7SsJsKTaHVIYb9OzebYEybJ+tIcqfsMb66w/1Hw7XBVDwOn0YbmrtSuOg5U59onZa+nDbYmIpGYcMZztg7ksGPcbPtiRzYwZXuSTdFqyLltFQ/pCrvIz0iAa2GEtfZYZUYniT0o9DqElbPL4ruy20=;3:nG0OQfwYi6oWUArUPHKFD7f4bOoim4Af8TT2rsrEau6DmvfbS/dmfHHVldRCdVG2aYCcMTnSeZio0GUp7fqXn5Z7/oqdZDbbKbnXHIRCU+VXDzI43QcKUSnfr/d0RTSfu2bUc+VvsR90vo2gKyN1LCLOzzHl5XfThHIaWXpqSp4=;25:8e+wWqef0X1aacWgNEEhfo1s4rrdL4UYDmNkLXORNE6y5ItHaGGh1ounuKgs1BAt3NH/bB1wdFdLHEmJLdwaLU2LisNMrZiUwqGzomSHywKHOXMKya4wJLy9qVonCii+R6xzusWwyYV6b5BtdeJoZHVYHYEq28eADtO7skm4wcNVf5F5rtO0dQ+zntx0cc/FoSWODHLOnG8/P913kQuYnjbhNu675eNk9UyyMzM+OaKKbfO7ZWY4qE2zzh5EoRYqCL8sVRByUM1QqYw0wVyxXCMkgD1ocsozzmcKLjTVfWuyIfR3vhCe6x34kcH4VHvr8EdoXU6NcmuHCNo3urdVvz199bYPj54dWBWRP2z2FIIbIK7ky3yDUQB4Z6OMWCqvS9Yr12FOKzZuj77/Kl+hG74jNUO5nVUXWOIyGOOH9URIK7qTG/aSs17v03H+M9j+iGvDm7kRhDtx3VvSNs9F1CY0z0nFFH2nqnFHYFK4nXE=
X-MS-Office365-Filtering-Correlation-Id: d958b986-f8c8-4cbc-fbeb-08d40a10bff0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CO2PR07MB2582;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB2582;31:i2F3/ysm3B5C/bzP+198HFgtvbZjh2/1rHsjlnO8jDrZ0TGvV3I0EuLkhGn1OkWrY7C0GxX8dH/SIUUS8UJxn71TGZ70UDvz5EgAY0DwoQS6Qz04Qkzlv4Sjt/DFYvcWkHLbVzZXixN1It7kzDFNYlC5SovodAJrzl+DLXJMUPgPSvDDxMVUoq2RF6QEH6hVBWb+fVYfGJuiKbD4dmGcp2bbTdS/NyyoYVD74EDgToBlILa8NnCZ/xLua7v8foX/klKtQ9yxUPdS7c2q5Xhda9io2KRET1s3eNxPviMZVuQjagBNVLwvVrONHH18cH8W;20:tt/NiYQit42IR36wvgV+dbOLfHrhqRTi2GrhDjfN7k8a8DoGMVaaSjdBMdAeB87Su66p738JbWlGWvyO94buPBFuQVzEAWJB+h2poyKCFI2A3PHUAILyGEI5GcgLCn3pzl40h+XgwXEtzTs3bWydwzUtpnvOXKdYghVZxSjDs4eRJDKE8YSL9dnbBTPKqw0M/ZoCDR4ai86IluL4XpJKGGtxmLp+9da1a/CrjuX+e1tR+yjaPamhQQQFLZu+tNjzJ4eKY2sAhALCdb4XhL9Z79L/6xhe4lHarHG2Fhr6joE1Lszh44zZZ0iswMYNeGVr8BSZXlfnGcWlHwKjyzY0NIpiGpUIyfY0L35SygllbWlgmWW0s6F1WR1GyqG7RX7yyqVSyNHAjuL3/KMY2Vf/UtOAoNbLAcrJpUGIsCCV3hwlXGUaL3c+8a+O9Xq4ltJaxaGj18a0nQuxvA6kCGgAnVlVkaiuZvIjIf+oCHGBp9DPxAIybgt6bSFeIIdXkgmYHRE+x/bS/eE6DtI6NWJtsK1owzwhX3E7OOw6yejM0CfdGBnDda8GNkvrl5cD4ziK/PyDwQY3tCSqoEqmWoI+hffH0s4zFa3dno0hHF5rJXY=
X-Microsoft-Antispam-PRVS: <CO2PR07MB25822F762518C5516CD35B2591BB0@CO2PR07MB2582.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CO2PR07MB2582;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2582;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB2582;4:l2zVkuHtoFQYYIhDwqhXR1+eQ03WXWWPKyx/4ICouLMcZ4r4V8OEudoJ3tC23RViBDUEzaj3evf/HOizNJ+Kn/fPJRdJO0YrPuqjFTugL03f+IywjS56NEeA1AB5J+EYMASiqHObXVQ1qj1qkWHQbwCnTDmgHIt0rWuQmk9neCTkA/CAiDuhekasjTDVQ/f8Z7FUe2gPlziJs1xntDJWQIUWZShIA2PU/AF4+vE74VP+PRimWKlhebvLs12FUTW5HFdCF74WXJOocaJA+UyNypFkdqPPKK5avKP4lM9vGJcu0iePTf9UbozXk2zene5m/zDsupgYyulriEBdCSmSqIpHnFhxFW3vbzWrTNIQJKzXA4aJzO8jz+T3IdlGj4ZantRtJfVm0x5gzUhoIkiQe2y+WBXahkZO18W9H+UcxVA=
X-Forefront-PRVS: 012349AD1C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(189002)(83506001)(189998001)(4326007)(68736007)(97736004)(33716001)(5000100001)(84326002)(4001350100001)(107886002)(66066001)(9686002)(5890100001)(2906002)(5660300001)(305945005)(229853002)(42882006)(512954002)(42186005)(568964002)(6116002)(2476003)(3846002)(92566002)(6916009)(33656002)(81166006)(110136003)(93886004)(2950100002)(81156014)(4810100001)(260700001)(586003)(6666003)(7736002)(7846002)(101416001)(54356999)(50986999)(76176999)(4610100001)(106356001)(1076002)(4001430100002)(8676002)(77096005)(105586002)(18370500001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2582;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR07MB2582;23:C9SR1k1w5PhQjMFPdvZU8zQA7U0yJ60awSOJLijal?=
 =?us-ascii?Q?V9kq5P3v3fWNc6b6xI/zyzLTas/s80dYdbXBNxbjTkrqXonFKjISmv+uMcUb?=
 =?us-ascii?Q?TaNaiGx3suhlOJ559/zuqOnEjlbjTgvfYh+SLom0+fAd1O+gNOGSHBrcAkhm?=
 =?us-ascii?Q?wvcQ4cZFpkpxtSN4FsZI3Ksgj/1znDic42R+qaM35KiiNCCP7gNXmvDUIgKg?=
 =?us-ascii?Q?iSRIP/HPD6URBQsu4iaCT7uFyEVHGZY3SBfmTQaHYjBfMQe9/6NT1ksW6IkV?=
 =?us-ascii?Q?Ld/BRYZLFymH5kUAY0m6X4/4aj1LxTKEgakft1e+yquqJntHPXXtUlDDH2pQ?=
 =?us-ascii?Q?TRagljqiVmhuivN+8StVF1umbbetj+TT0Y1EsoDZOKx/1jYps/jTsCabHU0N?=
 =?us-ascii?Q?fAd85WhVQ9qalxpnMZVmWM+CXcOxCoOi8Crpu2KMRlPYMf1c7Ly/vx3sh6J+?=
 =?us-ascii?Q?ivOt/JN1JBK77lkNhas3cG1b6Ml/kGtr1gtEdQF8MQDTH17QbfaP+BDFm1AG?=
 =?us-ascii?Q?9eHXjAmmlYlUEl+ZGVJF8GK9+xIu2p3YCDm8mxFiQ6zhNoPpSYhXFmpnM34x?=
 =?us-ascii?Q?HU1UMBTB9woVABcvzhJU3dDSe3gOWfs7wu6q2IZiNINWwN03bBfWrYcoptcF?=
 =?us-ascii?Q?CY13SGg0/1LsdrBqduvaHb9z7nnaKiPg1t5vO8g1hRSSOdfd9hqiDqEOOLtT?=
 =?us-ascii?Q?+uQ3IWPvkZCoB6HN3UqTtxsWzf0vvmHtUz9xA5HOKrfgTGHngsiDo65fFMI7?=
 =?us-ascii?Q?db8kddrclxwK/g0tR103xjDUsqJNH/ZJVyZElnYd9/9ylNP6x84kyLSGhrTS?=
 =?us-ascii?Q?zcDqlJDVepbE7faE75D+Qn7CfhJxILMfiz7MjSzS+DKmhOtnEF1sSJYVr37S?=
 =?us-ascii?Q?+yv/awt10h3wcabb3BhjHuraIgfyI4MRxxxO6FYmllnOMT0q33B4FwUnq18+?=
 =?us-ascii?Q?KoCCFwv/91cNhdVxmc3P8XkWohyKZn3Q5OsRzdSKCTUlzB3bTp86v3bofWOb?=
 =?us-ascii?Q?2MwZaW1sIuclAOMonA9npM2LZPbj3aGly6MCw/N9+zT+K2gBT1qU5vt1oRG4?=
 =?us-ascii?Q?2M3IfflNjxby0ak39GQvjoDX5Ltx2MWxg48IfPA6jzuMGvt+Pc5ED08cGHaZ?=
 =?us-ascii?Q?2XwKGD0Z/M6H0sINCt4sYvY9NzKpNZhxZbms/ipUoaM7xUowpMVQQ4zlo/ky?=
 =?us-ascii?Q?CpWcVVBu12J/AelKsK+pNZ8cZ4GAw3atHhqDGTG8c/khO50d7v/GGgaNw5ZG?=
 =?us-ascii?Q?QJ2Iy2vUBkpPEZ3nHIqWY0TJ2gLsrSYsSgSf9P8iMz9+YyYScc6CojhcwXjK?=
 =?us-ascii?Q?/hcfYSsvxRnuXp36KVgypve3Dakzs+iaCSS18qab2NAFUEbjJrXDJsjKZOyi?=
 =?us-ascii?Q?q2g457MZeR5PrpSTQtH/fKE0SrZjBnstjGvYjig293POpZC?=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB2582;6:z3Umem2Zgyi0UlcUZk2WlWmnO+fFn9I+V7DMk5ZSpTb/HtkUoNcFvkslTr0QxboNT0DpW+/Nem+4Ej5/vlEbF+GPvEwTa1ac3OyQ+VAiMvHAkmvj8DLheDC3EP8W59bjLVinrmtfcSPLKQpMLTLdwpN4/FuVPJG1Y/6yxPSSq1cvPpa3FKU91R2GKvtAdjysPfL0KazMwk8r5cbZwicc0ZfjOaGuxstZj9YQB8dHG+y93cIW/KvSrS3wsxHHPPlvMzIZ+NPEmIAonOS+oLeT9ONOlXo5Cbe3bzqKErGNVuuSfI4TBqyu5yV6aBOM7nw/;5:mUw8AvLBmmkorGFdWltP2GjqZ8l7KWBFQwNskpAc6oDdAcbfNLLkcnWXaegG/eCsuchTgvhPM6MCjtoJ9Tv720fIFLvQClpGhdp2M9lZsqgLNSArWJUdlRlbVFvTp7Gw2a8cKgjJLJyUwq9aXe5I6IGpZoVB+0FZV8+PrK2qbgo=;24:x2q4Iz6w8ufW3OERb5eH7Hof1DZk4e2nDW6uKCBL5rn7xF5uz/Zn6YVWQogLcmk+rMbY7BQu2n4HXTcZcgsazCATemhkEiW7ep5TA6yUkaw=;7:3Wis4LF/HnMIFskfAF8zt3DsnH6z9cTgjl+A5WvE7geSwcrPA6KaxPOQ7cVzDwaHcKQ5yxOFGsWgyanBmBICxWBn9CaOvYjFKm2m1SXEVS7L2Omm6rmXHnKNAyaMph4B0d6wlrW778gzwr77gQmTKXiR79C3y3lEYtL4wdPDaaexCPzsMjYD4ty2qb5Pt22h5K9Vv/PDnEvawGiquHDJReCckaEUo6SIksp5+IeXz/tStcTe/+BJZo6558Vd+gVFWH4/BNCzBGDMqBdqX7o43Pmr+1GLwiq+cYE0S+0nglPtChHbjtp0I2h61er0fl3+b/+YC1YY1asOrctzvUoTIroZ08PplpMhhwaFAlh9C8E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2016 08:57:20.3913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2582
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55783
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

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> As you can see octeon_i2c_driver_init never returns. Are you able to test on 
> one of your MIPS-based systems?
> 
> Thanks,
>     Paul

Hi Paul,

we can reproduce the problem on our side, but I don't have direct access
to a MIPS system so I'm still just guessing what happens. If you want
you can try the attached patches.

I'm trying to get rid of the polling around the interrupt altogether.
It works fine on Thunderx, sometimes I run into an interrupt timeout 
after a lost-arbitration but recovery/retry is able to clean that up.

Please also revert 70121f7 as before. The last patch adds some debugging
output to see if we run into timeouts or recovery.

thanks,
Jan

--T4sUOijqQbZv57TR
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-i2c-octeon-thunderx-TWSI-software-reset-in-recovery.patch"
