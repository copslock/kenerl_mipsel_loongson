Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 17:44:46 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:40315 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992618AbeBGQnstpUUV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Feb 2018 17:43:48 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 07 Feb 2018 16:43:34 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Wed, 7 Feb 2018 08:27:06 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Goran Ferenc <Goran.Ferenc@mips.com>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>
Subject: RE: [PATCH 2/4] MIPS: generic: Fix ranchu_of_match[] termination
Thread-Topic: [PATCH 2/4] MIPS: generic: Fix ranchu_of_match[] termination
Thread-Index: AQHTnHNKEOzt4VYpCEqwd3IbNKnlP6OZJoB2
Date:   Wed, 7 Feb 2018 16:27:06 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEE2517C990@MIPSMAIL01.mipstec.com>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>,<478b4da66648852b55c58eb7453f608d7501d5a8.1517609353.git-series.jhogan@kernel.org>
In-Reply-To: <478b4da66648852b55c58eb7453f608d7501d5a8.1517609353.git-series.jhogan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1518021810-298554-7300-1305-8
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 1.10
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189770
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=1.10 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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

> 
> ________________________________________
> From: James Hogan [jhogan@kernel.org]
> Sent: Friday, February 2, 2018 11:14 PM
> To: Ralf Baechle; linux-mips@linux-mips.org
> Cc: Aleksandar Markovic; Goran Ferenc; Miodrag Dinic; James Hogan
> Subject: [PATCH 2/4] MIPS: generic: Fix ranchu_of_match[] termination
> 
> ranchu_of_match[] has no terminating element to end the search for a
> matching compatible string when the first and only element does not
> match, so add one now.
> 
> Fixes: f2d0b0d5c171 ("MIPS: ranchu: Add Ranchu as a new generic-based board")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Miodrag Dinic <miodrag.dinic@mips.com>
> Cc: Goran Ferenc <goran.ferenc@mips.com>
> Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/generic/board-ranchu.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Acked-by: Miodrag Dinic <miodrag.dinic@mips.com>
From Aleksandar.Markovic@mips.com Wed Feb  7 17:45:00 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 17:45:08 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:57338 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992692AbeBGQoVTfFKV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Feb 2018 17:44:21 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 07 Feb 2018 16:43:35 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Wed, 7 Feb 2018 08:27:08 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Goran Ferenc <Goran.Ferenc@mips.com>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>
Subject: RE: [PATCH 3/4] MIPS: generic: Fix Makefile alignment
Thread-Topic: [PATCH 3/4] MIPS: generic: Fix Makefile alignment
Thread-Index: AQHTnHNL3+vM+XZkm0iQBtm1ToHHq6OZJp+i
Date:   Wed, 7 Feb 2018 16:27:08 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEE2517C999@MIPSMAIL01.mipstec.com>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>,<aca836516478a60b0f3d68251448ec96014a610e.1517609353.git-series.jhogan@kernel.org>
In-Reply-To: <aca836516478a60b0f3d68251448ec96014a610e.1517609353.git-series.jhogan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1518021606-321458-21852-1632-11
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 1.10
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189770
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=1.10 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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

