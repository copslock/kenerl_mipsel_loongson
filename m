Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 09:32:02 +0100 (CET)
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:53949
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993061AbeAZIbggVwg0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Jan 2018 09:31:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=891c4II5b94BJKfnu2/vKgaBUp9aCmGG8MV0CpEyz+U=;
 b=LJHdl5hiBiZzyE0Fhl1+zxV6Gcm0T2ECB9UNwV4HQEy+TSm/OVGdaDal/vFnAOrfhiqN+3tSd6soetTLxw4kxu8yP7WuvQ7NlSiAeOn8ll6xf1ctsHJVP9yj4TWVr0WMWNB5XxSGz2VuhwWl+LALXScYVKUGMc439CLYBrkZXLI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.40] (50.83.62.27) by
 MWHPR07MB3615.namprd07.prod.outlook.com (10.164.192.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.444.14; Fri, 26 Jan 2018 08:31:25 +0000
Subject: Re: [PATCH RFC 0/6] MIPS: Broadcom eXtended KSEG0/1 support
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
References: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <47412287-76d7-3e39-5110-717a498e00a3@cavium.com>
Date:   Fri, 26 Jan 2018 02:31:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: DM5PR04CA0062.namprd04.prod.outlook.com (10.172.183.152) To
 MWHPR07MB3615.namprd07.prod.outlook.com (10.164.192.156)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ae97eed-77ec-4d5f-bb68-08d5649730a9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR07MB3615;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3615;3:YO4ouh7Dq9JKxswtIe4LzlLogbigHtO3cf987F1xOcYJ35I/0y4n0v/SnGMceckwhAbbXZcaSt9VRuSxUbK5VyPAyYXa8hEcYMppJhOgG4avPJRkM45kjgGu5wFyCHo8CgW7RuU2WZ6qVrg4FZG5B7hgFZXxnfJ+GWOed0ikhQWn8rIrt8bnCwvsgx6/64bDSuD/W5Vg2cIaxTTgQTtdA+bx0mspG/xP5nVLRrti/XkNgEmM9/FHs07buAqponLM;25:rk1UNh/DjsKbpRDT7NCEH+xaWjknbg9kOyzmxL5XvE99B9frSVMy56skIh+nS0NOK0/L1ge3Qsd/sCqY2gY3d6hiboPCA1CFiMkHUJHcauCrP8N6bMgsjZAkwksnmuJovOpWtJPYbgc3VJK3c8xAnnwcz+8ZDgyOM8CbRZpF3oUBp80bvtPDdwcUn6YaGoCQoPTmNg66JSUFB54C+3EIcU32iwwjJd0a4KAr8DmBQptg69cItLF0huM7WgZAucQ4BDM0nH+CEltkweM6eqsz89lMnclGoC+ZtvxDyS/iG4gatu7XGh99V/4v7tNWH/fcxKXYGlo25wT0ZeTJ22U5ng==;31:kpAv1x287yoyD9sW+HpIbUEMlvhxLxS6OPpHVBmjOOh69K5x1XygyJy70glCfzB7emUtHh3xEMJ9ZmJzoNeLL8pnGZ0xcFOKa6WzrSO4+3flUdYw8qqJtdl0lR+nrIdWTkvRwNLMKIEfhmBAXLLYki+lIMDh8Ecce+OXAfnHFALUotGu6PE94n5OoYjNDKlW3c0QEqD84TGIJUTxv1qvXaO5ugpXeun9Ql31HhOKmkI=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3615:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3615;20:s+n7VspVxdmK1NxVgRg6RGBd/wFfftYtqbDQCD2z4hIbOVx74s7EJxFBW+ZyiaAm9wA673EhwbvJvNM3pG6XxNhJhZP1v9zcPxfpp52Hspan75W5w4hcacfjUW6Cc4W19H0P/TCiwqvx0sfXNyGAXh6XGUwA8V0cHlapW2khzNCxSDgjGnT8xq4gMDyd6KhNdETmaLmVb22Y2l9S2oTk4ENHPcPFmvvxkLjX3ZzgoUtwwCGA7LPPGP7WcQAQ1CFSntNTaRCxzut/SeTYjgGgeqlIMfCYoTcXFN29ifqVhWNvOtbM3ybMTgDDwt/SoqzHoMyrK+vMIGDxZb4ZQBifad12XVeTAoqWmJHnZdio4Sv/R15R9tdUnHu/L0yMony8pGrBZ8GvypZk5ebhGZ40gnYjGkYFWldNA+gbDuZeG/2f4Vecb+94YPwuVFIiLiXRDHlz8tyD53WyD6/yNGNiCpmpUgg7AoaAJ8y9IFJPmsBhbvgawVNwD5QekAMmcsFg;4:ymLa5OkNViqJcN6Aa6q0n/78sT8gZPxe59ulyfuGOhCpu1FvWJXbRjsarSzJmn8zcNmgknYVM4GRjUaEANjG2RPfDBtBIlUxP/JWmBMpKOc46FCRMPFZsbI9ao6zWNxfz2sv+N5CRTEzqO3AiWXOYpA/moVUg5pFnlyHE4r59prRemFmcgI5/oxSIMNr5qU+Uac0vrJ6/zJb6bSuL79XcuD1d0j6pQyfW0FBcD/9WlY+tlGWIfdANrmqZy/1jG9jiXgMR1+CwjXiw9vcTzzGRw==
X-Microsoft-Antispam-PRVS: <MWHPR07MB361518ECFB537D84E393A9EE80E00@MWHPR07MB3615.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231023)(2400081)(944501161)(93006095)(93001095)(6041288)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR07MB3615;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3615;
X-Forefront-PRVS: 05641FD966
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(39850400004)(396003)(346002)(376002)(199004)(189003)(8676002)(81156014)(47776003)(81166006)(8936002)(39060400002)(478600001)(65956001)(2486003)(53546011)(386003)(52116002)(76176011)(66066001)(106356001)(7736002)(230700001)(31696002)(23676004)(16526019)(52146003)(72206003)(86362001)(107886003)(90366009)(6486002)(53936002)(305945005)(229853002)(65806001)(105586002)(64126003)(36756003)(50466002)(68736007)(6116002)(6246003)(31686004)(4326008)(3846002)(65826007)(77096007)(2906002)(83506002)(26005)(25786009)(54906003)(16576012)(316002)(5660300001)(97736004)(58126008)(2950100002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3615;H:[10.0.0.40];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNjE1OzIzOml4cGQ4WUhpRWE2b1FZKy9tamxQV0ZKcXVq?=
 =?utf-8?B?UGR3dTBXMXpQSnRQQ2c3azhlY3FwbXdZY0tDZWdaVFc3dkZtcmZHclRlTlBx?=
 =?utf-8?B?MUw2dE9sT1FGNWpJSUxMNWxYWCt4ZUZzWEZUaHpjUEVCcS9JTjhyU09GNnZq?=
 =?utf-8?B?N0c0RUgveVBXUVoxZ1pqVFFhZkFBeGNqNm50cFlLYVVvV2Q3NnBWUlo5a1VR?=
 =?utf-8?B?YVpMT1RqS1R0TkowQ0hCRHExS2hVcjhqc2ZoRnJ5Y1lmakR0Qks4cWtiODJa?=
 =?utf-8?B?Zy8wNnJFNFVUTHp0MFVoNHpLN1lzWkNueFBmcHF0M2xnc1BmNWlCK2ZDM3l0?=
 =?utf-8?B?Tk5lQ0xkUW82VUhqaVhsOGQ3NWVObm9iRnliMytyREpzTVFwY0JxTWpzWGdF?=
 =?utf-8?B?R2dJaFdPTER2Mm5xYW56RytKcjlBS2FyV0tiSDFKek1TeFFlS0RQNm9XOFll?=
 =?utf-8?B?a0dFajVNV1krMWZrY3d2blJjZnhFNjhrUmNuOXVnelNkWVZyVVV6VndnRW9U?=
 =?utf-8?B?UWR2eG1oOXpLQk1UM0hSNzNwTis2c2NEUTZURGsxMkRGMmt2Wm9lN1E1emQ0?=
 =?utf-8?B?V04ybExVS2Y1U0JrRDZXK3FIdUhmTUtoSXU2RXpRdzZkcndoQUpsQ2hXVUFY?=
 =?utf-8?B?N0VCMWxjUmtMWmFKTzNmQXlKbnpsbmdMSGNSNTYrajV0VXZneEoyc0o5MlZp?=
 =?utf-8?B?aFJLWFhZUHhOSEFRKzM3cU04ZlFONk1PZWpGQ2MxdUxWOXlGL2wwMXBlZHUz?=
 =?utf-8?B?THM5UHVNdVVENElCUjc1cUROYnozS1RmeDBPWm01R2IvRkR0TlV3eXBSVFRX?=
 =?utf-8?B?bTF4Y3JFSTFlWk9zZk9hZGc4L0tDOVFPL3RuWVE5NGNWc1QrT3lsUW5WUWJW?=
 =?utf-8?B?dXY3bHU2aXNxQ09qT3YwdGgrV0VKblV2Ynl6ak8yeUptR2pzaXorN1dUNjVn?=
 =?utf-8?B?QXlWaXhSQXUvK0NUWC9acjQxUkFIT3A4YmRyS3lYVHZEekcyQzhqYklaNmZI?=
 =?utf-8?B?Ry9hekl2Z1NtT2ZRcU12Q0R0cTZTWkNvVnpna2dMSHFLQU1mY3k4M21EdnM3?=
 =?utf-8?B?MW9scWMyUkxrN3pzZmF5TjJXSTJkU1lRRHNSNEZFV050UFhVRmRaNW5Takhx?=
 =?utf-8?B?dGtDWGQ4NEJlUGdTTjYwcGliaTYxUWxtWkIwZHdKZ2w5NnB3NENEckFsVm9C?=
 =?utf-8?B?Rld3Qjh3TXdjTzVWSEVIS3dJWDZNVXBjbSt1RXhFdFVxditKOU5MSmpmMnhF?=
 =?utf-8?B?MUMyVHhNR29pd1FncGZJY0tLWUQ0WnJad0UwVFdNa3hsNFYxV1Npd25KRDFt?=
 =?utf-8?B?djZ1bW1OY1UvTzM0ZkltQVRnUGo2R0dwOHlVeGdpQ0hxcTlVbGFIOU9HTEJa?=
 =?utf-8?B?QnFFOHpSRC9YMGk4SGQ5NEcwV1IvR3J1K2VVbXNiWEFmTVB2UGYzcjBnVmhJ?=
 =?utf-8?B?V0ZweHZoblpWcHhlRzBMSHoxSEdUbXNCeUFoZW5VVm9CNDArSk1YZVFnd01a?=
 =?utf-8?B?b093dkdBZ2M1cUJJUnBEQWQwMkE2am9jalIxVW9aUXNBT0t1TlhpaW9Jc2ZS?=
 =?utf-8?B?TWxUZHdoSVRuaGxtdFl2UEZkMVBwZHlRNENqaGlZc0FHUStKc1lHWFoydGF5?=
 =?utf-8?B?N0RZdThRanBWZlZOcVU2elRsTFBXc0p0UDAzODJEaGJpdXkvczcza0Q3MUdS?=
 =?utf-8?B?Umw1YlljUjdHQVMvaTlQaXhmUFVvRkNoRzVqTTFnRXZOU3lNK3c1TmdXNTdr?=
 =?utf-8?B?MlhvRTlheEdkbXhHREZtK3ZudndCSXN4NGpRclVkbXE4N2V5andvKzkrdWpO?=
 =?utf-8?B?T2hmaXNOZTdCdkVTa2dVb09QNmNwRjRwV1ZLenhjRHYrdm1QYk0vY01TUXIw?=
 =?utf-8?B?NEs0WTJBLzg0eWdVVm5XWWpsTStCdCt5K1FkalhlMmgvNlNYTndMMzM1NURQ?=
 =?utf-8?Q?NR285pl6n9V4iYbEQ2sSZxSYEyl+7s=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3615;6:NUZJqVMmwiWFWrCmLfSCVmlrybMqBx2tiQMSB85Tnkw+0R3hsI0NO90M2mLpEBl+wmRPpl6HJCy7dqr+6SIhpBlRi+nbIlmvMBmuqKA8ZunEDg1KxA8QM8uNo3A7JBFOddEEO/bBUandn9xUdBA5OQAiHa5QCTFbsAxFdUkyEMCRj23k5pkixO4jzZMSywoVtClei6pJfdyXbfmvhKS2ASlfiD9KP5PHtOWn7nQSPby3o7CTTZD41BRRYUKZKgopdUHrPf/bgpXpVpG7ohySQPpw4qZ2ewq9g+jhNA9YAYVpSjDejwYJfVs+ay4fHRx4iB/j83XLt23F7hR0P+pYb3SGC8yV189MPCdVuoncg0M=;5:/KPY1Xpod/M2E+aaUdc6f2GqmhnGXRDzBsSxn7k0shxVckvjYyRrjxBTRBlRAEuJHSxiY2HeNUIWYcpmalBs0ZT39Sv/d6q/J3H8b7WN8muKMKGT0Wa6kvBkv70mvrNl+2vEfF+Wb4zm6U2wKakGd7A16eW4fn71UxtbBDc7IRM=;24:y4wyHHYjJ9sxQRsf8hinxixXsTeOpyzQdnUnMuMDyraTqS9fm9nwhVQBxP6YPKHebsMlG3XXNKuFwu3ciBaiBl52toHfQv6ww2SfE7CNeFQ=;7:PMUbkclMpN37DX1RXySVk+OaDu/7d8YW2sLCLcxUzO2maV2dOvBKCU+9kNEkWENcYnDm/VqpWD7wC3hYFPMTVWIO2lUVkHjBkdXHB6E7Rh1tUftPqb5Vd2UPAd8fAjHa39T6+wGGJxVljmwBqkDAB75uu7CvjbOwu+lCC8xZUQi9PWLMhqRx+e0mSHBl70gvOCK6K9dt3Wg0gulSkknid86DgamuiMZ5CbKI7QgcpF0v0i3ayb4Z4kZe7DAgPTfj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2018 08:31:25.6281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae97eed-77ec-4d5f-bb68-08d5649730a9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3615
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 01/23/2018 07:47 PM, Florian Fainelli wrote:

[...]

> 
> Florian Fainelli (6):
>   MIPS: Allow board to override TLB initialization
>   MIPS: Allow platforms to override mapping/unmapping coherent
>   MIPS: BMIPS: Avoid referencing CKSEG1
>   MIPS: Prepare for supporting eXtended KSEG0/1
>   MIPS: BMIPS: Handshake with CFE
>   MIPS: BMIPS: Add support for eXtended KSEG0/1 (XKS01)
> 
I have tested these with your previous "MIPS: generic dma-coherence
inclusion" patchset on our Octeon III platforms with PCIe and saw
no issues. Thanks.

Steve


Tested-by: Steven J. Hill <steven.hill@cavium.com>
