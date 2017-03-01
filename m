Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2017 17:40:23 +0100 (CET)
Received: from mail-co1nam03on0072.outbound.protection.outlook.com ([104.47.40.72]:31808
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992214AbdCAQkPvGMDl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Mar 2017 17:40:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=R01w+Q2nWUo/Berx6JoA5FkpjwkyZHgx/eoaRAjA+Z8=;
 b=KqiVBlCXrvsxIWoGzhKhTM/QVltRRa/O1OmBJ63Zu/SaSeXbLfI8dE9RnCpXBmEXz71PPXgQBCOjpNaPuV/+x4Dugp0BBYqfVxP3aMlj97/ijuISYMSndMJk/JxdYbj+Znui9yk6H52vDNsFUCiS2FSJ6HhIH3vNfZbzXkysBsM=
Authentication-Results: ezchip.com; dkim=none (message not signed)
 header.d=none;ezchip.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY1PR07MB2426.namprd07.prod.outlook.com (10.166.195.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Wed, 1 Mar 2017 16:40:06 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Jason Baron <jbaron@akamai.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
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
Message-ID: <7e05bd3d-08da-00ba-1b79-c9be8c659524@caviumnetworks.com>
Date:   Wed, 1 Mar 2017 08:40:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <871suh5wtw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0045.namprd07.prod.outlook.com (10.168.109.31) To
 CY1PR07MB2426.namprd07.prod.outlook.com (10.166.195.15)
X-MS-Office365-Filtering-Correlation-Id: 63fc3bad-86f5-4bbc-d741-08d460c19ecc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY1PR07MB2426;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;3:1bsp+ZMKtXdWlFnIUzyASq7qI4Y7GRVx5fbTlYwBZTcYtMBR68JRgLU7Ihou6CcuTqJVOKqVL1/9H6+GUYXqAi8N2Dgomxa1gTGXdKdUE3K6voMXM9G9jkl2oUBRPaPufl2M9+X1A2JvjLVbBJ1GgEXEx/1FZ7yvSolAaB4czOWNQeJRKh32KHofwVJY5mPTXnE1HY6A2pURroNQb0aYcR0s9vcSt8aOh4myPuvkp5DJ0ElleK7HZOmXsUIB9labKo6CaE+WjeS0dIm/LcVkVA==;25:QqTJc18PS2908FQT7aYPVtRTOeMjctLGekaYoeNqBC+fcmlvOvyTkPvEQhi2oYQZ1cGz3L/wogQD0hzpA8eHPp/PpnTYlv1SuLvp8TKQB+VzF+507CXbaY9IgFkO2L1YWX5C0VkLEtarTcwzVesjgi2/TVqAHzqZKlPU/qwz22OZc/Vj17juCVdJKUkLAJgi9PnPxwUs6AgjIpDSsE5bkdRJIs/y4uUNQnDbYoTvSbfuj561j9IcgYduFzNjoUc1wmjDQEOru6uGR2r0gWiiSeQt34A9YmIgUahavIeGu6Mstz2yu+r3pi7jzgTGb+v1l2FUoz4/GkQEO56UHRdWBShltkZIpT9du/mUsXjsk+4klZZ34RHi6lHFsacAub9YU28bDWAQBireXfKqxZujeL9Z4O8VC826olQYfdzSBYd5KN4KVs2qye/nRepT5OsLaCrRGy0wBojuq/UewmEXIg==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;31:0MQNUbH6mEPqID3OiOFz4+qXWoqYceE4ws5NYAv917bs6EZtkKkcW5gTrco61WLoqHyK2JZYvOvSHBxCzwds5f14XctXQpZbQQMORPAodere/y1Ugdw8S8SMDHC/L0M3wPCZ0K4H+hjbIUuyURWBXdl50j1GuZ5k2eScybZsWmhZqReaPwoKqxcV8YTj6GubAw3AY8LoOch400zlf5fEGlB+/9fvWY9r5T9tRUEim+Q=;20:Zjr2mW8JCLeX4jue4SgXBAyfYUgI6s2DonB6vY/+Z+glxWOfvh4Bb1TQ0S9zIvH5CaEfsybFBSpeYkzmS9n3hhEi/wsIUXFw292DuU9savHDBWJG6Oe0h6y1DFfxm8MRZdwerrOSELuBOEaZE8KiT6ihCzpNvchZ+/BH5iLlAOcJm9fBac2Gdb8Ez7vb69RH/zt8N7iUX4S6KHAVUKZcRLi2obz2qyhukJkx1riRPfzpf/ddD0FrCyHAqIR+sDcjPw3YNHX4m5KltQBg6YAmY+zENuWnFd5cSRYRfg9DsbNwcg6YynLC0Ga4HVU73Pb5dQNnbn3jgKM3d3WEC1gszKR237UGsFg4WthT80z55qTHCVHUUovHM/dhDRbVlNTbvEAeRSvLZkBwbNJC2egfzzJMX76XtFiJJsAkyBUfT3fgU6iX0UTJcNXH6tXPlD5Iw2iHmH8JdBjK8xW9w2F33uvwVsPRbt+tXFMNzxSghxnvlG3Kzyo3o88d6hL/dNrmZJDeEeYkYQMwOC0CnV87BsfhfIIkZ2liVNCyb58yjfRlOX3KPzyXWdOXPN0KI3UZLix36CtzLbIBcFcZUv2td+/HAyfUydAvduQGd4eIc1Q=
X-Microsoft-Antispam-PRVS: <CY1PR07MB24264DBAB4EC19081D90C98097290@CY1PR07MB2426.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:CY1PR07MB2426;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2426;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;4:U0OB1fl+Kj1zoAGtOOAulxDtlW5q/Zn73PvFfslqWpw1F1S40I0T+4p0eMGwk/Ofd8SRHyrAn8CcAN7Hs1cGKute0fXG0+FriKKr/P9DgZVYUAMI6vv4yWhlVp4vVNJCjwigOl/JWBDkTcEfj0eZ1AIL9jStxhllq6JiH3w7igQmQ628NVuRSZBCPwvCqFgNagkoU3IZB9tkACKYY6JfUGNRvjeyT2zP/AtuDALCIG/nrlJ2mzmyE6M9P1mftQ1zKubSj+7p5vqMQSPrVTHoErC9yWaMwQuA9hwjb4taCBUswqAUt7ToJPxCvJp95NNTWiXc8mt2vFhP7E6I5n45YasFF5JlDQG1l8FKTk5/1Wx2/sUE5kWn7yzR3NtPOqnr97nQSAOoy+2DvZJaFc8zoff9yOcjTX0rA1cROqa0fykscsC1ZHYIGIMO9AQs2+dJCWxbW/6SAtw8sms8+dcv+1nqjPPIkrI2pb+T8MkIqBQzRQ/pymsZbeTPHfCCw3J8jDjfqhiRrEtAIR8Aukgjbth5ekiXuCVANedFhiJ3hs1ZQ2AWe6EddUxcAlQ6alXGBDFL31BK81/zyaqXyhXJ0xCjO8FCT+yykbFAdSL2B/Iwm2KTMcGA6QPG2vShiKtFBGH4aYEPHW/NARseubqWWA==
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(24454002)(377454003)(52314003)(2906002)(6116002)(3846002)(5660300001)(83506001)(25786008)(2950100002)(305945005)(42882006)(229853002)(6506006)(6486002)(33646002)(7736002)(6666003)(230700001)(7416002)(6306002)(6512007)(65806001)(66066001)(65956001)(54906002)(31686004)(31696002)(42186005)(53416004)(6246003)(54356999)(76176999)(53546006)(50986999)(23746002)(189998001)(50466002)(1720100001)(93886004)(36756003)(53936002)(966004)(92566002)(81166006)(8676002)(38730400002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2426;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR07MB2426;23:t6K1aYGn7Jv+cr/RENhQ18MDjfMsRk6ekQm3i?=
 =?Windows-1252?Q?e8aJXx7TDab32pN1Zmr3LXIftiCS7rwMfFtdqmnnj2lHtDeaAZx58Qrq?=
 =?Windows-1252?Q?KbGzMqw38PAECUxfcmjqQZ2OuNY2xZOjwQz8m9m5amThW49GkNoHCLUx?=
 =?Windows-1252?Q?cw0ZwZFMJGqugFzqI/HFfyWttQ06CN8ZUdlmh8EjdgA9iYBT/JdgpDJd?=
 =?Windows-1252?Q?w4QMKsCYfelDvYphby2SpqWpYMdFlboKx/paejHIYAYcocBmWLlCLS8A?=
 =?Windows-1252?Q?UEurukGfRRC4dZbzLUM0ON3QbOwOfeHkDhgxqh/ieht/8lt0XipHaf+8?=
 =?Windows-1252?Q?2QkAnIPeK7kBMV/0LUl8hg0xlKRcZ6Ep6u62BSDK780M7+aw2zR2TlM8?=
 =?Windows-1252?Q?kBc5P3DO2ZMRI9XRJcKLCdV2oW5DACbk59fo7qI8EeNkFVFg2EDzeajm?=
 =?Windows-1252?Q?ia3O8/sdvzkd28VRnZgjip8uSYXrB8dAWlTsM5fb06hY9ycy8LInZw88?=
 =?Windows-1252?Q?fF+Fq+Q+RYzb7ucjF+WbGtwUsBrDkqSA7r38JMY8UH61UYR7S0HOcsJK?=
 =?Windows-1252?Q?LIxUUL+sm8UNn6MVJV9XBwiK4J75U6uF4ixCRRQdufVUyrniWWY1uwD4?=
 =?Windows-1252?Q?3vyYvoVf0juLVuJDPCrgmBI5GOxBvi910ySPuCTPbQo9Lo2Z2/Hg/NyH?=
 =?Windows-1252?Q?G1oXxaeFPfOD1q16SSweTUnpcgP0fxTRnniFj5YV49jkDlwXlCcVrMdi?=
 =?Windows-1252?Q?FV3iXaPtB2uKLTi450Rvx38snaNB2MXQKKAyZViP/qePIFy/YOPr9mDf?=
 =?Windows-1252?Q?HjIkXs/3aH4/3g3Uu+30pAp52y4BwiFFqo3uEp9W8ZfP4/CDkNAuIklB?=
 =?Windows-1252?Q?7Ilf8m6jxwmKxjbXhBA4nseHOqYkZW4zVfiPjRGGK+RlmNkQkPuIYlQS?=
 =?Windows-1252?Q?k1mp8xmtgtXJkxKeiwP1QUSnOaxQx54OnD/X+b7+o2K2DDvU2WBZnq0L?=
 =?Windows-1252?Q?wetxkO5Zjz7pBobb7kmgNhoWnTe3nDGYxARTfzQoFn9tw+SyJmQSrG9J?=
 =?Windows-1252?Q?4eAoFN5ZpO2jMiCLAiE2LpMMjaxRPFhDWr08PhxhJtYgAdM6BrIjGbfj?=
 =?Windows-1252?Q?RXCIHz1nAK0iT8NEa7yMn31eb1XNo+V3kWoj56mC9w2Ia3oFH4oJTZP3?=
 =?Windows-1252?Q?6OTEijiWvrJyWCS2054xLNYeYdQwbDrejPEVgI3TdtnupVdfS3aGRjtr?=
 =?Windows-1252?Q?iEVYy3nje7SNrtM+9bTtm/cPldSCqgK5u82dAIGIy+RJ/ezhf+N8JqPH?=
 =?Windows-1252?Q?VJd6cvzXtSSApI3eOw2tjw4lS5MjEYVz6XKtfkK0Fs0VN8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;6:bGIUo/1ve50Vxi1n1gCjlivjQQElCHuWEFHYzF64HTqL+iMzMq8e+aq5nqmvk57OeI5y3azFns38+zXVJ8gLcYmsjj0uj6a106d/pCzPmrW1pjkqGmmuwbXVZz3+MRsOG74Z33mJWwnxmGzjuoJmta4x3pmA4SVY9sAP7+EGKnKVt4XJc7zMzABTWDcCA/9EhvpwNuMSOwttVD5UwAOaHzBXP7PUmb41Frg/3qFJ2gjpyumDthYHKtLPGASWh6yyn2NZApLjjOGABzGy27XZJrcZHTDCD0omogoZYvNs9xaCW+Q7r2riJROigGw4UeA4XV3Eq89PQ3dbKkvDoJJ8uqBN5J6O8FIpTqgX4uzLW4PseAWf4xBNkCDTvNsJ1ajgNyukUz3A+eKeJhrddmFWoQ==;5:oRVWIBPfUwvfHtdKHYd7yETVaMwli0VjNJqcjELTvrtwj0GEYsYhYMqcpfYr+e5DC9i1ZSSE6PUhhEZiyZBpoxTqneEx+w+x7GcUV+2lm8aqUKbtzuPmDYqMAlx29fZiRgA+NvNXOdctThk8g3zIsw==;24:3Lc0w8oGU8oRnAVsM4uoLDJpxMSE/NXqbCL2hgssEQPMhcaVhG2bo6Zx4rD2XTPAyZfusQ9EKnc7Nuyb6B/BlAuVcQ21jOaTE+Aeh4UnUpw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;7:rRBbDMuM6fMbdRcdzjpeRWyniOSh+B8cV0G8ct5L/wikXO8nglU3wvgMVbE4YPSnpUHSmc9GI/QC478JyywntXnhO6vg6E1vhi+9pQX2CotrhvUwy9p7Z1ZWzK/e0OIDtU9iU5+KbxobL0CfXyFb2erIpKGgav2FWKedmBTsIwVbhp/xZgQLt76mH4DumNrczQl3mNodJc5AD0DqZRQtRv4+zZkxn9PowPtK4vji9TtCz4ZQitM9ocmMKa7XedKjBB1K2w42A3pJIO4PINYeFuEsd8Zvaat8H1zdsxNGZGNRXwbZGt6k3ELa4YTSQ76HVMonwC8atzoErOtPSZk4YA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2017 16:40:06.2761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2426
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56949
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

On 02/28/2017 10:34 PM, Michael Ellerman wrote:
> Jason Baron <jbaron@akamai.com> writes:
> ...
>> I also checked all the other .ko files and they were properly aligned.
>> So I think this should hopefully work, and I like that its not a
>> per-arch fix.
>>
>> Sachin, sorry to bother you again, but I'm hoping you can try David's
>> latest patch to scripts/module-common.lds, just to test in your setup.
>
> It does fix the problem.
>
> I was reproducing with crc_t10dif:
>
> [  695.890552] ------------[ cut here ]------------
> [  695.890709] WARNING: CPU: 15 PID: 3019 at ../kernel/jump_label.c:287 static_key_set_entries+0x74/0xa0
> [  695.890710] Modules linked in: crc_t10dif(+) crct10dif_generic crct10dif_common ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c kvm virtio_balloon binfmt_misc autofs4 virtio_net virtio_pci virtio_ring virtio
>
> Which had:
>
>   [21] __jump_table      PROGBITS        0000000000000000 0004e8 000018 00  WA  0   0  1
>
>
> And now has:
>
>   [18] __jump_table      PROGBITS        0000000000000000 0004d0 000018 00  WA  0   0  8
>
> And all other modules have an alignment of 8 on __jump_table, as expected.
>
> I'm inclined to merge a version of the balign patch for powerpc anyway,
> just to be on the safe side. I guess the old code was coping fine with
> the unaligned keys, but it still makes me nervous.


The original "balign patch" has a couple of problems:

1) 4-byte alignment is not sufficient for 64-bit kernels

2) It is redundant if the linker script patch is accepted.


>
> cheers
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