> 
> ________________________________________
> From: James Hogan [jhogan@kernel.org]
> Sent: Friday, February 2, 2018 11:14 PM
> To: Ralf Baechle; linux-mips@linux-mips.org
> Cc: Aleksandar Markovic; Goran Ferenc; Miodrag Dinic; James Hogan
> Subject: [PATCH 3/4] MIPS: generic: Fix Makefile alignment
> 
> Fix whitespace of generic platform Makefile so that obj-y values align.
> 
> Fixes: f2d0b0d5c171 ("MIPS: ranchu: Add Ranchu as a new generic-based board")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Miodrag Dinic <miodrag.dinic@mips.com>
> Cc: Goran Ferenc <goran.ferenc@mips.com>
> Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/generic/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Acked-by: Miodrag Dinic <miodrag.dinic@mips.com>
From shannon.nelson@oracle.com Wed Feb  7 18:02:37 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 18:02:44 +0100 (CET)
Received: from userp2120.oracle.com ([156.151.31.85]:52984 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990434AbeBGRCg6aE-V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Feb 2018 18:02:36 +0100
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w17Gq6ZQ085370;
        Wed, 7 Feb 2018 17:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=t8qkj05xE5jMGyqs1OsOZL7GRtK1W9ho20c5JJygHrY=;
 b=RWv2w5fV1XRN1aZrMYT/5yUTkcEmnqeHCtBwrBfLJThBqxe3AN9399dXgdKGBjDW6FC6
 lCgL15B/NosiHA2x3FJ+sA8OnypeeUwoZD+7ST5mJ98rIJ9Olf8agFxl9OtKd2N1O6FU
 NABG5ujgHzQksmFo10/H4gpl4I6vkyj2Q18/KUHmxV2f5ueUyMI6O1rzm0yBazn21dPK
 Yjt9a7JxP/QYb96FLsTWKb9uIolmBWHSZooGj+nPjQUCSDOr1IRi81JSqm1DGVGWS1pW
 JG2ZK7zHKvyjDoVtdjmlCL3xotPdymaG4IAoHnrAYWH1738vGidNZrPJUfDBKlkCdMef XQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2g058p0454-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Feb 2018 17:02:23 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w17H2MMs014469
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Feb 2018 17:02:22 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w17H2Kqg012829;
        Wed, 7 Feb 2018 17:02:22 GMT
Received: from [10.159.158.96] (/10.159.158.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Feb 2018 09:02:20 -0800
Subject: Re: [net-next,06/15] i40e: change flags to use 64 bits
To:     James Hogan <jhogan@kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     davem@davemloft.net, Alice Michael <alice.michael@intel.com>,
        netdev@vger.kernel.org, nhorman@redhat.com, sassmann@redhat.com,
        jogreene@redhat.com, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
References: <20180126212459.4246-7-jeffrey.t.kirsher@intel.com>
 <20180207150907.GB5092@saruman>
From:   Shannon Nelson <shannon.nelson@oracle.com>
Organization: Oracle Corporation
Message-ID: <e7c934d7-e5f4-ee1b-0647-c31a98d9e944@oracle.com>
Date:   Wed, 7 Feb 2018 09:02:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207150907.GB5092@saruman>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8798 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=779
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070213
Return-Path: <shannon.nelson@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shannon.nelson@oracle.com
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

On 2/7/2018 7:09 AM, James Hogan wrote:
> On Fri, Jan 26, 2018 at 01:24:50PM -0800, Jeff Kirsher wrote:
>> From: Alice Michael <alice.michael@intel.com>
>>
>> As we have added more flags, we need to now use more
>> bits and have over flooded the 32 bit size.  So
>> make it 64.
>>
>> Also change all the existing bits to unsigned long long
>> bits.
>>
>> Signed-off-by: Alice Michael <alice.michael@intel.com>
>> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
>> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e.h         | 67 +++++++++++++-------------
>>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  4 +-
>>   2 files changed, 36 insertions(+), 35 deletions(-)
> 
> ...
> 
>> @@ -4323,7 +4323,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
>>   	 * originally. We'll just punt with an error and log something in the
>>   	 * message buffer.
>>   	 */
>> -	if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
>> +	if (cmpxchg64(&pf->flags, orig_flags, new_flags) != orig_flags) {
> 
> This breaks allyesconfig builds on certain architectures, for example
> MIPS 32-bit with SMP enabled, which doesn't support cmpxchg64:
> 
>    CC      drivers/net/ethernet/intel/i40e/i40e_ethtool.o
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function ‘i40e_set_priv_flags’:
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4326:6: error: implicit declaration of function ‘cmpxchg64’; did you mean ‘__cmpxchg’? [-Werror=implicit-function-declaration]
>    if (cmpxchg64(&pf->flags, orig_flags, new_flags) != orig_flags) {
>        ^~~~~~~~~
>        __cmpxchg
> 
> Should the driver now depend on 64BIT or something?

A long time ago this was the original expectation for this driver, but 
it was strongly suggested that in order to play well in the kernel it 
needed to be usable in 32-bit builds as well.  I suspect this sentiment 
remains, and besides we don't want to break existing support, so this 
probably needs to be addressed for 32-bit.

sln

> 
> Cheers
> James
> 
