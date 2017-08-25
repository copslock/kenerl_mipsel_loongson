Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Aug 2017 01:14:30 +0200 (CEST)
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com ([104.47.38.72]:32547
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993179AbdHYXOUQtgOx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 Aug 2017 01:14:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3fHJMOfwvtcEdMWrryL1hjbGhWDeQHAxmvwTBgtsZsA=;
 b=CEVgQup5pPb74yq3mhvz5cdc6WYv7zI03dKJg9Rn/7us1WbctsV1nKL+XFWMhyliBIHdP3Vu7gRqbMl1uqSGpli7S8TdWBvvdeh+UXLIwzAedvenAfiDdqNeeHYL6gy2GmxqDTgtGu6eoTEvkA35RmvJFvhYxkrmHMWsP5N3GuY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1385.9; Fri, 25 Aug 2017 23:14:11 +0000
Subject: Re: Maintenance of Linux/MIPS?
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Florian Fainelli <f.fainelli@gmail.com>, ralf@linux-mips.org
Cc:     john@phrozen.org, david.daney@cavium.com,
        James Hogan <james.hogan@imgtec.com>
References: <c96eaa42-ab7f-d902-746c-c6cff242c596@gmail.com>
 <1539189.Q9sWsqvfCA@np-p-burton>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <5e78f983-04fd-0357-c580-1438cdf1bc27@caviumnetworks.com>
Date:   Fri, 25 Aug 2017 16:14:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1539189.Q9sWsqvfCA@np-p-burton>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY1PR07CA0014.namprd07.prod.outlook.com (10.166.202.24) To
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e73b9770-1fb2-448a-93b6-08d4ec0eff99
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(300000502095)(300135100095)(22001)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:LB51IAKWnnPX7OsmXaRb/MbAn99p2itrY+rmdICjjpWyYw95kb07Shnxmx7MS2Mn4OFyE/5M4lH5BeMrjBLTjIzoVQTMQJhAm4Qyt2/WhMkxTml93AfMRQXWrHKxCpxOnPLhsK4+2ptoMakBU7/ScpBxVJy7IPPA285R0nUlZAvZFmVn7eVQ8lee9RHRuhRTo8WnOOt6mZCgXf2kDb1xsHQKm6yMRZSAtxt6oc8FP9RKVXyS0Kql2E/d5t2QKkzP;25:ooxx7c3jnu82gEdUdjCbrm3wWcMtp+2mGTFVXYpOOAdMM6KZNItSScDy6oZlCloZpMGl0SoO8reT952O74SEoEt79EJGcWdctFcpyau6G93ZDeJLgfqtmHRT5rXT9P4l+I4rSwZbw+OGOTCjpC/Ea0prZ4zTPtHyUyYrfGcVPuZoSObgK8GF+n5cMDII7P9mCOtaVX+eBLN0jqNsJqirXgiQDCmnfC9AA39volUVOUpph77pn7CBypCwiajCxDAaFtuOBangOEAKHo3qWgp0p7csWI0YWZiTUtBOXjBVzG4qa4ePsvH+pY2KaHhkVqVuzUhpmarYZ8eaKL/puG+GXw==;31:mlkZNmBWrRSudrRR0gFvMivVFZd1qbxi7RpBI38ws1m5XPLenX4Eoa/xAKZrsuq0w+OnFx9jVz5VN0wlwo4VDk2zHaZulSaquwetGopQ+6lTN4dt0Ss+jqlQwKQnE3LK3gDK+8nkZEPB2MVRoBwkE5C794cUYK2qbFYPvHxlBn0W9PrvUr2rbxgI/DkELUK1BWC4drf0WN1NOjlteH5LoQhybcdL1SKJ1hRaJfb0c0o=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;20:5GspJh9+GH5YKEci9bxulskj2FBGuMEcZl42PtcprTKJ3kIB2teo7Ln/mttvWfSKgmI/DgtVrIzIVrdJpzpm/Xxt6ZfKVhiTwoSm+AbqCuvwt1zkT06pXVp10OH46CIAmBdLujDVf5DoGqmf15Z27jpmJOrNrFeGSrnNtYjgBVNyTf93UjKWu/rGfnhKZA3WJUYiRmJ2rhJ1D6lWk9NigsVafH4VehORRGDBTTpta646glXCaLhAlA9M7h+nUqPyTXCxOSX1XE5vt9+W3bViI6OBDXx/sSdHGid43TtDOYF5cmP/ONgRT0n1mvel6cBElcOkKOObMz9ziT8D28qkby06nvWKZuPFlMLHGou1L164V5NQOIHi8Z3ch6sfUriuo7pOBW3qa/5RNNuSPuJweA7KaHvvcl7LuL+UH5VRzXRwP3SmRRi5ODeA7v7IO3pi2dvii74++wcP70DktOM3X1Ludyy70BrZFKedHzcQHk0TgWO+RPCjmN+FDVZYCV5F91P2GWR2Y5mECgBCe5dV/kALMWpvTQS4r7Kd7Lt8gHfEXgWmoX0GNn0Q/R21s6gvwhF3SnzedLo8aHXj8mEzuidiHA3fuoraHYZMNE8TBiM=;4:bye73X/WK7iY/9NFY7uayHL/FHe8YJ1NoQiSWghCuGAf81+7CRZay3QIwwJB8eM/qw1w/T5gKIpLEpyMAvUpvmMoV/Tkn+wQrjW/9mF0gfj/KguaKk1RrUCNd+a0DE9UvOtOkdkb2wtto3XPCSUtiDrvRYpIMzlFBWN25mIk3apx1xCqhoewPkR27iLuJ7a8BQdQIvj2atAs+M8YtLgWufjmDWdAEXhs9r0RbHJgoTdrRKYAV8TgbNRwy4dcQr7v
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB350196C282EE4AFACCD34AA5979B0@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(93006095)(10201501046)(6041248)(20161123564025)(20161123562025)(20161123558100)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Forefront-PRVS: 041032FF37
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(377454003)(199003)(189002)(57704003)(24454002)(189998001)(64126003)(33646002)(5660300001)(53936002)(81166006)(65826007)(106356001)(105586002)(81156014)(42186005)(8676002)(53416004)(7736002)(66066001)(68736007)(25786009)(101416001)(305945005)(65806001)(65956001)(53546010)(76176999)(7350300001)(3846002)(6116002)(6246003)(47776003)(50986999)(54356999)(966005)(69596002)(23746002)(6486002)(4326008)(4001350100001)(478600001)(31686004)(97736004)(50466002)(230700001)(6306002)(229853002)(6506006)(31696002)(36756003)(6512007)(2950100002)(83506001)(42882006)(72206003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;MWHPR07MB3501;23:m7yeBG7FHfjO06Hyq+IAO4JqpGc0N+mt2BqZm?=
 =?Windows-1252?Q?t8DQXJQvaCYwXiuQaBIJA/ebtUwVcsAXUCgBBnq6k71s95Z2UUPgZR+L?=
 =?Windows-1252?Q?UafxoxYxZij117j9fCRLorJX+GCntw7wwfGeIxhw8V/bK2jjLd7aQOL6?=
 =?Windows-1252?Q?W+bI8TLTP2Ft4r9VJjR4SuA9q01J0MyPpdlsruBH4Of1af2Jr8GvcZ5g?=
 =?Windows-1252?Q?6287YzuJl2sHMpg3TlxCFl2p3XxnEpMUxt03tUcT982Ri+3EKAeGtx+C?=
 =?Windows-1252?Q?x+74EO3vPlf7uJ6HA+Ko8rf4DxYzXDgbv81wxyoA3RVhy6CpEXKosHwg?=
 =?Windows-1252?Q?UPhGv3Cry3a+SUeXNulVSE+y9nW9ZSOwa1cyH4lP37ym9Lqc5aMfYAOQ?=
 =?Windows-1252?Q?BcGxuiDtghT4jEDcxu/sV/qSIprcY9+MDpMDyHcxNJrl2NvPCKFFJesC?=
 =?Windows-1252?Q?bFMYFN5yT52gA1unXK1SkhETeDrUqKmSmUPSDZOD06De4iifTgG3MBhJ?=
 =?Windows-1252?Q?YXe+VNCJC2iWTHS/UpWPfJVqvdLA+7yIYvTdRbovGcj8FrugnTuIbSYK?=
 =?Windows-1252?Q?BYF3C6BmJeivuHMJYtSfnuVxyQ3k0bpSSW0mM/i9hXdIgH6SPokVApCc?=
 =?Windows-1252?Q?zyKVxjbk/8wc8ZNcVsOrQjchdw1NJd7skI+sG9P80as+O2Zrtk8AeBSF?=
 =?Windows-1252?Q?+JpWZ6Xy6kup1LWCnfD8Zq0JgfrXqBo4+028ZgS28eLpEggsp8zFZZeE?=
 =?Windows-1252?Q?G4jpNituVeUUFsUj4fS9oYY4aO+aLwTN/ILcJ2BifI8V6NweDVs4kMPB?=
 =?Windows-1252?Q?oElXMWxNmCpYxwnUjJPbii0lkNnCRovq2HpWehSJCgiSIni45Ua22ue4?=
 =?Windows-1252?Q?1lJatQqIvKVPyMAcZ4dMMBt04kYDf+aENkMMVAalIRAdEV89TMfQAJeK?=
 =?Windows-1252?Q?ojW1PfFiXNlNu3sGHNrsfH6tb4VAfhOaX/RNZU4hR1TlGMavAKPwoVSf?=
 =?Windows-1252?Q?CFJEk7t5GZT5fQFKbbiIwuMLjfDULvax87ke52ytmAwV0jiVbNcjTRf8?=
 =?Windows-1252?Q?m/wd6xS8Zvvr7+H1Q9dPER3pRLnAEcpvQT3lVUgcmEP3UY6kItDEkHHY?=
 =?Windows-1252?Q?tc4XUE6iJ5sQ6v4mJpcssM2B8yK2UY7Rzb0zBjE9Yes5QCe1BaNpJLzh?=
 =?Windows-1252?Q?9aOLgwkO4UkxvGjl5iUv6PUU/lnMMYxvUN+8bZFe/1Sd4QGceAG5YaPa?=
 =?Windows-1252?Q?XClDIMXjDQyvrISUuulJNQJPy5jMl/BqCBFsZ/aVJb7UVkYeTMwmK084?=
 =?Windows-1252?Q?FM5wi4NqQ+Uk5xk4zqWQ4TDqvDpz2Bv1wcwGv0rckIoDWI63VhAByO3V?=
 =?Windows-1252?Q?GEIsNN4rFBBl7i7jdUD/nYxn590OXUs2b6oMr+kY/Zr8YBp6HuB4WwON?=
 =?Windows-1252?Q?dM34PF6q88Bc/AHxIUDlisD9hlqxa9llxuxBI3AqsSE+D/fEOKEsHTQz?=
 =?Windows-1252?Q?GzobWhx+RBpP5aWYVZIUQ4krDctapam51SFRh1kY6RAW5FqxQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:fYGVuOnmyTEBm67tB+Oihwym1+P3lT7qN4YvU/LYFIl2PuJbtSOf+3eJcQVXL52t5FT5i3NVgp3JIK+CTpsRaP0k04VR0oBW98BWNO6y7JSrcXnto8h63m4RaX+V6Qje97tyrZdCkDwFwi9DZZcZ6cp/L9p/lkgH6yaJ4mIPk/qyE1+ymoNJpF/xJnbYoVJv8+0M5HlpLdH6jtpMRT17M6/Zq75p7I0rYKb33UhvG0Wni4tHHxMpHeotLXBvLQsPX8YedZJHVmQ9zi4zn6xY0ZkU+XveJsdzyWJWIZ4QjEYstlZzMsDKBmWp1Au2KinkW0WdffMm6GK8czULH+B6+g==;5:chd5JXwRlQeQ/5mrNarXANP4hqluIH6U9ZFcziW5Q3z7OYyI0QeB4o2/bZclOVBT0W640A+NVq17aOHLO2/Kt+iraXw2f3ITbuwL4Px5CVyWxFpOGZKvxLM3K6lSBHDwG3xOW1JxDx4ZeqbMHJaQBA==;24:wZc9Vf9fmBaFCulOKhS2fpnRDXNdsFixcVHT4K4JfX4tZIKRpoXQUGpz0YEmcEqFaEG7NPPB7wcgQX2rdwhjk6LbrENyewPfVJrb9Euks0E=;7:DCtSlvk9FQSdPC1TApZttFk8IZ7+m7l9jMSop3eCpfjfbqo4uhQVVUWv6s+7mz1Rw7WwOGY5ZvI/CAAhAFc2FtIpGa9h12c/EqYpDi09XTzZMpF9Dx3eT7P4CwygDyN5+WH6iY8gkxeEi5CNPZFGBWZ+s/6n1smFi5yGcpZbXDqdXyHDZt0nDYT4sUPmQ6xddbdFvEBeGvK467SuAcZ4W36fYxio5ZwGA6slqdm3hy4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2017 23:14:11.8269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59806
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

On 08/25/2017 04:07 PM, Paul Burton wrote:
> Hello,
> 
> On Friday, 25 August 2017 14:21:33 PDT Florian Fainelli wrote:
>> Hi,
>>
>> There are a lot of patches at
>> https://patchwork.linux-mips.org/project/linux-mips/list/ that appear to
>> be under the "New" state and have not had a chance to be reviewed yet.
>>
>> What can we do to help speed up the review process, do we need more
>> reviewers? It seems like most patches affecting Linux/MIPS are still
>> core MIPS kernel changes, but would it help if say, people were queuing
>> SoC/board specific patches in trees and submit pull requests? Would that
>> help lower the amount of patches to review?
>>
>> Any other suggestion?
>>
>> Thanks!
> 
> Personally I think it'd probably be good if Ralf were willing to formally
> share maintainership duties with someone else or a group of people. I think
> James for example would be a great choice, and already dons a maintainer hat.

FWIW, I agree.  James has a lot of experience here and has served as 
maintainer when Ralf was away in the past.  Making him a permanent 
co-maintainer, or similar, with the explicit mandate of getting patches 
upstream to Linus, would be beneficial to all who rely on the MIPS Linux 
kernel.

David.



> 
> As-is Ralf ends up being a bottleneck a lot of the time, and the backlog in
> patchwork is pretty good evidence of that. There are a whole lot of patches
> that ought to be going into v4.14, and that ought to be sat in linux-next
> right now in preparation for that. Sadly not many of them are, and usually
> that remains the case until very close to the merge window. Sharing the load
> could only help with this.
> 
> Thanks,
>      Paul
> 
