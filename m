Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 22:12:50 +0100 (CET)
Received: from mail-bl2nam02on0069.outbound.protection.outlook.com ([104.47.38.69]:24149
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992289AbdCAVMdboPip (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Mar 2017 22:12:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Qg1yBM5Mbb93cTgEPpnXi50wdtATDGnvNLsyVpX+p44=;
 b=MDGIYgoAKG+1XjBQoi+tvOy78CP7NWEd8k3RzfcyjE54AXi2JMELftj+hC8TO+DISybKYcSoNTaihiLDXWchjM7O/6zsJ58eFjJ/L+nlsbK7aAIN4lhUNCo8wLXJsKqbpOu6YTjcvoAi+hGx2Zi5pQmRgBfH9/Ee31jUHQxbpOU=
Authentication-Results: ezchip.com; dkim=none (message not signed)
 header.d=none;ezchip.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2418.namprd07.prod.outlook.com (10.167.101.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Wed, 1 Mar 2017 21:12:24 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Jason Baron <jbaron@akamai.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
 <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
 <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
 <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com>
 <d10e986c-7f6a-3935-88e2-ba39708f79ad@caviumnetworks.com>
 <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com>
 <912fa97a-aa1d-c0e4-dc83-fc5c745db1c1@caviumnetworks.com>
 <23989c10-7b47-3fda-f790-25b53 9704bec@akamai.com>
 <871suh5wtw.fsf@concordia.ellerman.id.au>
 <7e05bd3d-08da-00ba-1b79-c9be8c659524@caviumnetworks.com>
 <cd989fed-a136-5110-f22e-d334d923ca8b@akamai.com>
Cc:     linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <d6e62866-4e7b-53cf-8198-35cadc1c8c2f@caviumnetworks.com>
Date:   Wed, 1 Mar 2017 13:12:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <cd989fed-a136-5110-f22e-d334d923ca8b@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR07CA0015.namprd07.prod.outlook.com (10.173.33.153) To
 BL2PR07MB2418.namprd07.prod.outlook.com (10.167.101.142)
X-MS-Office365-Filtering-Correlation-Id: cfbf4ea3-df49-4744-2b00-08d460e7a984
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2418;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2418;3:t1M2srP8aui1U9fgF60EkWoBgvcj4nmVLWKzxaffr+8yt7wjAA10QS+lUaBoaQRHzBctA5/QAhYlXBwQ84dRTrllnE3eXGGLLPTGWdvsnbRAGAJF3s93/EnLRo/s4mG1LS2QSTu/uoeJbjmcZV63KI0VHFHtp92YeJgKXjebVb1srqZm86ilgQhUY6uyf63i/mm1WukyUj/CZ+COFMQatV1h9AnNE7BQPvz5bCJQWG6KQTMI+8C+yuMCLsP3LBBFZfIQmi7aCnOe8pDwoI5Vvg==;25:/uSeODIQ2ty27a+Elxob3NydsVAdbXLAXKnQU8af3o9gwIBkV4eZqPuotOywIMIgkkMxFmVhK34BohrXFtsLC4jhnUv2FzVZWJvC6sUCAlXs2u4INCXTJc5SQrOSxkaM6cF3Bx9iSMwkSvrgpcDUokqxoqurwiyqrr8Z0UlG6kanH8LZax1O6jLLbopVrGCbe2fRWODupjCsXDrzaZsLbQC4ifPFDxGKtDA4gwr1Ei0SADhvhWfbLrCxraKqDU8pllO+/dIKHQFzR+NW8F5p7B8gbSN5GNmMz2fGX36pEB6m/SqIXppeAa6aIp/fsU/zdUwuSJkXvui6UxA2ZqQ3PZ/Ot55yT0J168ia26/DBQOoj04TKQPwV5gGGFFjfp4VKLfO7yEnufrFAlMXEbUA55MPz9XQ+wvl03wB1uNpWC3uX361gyvEvi/BtZCNL1sKLR3lYC/CHcgBO3G6jxuDew==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2418;31:etcgbeFYUYsK20EylCSFPoT3f62xJn9nkc+XCED2dXZAs2KXPV/uD0CDnCWGM8vH8NPXiszNs6PI2IN+9Ur8A0NjZZHGTaYxtPSFrvbQc9CqMHcA8YHJ4o56dOhJSm7Ec4lKi7SPmw4VLOy7fnpbGTtLYv3ehVApJLW9YCvQ167NYLb2ieXFGcRrAed8JtKz+9DbVNR4PMLacpoaHNJWTxJB4TWi+UE+w+x6MX5AFROartucusYkboYEi9Bk4n3V;20:tuaoSe5oJFV9e05oUIaE3lNZBeet8KX7s89CAt2YCXGsTWrGo0N+yZR07ac8m6ZEQ+SbgaSnl9VaRZxN5TAdFNIvaNe2Z2uIRkKa7Mca6o7iXiFk47WIIGi0kheRVKYGVfQB0VG4W8GirGCU44wfdc5D9rHR2EdbE1qK1QTPh/foaAciNG1SSCRiPoTuf6nJAk7eVPz99PiA9tiJqPKhi2Xf5fOUhMv7nAnV9mBHGJQa0mp8e0l5Od2UpcJD6zDjZuEAEfy1BpmX1gCwi3A/mI9myoYrv26llhrAx39MJC+KcvOqyQocUR4JF7RNipMZt+YrSu0qYDIcrXXSrew2tX43XZZ+wfThHOCXXqpKzGqgex8Dowe30YCvTkhaVtCEFxaHsxlGJJmgzaMCj1iPCwAmX1Q5zUTPMA6KC0ItKka4/+2KY1ZjTDlscU5AS2jbfAuJpKN85IvvzfTQwIzfb31Xi+zMdEvSrlzNPEwnhC97ReZQraDpSfVdG47/k/EnCx18XMzHnqor4ZO5vG7JjzDZy0+BupMiraSVdJhk9Z4gGkDU2iUuvIODXG8EbgiCuLNViGcD6QUsc3gbAdGtMIVvC2CRVrag1UvyuDL1h14=
X-Microsoft-Antispam-PRVS: <BL2PR07MB2418867B30ABD833A65ADB9297290@BL2PR07MB2418.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123555025)(20161123564025)(20161123560025)(20161123562025)(6072148);SRVR:BL2PR07MB2418;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2418;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2418;4:mez6/VIQz8cCv9fdnK39+adAOAl9XNCxBCv8FY2YvTtgOCryWNLBJBk/LrlBOxZrDm8kMOzxqIBNTypbqBSyjfkXQbBetEuRP7eVMtJZ4QMiG9MUSa9s8VUCl8bH135ChWjWhR8R+fjkP/jh7QVSvJMQs8E8LWYSX8Q1b8IUJJdOWIHCc0uTFAo16/+fokfpAwE3yXCLASz+begGXOi+5Be72kenFYmHPMZdIBZI3RI/fchiOmWhIEZGDt1SO3OPzbFPb80zXVpNu8Lar5O4mipilEnsyA5qOKpjlCk4Sj3dvzhfkedoZC+hZyJw516ZhtAUV0S/4bmlw6hcOU1OxYfE2Tkt8Mlr8CH5eVF5zGO03THn6JHn119DDB4jYFf+ZLs88CS1eYssh2X0RTU4Y0c7Az57y/UsqO4Cm9oaDVGD3EXpqX9jo2oyg2b2OwKNn/a+01Im3RnbcsqudsYs1ETba4mcjJO963/AMkaCWbZhgBTDcYno2mm7OYO88CvXVE0PVP0UeQ+hymJmU7jzr+tSXH8Pfm0i3lpcVptMeLhW+CwoBqGhdwwEUCeIT7slfUbJC8W3LKGjLcJvOlpua7qCGq3EkAFbZBiX50mkXGo=
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(24454002)(52314003)(377454003)(83506001)(53936002)(23746002)(6246003)(38730400002)(42882006)(2950100002)(6506006)(36756003)(53546006)(230700001)(4326008)(65806001)(47776003)(93886004)(4001350100001)(189998001)(92566002)(2906002)(6512007)(7736002)(50986999)(81166006)(54356999)(66066001)(76176999)(25786008)(8676002)(31686004)(42186005)(54906002)(50466002)(5660300001)(53416004)(33646002)(229853002)(6116002)(6486002)(3846002)(305945005)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2418;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BL2PR07MB2418;23:U5Q/Hmpm6xsfoXKqMOBSDx+cbLobflBJLx+Hp?=
 =?Windows-1252?Q?2iZ14SI9v/pWE9aPYLVyo3B+3uzdz8Lc8gY8YhNOYnX5c/BBCuyxgLGJ?=
 =?Windows-1252?Q?gD39y6Qf2qSjTnhBBL4Rx5SkYlTm+NEBIuZsU3W85fNL8toGLX3gFqhf?=
 =?Windows-1252?Q?WfRBhxAH53GCIZy8ruJXGlg3awO/ir02AnxZ2L6Lxh/dXCa79vNr4Jt8?=
 =?Windows-1252?Q?n0Uks+85FzjBTkb37CyWB+7ShXtf8qt0mwaxM2dz/TCRkg6YstEdH1wm?=
 =?Windows-1252?Q?RSD0oPF+PCWLRFrRlmBhmhMM0CpNPtzxzd+n7ywpcCLE/caSbmyTCX0Q?=
 =?Windows-1252?Q?3r9mZ1y7aAn7nHE+6QG3CgEgbPybf2qpDY3nJ8i6XPvH50wRnHyap31A?=
 =?Windows-1252?Q?3q/Odhi13H/bbPsZMqn2bdbj3UvqE64rT7CXG9irJnx0nVBXCeiVgkVH?=
 =?Windows-1252?Q?JFbUEGTN2Wq90XvV86d5I80ccukAVkjFXvb1R8MbPw9ip5SicWXkrq3V?=
 =?Windows-1252?Q?VIyvCAuYjA0MvB9QG5yfOGBKSe5MNoaeySBGv6Lt2ntGOBticfZgdW6d?=
 =?Windows-1252?Q?sdISFQfCzizIPi18v8MLVu/pf/dt6N2u0d6Zlabb5E2xKOAR8wid4Uh3?=
 =?Windows-1252?Q?zvB9yDBAVN66y1su0WtsNUxkt4aCon8XKNA2+f4UqpuxtMHNyxTWzz2l?=
 =?Windows-1252?Q?U7yGspcO7HnDrvMyRUxKQ4FmY/MfbhYZ4UelEzvwmWWJsXJPUzEzc40g?=
 =?Windows-1252?Q?eR0mwnqGxuQup6LEPzEhWIY3rjZXM3Fo0l6dMniuu1OLg+V3EsxLspMk?=
 =?Windows-1252?Q?oqW3Hbqz+XRdgfDeRh7u+3Ac/pcCEm7aJ+U27GeJd8BoQB6JmpPPa+qo?=
 =?Windows-1252?Q?1fPbvRvHByAPgHirSpqtC2dfOET7kRptMqyfmIYzKImvNWc+M3//rKoS?=
 =?Windows-1252?Q?BMgODcikAwZYTyakGHteI0VAz1lSB7DCWnQBBQkgLxUGn/RLa8oq2m7l?=
 =?Windows-1252?Q?bgv8+wHTeJEoxNmvFzEuenfTU6OZSzAV+o8FVCAd/iuNEgAV73h6TVac?=
 =?Windows-1252?Q?MB41cy/x10WMxZtuocOFkJrJFbKvjIGXndsX6WlgMXSgaHVxksuiz0UD?=
 =?Windows-1252?Q?KJB1GwVxEpWDE97CkmJSZ45H4L72xzPsZWbqv/ce5lVxOnkLzCKQKPPL?=
 =?Windows-1252?Q?r4g3CN8Uf3W05RkElIB5ZypFcT15yK4UdePX9qfJ8e8nBC94t67CdvjT?=
 =?Windows-1252?Q?Q02JGI0bMpg8jQ3tZ3Wx6GJwWzMrA2/D5Zdd6s=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2418;6:hCFh6ehxg0s44DMSiJ3liA6xBeqxbq7k1bcpSBP+ckK3SmCKe5Su3lYO7JjihBERQjxl0ykhLnCrumJU5xM+kWRBqUcJywZrAI6clN1RgaeR79MGhVPRfRvYeg/6yrtWZkYWh7XStBa2kbOi3HxvkJF/tidPcadlbcuC/0HlPatRTUuWWfTDe/G/d3FUCjteML51sFBM/R30R2tRpZKwq9YjI4EBL8+hhnZbYn0qsEg/qNQqDJ+T9H9uF+QCMsL8T/pRExssWtC8+9Ha6o3mZEkzT8FqRDeoe5k02a2oud8vnVEs1S0kN6jkK97j539OTcoivTHVQNtv3CBdJsSxesHc5k5CnUTxNALFXGo3rf7wuJdWDZDJ2dorvPRlX7MXw5wGi0DVhIJXxdO5UhH/Cw==;5:v5Y6FrIXqxIIm0MXJXemQp/V949YH1n9h/gmvLqAzrCaUuze3Ii/vpdF9uyelt11W3LPvWNf0c4I+6cg42zYRkOvpaP6r84ISY7YnpP00oHGCOBhPFqToXiq4WLMGaO/pso8z1+YkzDpIv7mM7ZU3g==;24:Ba//ypN6sWK2IqXo77/MRvTFqLzxleza4eNKNa28cjuFMyU0QYozkUM7SsTjr8rzFA2DA5lkpvWfB2AP264rXetlZMuZnUL1BI8WwRbxpxo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2418;7:WTgz4XJx/bR8V1qzjRN4p8BFA68GCdnzhNt4/3DpdeeeXKbKeXLgLmCFy1OEk4l6yrry5fJnCedioJlo0/01k/8J6pMzqh3kUAhF2zb4PPZXxYQ0SLSunFjfQpGaWTajtFpKd5sCE7xX9m/Q/fJzNPX3KjwwPxC4ol3jnxRFK2OMcDF0xBp1ZWwbRrtNmrq7O8VJk1qiIbiQo1RYmcFsOb9ndu7+y5HKSPExSuFIBxk3LXhU5LHNCi3RutTxnWs37v2E2QppxK9NJt5j/7e7qYz15QQgOLQGI+iZ03kJ0dVgmDhogUlR88XzBm0gK4CMQN/TwZq7vrZLBfgvzPJSDg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2017 21:12:24.9428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2418
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56952
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

On 03/01/2017 12:02 PM, Jason Baron wrote:
>
>
> On 03/01/2017 11:40 AM, David Daney wrote:
>> On 02/28/2017 10:34 PM, Michael Ellerman wrote:
>>> Jason Baron <jbaron@akamai.com> writes:
>>> ...
>>>> I also checked all the other .ko files and they were properly aligned.
>>>> So I think this should hopefully work, and I like that its not a
>>>> per-arch fix.
>>>>
>>>> Sachin, sorry to bother you again, but I'm hoping you can try David's
>>>> latest patch to scripts/module-common.lds, just to test in your setup.
>>>
>>> It does fix the problem.
>>>
>>> I was reproducing with crc_t10dif:
>>>
>>> [  695.890552] ------------[ cut here ]------------
>>> [  695.890709] WARNING: CPU: 15 PID: 3019 at
>>> ../kernel/jump_label.c:287 static_key_set_entries+0x74/0xa0
>>> [  695.890710] Modules linked in: crc_t10dif(+) crct10dif_generic
>>> crct10dif_common ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat
>>> nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype
>>> iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack
>>> bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio
>>> libcrc32c kvm virtio_balloon binfmt_misc autofs4 virtio_net virtio_pci
>>> virtio_ring virtio
>>>
>>> Which had:
>>>
>>>   [21] __jump_table      PROGBITS        0000000000000000 0004e8
>>> 000018 00  WA  0   0  1
>>>
>>>
>>> And now has:
>>>
>>>   [18] __jump_table      PROGBITS        0000000000000000 0004d0
>>> 000018 00  WA  0   0  8
>>>
>>> And all other modules have an alignment of 8 on __jump_table, as
>>> expected.
>>>
>>> I'm inclined to merge a version of the balign patch for powerpc anyway,
>>> just to be on the safe side. I guess the old code was coping fine with
>>> the unaligned keys, but it still makes me nervous.
>>
>>
>> The original "balign patch" has a couple of problems:
>>
>> 1) 4-byte alignment is not sufficient for 64-bit kernels
>>
>> 2) It is redundant if the linker script patch is accepted.
>>
>>
>
> The linker script patch seems reasonable to me.
>
> Maybe its worth adding a comment that the alignment is necessary because
> the core jump_label makes use of the 2 lsb bits of its __jump_table
> pointer due to commit:
>
> 3821fd3 jump_label: Reduce the size of struct static_key
>
> Also, in the comment it says that it fixes an oops. We hit a WARN_ON()
> not an oops, although bad things are likely to happen when the branch is
> updated.
>

OK, I guess I will send a proper patch e-mail with an updated changelog 
with the improvements you suggest.

Thanks,
David.
