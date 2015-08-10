Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2015 23:57:48 +0200 (CEST)
Received: from mail-bn1bon0060.outbound.protection.outlook.com ([157.56.111.60]:52224
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013008AbbHJV5qc0mZ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Aug 2015 23:57:46 +0200
Received: from BLUPR0701MB1714.namprd07.prod.outlook.com (10.163.85.140) by
 BLUPR0701MB2017.namprd07.prod.outlook.com (10.163.122.12) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Mon, 10 Aug 2015 21:57:39 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BLUPR0701MB1714.namprd07.prod.outlook.com (10.163.85.140) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Mon, 10 Aug 2015 21:57:32 +0000
Message-ID: <55C91E48.4010007@caviumnetworks.com>
Date:   Mon, 10 Aug 2015 14:57:28 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     YunQiang Su <wzssyqa@gmail.com>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: what's the status of little endian support of Octeon?
References: <CAKcpw6XSffSzv+5yQMRUaP0FdM-tG444wL75HffstdwLqvfQ9w@mail.gmail.com>
In-Reply-To: <CAKcpw6XSffSzv+5yQMRUaP0FdM-tG444wL75HffstdwLqvfQ9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: DM2PR07CA0027.namprd07.prod.outlook.com (10.141.52.155) To
 BLUPR0701MB1714.namprd07.prod.outlook.com (25.163.85.140)
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1714;2:cAPrkByyqIxLLFw8mSrWfIh41T3rpfOHH5UqXDZA3NdUMvLBOslInD2qNO4NW52xKX6JcRa9GRQcYAcZsx655pmIbVkQd/RPDpJLSxcc4vNJtPMbXt6ypSmJ6TrOGasf+CYvjo7RMuJ0rdHf0JGD8OQ+peCDvDdqtXcD3GBatbY=;3:uWFTDTwggL2VGgMyqkRLrk/Ul0qJgJ7njQ+2Wea2hL7+XaW/8woRGqwnQ4GJacDz49yDkYurB+xeA5M3be1/pc3b1n8Xxdz43rdcXWn+tYJcP8qY4vSkB79ST2+Wq+1N5dWBi3HtuHo7NvjXUjsDUg==;25:Iwen94zIeles1zDLJiuePijkECOODvD46eXyFS93IM0ihw0puN6lN/etzuaejxkDMEnVIo73i/fktW3eLlzrm92XFE+m50wCUx10PkD4QcMK/4NVWzu6uqneyyUa/faiawdn6yh4Chwqds+eAP7AVI3gLChr95Oj8fKd1UXGKb3/BkM+Bni9So8PxHKsReoWx67zKpBWH2y/2cYRuUAeWUD5xh67mcrSS0fPd/WCtib3i48/NyUpFcOfj34FV/iXK4ei/1A911wtYmjjlUbaAg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1714;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB2017;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1714;20:Avn3PQDxP6/AavlJifGGIS0qNTaExmd4S2nHAxtI/YX48kX5VWF16be8r25JQ60ahSXnQba/czV/fCppKta3rz+aIgW94/Oq99yfA88qCcOKCITyFva1lqm8VxG/EU6yqIlHjdN2tBCb+SlM9ECytZ//s/kfwui9LupaCYMLd/uMPVt5Cdr0baKI/bQzph2CPhugFF4FOLUc6UANINa5RYBpAJOyaRFLIcwBfY0QcjBfFRNvH417J+KIbabCfl8xpnLpIE6deOJQWsAxgZ5yd1Cv3FQwJUjrjKlmb9X7XvjjCqR/3jAjMHhkCdgzmz4k4ou7NoHvtW5tn8Ck2XDIxqRUfmL8OJXS8qwp99Sm1vBoC1jMB5k6HzOCHYQlS/ZDGtzCcDdsPyRpEd0pSQ4xUi5XWPFyPEvARe9kdRKiuHMJ4CFByL2HZjZqBLZHNWHtFpGqFLOpaV8mCGtT2P5SrN4T1N3UFofmN5bOpEhjJroPfpQUxJElHU5USFdFKsU7WSIFXh2IZOR2PBPMSEpidxlDnNzrH+uIegWWtYYvccMuREWuNoSK0GY1ARh++jFYb/fukF7HH9rI+Qwgp7bQzXmy4GJz9bnT9QpzEo2Ivqo=;4:Uk4xBZCwDHgm8obwBGoUG6LR1dDYt9jzkbdz0ejl4TGxOEuH9dSoGIjr/R1bBO+ftYI8b0IsJzrpktekZcHjvtmh9BhE8XsLua/TASqjVL9xTTMl6ATUfBENuVYPXMM7KASqMVwwZjIakfxOlI3Kzu7oJrziEQWqYxgro27Al+ycDYBxl/R/soiMIvytNiJ7UpIRcV8YZ9ogTQzBWXD82C/O9qITT2TaLAimW1bE0pmndaWSrbzhTlKTzHFiFkbY2XZaF4+lS6RFgNuyXc/4tfpOeceSiRpHlA0DWZHCoKE=
X-Microsoft-Antispam-PRVS: <BLUPR0701MB1714AE3B1D539BCD115859849A700@BLUPR0701MB1714.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BLUPR0701MB1714;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1714;
X-Forefront-PRVS: 06640999CA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174004)(24454002)(199003)(189002)(377454003)(83506001)(36756003)(53416004)(19580395003)(92566002)(42186005)(65806001)(87976001)(97736004)(65956001)(189998001)(64706001)(2950100001)(4001540100001)(5001860100001)(47776003)(105586002)(5001830100001)(66066001)(81156007)(80316001)(4001350100001)(62966003)(101416001)(106356001)(69596002)(33656002)(64126003)(23676002)(65816999)(77156002)(77096005)(1411001)(5001960100002)(46102003)(110136002)(50466002)(68736005)(50986999)(40100003)(59896002)(54356999)(76176999)(87266999)(122386002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1714;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjA3MDFNQjE3MTQ7MjM6TmFCNlphd2ZkbWJRc0t1bjIyZFVVUWVG?=
 =?utf-8?B?YnJoZWN6Zlh3RjlFVGdpTytVY1Q2SENMamxJTkQxenMzY3dPZmVzNTBPeDFD?=
 =?utf-8?B?MllRY01hSm1wQ1BDSlFsT0hjVDYwWVVoZnlzb1g1emJORTM0L2J4MmxqdXQ1?=
 =?utf-8?B?Sk4rTmVVSzIyUUd1RGgrMHhLem1CdHhOQ1F5bW15ckwzNmltRVc4TGg0bnlI?=
 =?utf-8?B?V0pROEJOWWlqdm45bnpjQlNacWdzM1lZL1MyV0RpRHFRVmNxazBUZlAvNEtN?=
 =?utf-8?B?ZVRnUHRGMXVldG5aZTJWZW5hTmErajNFemU1N25ZdnBjWFZpckNtK0RCejJj?=
 =?utf-8?B?a0pyQWd3d2x3YWhPNHJ0WTY4clR0N1F4NG9BSDNuempMZHd6cWxuSVA3R1FM?=
 =?utf-8?B?OTJLK1p5N3FMVCtEeDZHRWRnM3ZjN0toRUtmbEFWbHZpTExlSXpmck5zVlBa?=
 =?utf-8?B?aE5mVDk2a3J2bHRncExNMWdMTW9RU1NMY0NzaitaVnk0b3RWOEdJVzBXWVZa?=
 =?utf-8?B?YlQ5blROcHpZN1puWURqK05lczk1RmNRM2pFd1Fzcmh4MjY1MTBIRGVmY09C?=
 =?utf-8?B?RHVzU0R1YTdCR1ltUzBwVVpQMmVNRzNhZ0w1L28xMzVOWTlQN1pOSDhEb05o?=
 =?utf-8?B?VnJJQkZRYmhPMVI3eVFvWTdOQVdQSmFXT1hSU21BSzZGS2ZzeCtOMVJ1bDJC?=
 =?utf-8?B?RThWV0lMQlhob1hmQTJySk44L1QvZ3JiWFA4bGdFbjFscnc2QS9pMjdxWDB4?=
 =?utf-8?B?QU1meVBsRkpTK2V6TEdhVGtPb0ZNLzdyZ3djZ0pHZFhlczJCWjFabm9Hd1A5?=
 =?utf-8?B?VEtEK2lZQm9VYVNtVFh5TFlMM3pQcXI4UlFmYVovZnR0M3QvYlY4Y21ldkt6?=
 =?utf-8?B?dnJFSnhNbExDN1IrWFVENmdtSW5nM2pCaTNlN1d3eDd4K05GT0ZnYkRTKys4?=
 =?utf-8?B?d0hIaXBoa0ZqdVhIQXdYeE4rYU0zNGN3bmNQNHhzcmVQMTFOd09WbDV0bk10?=
 =?utf-8?B?SytvM01hVXpvdEpsNFk2OWJ3QlB3TDFvSTVLWlY1MlFwMmlXa0VmSzZTLy9T?=
 =?utf-8?B?V3VyaGhyOVVIN1IyUk1IY0tNTnZMMUhVL3V6LzhvVi80c2NrMFh3cFA3SEEv?=
 =?utf-8?B?QSt3eGNCVk9jTG9vSHB4REhVelFBMzh3cjJ5SXNGa0MveXlrRk52WDdpTDZr?=
 =?utf-8?B?UVFaQk5xbitDT3JESy9FcnZWVHkzK2tOOHhLRkE1K3ZRaEFuby9sQTM0a2E2?=
 =?utf-8?B?VUw2Q2RybUNPVHpNNitWVWlwUUdtN0VyOG5aUVdySzljVnlhdC9WYTViYU9S?=
 =?utf-8?B?NUJKQkFNWTIvME00RWlNamRXL0tha2c4WGh2Rk83aVZFb1dMVG9rRm5zZml4?=
 =?utf-8?B?bi9kZUlBRXl2dkRyUDEvcDNXSlQ3eDRoQ0RtOGtIZ2liWTdHOVErV2FCbXkr?=
 =?utf-8?B?WEZiVExrVDVCenF6SjJmS0lQN3BEL0tkVWFNSjZKVEU3K0RYd2U2dkFQUHQr?=
 =?utf-8?B?R2pQdUd3R1gvSE16S2hzb3I4Nkh2bm1RMU1GMktZOUg4NGJpbzZPMGR1OUVN?=
 =?utf-8?B?eWhDWHVsNjlsekJETFhlSlAzUmh0dnM3SUNFblN6c3BvVVJzaEF1N1cyYkNP?=
 =?utf-8?B?d2dvK24xZmR3emE1VHhtQlhxMG9GN3MyYW9POGZDcUNMOWc1N0hvWlNQdFp1?=
 =?utf-8?B?aGRZZk1HMy94d0FSVjZTUzY0Y3lnVkg5RytqNjdVZG55UVJsanRvMzlmd2hI?=
 =?utf-8?Q?ttPglI+VcWHIVn9H2cscA2NEKmsnhNhx59Ndexw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1714;5:rCyyJyl8IDpcFmWkzPuGHY2Q1/74N0yVkD/hvaAN8u3Dp6OX4p3v97vkPM5lSuid17VgLFuz7BS7JMhlumezajSxNr4sp3DjCxX28woLkLZGYdAKEly6+Up1bvbkyurtvmMAfXF3WoK5LMCgDdOXvg==;24:UGQ4sDXER/xbU1w+gLPcfNqz2lfkOQUWipCCA2MuzQyHIL1SdyTtkDfii3rDA/VVqo6Kx7VBPRacX6J/ZpS7oUy5nwbYFMTnDuHq8XEaCoE=;20:NXOdhBTq3vzMHY5n8QpJLvKd+jgi3UzDZ5CUVsXplZk4YeN6jm8waF2DwbsdmGqGWsoaevXF4b7cJE8pJ1M31A==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2015 21:57:32.2283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1714
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB2017;2:KQzvqUu1L4egECXK1mLt3xe0j6dM6K+xKi2LEus0TTRhU0eQ0yUBR5dtkx9oWupqbTlX1R88sML1/DwqhXDiILGWXQfHIuIhMi4XJtoag+I6OCZ3aJXQFCJQvnCF6El43KI9C+QaW6uqcLz/ctBYhhME+juewYlZEcwNBd/ZL98=;3:Pszitl4X7QsyyjXEoyHr1Sh05NeoxCL13RD2Hbl6dwrlPITDQ+Ra2yUF+qPB6PN4jzZCQxcmupwEmXbqawPMV7XVn1kQ6vSXcxAAtTn/pZwEdsrwvJ3yy5DQAaylrwwItkR5dpfTzm1a3viX5E22Aw==;25:a1thmdIcX4kfrKvxHpNuWytpCOw8Jvnq7NBHsg4OtDIwvFcJ/VNZ1b6fDK1W1SiRNFZCpFfKz1F2WRid16orGyIR21OcnITfvbLXavlYxs/yaSkln/JeHf700NOCZotqdbDdx9lGPcjD4ZhHO7rhqSq0WB4NmxlBDuf8mzdVi4KOKQ30w3VMN+MbQwUTsqG1MP8+7c6efQzGd5GCXkoY/3z01fzYZqKfVKxbY8ImqDlLdo2h+HvXALtlUyVu/pKDUH8tPB/eVP7VcAW6AqjA4w==;23:11DC3rgNTtZNwYccM/uHFspELTX7f02P9QvGOQaoH2kS6UJQqiwlZDjS+zPuu4nJyKD84vnrfJFiyYBBmV04pn6kEJI8TXfSV3kX1o8BDRyWdnJj81dQwCzycl85kwYNK8/of8jUQcfdwGVETArCyWQp19KmglJoecyQ58vNi9jDHN8of2JAYwjVuhVCD9yP0VywUQ2tNlHrtbUsEYvbjwBXxAKbpwxw7deSpgo/v3rr8ELKQogqstKI3ZnECUvj
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48757
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

On 08/10/2015 12:04 PM, YunQiang Su wrote:
> I am wondering about the what the status of Little endian support of
> Octeon in upstream kernel,
> aka Linus tree.
>

I think the kernel.org kernel supports little-endian on OCTEON II and above.


> If not, any plan?
>
> Octeon II:
>         Supported now?
>

I think so.

> Octeon III:
>         Supported now?
>         How about the FPU?

I think so.

Anything that works big-endian, should also work little-endian.

That said, some driver support for OCTEON III may be missing (and OCTEON 
II for that matter).

David Daney
