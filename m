Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2016 21:59:52 +0200 (CEST)
Received: from mail-dm3nam03on0068.outbound.protection.outlook.com ([104.47.41.68]:27386
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991963AbcHWT7p628r2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Aug 2016 21:59:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+583cddNedAtLdk7Pzk7y8t7fxo9RGHj3Gz/KAVcdOk=;
 b=kQwezjtXYoIQApMn6RdL+wC3pGVoGHgCQvJfuK24ITR7i+1GaTD36JTO8YsU7wQagVVOYRRrmUlMFv/54LtB0o80xAAaxu15Zk94Q0YED9bcal0Cu8yK6Kp0CugK776pzgYygf63VkbTK5/LKDvBCNfWXRSKjz0ydqmJNxZT2JU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 SN1PR07MB2143.namprd07.prod.outlook.com (10.164.47.13) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Tue, 23 Aug 2016 19:59:36 +0000
Message-ID: <57BCAB27.8060502@caviumnetworks.com>
Date:   Tue, 23 Aug 2016 12:59:35 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller.
References: <57853474.9050108@cavium.com> <CAPDyKFqaGLWxkG+CqViqDfPqeffKE5rutgR0gduuGs9F0DX+zg@mail.gmail.com> <57BC8ACA.1040506@caviumnetworks.com> <CAPDyKFp047jKEZngegTxk1grvwPivqj+tqAX1ekF82s1zDE53Q@mail.gmail.com>
In-Reply-To: <CAPDyKFp047jKEZngegTxk1grvwPivqj+tqAX1ekF82s1zDE53Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0014.namprd07.prod.outlook.com (10.141.194.152) To
 SN1PR07MB2143.namprd07.prod.outlook.com (10.164.47.13)
X-MS-Office365-Filtering-Correlation-Id: 56e7fb36-2e37-4b19-1a54-08d3cb9002dd
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;2:l84OGHqBq6CUUejl/TI6HlpqlQPLMcK8+Poqj2fK45Eig7YtrHpRinU4M7kqBH385IUQmyr3YnC1qaitO3D1LKjybi20j4Dd06bNlcypyO/RygkoqSIb0OUjjX0WRhNWkkrfGpGUEh2vITfGZDM6ct05v/QAVY71OaEjWGWtm7/tbfjDgpn16Uo1KM2EdCLF;3:Wht1be8on3g6VJblV/f4QJGOkDPHQrZ51fzw6Y8N7oES/ekMCJhFrSv1n2//85F9Eo3bdQZ61Uv/cSRjLzQj8z4zpaFcUxd3T9Bx5lgYdi5Trd9e0uzOSuWxSIlQSdMe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2143;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;25:w7s8f84KLBy2dUn6nhoCChOUnyOaWr+OVvZGdBqkklB7shpRSZMO2zfl16tb+KwhKpNe0Zm1lS6M9R9nY2bIXVaL8Ja1lmiwxsS8nQ9MM/Z9mdyvbkPp4NbzTY+pi/8sBJ1SfPP0qXYtkUnFYkXo4HwcosD8QMnCaSgtvtAwXnbmAC5MNYpvdt/TxfjO5d/dkXaB0St+ADBortOeY/DGh4pX/nFW6vFhesjdrVskXvjPlC3sn9m3eyxwM/6c41mHZQrJ7BqQGqXmYwUPMpYaOdAHBfNsJ3TcBAL+EfYkfjtHS/xiKm4m0Br5mXECNlZq9YDz8ZLzPPw1Xp8ns7bLj+AjUobtx2lHKsg/oPo2oAtj4F0FRcAYrNK2va1KKcwthyVXlYAmtRgBZo9I+5MQewUeyrfUixdcTdL4bhLTLD/jo+0E56QKqZNQ98JHgo4Ud2b0kPbF0wN5hEe8KI0NIe0k3lj40GuN896TRVeby7T89yd2M6z9XPqEbrEHd//mM/7AFJvgm/PakxdDU9ygSm953TYSj93iKZa1eRyiC76uNFrC/QFTVrxs1yREz0DR5qbywg0PSOKHx3ds2hnfXi7KEBINkGCtAA/JI0068pya0Ja7TSyOIcku8iFyD/tE9EqQwmNu6JiE/P4YKbJT8vg/Sn4xz3qU++civckSit1vuz3kNU12im6mADaG6z1gu84xZZHBAYW1ebsCWVcPLRyg+fFKy+Yo+iWvAlJ+yG8=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;31:aIumuz5QcjHMhZ0mSrUCJ+7N0MzSsTCWHu1WXA9Zv2u6p+/xkgvDwtKcmpzFuGAg7/nZhlU3ZGZswvsr3VZSB27AYhTB2Z+Jl1hQrvyNXteri3yVZYS9Sbb4qlns2VNF+YotHlq8dlK7ixL+p90EydNCjmb1ULbY7KaOzN1ws9Ko2OIISjGJlb5jz4U6P2oZA40nDE1bkTYuBZeGcRH/K3aR9KeKv2UdykmnyLcMX5g=;20:dmhSX/4DOiks3gz/TBey0GzwFEtIf/eyrOsoRThDXITOFansAxmcRf06+cOmShz6S+DhjlyEw3pKWfWf4WrU5WAysaGN3MlbnEKrlLx6UOtikeod6rXjXw2Nl1hMniop77pjSUstx1A+1Nf8yN6LTSQiF6EvgR0wcEUl6qPAuvWpAM0DjhiodVoc9w06nT3IfWSBCHFSMcKfMMxENaf/l3mVgcTD8p47Q7t3pIhvWFQOBmALEm+7ENczDtNM6mK+Q09kh/jsFslR72xR1nDGbg4uJzGdXUlr9hYCnNwS6VPXwkgeHze6AQZaxChnqDMPsn+XLbWM2rA6ReewlNDtfJ3EZiEmPE6zdu87B0NM0Mw/rvO4Y+4+qASpGA9juJ5ANQdM3xmnI3BXkZ7vYi26w8wjVz54qAMlMJ21H8edjljdbH95q7ybVcUaQUA+VTjtbg1C9jPqpamnNw0Z1PybT8m0SBrynKHxVfOKpuY6A3xJqzs3WGwLNWYKsNSPo2KkCqKfW12GhlgQpG3yCL5dfZB9XdU8OBhUuesZaTshvgVL9ffqf5Tgy3q8I9gW8jdcSZy4IJ4MzM8PkeLBenZonI1y8IDSs3AyWPLChfGhtAA=
X-Microsoft-Antispam-PRVS: <SN1PR07MB21433C00AA59390F38E52DB197EB0@SN1PR07MB2143.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:SN1PR07MB2143;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2143;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;4:ci0PUFhvesdQ6JUOkwjeNi7qXd4z8HJ6l6XdxABth2ZHuh+23E6d/eLjN9rll7eSHNYeMDra8t/DWwdKtwWTUWkRDv31dYsxVnmvUghjeI5XdgRToj0h7Jn2bqCa/zU7/tS+02381ZG4bJPEWdYE41CmxMruDxNQaNYGemhR1m1tuFuiSSBVyuAaQRUfM5Iq1lP/UIZcCLoxDgw0Y3D/jrRaeNoUQu+4y1jvyGa9WAT9zdpgjw+k1UcVBcvTxF0tKa9e1qVbMY2/5q2/rjqqOVfeMV7WXvQXWfB7c2OsqrDcz0pB+YrUNkz7mpH7ts+F7K8f5FIqjATB/UkwRN0RWH4qGKVLcpIotWEME418T4bbhbeuolkDTeI0orLTxxiaKSySiWz/HgD1+YfPKEwfSg==
X-Forefront-PRVS: 004395A01C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(377454003)(24454002)(189002)(4326007)(80316001)(42186005)(2906002)(59896002)(83506001)(230700001)(69596002)(4001350100001)(33656002)(65816999)(92566002)(19580395003)(101416001)(7846002)(7736002)(53416004)(6116002)(305945005)(19580405001)(586003)(3846002)(5660300001)(50986999)(87266999)(76176999)(54356999)(81166006)(81156014)(8676002)(64126003)(23676002)(50466002)(36756003)(110136002)(66066001)(105586002)(106356001)(2950100001)(77096005)(65806001)(65956001)(97736004)(93886004)(68736007)(47776003)(189998001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2143;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjA3TUIyMTQzOzIzOnE1cG9WdGJ3YWpsRkIxMUpqOWI4YVhXUjYz?=
 =?utf-8?B?NTB2LzJyNU5FNlJNVlJFaHVDOGVUSTQ5cXJ2dThFYUNvL1gvZUhXTEMxNXNR?=
 =?utf-8?B?TWZMVGNvTWVDalRPTHQ2MDN0NE1mOGREZTY4aU45T0M5SnJFRGVvUXlOazRI?=
 =?utf-8?B?Rk44d0VYVzRMd3hrdTlDOTlTRm9WR2szT0tZZTE3QW1uNGVDYWNzU3AvRk9Q?=
 =?utf-8?B?T0ZTSkZuWUZiUTB2Wlh5R25pdnUxOVkvWWoxVnJoTUlLdHpIT3VXWG5WYndO?=
 =?utf-8?B?WSs5VWhFeGZPMVYwL3dzQ2IrSzFadHBoV2pCcXBrVThFN1lBSXNpaExUS2sz?=
 =?utf-8?B?Z0ZxMkFYMlNYNUg4bTArMkV4Sk1tS1pSVUVPdnFvT1NzMHZYQzB3cXBjMFJ1?=
 =?utf-8?B?QXl5L1ZEVlRRM0VtRGQyVEZVZFVsQ3huVXB0NGsrTHZHSGZDbFVWMlFvSVNn?=
 =?utf-8?B?V3Z3bE5RbzRzS2s3aFQwa0lmTXYyWUdoZ3VwQ3MxdW5IcFFLck1ReFBPaCtQ?=
 =?utf-8?B?cEFvcFhmYnJvT250clplMU9nL29XQjRSR3pvUnMzZXhiU005OG9BekJzeWRz?=
 =?utf-8?B?dm5pNlhGQitONm5oMElLclMrUkdVOHg1c2VYTnIxTHBwa0xQRmxSYTVTUmcv?=
 =?utf-8?B?b0RmZFRKS0xHRElkOFZLbDVSeFVSZ0Q2TGQyVExiWklaS2U4aDh6b2hSdFdO?=
 =?utf-8?B?UGxsUGNLQXV4YnlrQjRKWHV6YnJ3UFhzeFQ3Y2d2SGtGTG1jTHozZEpOTHhJ?=
 =?utf-8?B?dVVhbzN4dmZkTFNMQVNMTnJKTGlMZGMzbkxxOFNuamo3UllOeGlGcDJNL2JN?=
 =?utf-8?B?U0JIVUV1eHUvVllIRUFmd0pYWml0Q0k2L2JhSzQrNTZ2T2ZENnNnUFdhSC9F?=
 =?utf-8?B?MTJETEN6QXpTcG5vMkd6ckd1d0xrME8wU1h1M3czQjVQdFR4WTJhanNQTDBU?=
 =?utf-8?B?aTBEbmhOMVZKUm1pbFBCVHJ0YjQ1eWIzSFJ6ZVlRdDcwVUxFa01XeFJ3RDBq?=
 =?utf-8?B?SmxGTFhvZm5Vazl0eWFMOWxKaDgrSEY4UFpCL21VaFRZdU1wVzdYZkNrSERl?=
 =?utf-8?B?aVZlWU94N2JtVTU4bCtjTndKcSt0RUZudmIya08wMHBleURvM3RCb1BEenAy?=
 =?utf-8?B?SzBRSVlGQzRxemlQck9VWmlGVjBhSUdRaWY0OGdjYzBoMHBDNDVHY0Ftamds?=
 =?utf-8?B?c0JIZ0FiSGFVcDAyL3pTYXJ2RGRLcWJmYmFKMDhNbzZUckVXU0NGdVNDZTJq?=
 =?utf-8?B?NFNSRytiaUpweVcxU2tMTHpQNm5DeWt1bDFabUs3dWxjUUJyTTIrSW9Cekdt?=
 =?utf-8?B?NFQ4dCtkOVhMNzZzV09NbkMzL3pxTERiN0xyOGFRV1puYXJ5eFFvWWozVmZo?=
 =?utf-8?B?eHpLTC9sSUZnSnVna256aHcrZU5oQ1lkWVNOVlNTM0tLSWl2TkZkc0Nyb0hz?=
 =?utf-8?B?QjZZR2xTMmpyLzl1Y0JYVXJYbmYrNnFMT29zNUFVNEJUV2RFSlZNVnp3eDVD?=
 =?utf-8?B?dk9IMjBvck9rTEhRZ2NsbmpIeStOcWVzSzBNN2d3bVJlN1JyN3FsUk5XckVG?=
 =?utf-8?B?R0thZ2k5aWFOR3VqMVgxNklHcS9iQ3VSUHVCK2RldXROTUNmSmhQWHRPVml1?=
 =?utf-8?B?eVd1L0ZNZ1pGZTdJQmxZcFR4Y3dQMW1FNXRkcEZjKzZtYXhvRlJPOFAxTTJk?=
 =?utf-8?B?TW9JRDBBcXBnMXlKc1AwenRRU2VGaEVVTm1pb1lzSDkwaitOdmZuRFJ0akRx?=
 =?utf-8?B?YzZwNEF1WGJ1NTdtK0ZyUWxqb1pkWVpSUktjWW5MYnpFNkxKcGl0M3Qzd2hR?=
 =?utf-8?B?bFJIY0Q3T25YT0hvMGMzVklTSUlSbG1RcVdXRkFVMCtLa2c9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;6:McTw8bIdbtoWBs82iyGhE9mYB53qauqbZA2p81EZn55yB+4Mf0v5IqwD9qr7ut+GgfXF+vdvkE2g+DgLNYVLgtYkNPVjdiYXBvHH/RqVHbEMwM/0Zc3WDV3PKsXqyIe3qsdF0QAeVPlZ7PeZld31IOFUbMfVemtlTHUwKFM/ikczi1IJ1kJziON1vZFsbe/oIatwmMLt0BlOjmVwb6cJGNPVmoHgSFIRCIeo1Ue7w9YoVe+13C+E6BB4LXKUhZCoka5lOWMbT6h0OkE1AS57ZC+SSBUiyU9rOr74ZfloQeo=;5:NSQ3XFu5j4GlxgfES1/isipx+0bENW4qYOUj4QnW/IQneytpy0EmGFuUZd4Ryl4G8dlShMEkBsJ7szfeb33lNZIhwZyBuKIYVSWnuUlU7tTLBFvysMu5kQLf2+E68Ue0Nsb+uCH09zEOPcddxHdL/g==;24:YUWmEgq63pB5U7pCicDGAEn/wIv3BbGCm+z2C2tPyuHW8Sumn4kuKLa+diS6ZeXgCRbATEnaYbt4cYn7wQTQp1IVsIxLj6mY8ctOJPd04eQ=;7:Ihn+LlbOw5JVpH6ipXS/LWH1y2UegJGCXpn1eUmy4DSvJfFHOE8FItb4GN71NrBuxL1nyc4LYzLDGU3mx+NCYNWFg8lKfAyyJ+yPLzKk6OOblqWGKnn4srCx/FLIqtfovRarT5Pu978mB2eW3GGgOSAOkl0DiJU2XZgaKlSxqxOAIm7YQni3XLEX6NEld0brfbToqsakmPQT/E2SPcwZgZ4Dheq3SEvaFwQ9tls5SsNsInOrh9wJ+kSogwIcbMPl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2016 19:59:36.5989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2143
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54736
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

On 08/23/2016 12:46 PM, Ulf Hansson wrote:
> On 23 August 2016 at 19:41, David Daney <ddaney@caviumnetworks.com> wrote:
>> On 08/23/2016 07:53 AM, Ulf Hansson wrote:
>>>
>>> On 12 July 2016 at 20:18, Steven J. Hill <steven.hill@cavium.com> wrote:
>>
>> [...]
>>
>>>> +#include <asm/byteorder.h>
>>>> +#include <asm/octeon/octeon.h>
>>>
>>>
>>
>> OK, we will duplicate any needed definitions from octeon.h into the driver
>> source file.
>
> Why can't you share it via a platfrom data header at
> include/linux/platform_data/* ?
>

It isn't "platform_data", it is register layout definitions (thousands 
of lines of them), so I don't think it it appropriate to place in 
include/linux.

I think the cleanest approach is to put the register definitions in the 
driver file, which is the only user, and delete the definition header 
files in arch/mips/include/...

David.
