Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2016 23:11:59 +0100 (CET)
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com ([104.47.37.59]:53600
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992128AbcKKWLwEnInj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2016 23:11:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bcMFOilUZkI7ncrOHUV2Wvd4CvbKtYUogP3LyUi3wuc=;
 b=P9EIJHR+JwFIU2H5JxMERn4A0GBu+q0/QRB5GTm7bU5V+zh9CazKNwO7hbZFmM/FTfy9r+ZhS9AcnjZWhjxq1UqsR+NsDHKh0uCVasANCvSGvaemnGftrW0OnPt/MH13C5LZuLtmqtlJ2ICoB1oeTpZ1T7lcTwZ2lkQyJbtcZ/4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 DM3PR07MB2138.namprd07.prod.outlook.com (10.164.4.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.707.6; Fri, 11 Nov 2016 22:11:42 +0000
Message-ID: <5826421B.2020606@caviumnetworks.com>
Date:   Fri, 11 Nov 2016 14:11:39 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
CC:     Jan Glauber <jan.glauber@caviumnetworks.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Peter Swain <pswain@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
References: <20161107200921.30284-1-paul.burton@imgtec.com> <20161107200921.30284-2-paul.burton@imgtec.com> <20161109134103.GC2960@hardcore> <1595446.2T31j1Ekg5@np-p-burton> <20161111085707.GC16907@hardcore> <2702c562-ca4a-b7e0-4828-85f0df7d8f9b@cavium.com>
In-Reply-To: <2702c562-ca4a-b7e0-4828-85f0df7d8f9b@cavium.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA049.namprd07.prod.outlook.com (10.141.251.24) To
 DM3PR07MB2138.namprd07.prod.outlook.com (10.164.4.144)
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2138;2:wJMnisJ8FYB48r+pUKUSxkys4uqAtE5MxGjE6F/sSc8u6rbt/FTviaYHzDo5gUtHXdz0pshdecXS5N3NZbkt7Ekxq/YXYlH424bBHPUnz0sKGCRIfKYDsaTW4crcYL2AcUWcjBxLkCsgpZ8jRsnNz2UaKYY/tnUIXUjH7upDbIE=;3:yQoKtT0upILGYVr1PbOvwZRUlLHaU2vMCqZfDVfFNgoH+OjpokuH2VmkrW0FiQ4r2Kefo3S0eyUqg0NSlEgQQpKpaK3taGYawlR4PgGSht9Nb7hcmGmP5lwLu3P6C3xMurvlD0tIIyHHIlvRRwa9QxEfLZwGFRrOUWl/VSV0mVk=;25:g49fx/b/CGeWjJhM+CGFZBzNhA/8Kae4U6IPrBnik59QHXD3XXQR+NlzJaLqpINhkIp35eLMB4Hhyjh59IZ/bPgEyaBkRXt39eMeiq7tMlFZsEgw+eguwXdoFHJKUeLk2tNzrUcFYM9eqjbnPEr0DpRTyVxjO+x9DXPP6SQGDSnd4wbDe4vgt/7Ll60nPqiYjEdY44nRPl3bGrBezLo6PiHpkcqeJFrHO3vijPuMHYZXaTmF35xcf/FiPOrg5MlmWj9DC5RLY7h0UsDXbVHtpf+hqu4qqWj9GfLXIEn8Ld22VQvs9idq0nFX0GapzI5rJ8D+ySKnE60NeI9FMWmzbG4IHPvLUPdR7xFuCNsJpS94ygoblPaRk3NL+M5LMZxdnPZsS0If5UbRKdktF5CKApLFKIGWVpa+DnWdO7AFoTFy4yr8PQ7RaUxo9NdXhSnq
X-MS-Office365-Filtering-Correlation-Id: 521821f8-2e31-423a-cdfb-08d40a7fb7f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM3PR07MB2138;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2138;31:ktthoGk4iNjlDqe5dCNx9JiUQqet35xFOpUtJmil4mwBdE2jED1OLCAEkxZ/V/wlzKU8Jrso96VT0uOnYpfrVXBjhVMkmaiI2RRw4QQwFklDuTjI+jnJrwpAVjZHr0C6BbhnWwTuqGSJZ7exmFTULJjouVeKMYvT7ildSTfRD4CoQi398xge0LzBJPLykFQmRPxMifzfTXRnPpvJx4jvYBIdYUjjzUuzSV4vCl9CIF1D3JD7pKHWTQ+e0yV5i0q1sNc6kvFsSa3Sqh/qwKNsSA==;20:JQu4LfX5OqOsR9rdcuHi1qStatdKWWJw4FxYs6anGosOi+QM+nkg5eazdv0ZTsxkKa1xGLeO8FfW4/cxpkGriFnZvoaK3SE7igRb7yF6uNYBaeDEpLjH3fYWqrhxdBh/sGJxNSE/eIn6qV9rbTSfN5X+b4LC0JDQV6twCh3BgiyhZbWezjg7zSn7Xrprr0DChB6bxizuD7uzi57E+AGD971F9/N7KHhB+hXl+OcnNaMhlZAhJ4Mdz2XIaNtUDTP0XLr5h69f8d9Jyuhlo8C10u4qeFGZQS28wka9PjrjmJU/73PkqAVJy9z54lx/3u0XegH3laTzI2RcW34UqUVUv6yFx3+smEj4+UUKfAtq8co55c6QytwZupbCyrRd4nfJtLO8K7hw7il/cxtCRXZehTWl2M05kpc4vOPiaGPC6IeiIupspy/D2H9XlZNyk/kMSnpPjo31qc+OY5cvPy6QE3O24J8EZqRWIfnBMDJhPTggVz/ld1qARgpZfYazbWUrbATPmvlhnz+6Tf0tJp5FMqKlKZkyblnPcOtyzcDwIlDaWg1l8A/bqlJ9kQbxnZ32l0v47vI6ovkK/GIsJ0bX0vQVAVt+ym2Demol/F+Z894=
X-Microsoft-Antispam-PRVS: <DM3PR07MB21380E0431ED136CFFD6233297BB0@DM3PR07MB2138.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:DM3PR07MB2138;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2138;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2138;4:4SeERhLXoMe7kSQZalMM5u3TFEQKCFAWd5FTydClBGo0A2MZmwd8GcegEDzfDIT2K+FfgkuQF5MxleSYxxU3ZYNH6Q5IxJv5lO3zKNBtunMv6VTVgJAYwM3148Wrj7sfQXZXgxRnV2IX6MOwl9A2QsrYBX7D9mXEufnehqDUW9a6P/QSzFpa4OU7DTW0zth2/Kjb/ezuyNsAaV2u2kzcvW84pl5k0FPwMPMw9INwyd/qQ+9+bde/REHnVmT6Y+JYnwBwgs5mbbBOOg5GYL2Oh4TJzFiV0yUUQKGEN7PwIm/XIMdkBP9Ayr2drGXlLRYiacTB8yGQUkbjCPHSbXsOJBd8hm3vuzSHghyDkfZHSa3o3p6SvqxWPG0EAVoPW0GDH8Zhhq/BOqn1S5tY3aNNRg==
X-Forefront-PRVS: 012349AD1C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(24454002)(189002)(377454003)(81156014)(230700001)(33656002)(2906002)(92566002)(110136003)(77096005)(5660300001)(189998001)(4326007)(6666003)(36756003)(83506001)(69596002)(101416001)(42882006)(305945005)(7736002)(93886004)(229853002)(2950100002)(7846002)(81166006)(586003)(6116002)(59896002)(80316001)(8676002)(3846002)(6862003)(76176999)(4001350100001)(97736004)(99136001)(50466002)(65816999)(42186005)(54356999)(53416004)(50986999)(106356001)(68736007)(64126003)(5890100001)(105586002)(87266999)(66066001)(65806001)(65956001)(47776003)(23746002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2138;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM3PR07MB2138;23:2dAKAcQZW6GO18oyRw2UmrUyrmRR016G4vArB?=
 =?Windows-1252?Q?9hlXx+Zj5w6opOWgf51MzUHPTnCuC/nu2lQM3CCTdFvRtYeyT2t0YZEs?=
 =?Windows-1252?Q?V+FVI9yRNDk0xGrlaIOFGId9CyHa8GqHnK9txCVErZ6Hw5qyUPI7FBmx?=
 =?Windows-1252?Q?aMAYMCGAywpZctXUMt7ejCqq2AgVM0uxKeGzbUrOjAutJBlXDOCW7Jr0?=
 =?Windows-1252?Q?nVb7qq8zsOW2xdcXF+GRCOrr03KV7SOSQqLC1Rr8q7gYjGMKeltIwIyy?=
 =?Windows-1252?Q?oYsy50Wyfo9NEQ2pZsMZKp6w8LkMu1BgWpKQdMutzM2kaUJ4cwdcFEGZ?=
 =?Windows-1252?Q?E5/dtSW6o6avyzRqnbSIXz1pc348AamD2OTWy7Ol3FQPkpWo0szhSF2/?=
 =?Windows-1252?Q?HWzsOO/fXSsM8MKKJDqpEpyb+poa23/o/toiH4/K5EQX5bNYNd2wDhHE?=
 =?Windows-1252?Q?1acguAruKvyZc0EcYWtqu+2/dgWmFun8f5bEgZuFLRGmQqj5wy8pjKG5?=
 =?Windows-1252?Q?m44KKc6Ss3VJIYz9xBxJBLAgRjUhHQxhw6Yb0OoSNS/rX/9NITB/qtTy?=
 =?Windows-1252?Q?qALJMsdgjUOBE1fxK/uWjvwoCp8Bs9jctNWo/hjOC48C/cpeQclOBmfT?=
 =?Windows-1252?Q?mYJg6rutT/RpnMsjSIeP3V8wL4YdZmeC+XEwxC64jGA7JDHqjKT0tjEr?=
 =?Windows-1252?Q?MCVrTT4Z8ppYqPbkgwBq0S80iS4NESCkCk4/BFAUAfDe1NyScUnO4v1s?=
 =?Windows-1252?Q?mJcuV7jK4hTYBwh6x31XeeO7Zk10En3af8cDEw4f7dDftkWeLS9J/Agd?=
 =?Windows-1252?Q?wkJrP5cnOaNLajDrWJb7yrR20QhDcrnx7aRHP4JoSsjC3QVULDkINC6t?=
 =?Windows-1252?Q?BdDNa2SlY8/yRbUVbIPcajpop9ormRHaWCZQwUQaisFnUh8YLt7x1Kok?=
 =?Windows-1252?Q?s7Ttsxr+z0Q1vAUrsmoxn/0oS9K1FAMM6FiruNK/HRJSD5UAMjnlaT/q?=
 =?Windows-1252?Q?lTQx+8Mi1Lz6+d07zLxN/VJp0aX46PhSpc52PKpPIWNP9JKbOPWSnzP6?=
 =?Windows-1252?Q?KL/HL1f2EYYuonpM95GHe8B2jg8MMUxij0fwxPQQCqvelFpdHnvzHopd?=
 =?Windows-1252?Q?OJ5G0oNEBCqRmj1gb8ER/t7wefvQUAK1fDlfBoycrcEUcg3ij+wWpjhc?=
 =?Windows-1252?Q?hKRsfy3bxZmQvdtv5sASoyOAJmoVXjjHr2lkaIdocUBX7pUhMPP5oMBw?=
 =?Windows-1252?Q?UPZtx3IzT4B6T37WgHRqGZazWKZLUSb/C+o13ArRwrw+nPd8u5g64sJd?=
 =?Windows-1252?Q?ZVofAluEUxOkl/Ua/FopIPrXLakrhsXUwgk1wvKY9JLLTd026T4bKItp?=
 =?Windows-1252?Q?GJRkHM/22JxD8TLcpyNy/hIrXU4Dz647cUEj4M7j5ZYwC3+mar4nZBok?=
 =?Windows-1252?Q?ySWPkatCZ1Ldu7cSyWjSMkpgNYCKAitrFL22zi0Y64yHHAhpHvfb+B+a?=
 =?Windows-1252?Q?zloufN7P+M9hJhLUANH2qzO0P5A6OHVk1BP15pjYBulfey4FA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2138;6:R/NwLbsqbfUYRJXCA/dWYYj3cT+lm1fW5C2z2nFrAdanSy8EJKsLATq8cB/eiSVs1ktHgkUoXiIwhL6fXxdvFPgcYBbEhEek5ru47x0X3u9izfXjR21dklW5It77p5X6ANDVxvn/J6V1hlhHWxv+NFS92DZ11/k5gI+ch0rsHstROaP7gG8AOgYTiA5wUkErnkPoRvUDz7U4SwILSy/DopNJuX/q3rDWbAbfvqAU9r9HVLOqq/lBCGxaA/qJx1vB/nnVELg5f9EhCpCVv0mGOCHt83VpdIYUORNapeeU+t0t5SOFW+TAj2dmG8swrRwBW2kHLQu5q3OTvzUEB7/gsCGDb988XuFNYEi40WgKymo=;5:Re7bI/IvMWdTgI7egIbeNesw0tQqj+qHFJmoWHc4LiCWikGo+Fc3yfmMpbV2OL2B7v7dfVLBO+y87G/8xoHklVDxYv7CXGEcB8GTYUoZgQQYlJo4MrN6fJxwtyASxOCDVHwaYkahv66kWtnbgvxDvw==;24:DldYvZna5i3cKwJV5gUf+pqyogsWSh+YAqYijiASa2AX1GqFsYkfl1FrUuJoozkMfGbAQ2pwxWZxTrJyCYxhdluCnWOX+2v1gzr62ujBN9k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2138;7:g5WBQ4hqQ/KhzpEFkThaYBdvILWbx3iaLyNnoqmkKRu8mXFn113QQ/rZlLsx7QaK+IiXGDMNhQLbgEObqEzkhWJuvnsPRZA+Uik8tGT68WaKwAi/RBC0k+hSf9TXxH3cu+Na0ithykZiyV2k5Qm6L3fI8USNA82/Yibi+kk85QUFTDsEHhgi3oFh3LRgJBw65PMD7kRK7Sn/lbVc1nlS4lamHCt1Pjj1k+X8+TllyzYkPKNA0vRnNRQYSObFL9pp2EXLXgOcxInwJrPDzV59DON8EIhMuBfzXf4DWb+1qnDDKjFcq29+n2gWCoJyGYlAfmQIu8e+Vzei8lYW8KGNtxLvsyN2Vjlv8gE/zoyI6yA=
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2016 22:11:42.4953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2138
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 11/11/2016 12:51 PM, Steven J. Hill wrote:
> On 11/11/2016 02:57 AM, Jan Glauber wrote:
>>
>> we can reproduce the problem on our side, but I don't have direct access
>> to a MIPS system so I'm still just guessing what happens. If you want
>> you can try the attached patches.
>>
>> I'm trying to get rid of the polling around the interrupt altogether.
>> It works fine on Thunderx, sometimes I run into an interrupt timeout
>> after a lost-arbitration but recovery/retry is able to clean that up.
>>
>> Please also revert 70121f7 as before. The last patch adds some debugging
>> output to see if we run into timeouts or recovery.
>>
> Using your three patches without reverting 70121f7 fails on both 71xx
> and 78xx boards. Paul's "[PATCH 1/2] i2c: octeon: Fix register access"
> eliminates the i2c probe hang and both boards boot properly. Tested
> on top of Linus' v4.9-rc4 tag.
>

We need a definitive set of patches to apply.  If Paul's patches are not 
sufficient, work with Jan to create and test a set (perhaps including 
reversions) that will make it work on both OCTEON and Thunder, noting 
any dependencies on Paul's patches.  Then get that posted ASAP so that 
I2C can work again

David.
