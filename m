Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 23:34:40 +0100 (CET)
Received: from mail-by2nam01on0087.outbound.protection.outlook.com ([104.47.34.87]:55179
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992615AbeAEWeaOd2GF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jan 2018 23:34:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xhTcm0+Dmq+O7m274PWpKxDPhMfyrx1ZHrieAks3OEk=;
 b=X1Tnw+JdhYEBar8Er2E3c/DRtfQ44+UfaYEzmRhqlvvsfDgjeLy2Y8kYOeIxGQM38pjmFlqHRt8gGnpagxNTQQTr3+4gfVtrsZ9nozdHAvhJwrVuV82/XnamMMEXUntlW5ekqh6QiAIhRGMxFwjiUBRw2h401FIjoVZJrvrMFaA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.366.8; Fri, 5 Jan 2018 22:34:16 +0000
Subject: Re: [PATCH] MAINTAINERS: Add James as MIPS co-maintainer
To:     James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <john@phrozen.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>
References: <20180105213647.28850-1-jhogan@kernel.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <5573a110-d7d0-9cf9-68c0-968459010b13@caviumnetworks.com>
Date:   Fri, 5 Jan 2018 14:34:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180105213647.28850-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0048.namprd07.prod.outlook.com (10.168.109.34) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cf12cbe-d514-4d50-abb5-08d5548c74ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:/2EFXfZMhiz2fF0a+h6afgQhSjv7z5zZlI3UEzCxxjH9F/2AHpAJyBpIMDasAmygq2QPBTJLpUzFw8UGuiKSh7XQMcEvVtz5aM+fgv+6niXg/qVslViMYAS1RIxgH+HR8tFt4BMpsxI7a+wuDOhfWno0Vcsenk18QCyCU2E+lCGKzq5WvHF62jbT/T69754TAvrNE0c2HFW9yPn8rpnzdmG4nKEyrbmK2X2zznH9tYScQ9EzSqQq+rlG8vti9UIy;25:okWRba0gO2PhtyIP390N8Bjh424ffr9vOT532D/tl2jjMm7Kr0N0HVS3W9m/593m1geqJpCHKLAKSxe2LaBPfr/9TQe2iuyRrlYHRl6FZxSdmAbi3EVhAlWSUxaSN/xIr3bq3s28gJXQgGyZm07f/3s1GtOtAQFausvyy1SbbZx/Zi4q0V5iTpstFOCwWj1bdlh721iAeThDjDLaHb8Q/YbTSzc+KojWW6dkKxdF+qwHcwFQtIqgJO+lcEa5TIJh2SS2CKwcObMNlym/siUDeRm57XSqTsdbu3/W42QA63WJQDnDLPg6+iHoJ7KDCDCooNfYSHuO9mCCKhgUUXOpZg==;31:p2cthgN0JjrWn5uFWJmMSHRBei0mHnZ5088QRZErjuDbIWxLipBkqm9RqFW5a3f3BD+po7Pff2SS6Ev/wnRWEOi2KnOP5C++14wGNluwDpQ2Ca7pZ8mQFJyJ7fgb35HjYrmqEl+OYJLhjt4A3o8PscgPt5Gw2uLsmcwAdaE/R/qc59LEW0yxiZ/g3en7Ft9zdzyGmiy/Kt7IUmO/jNxVYK1dnqCE0ZI6WKaVZVM4NsU=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:eNipJraxmeMjWpXVsOTY430xgFS3XCaGbtpE/s3eEpyv6BlqX9s7zH36VmvCOWQiuHRQI3uNn88qbifb6TiKoGBJsJiLGAX3JvaiIdcWbXh35MfPoHRWfOVKx48Osydhu951Z5gL9PSiOB5WV4a6z4MdSalyLAaGvWU88I4Z8jl16WN0KMCcPtNRWTc8Jury66tbt4f/6YL+dcuf1Ea0lHwY2gUI2Y7RwEPRIIdMy8XBQun+svkDK3inIrIDnD+x1NM2MHZFDZzeZFTM8dppeDRmn6/gXo+set9Ptzn60h+yDo7pk9K8qNNt7oCMkgepAzFEt2/BLGo0WtaZjjkR+V4BOpayzB0hc3+utwflWfvmkXdZJ217urmrmMrpsk0IQxCrVnCpXButIUT/lQD7YPR7wE9rPwM4FXyCppgUTVx79aNN2w/D36rsnN5/srF3EUosbqrp76C/6UsbHM9TkCrhPYsr8lvHjO41flmd9gLmRqF5eQypUMgKryU3RT2ROnqh/iOgDfUpHjyPU1UXvVPFYjQgsCWPRhy3KRR8RMYnbVLuA01xrK/lPv7UtM8CK0ABn+OMpBISmwMwc7eqMdnOdY6vQ1hYyev17wYDn+U=;4:zxqPXOpgIaS4oXuk9esA6VnffEnMpggVRM6PXtoobMmU1zr8PUqrKGJtSvdGhIc4QC58rn3LxJksqrQzcR5A10jOh18ZBBeQv8xIEsASSbpYyoYX8ydTycgfo+OA3Vf/OJ2PvR+DDNc/A7DiU9HaQo34LdqBngMJcrUGs4AJMyv1w0/lNRCw+jZqqwL5Qfk/f1pjkh24S2tgtJLT4RwggvmrRbhb9910yLQo8Pa5uMG3Vhe8CL4KaN9Ff00kT7IVLfZmtQK8eZK2r0+VNUSA5WYqaVin05YgrQ2C6Uy41iJccCd1RraEpmE7cctz32h1
X-Microsoft-Antispam-PRVS: <MWHPR07MB3503A86A8F1E1EFA70E1AA70971C0@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231023)(944501075)(6041268)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 05437568AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(39380400002)(366004)(376002)(346002)(24454002)(189003)(199004)(110136005)(47776003)(6486002)(2906002)(6512007)(42882006)(6306002)(105586002)(230700001)(64126003)(81156014)(8676002)(81166006)(5660300001)(65806001)(66066001)(65826007)(31686004)(58126008)(2950100002)(54906003)(8936002)(316002)(50466002)(106356001)(65956001)(4326008)(69596002)(16526018)(36756003)(53416004)(39060400002)(3846002)(229853002)(53936002)(59450400001)(76176011)(31696002)(478600001)(6246003)(386003)(23676004)(6116002)(6506007)(53546011)(25786009)(97736004)(83506002)(2486003)(7736002)(52146003)(52116002)(966005)(305945005)(68736007)(67846002)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAzOzIzOmtjVVJzWUZEYk5mcmVXWHFuUCsxdlhDRzBR?=
 =?utf-8?B?SC9WMzJHTGg1ejg1KzZwS25WSk9WU01KRzVXUnVQNkpqWElmUzVyMXY4TnJ3?=
 =?utf-8?B?WXdjSWxrb1VrOGErUHVaVDBuYmIxczdwZnB4SkVNTDc3SEVHTVlWSmd2cVk2?=
 =?utf-8?B?cjExR3d5VmhoakpKTGZqQm83U2VYOVVGdWRsdnpYODhlelFIeGEzNzVrM24r?=
 =?utf-8?B?VzJZbnhYTVlNKzBSUGMwc2s1K3lGSVBGRzJ3dytkMFE1KzlqcmlTcEpadFdv?=
 =?utf-8?B?Vjgwb1hSZHNNUFhvMGJDNXU0Skp1YXczeDFMYmJWZ014TU0raFUwVkIvR0xJ?=
 =?utf-8?B?SUNNS1RqLytwU2FPU2djRHhrNE4zRlBxTkZuQ2FpSEx4alRmdGpTN2xFVkFw?=
 =?utf-8?B?YWlqdUdKd3UxRzVpUTB0ak0wVG14QTlTUGFBNGZVREVWVExKTzIrdlI0aVVr?=
 =?utf-8?B?R0dKUG9ZaGVmeVhlTmZvQk5mdHNBc2tzeWczS1U4QXlpM1NJaUUzRU9zNXFE?=
 =?utf-8?B?bWhVb216clFzbnVrcHJTVXJnZTRUQzVJZW5zejF5V1hVMGVDRUhwR0llYk45?=
 =?utf-8?B?T0tUS1BGY0k3ektHcU5YdGgrR0lmY0FyV0pCVmoyTnFpN2UzaFdwN2RyZDJB?=
 =?utf-8?B?eHBPVjc3MVhzMWdyTWVBVjhrNEQ2WHUzS0lwMi9RRDUxRmdGdkt6d1lHVnRl?=
 =?utf-8?B?dCtMclBIUDUvc3RERjRTMXdHMEV6SnNOa09IbDRuSnBEK1Y3Qk5RUDY0VGhE?=
 =?utf-8?B?L01uOTYzT0g2NXgwbXpoSjdNQWRDT0FlUlRGT2F3WDJGQ0trNjZwMzNpRy9Z?=
 =?utf-8?B?b2RDUUNhak4xVk1TU2hZakVlTmFjV1BIcnpkL0NpM1cxOGdVK2FXak93SGM4?=
 =?utf-8?B?b1N5emc4YmVxVFJWNWVyUkZqY2NUa3d2YnZlSUlSc3l3MllWVWxUQVcyUVli?=
 =?utf-8?B?b01OcWxWK1cxdlFVTGVmaGNpRHRuRkNHZk11VkwzZE5xcU1FRWVRazkwMDlL?=
 =?utf-8?B?YWpBbmZ0L3JNSS9XOFRkb1hKUVh2UzlUdmVPRHhUbGZRSDd5dlJwSWZxNDhD?=
 =?utf-8?B?QmprVnZYR2hXOWVxQlJZUzEwaU84SWRRWEIzdUNvOXlmY0Rjdko0OHZlb0lN?=
 =?utf-8?B?ejJRL0crYm9iaUxqQmdyUSs2VTBMc2U5cUdtclM2Vk04SlJDdzQ4YzVwWWtE?=
 =?utf-8?B?RzNSd0hqVS9WN0NlNHBnczVERzZCVVhkQ0VGa0RxQk9PVWlsM2pnQXlFVStn?=
 =?utf-8?B?KzBtNGNrWVlDMnI2M3Rrak1xVWlkVThjR252ZDVaZnhicHhsWkRMTVpYM3Nq?=
 =?utf-8?B?QjVPbmhtc2Z0R3ZkK2lpdkxwOVI2dHl4WndUOXo2MmYyeW1kd3NVbEI5QnFX?=
 =?utf-8?B?ZUJ2dUZGQUcrdUNtYmwzODhBT0sxRGNnckl2Z3lnQzIzNlhRMm42d1ZHQ0xp?=
 =?utf-8?B?ZHF3QUhLUmVCSXdVM1JCbUsxQ3g2em43eS9tKzJTcFZ4QmJpWUFkMHJmMWhD?=
 =?utf-8?B?c1MwTWtFWXBFR0Jyd3VROVdxZ1hwM01SQkVXWERaS05Oa08zTWZrcXdVb1JS?=
 =?utf-8?B?b0NCNVF6STQwci9SbGF2a3I3ZTNiYW5rUmNDajRHejNWcVlVYVpCejUrS1My?=
 =?utf-8?B?V3RCVUZISmVpVzgvK3VYa0doT2UvNjlGWW9YcFd1UXI4cFFGRi8ydk5mbmV5?=
 =?utf-8?B?dmlneDdZaVhXa2J0ZWNRUmVHY1U3Q0IrdDdKemVQV0dpZHhUQlNLQnZyd2Fo?=
 =?utf-8?B?bGkzM0pKbDRmVE9LMHBKbWlVSE1OdHJSMUJ1WjdVRXhtOXZDVDVleG80U0l2?=
 =?utf-8?B?UDB0YWtrQjRyK2tleHpTMUoyRnFnMHFzVzlqdDNxWFJReWV5b1pHR2JZN0Zr?=
 =?utf-8?B?NWFGY0xocXczZFV4Q2d1WjV3L2JUZE1BemZ6MHROd0NPeGd6SU1iQ21ldGNh?=
 =?utf-8?B?dGNIQi9ReDBDR0M1TEh4ZVdsbDZmYmZRamc4T3hXNk40UUtJcFloOWNsNGZu?=
 =?utf-8?B?KzA0ei9WK0lodGJDUWZ5YXYyc3NhaVFQTVQ4N2VueVk1TjRyM2hoVzJIc2VF?=
 =?utf-8?Q?21zI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:yLZ8m3UpzwNp5tj0dmTDxlou9Y6O0Hjq8JeNcjMBe2p1YpBh4S17W+XtRowCOrT9GVEhnlvhdEeYCCGQayf0CgFkdGUGMRwdpZueQBNTRg24v/Sz2A8M3mShU3t7dbhwrSjGxEonV31S3gMZXxFyt3tWwUpsFMIWxxJAAIu3oau44D7ePQQU4Uo3rX9DPbagRmZTN4b33f6cs3XUQruU6Ti6Vld5LFliql6+x6MOuxHOPMuQJ+hyDNxijzXRwaf11vCStkbcOTE+Eiv2e4uH8azU7svRlOI21IS28T6rplZyrkLIS5s/9r9x/rMKJcyjoMtYsu2wWEVNY+763I4IQ5AG5qTxJ1eRlJd/wdJ93DY=;5:9a9RO2ZWKg2jwDWRHEJI/fUBXQyYt9vYL9ZMT0wacLf/ljYLWoc8Tgwi2DlJlc4/H0r3FbA4SCbR5wLf5A8rHO162OAq+xrmk+gfporGNAdorgiCwDiGApJxWJSuN3ikw1bMdZa7GEOgijG/8nRjKsS/3maSjGCOCudT2DFCGjs=;24:qagHOLnX0gR1/7Xs0ML0gmtdv0/ubHv3JGi85sSJ8G/k2bngusJFBCjUaPfzoxZIQWEcqeuK1Lj+uTXeqeq2zpSkdvLMwS91JG8hGjvUeDs=;7:xPa2N5clcZbn9oQ3K++uWFPWAkdoT9mL3o9jQl7ktNQv6s+gjPx2WK8wyj9bchgpVVcbetmVoHRrbaEB4PvA+q8jETS5hnrGEv6ULi/aoIBXxgHIazkSSdJWdWhtXGA8rKXrH6vh1NddoiWyWuWQQHke93R9rY8XgMmtgqISV/1uXR9vq8sGZKiGzhvnpekFw+2qCNYRGJEiSX7rmlL3j7nyXxoWTAYlwM+MLOpUcEmkJ4Uo16ywhjeJ/N9EpKlM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2018 22:34:16.6211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf12cbe-d514-4d50-abb5-08d5548c74ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61942
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

On 01/05/2018 01:36 PM, James Hogan wrote:
> I've been taking on some co-maintainer duties already, so lets make it
> official in the MAINTAINERS file.
> 
> Link: https://lkml.kernel.org/r/33db77a2-32e4-6b2c-d463-9d116ba55623@imgtec.com
> Link: https://lkml.kernel.org/r/20171207110549.GM27409@jhogan-linux.mipstec.com
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: linux-mips@linux-mips.org

This is a really good idea.  I'm not sure what kind of buy-in you need 
from Ralf and/or Linus, but this seems like a very good step towards 
making MIPS maintenance possible during Ralf's occasional absences.


Acked-by: David Daney <david.daney@cavium.com>


> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d3d750b19c0..61bccbd3715f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8983,6 +8983,7 @@ F:	drivers/usb/image/microtek.*
>   
>   MIPS
>   M:	Ralf Baechle <ralf@linux-mips.org>
> +M:	James Hogan <jhogan@kernel.org>
>   L:	linux-mips@linux-mips.org
>   W:	http://www.linux-mips.org/
>   T:	git git://git.linux-mips.org/pub/scm/ralf/linux.git
> 
