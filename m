Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 02:38:04 +0200 (CEST)
Received: from mail-by2on0064.outbound.protection.outlook.com ([207.46.100.64]:31584
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012601AbbHFAiCwDpux (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Aug 2015 02:38:02 +0200
Received: from BN3PR0701MB1719.namprd07.prod.outlook.com (10.163.39.18) by
 BN3PR0701MB1345.namprd07.prod.outlook.com (10.160.118.17) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Thu, 6 Aug 2015 00:37:54 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1719.namprd07.prod.outlook.com (10.163.39.18) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Thu, 6 Aug 2015 00:37:50 +0000
Message-ID: <55C2AC5B.50408@caviumnetworks.com>
Date:   Wed, 5 Aug 2015 17:37:47 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Paul Burton <paul.burton@imgtec.com>, <daniel.sanders@imgtec.com>,
        <linux-mips@linux-mips.org>, <cernekee@gmail.com>,
        <Zubair.Kakakhel@imgtec.com>, <geert+renesas@glider.be>,
        <david.daney@cavium.com>, <peterz@infradead.org>,
        <heiko.carstens@de.ibm.com>, <paul.gortmaker@windriver.com>,
        <behanw@converseincode.com>, <macro@linux-mips.org>,
        <cl@linux.com>, <pkarat@mvista.com>, <linux@roeck-us.net>,
        <tkhai@yandex.ru>, <james.hogan@imgtec.com>,
        <alexinbeijing@gmail.com>, <rusty@rustcorp.com.au>,
        <Steven.Hill@imgtec.com>, <lars.persson@axis.com>,
        <aleksey.makarov@auriga.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <luto@amacapital.net>,
        <dahi@linux.vnet.ibm.com>, <markos.chandras@imgtec.com>,
        <eunb.song@samsung.com>, <kumba@gentoo.org>
Subject: Re: [PATCH v4 3/3] MIPS: set stack/data protection as non-executable
References: <20150805234348.20722.71740.stgit@ubuntu-yegoshin> <20150805234936.20722.60927.stgit@ubuntu-yegoshin> <20150805235543.GG2057@NP-P-BURTON> <55C2A50A.50805@imgtec.com> <55C2A6FE.1020003@caviumnetworks.com> <55C2A91B.1090704@imgtec.com>
In-Reply-To: <55C2A91B.1090704@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BY2PR07CA046.namprd07.prod.outlook.com (10.141.251.21) To
 BN3PR0701MB1719.namprd07.prod.outlook.com (25.163.39.18)
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;2:8a/KMQr6dUnyI14fH3iU2euIElnetAQF0wxVvRxUBX22GbK7UytlFQa/WAml/vMMwo8m/pfywTs0K06dreDvSp/WC13nTy0yejylXC+WmP9e21oTy3LqpPGWugwXOCylZbRcc4A7gsAo1iAyNvduyDqmkGbrjk7LOKiKSAQEx7o=;3:7qEyaSW1FdBffJxjPZCl3dABlYN2Wu/XJU51a8HTCPCZN8H8R79mioSdpMf12qlME2U+dHxiD2s1HGY2RmyIGgZ5BBmXe9OQAYcyQ0a5M04wUw5U8ARbOczqnyp5Pz57sj2SjFqQ168sk24YdPGzbw==;25:9To2+bvqaMBaC3Ws09a16DajbTEfTRpIOxbgsZiDa9m0aw0Y/QqOI/IjcI4zIum/Nsl4s5mX9BQz9fYHHbL/m4ab7yoHgO6tUk/ZGOaPaGNFzYGUHcG8u31OoxTbjU6Kmd0s7lIVFgCRmK53gLgXyKtAGZ9YjdIoZqXx8Q5WHFer4bspw77Mrg508IUH5SHA2l/L3oTtvTWOE/nyMVuvVMXBf572BXfBV7OwAXnitKga59KRfC5yEko3JSlb3adpCwzJdR2d8hNq23BM79/1Cg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1345;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;20:c2du+10QEw19OI2Jxv6+D3BKBqe3izxUVM/Msbz467iUsWEjy1ClqV3gcrh0Jq8ipz06OMHZbhK5R4At3w8gKt/zaN9UqNqrYno0rwZmqwn8xW3cu92f15xDI1yW+qPLLOudxHgFpnAlKPPZuXzsoA3cJgXnbMKm7tKK+xdoeR8DzaNJzzp/G2mEZP0b6D5ID1QBV7Q9eOt8wezIw6l3w/kgIJRohLt54Y2YYadkHJnEBNW7yaGMKVlP5nqG2J8+f/3n2KEvYF+K809iw2fvb7D1zGAwIqH//QgLWCJAlJe8FcaWgVvYkKD3Wtn4WWy56njQ9bmlpOTIxtDlHDtz44O0nRAxzcKTnW/IDWTMz8S/GnIibaPjG91M5fC7YAbczng9/s/3Dg5sfrxAt+egvFIgYJWZ8gCasifSSbMA6/U6/eZFlmz9il9yVPGeKjGxCfgcW5T7TcHeATpsEqtRquknn56YeupZtXgQpnjyRScX8KzVDjD08Wp+mgLMBbzWT+o/pZhuvbZd8n9T1wK1cRAy4dVi5elBbP3XH3s7sL+Gu1ZqK+CSaG5zmCcwW/4q16Drkv3ZU5/GCAaNXSXGJ8KKGDw9m+bdhrPYC1rAzf0=;4:32AvwPQ+uT41AUlaj7kDz3e1vNOjkqMcwVpOlJvptiSMPmQeS9tDIJ+Q1S0tnJ8c+3qsAYFir7YHkrAfJL8tk3TJrlKjxyTC4i9Uv4HRekrXGStVKVfovh/TXMxxZnNPbXU0pyUaFEyuYciVCVdYfO4eojQ9qo5QJ0wqlqAHdCOGoF/Tz1J7CNp4rT9OaBQhINeg3r13areozEPDjPZAPOWqBjTq8a0FRyxBLF8a8O3BfQpfCVd9k/lWoyp4xhh0A9qWi8TUMkmY38MJYvKgZprGl/MDcb4y2BJORcSwKfY=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1719345195090C76007096FA9A740@BN3PR0701MB1719.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN3PR0701MB1719;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(377454003)(479174004)(199003)(189002)(76176999)(50986999)(101416001)(54356999)(77096005)(68736005)(65816999)(92566002)(40100003)(62966003)(69596002)(77156002)(122386002)(65806001)(64126003)(83506001)(2950100001)(93886004)(47776003)(64706001)(65956001)(66066001)(33656002)(23676002)(5001860100001)(5001830100001)(5001960100002)(110136002)(97736004)(4001350100001)(19580395003)(81156007)(4001540100001)(189998001)(53416004)(42186005)(46102003)(50466002)(106356001)(36756003)(87976001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1719;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjA3MDFNQjE3MTk7MjM6SklqbU5PbXVKQkhFL0ZNZGVHd2xIUEdI?=
 =?utf-8?B?RHlwSDFTUE5lT08vcXdpcWhUVWg1UnVOVWV0SlU5YzVEWk1QZ1pwQzFrRjk2?=
 =?utf-8?B?RmZJQmJoSXM1ZjJPTTVhZXRSa2xobVZFYWJoTitnb3FJc1NjbGFRNDFlQnhZ?=
 =?utf-8?B?SGhEV0ZlRkRMUlVHVUJtV0s3MjYvSktSK3pId3ZEUHBzdXZXazBxZjJ4RnJI?=
 =?utf-8?B?TlN3NXZQK3E5a3pBa1BJbXVsdWZ5MTZLTWdPaFAvQW9JMkh4c0pJWm9oOC9u?=
 =?utf-8?B?VG9NT0hxRFZIbzhsNjV4V3paWENCL3pKTXRhK1Q0UXBiaWdHbHNGbGE4Zit4?=
 =?utf-8?B?VzBnZ2tjL0dwVE9rZmhuaVlFNkNTR3EyZTl0akxwV04wSnpzY0MwWTNWTzND?=
 =?utf-8?B?SVRFVHBsbzk4U1JwbHdDSkdWOWNxL0FwSlJPR2xjRGJMNE1Yc3V4TDNuWEdI?=
 =?utf-8?B?aFhCeFVYNWJWRzFXNFZQWUl5NGFBUUdHYXdDVDRhYnFqSURNekp3OS81TVNE?=
 =?utf-8?B?N2gyRHhjSnpxNWh2Zm1LOXVDU2xZRmI5WnJtTXZCZ2EzQ2tvVGpYc0pXS0Za?=
 =?utf-8?B?VXBOYTdEUnlzUW01QnhIWitubk9GVEhSUlZuakVqRUZLenZrTFBKNTNJbmVo?=
 =?utf-8?B?QlZUMUJ3Mi9FN2Rkb3QxRzQ1RFpUdkV3dDVOdXA5MXI2SVh1QVBZNkJGdzhn?=
 =?utf-8?B?VkZMa2tVNERlMzBXcDVYMkhPVkNhNVRoSWRmOVZqTkMwTVhQWEVISi83M1JG?=
 =?utf-8?B?dGVHSTJBYk1SSXJaOHlZNjhIVDNWcEE5cjdwV2NWY1RFdXB0cEtBVjZOUDdl?=
 =?utf-8?B?d0FhY2xueENWMDlTVDRuMDNSQUFWVHdJelM0a0ZyaDk1WGtNNmlYNjArN2tZ?=
 =?utf-8?B?QnVSK3Zlb2w4U25iNUFXeHRRTzJKRjg3djlRYk5pUXNXRzkwRmtRT1pJOC9m?=
 =?utf-8?B?WnU1OGFOUzk2SHkxam1LbFlTTjIxYnJzTUg4S0FBZ1BtU0xFQnNKdjhlWUJk?=
 =?utf-8?B?NEo3T1pFd0djTi9PQk54NlI5OWVPcGNncFNkYzBvcStuMlk3WFRlSWR0eDdN?=
 =?utf-8?B?TnpDcHB4OVRwamtIU0VxR2hNZE1vQzA4SDNVVWxZckI2Q3gwUlMvcDduY1FL?=
 =?utf-8?B?S3VmVFVqSVNySVlwM3pLc3ZzdnRrbnE2MXFYNnloY0dJTitjNEZ3ckxKZ2ND?=
 =?utf-8?B?ZFA2UDdHY00vY2VteWFCNGhLdzZmdVFCYXN5SmVaSlROdXZqZ0tEeUJNSVZa?=
 =?utf-8?B?d2NoMmFuM0tsNTNDb3NuQWdiVktXTEJBU0hGSGVhSDJRaTg5Z0Vxd0JISEZ3?=
 =?utf-8?B?ajY0NmE5L1ZWU3NjOU82TlR0RTBuN0JxWGE5anltNVM0enFRaGlGd1loYmJt?=
 =?utf-8?B?dk5xaDdnL1lsOWhueG5xMUY3TGxuQTByYUFlZmVKYlpTWlhMVVFlbFJHaEVV?=
 =?utf-8?B?THdSVys4SHY4YlRvTVQ4Q0ZWRWRVdnRNNVUxemJHZmRIeXk3VGF0R0JwWGp5?=
 =?utf-8?B?N2p5MnJ3RzF5Qk8wRHJGVnFDcmZUSGlKODQ2SFdLZ2U2dWpUbEsrczBtVE9v?=
 =?utf-8?B?V2VPVjl3Qm0yNkdLZnR5dUJCaHd5Tm43ZGZnTVVoU1oyRUZEMTRYWmU2RExN?=
 =?utf-8?B?b0F6OGZwdWF2bXJIYlgvTGFmNFpIek1Ob0J4bElYd3ZPeVY4RXF4SmN2NUsy?=
 =?utf-8?Q?fSkc0BSR6qY0LT1FOKoY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;5:HmAO79JW0mGPU+hHEjRFzWd41o64+EDu7nI7t/3353963MHeYAWu33kqqj0bmRKbQVN1rX9TK8XbiKBsbMXkiijQ+f3ePPVAT9PonT5eNq+fb0bZJ5cdic5F/6EfOL1IERvJ7ub5t8BrGB8t7ZbIsQ==;24:4rMuPbQA8RFQbR1ZyuMeHEZXS4uPW6MVK1gKH/4nHXN0+gMSGp2YXIFzl348AvH9+IIrSSZOXzNaBqlS22fvzXcABkas0oylKxSZ5hexmbE=;20:WRIR3MmFGu012BNEWadILnccTSA8A9fjPadaFwnQ2s/VwK6R03sASNbhfuQyJPKCIBkFzqa8iwpxzVjSkoTIxg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2015 00:37:50.9216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1719
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1345;2:/p4IHWuSCJ9NfWMaOXefIEern5pDl4Df/Lfc7Amo7CUedSmDBjg3F+hCYBGLkFkFDR71tgu2aTl6NoG1CaZ3pgC8eabIbpPXc8nMxaP+bGfV0TrCwLij52Cfk/lhrI58RzTjEGx3T4SBKWOnBBUZt/yed16zFOTH3b4h6XokfVw=;3:2ElUasHKwNXm/SZhmHpYbTytAajDdjtYJ9qCNoWz3lK4T83bonBVG1ukwnf7hPIArOGZCdQq9d6UP8cYj9OnGyeLVbAp8jdkowHvZbtaAQRa2hwuCMXDa6ztYZ0hqPIR+0sYut+h9z8kM4O5CYAQzQ==;25:aVt5u1KfntgHEWGB3iuqs5nNPaS8XjQzQsmOHq8rutAZpx8RN9eFTzSpAa5Ty0KjsRk+O1ulsPOPvJ9uNatAmA9C+Xi2l7154eDJk54pCmdUS7kk8TK8vG15V/RmYdQR9nEQ36ECwhO4mdyCTErU3PhDg9joyxY0n/GDMjrq99Dwt1zk+mtwHLAg4XIT/Do/Ct2QUsjBzEYax6MiTNcBRUPwi4T57LTy4f2NE6gVwYdFvU4eRG2bu+OP6IdY+YQePEkjh7Ei1E/B2jPFgYbkdg==;23:cCrGE9kGTNXc9Yb5/Lp6xxPCh7Cq55Zwshlk1SvenE1mzx20I4Ta2+XrW5lIi+8GPx9K/Dmo6JHB15v4rT1UR6bIATLoUZKnP5tCLvKPy9MRQkv3S7xppyd+MSo7rqNwTyz4PeyWXFpb10BFXTYtj+IUucq5T7RcqUa4mx9LFTJdj4KFkzIaAVbAc5vH4pNdPTyA0/aV9Pre89/c5AfLfaT+gefGrcw6/PwzUEtlWvVbyiNP9/HzzpEVyQ+j8+7x
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48640
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

On 08/05/2015 05:23 PM, Leonid Yegoshin wrote:
> On 08/05/2015 05:14 PM, David Daney wrote:
>> On 08/05/2015 05:06 PM, Leonid Yegoshin wrote:
>>> On 08/05/2015 04:55 PM, Paul Burton wrote:
>>>>
>>>>
>>>> As was pointed out last time you posted this, it breaks backwards
>>>> compatibility with userland & thus cannot be applied.
>>>
>>> Never observed since first version.
>>>
>>> In other side, the problem with apps like ssh_keygen is observed in
>>> absence of executable stack protection.
>>
>> You cannot change the default.
>>
>> If your ssh_keygen is broken, get a working version.
>
> It is actually any application which requests non-executable stack
> protection and needs some emulation BEFORE GLIBC cancels that
> non-executable stack protection due to libraries.
>
> If you build all libraries with PT_GNU_STACK 'non-executable' and use
> application with the same protection then you can't emulate even a
> single instruction - it crashes immediately. So, it is not a bad
> application, it is a bad choice for emulation space in past.
>

This just means that your userspace is broken.

If GLibC cannot do the right thing then it should be fixed.

The very first thing that is executed is ld.so, you need to make your 
ld.so do the right thing before transferring control to your program's 
entry point.

You cannot change the default setting for executable stack just because 
you have created a broken userspace.

The ability of legacy userspace to continue functioning cannot be 
sacrificed.

David Daney
