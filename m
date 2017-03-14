Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 23:59:24 +0100 (CET)
Received: from mail-dm3nam03on0051.outbound.protection.outlook.com ([104.47.41.51]:30544
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993411AbdCNW7Mgw8uu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 23:59:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Cxm2cyKMDx2nD+1vTdHp82ps4dLM9t341uUl7hrHLfU=;
 b=hfPwEuOH+sFqzAUJ+ZVw2jQBMidLXDZFLuXZOma11m+S3o0m+QCPWGN6HOjVby/0fKprVniDvIHa/YMYttQSTc/qIj/4mCfjkCeW1NydBqQmP24y2z9SE2nW1jcHywaJr1lfE8GlbHVe9o0wu+U9uiSqmT5DN07NckIlFhP/sJo=
Authentication-Results: cavium.com; dkim=none (message not signed)
 header.d=none;cavium.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 SN1PR07MB2429.namprd07.prod.outlook.com (10.169.127.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.961.17; Tue, 14 Mar 2017 22:59:02 +0000
Subject: Re: [PATCH v2 0/5] MIPS: BPF: JIT fixes and improvements.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Daney <david.daney@cavium.com>
References: <20170314212144.29988-1-david.daney@cavium.com>
 <20170314224946.GA11983@ast-mbp.thefacebook.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <1bbf9439-bdc4-1d5f-ee55-c8caed106e19@caviumnetworks.com>
Date:   Tue, 14 Mar 2017 15:59:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170314224946.GA11983@ast-mbp.thefacebook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN2PR07CA004.namprd07.prod.outlook.com (10.255.174.21) To
 SN1PR07MB2429.namprd07.prod.outlook.com (10.169.127.141)
X-MS-Office365-Filtering-Correlation-Id: 248f6dbf-a292-428d-9441-08d46b2db5e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN1PR07MB2429;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;3:771NDEip8gxxG/xhhuGFYKtUsqYUbOo9AQurhe0yGi4th7/EZxnurwbK7sTXTulgrg0/ey/2UEJowuFkwfvBVDGmnocbsMakX8TvS0n/0pYZ9FlCYntoQALqBROb6EXCxTknfC+GHXTp/Cir37Lw/0eXNGP1lcVVpnTveaA6ukCinfG4WH4/To/LblOHZaJ1xyyxw3QVz8DvMLYKOTqz27DY6nTNv2JvTen/PzSAK61i2/psXDY4k07Yr0X2s40VXqASns1XLGKcWDd5qp1iXA==;25:+e/0OPP5tI6MBe3SlFqu/TldzETlPMKMU2VD151KoH4wsa11TNuzSL3tjZKUgFxDb7ena4gI/d0TRwFGdUpp83tOtPgEbC1Y3cHd+1RBLV39bW5PfOlgkScqwKld6tbYdzfmIsXHYXtIol+2mGmnz3uCXygu/Hn3ZX7G2ZUcTVX2OBX+Wk/Y9okpLYfOz5FVfRdy+Pp1y1Ikhj2AMyL5FzM5N6UZH9VxC7ygmb4yc5Xmfnn87qLLSI8wwcWI3n/7WDM3Fm2abXQau7sBH6rfaekyMgtlaRlw2a2TNRhibvMbe2gYZGHrcD/4WhbpsAnHw6vtBBxVq73O4SzEm/Ail6C4Xgc3hG87kFGy84+KwnCEQ8qcdejRiP4D5UJ67mmBhmgbW4QJ3vgUSRbQpf3A5cvqepHdwdUxjuzFZRYzvWkFh6GCNQVpNEzVJoLd2ZiPs9TQJQ0RtjGbVDdoAz5x4w==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;31:wVY/yK3Gvv3PrNJc4AQQs1jxljaqnfb3dSYibLHKkVKDmQfxhsdwEtPPA6rJ95CbE9ccmaXBP36bcThfx0TTKDiZ5pbb8obmr7wQf6/dfigUn8yvkauF0cau350bSKyTCq0eGLQZzTSLAS2gGYVFwfyVcGsKFT5AfMXg06womFmWkBf28bgLm1wbgZex3q4YBQgZl1pUO69QsJXltgGtPisgSyjIAtur+M42TDxnK+0=;20:WjJNQVunwUcKjbq89WWudlD36KS4mOfOERlrnZ+d2fbAYYLpjyeDwQw5w4eYQFmE23A7mxrJHKZrMfOq/BzqaUZQ3TU4yz774+Osx2FQmv8FwTfwE5HyaQu3TuAG+ODVPB3OuMHv82HynheL2+q5geuTDmzF6eKWyaRBZNQql1kZ58lukdW1z/PCPkXLOsO8tSH1ohWfo+WhCQ3odlgfrpmIKmfMkfiHYBs4nUCbrK8DF3Ohylo+WjN0GkPyxJNzrUFnOGwbwXjVTPRtKYkiLPRl+scZhgx1YVsl13TipnTZg3wFbp8oe6XJj1I8YgXO9VgXedcfEedC5pGIJWqz/YeB1xP15185SokQoDnyWHjgMw1lc0w1odeSovmXfKViVzvFI/z/JboisNM2WuNBuTiSsuBFFe8sYzNoM0xrLDCsa0mD7rTw5Yrg0JA9ryqDso5zyGffwSN81IkCXWSdrlwf0akLs4o+GMcle6u8s1Y/4eFCQ/ElBc39ghKhuU03slcn8/oovhPqW75b0hTFZ6mgeeKUJXEJtdtuAweUdJtYJDUkGrGspC7nBHP15SAQoDQ4FH/XTmrvCWaI/kQVVAxW0xXxJ7ct8tBe7/4Vvsc=
X-Microsoft-Antispam-PRVS: <SN1PR07MB2429A25410682E13E70B3D3397240@SN1PR07MB2429.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123555025)(20161123562025)(20161123564025)(20161123558025)(20161123560025)(6072148);SRVR:SN1PR07MB2429;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2429;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;4:+cjipUnAPdBNJ0W+t33MkBFjp8qxsvLE+aEOhxD2lMD04eqi+n5FiZgZEb/OUUe00yJYydRPierj83Ai9CWrr4WCaHHe7Oh8jBCtSykRxNSVPIssAdwBOUN+tYAp2VZ0JSAYcgbxlwoLzl3WKtgRxC3OQFnFNNAgbBbOm9HBOzXd+Jo9rIm3xVTdaiWO4atrWU1Ld3WE8T9IsVGrFZ6TbQhjZktg791P4mwHKHML3yllMFh8F5hbcazdOXKHA1UqCjzkV8aLfW2/CQFBRqkIyakQs/8JB9pcdBe/ZzNu3sTCOghx6viOwZriZdpRY4pGkseubU9aaOwstp0ooxE4hPK8YbLIVNk1sBiqZOUQOxxLyvGX8yfTPl3i5JVPRmI8lHf6/JOF6M0EaBRjptPwJg+okEmfd9fcqy75HAst+No6HBtw1dT/cgn9PlSCoDrI0+xrPmn5h4X5ek9h9nKdM6J0jK/OnJ/+1Wyize+p4B6BJoVAoS3D10Xz+2NhlI2/bBb5WOt7MpQSzcKGH2Ub38xJin2nPvXNpgU7uBt8a00DYVRgHyAPb8Iv71Fx8oTviU3nJAtyUGcSJY4+CCfDvIpzMdq9eUOP6GPwEnR/BgA=
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(979002)(6009001)(39450400003)(377454003)(24454002)(229853002)(54906002)(6506006)(6512007)(305945005)(53546007)(83506001)(54356999)(65956001)(53936002)(65806001)(50986999)(76176999)(47776003)(6486002)(42186005)(81166006)(66066001)(31686004)(36756003)(53416004)(8676002)(189998001)(50466002)(25786008)(7736002)(33646002)(65826007)(64126003)(31696002)(230700001)(4326008)(3846002)(6116002)(23746002)(2950100002)(5660300001)(38730400002)(107886003)(6246003)(4001350100001)(2906002)(42882006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2429;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR07MB2429;23:1IpwaQGmJVrAHfrfoM9SoNXz/adKOy71q+WYJ?=
 =?Windows-1252?Q?elIv2Ac2/S6Bvcfxqq7JnN7TyrfXiVWNGzrpba+tiFSSf6w0kiX22KBA?=
 =?Windows-1252?Q?R1rwkpWZP8FrhkWhadtOGtYaB00aQvyDSi4K8GfjwkKoVxqtc3K7FWx7?=
 =?Windows-1252?Q?6z/7up5RB5JFDVustc45KaSqcSune/B9F0rX+3jqxn3OzWT+haDRNltr?=
 =?Windows-1252?Q?kBv3uFxkec6O8qXRea1yJ3S73rJIIdALM8SEr+jL7DxE9Qcjx2V8+/wj?=
 =?Windows-1252?Q?ChoPQ/yuAEGvW1O79u/fCfFgVFgZY3epDvuPwZVuPeB7IiNQaJnmxv9C?=
 =?Windows-1252?Q?ygGgPFWwxsLZe+KQpLRaQNzc/OFQmii94gtey2mgt59mm7xHIoHJo+8H?=
 =?Windows-1252?Q?DdNzT32B07i2yJd8XAyX36ZWaf2Be/fkw14aHaL6DAfd9XIwVYVTGbda?=
 =?Windows-1252?Q?uq/mbS0O5mdgnsa5Dd0nWZEyuAYZNfE5YSGh6UZ7bVX/XnRA0JqDxNNi?=
 =?Windows-1252?Q?InfJfg9zJpJ8qgtOMzA84XYhwgM0F4ZYobex9PN7L6s4hW2JBMwEWc+w?=
 =?Windows-1252?Q?lnw5KENd8/CJxliLLjVQ0aCiofXIsNLf19VQBfvyDVt0thMVHew3sTlX?=
 =?Windows-1252?Q?R9ozT6C0a/NVUBMDRHlrQ++IBSjoJqcuacKGoInPwfYywQny2gLdyCNO?=
 =?Windows-1252?Q?o1oh0PTp2nqvknqG93kY/dHw/LApGr4l9Qu6CSnnG+slcE/KiIqWtwI1?=
 =?Windows-1252?Q?3a6hklnpuROqFlMTtyesMGU6xWgWYYqO4mMs65PFqUAKMAaJYqu9s8wD?=
 =?Windows-1252?Q?VxJw3UhNoZcal79LvOqvdBsnbiZqlOMZlsUhAqZSZL9Uj+DPMrQUrrpY?=
 =?Windows-1252?Q?zLR4U45V1ARIwEj3z1wbeefbQpIyIew8A8wwY/A5dwQyKMg1AlF3NvBN?=
 =?Windows-1252?Q?/E1L74uwzYAMSQ7nTb2uyIJD1eswPEWFLWq9SYNg/ASchvvUR9GhMM9A?=
 =?Windows-1252?Q?9sM6vZvcocsOdO3Wt2hGrtocDG5T+NJaMKxgQZOErFBOoLkG2lPAJffS?=
 =?Windows-1252?Q?Dhqg+CxEP79glZHgM/1iMxRiKoLsUUJOlGYwuyRcfcytrGDV876lZehb?=
 =?Windows-1252?Q?Jf0R/O8JVEtYCsTi1+GBLdTzHX6jkJxDHy+XqzRdgBYY0M3NNmwY37lM?=
 =?Windows-1252?Q?+df7bbVItZ9pqmlMql/gy91q4CdJp0gNuktVbcL23MsaETkdNUkU8JkK?=
 =?Windows-1252?Q?vecbNb9q7xMJeNPkWcOxKT3wT27z47lEkCOkMnN6W0/ZF32I0HK7DqGC?=
 =?Windows-1252?Q?hzCBJCuOVZylqE7rmq8j93uzNal4ZwJnY8cggr10VSnl1tJ5YcMfawN/?=
 =?Windows-1252?Q?ZuRVGucPrxn?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;6:d78rK5KhkMLsq/YqRTzmf5cdcYeJu5BM7feKXCZIpZsS96oEYU9/aYMrtxhQQJegzRk4tIyIEq811c1iGY6+eoH2bNup3kzFB1XPnF2rCT6VcO5QILZVNO6XS4q7wSiHYQuUMVSX5NsayiXhISHr1Oc8sFYlSKxYUWIl4AZ70w5SF5X7eHE+LYNsrzn0NpVgFbWilN0iMaxg8W6r4YQR6ThFnmrXlwiukynf/pzOBarb1JWf73r++L/SqJFnmKUhXnUnKyhe/+BUc+gZcXr+HGsD2iwp0M/dkHDCTKr7gPgL58Oe/GJiPfFKQpW/Wk1jMqObjkxc1UnKqbOsTbOh79MupHypcCe2MGgYHPbw8jMmx1QaRSvM8eahcxcx5n6fO5NJa2LuR3FzyCZD7qUeqg==;5:7oObqJFVSPEpM1sFW2493g01huB0Tkg3TkqjbNjLltgRSr0x9gHwLufaRuHo3CwCu8T2lBjTyiUOiAKSNU034DpPcWAPaVp2moz6MIDla9g36s5g4Cp27ZYw+WZ4FYRSAYcH4nB/kocZRblS6eOVkQ==;24:GYe0YQwtZfyQIlGCrSUp3T1qbmWjiqD5IXtQyG659RahbVxo1mFCWe8goN1TR9+KwmolJWQw9UuLNGS+JpPBy3tLc7whPySRNt3TA3No3PY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;7:rgbXwXe6IYEawiN7mECQdTSQt+49OXkul7nDuPJmpEVnPHPSSfe69c4w9zWYYmIMfNT4j3mZzpvYhVEjgvIW5zIUYDomcJ8308TkC+se/IjcxmeeMjRPmmJSXNfmdQMEJNH+cFlSKD/VQBmX0nsjWY/L5ckT/1hAh0oFR+oPXZQvpTrE9Yb/gPdw5SMVvF7m94wzy4VknfDx12J1h4+dioSnlvTFfwE0J4MUstZB5HFUnE2XvdWZDt8bqt3qH85x1PxeOjrFx3AULMbaHRyEXhJLu5329Qt3zoD7KiBqznRdulL6NbcyXzF6VjvLZ9iAHmFaucA8cf0nfwOqwUHZjg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2017 22:59:02.9682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2429
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57271
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

On 03/14/2017 03:49 PM, Alexei Starovoitov wrote:
> On Tue, Mar 14, 2017 at 02:21:39PM -0700, David Daney wrote:
>> Changes from v1:
>>
>>   - Use unsigned access for SKF_AD_HATYPE
>>
>>   - Added three more patches for other problems found.
>>
>>
>> Testing the BPF JIT on Cavium OCTEON (mips64) with the test-bpf module
>> identified some failures and unimplemented features.
>>
>> With this patch set we get:
>>
>>      test_bpf: Summary: 305 PASSED, 0 FAILED, [85/297 JIT'ed]
>>
>> Both big and little endian tested.
>>
>> We still lack eBPF support, but this is better than nothing.
>>
>> David Daney (5):
>>   MIPS: uasm:  Add support for LHU.
>>   MIPS: BPF: Add JIT support for SKF_AD_HATYPE.
>>   MIPS: BPF: Use unsigned access for unsigned SKB fields.
>>   MIPS: BPF: Quit clobbering callee saved registers in JIT code.
>>   MIPS: BPF: Fix multiple problems in JIT skb access helpers.
>
> Thanks. Nice set of fixes. Especially patch 4.
> Did you see crashes because of it?

Only when running the test-bpf module.

The "JMP_JA: Jump, gap, jump, ..." test doesn't actually use any 
registers, which I think is somewhat uncommon in BPF code.  The system 
would either crash or have weird behavior after running this test.




> Acked-by: Alexei Starovoitov <ast@kernel.org>
>
