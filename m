Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 00:36:38 +0200 (CEST)
Received: from mail-cys01nam02on0040.outbound.protection.outlook.com ([104.47.37.40]:37765
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993483AbcHLWgbJrqsp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Aug 2016 00:36:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JbdEGJJhgO5V0zPqpxxzizmHWwiNWnNAgw3brhMc7o4=;
 b=LUzyVyJucFfE6GF2lJ2JvkSjKYztbV1q6oZkhi4Qz+cqAYHY7PwqqPzHJn9r/1CR1yxE9wrwjTyDkYyrRncif2eyXryAvIePG6cLrQBDAbfPIIzJCC9AAsRG/6nw6lGnYxe/9RzHnwEfUYMb633sBKFdMo9BQ4yTotk4YwCoseM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 DM3PR07MB2139.namprd07.prod.outlook.com (10.164.4.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.549.15; Fri, 12 Aug 2016 22:36:21 +0000
Message-ID: <57AE4F63.4010506@caviumnetworks.com>
Date:   Fri, 12 Aug 2016 15:36:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: OCTEON: Changes to support readq()/writeq() usage.
References: <5780652D.2030604@cavium.com> <20160812213801.GC10648@raspberrypi.musicnaut.iki.fi>
In-Reply-To: <20160812213801.GC10648@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BLUPR07CA059.namprd07.prod.outlook.com (10.160.24.14) To
 DM3PR07MB2139.namprd07.prod.outlook.com (10.164.4.145)
X-MS-Office365-Filtering-Correlation-Id: a9f58091-1747-407c-876c-08d3c3011671
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;2:xDkYOPHVgpHbRamcR34U1C0uVYGCtYkhQHvTNYetohV/bSyvyZtKWpc8dJZsh87mHG/jaqpYSg/HmnC5oSfpT3AT5c3MWQOF8++/wSCYxqA2Y7Pv7pbXgiXXvOdJR/U6ZExl/B2heesvrqhcR88tOVi31L1LQkgWZ2D2kJ/sftv/KL3cNozA/vg5J4Eyqh+W;3:0vTEMCYoXQOxc8iYXVPDtgeE8TUU93TLpzFut0lahb56xVVJgMCWIUSQj3d75AEQ/3Rc5hjUVlteN3jChOL53JOnrl50b0xofDG7RphZ+jeaVnkG3e2nBMelIGKl92a+
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2139;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;25:nIVkBYWnqozs4pShg448sR58M3yGUZ0AvWRCTGhmFv6rrUeNNp05XzbM3NYg4TNAUSf1zTvaqbqJ2BSpKONS2/mfRjhqLbc1K+OJpLQOmg4Nb3A0vZayEQHYzxllqzn+6HQFD19W3qYvQBNDgqw7YKVjX3w8UKsmv0MAZrQedEEunm50vZhsZAslBUGqx6Slu6u5iUACaLB/QhW6X+Ny+/VWi+x6BlyDAKhyGDDjMjktvFVs7HhWBdws3+ms3jeM79Sv6MAbEiXg+Ujux2ALlkqJdJLPDsOZUlr0ksDLp20FFnOzxKLJBfdJR9UfLu5hULhwCNCI5omrxZJvVlcfV1h8BEaw3nZd9ycYQh07H9oIuS5C3VwJ5Ldg1Pz8U15bwpQ3/6riWrbg5MXrzGGuhMHOXqoTT5ixu5N04aL7tVIdrZ3vjOYkfMNz3AuI5C/0VjpP0sS3PF5dut5eZm5CaZ1/JvuhPXvWCXD1wtLX0h1aLpa9gjIF4D3hu/bbFfMMw+DGiA/l4D15xSrIl+YLOCaBL7cqR1ZveBothALCUboRx2eqWFLNszI4kTcKjq84gCkzNOiDGnrkN8S9LBPEMrsAT+6nye92DdB387QRRG9MGVF1oZ4Ltor5hjXxcJeAinyv9Q3B2NkAI17JRMn25Bgu2yVxOEXXHD3lBnBO6HGvPYA1w90PmHpZRJeG+Vgd8AXYQwrcXWI9H04b881Kt4jWSZ/2RNG3AOQ6eDRano8=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;31:3nY+VXkneLmgSTeAIVwtEe0kMPPkHRajfmmo7tB6cn4pd5Qml/uV1FUNt2gAYs9H7UnELcqEYmy2E1oEa/KO8jSDeZrQBJwYl7TM7NDt+yBIztHT7lxzF6pXrLcLPQkMTdex2PgCnYLXct+Qmn0wAiVW2i2ZyNK4VaxUCietKAckdWT0czRvgiUjn2RW3+WpySZpqIelmC3AvsdCNzD6KORQ8YQnre4POz8JoXeNoLw=;20:QjVIDbB/5HSpYLpIFBGG5GwYFPbRQSSzgyG44ZtDlVR1NIMsXzCJ2LXhCcWhvX4dENap7ew1kb6rD+HFUtKuW28/PJT0sR/9PnCHrxbD3B0+Qb0tkaAkg/3DH0kA3cjb72DhMHbB3344Td+1XFq8ahQEXMFTd5POIFOIwIzPBN4It783bsjxlEs498mbJR+/n7A2PYi4yLBnxLz37iCA0m4TlZ+nlXfdiG0hXWcsO9L+lvn2Bn2oS3eEHzarlVAa/07BKe7pKo2sXC46KzwyXOQEYPl3RM+sMuPuI/f5hipGbI+nfHRKP88BbZ9QU/rMMleRA++RRHbDDkrr324AulGwUTLXFmLXQinbgZwOSVhIBvojzTcYalZWaq5PsqENagEZfT8ihAmWzpruM2qjRMwafrw2bW/d3NsvAITO6VQTiyPGz6+WmboyONlu4oIFKZguXRwdYL5PCrSIhoeRZeQ8vXUEf/t7gIO+Q1HgNYCJbNrMZOIq5eq2RuqbEf6UFaDNhCrq+glhd0gkxMWDlX/bdcF49P9+R1Rv5mJGOP9BQemV65pJVX1nvZN6MkJcA9zcs38Ggs1iyS5uNHJsScnCeloFGWUgPyguik5puKU=
X-Microsoft-Antispam-PRVS: <DM3PR07MB213973FBFF45BF35BD4351C2971F0@DM3PR07MB2139.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:DM3PR07MB2139;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2139;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;4:6/O0R138cDY06fMzaJm863wvsFy82w/Lu0DWt8wWmS9Nu1TmobGeyCW0eogef1nRrAQiv+QApkQ8k9p7vNdmhd3w7eXCKCiOmeXsuPMIXLD5bbF0c96wlMkfOHf0fNTfgRH6kq4x7nLZL4FcmD/DoEOl9a0Mk36InTIZNz+lxKcSrK2Q3pY0Kl4raeunBAxDgnDD6n0hTT4a3q+kdJkozDvTZfR6tQ9DAimo5vpgA20gR0uDFMRp1SZZCxcq5ILMkP+pa+fADzVvQ+jX3y2kF6eINhKvxpDuzNjJgHDwHSwnPLA0Q5KOpsZE98Qk9Dkob0A2lBC73tMPmv6fAsCYBkwTGWKLe4YP8np4ECDVj2xvBBwwTiFoWs7wlwLhbxD7TLbN91rkjUlATthhxoUCHQ==
X-Forefront-PRVS: 003245E729
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(24454002)(377454003)(189002)(3846002)(101416001)(59896002)(6116002)(105586002)(2950100001)(50466002)(97736004)(4001350100001)(83506001)(36756003)(65816999)(81166006)(586003)(50986999)(87266999)(92566002)(7846002)(77096005)(54356999)(106356001)(76176999)(305945005)(2906002)(4326007)(80316001)(189998001)(23756003)(66066001)(19580405001)(19580395003)(110136002)(65806001)(69596002)(42186005)(65956001)(47776003)(8676002)(53416004)(64126003)(81156014)(68736007)(33656002)(230700001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2139;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DM3PR07MB2139;23:/+CmiKNgp8gR8MRhF9dZeiorCuQO8+jXdrGcn2S?=
 =?iso-8859-1?Q?xfVzHuXa5RKrtbqA7I8v+Z//OsTIePRJe82uRiN0JrWjj2yPP6F2nhTb/X?=
 =?iso-8859-1?Q?MryPR2v3Ll0TVCt0Cb6p2ErhtyoQSND3vhFBAjkN9B7B3iqHEHhQA+TJhv?=
 =?iso-8859-1?Q?PqWwEKnuw4iqRO+CvHts0bb4kSrBKT6X1tly4CUq/Lznh9JOIb6DaIqnQ6?=
 =?iso-8859-1?Q?4AiotfFIlOkLUOFU/uayPTxovqMjv6pk4xv/kShfam/Z6o3mtVvGuW1GVm?=
 =?iso-8859-1?Q?EHTp1e1zmlsPBK6if02smiABgRSeJOTccP6KszuicVFspyvEQsW1FnhyOa?=
 =?iso-8859-1?Q?tKMMsS1OUsoFU+HUwt0BlSuQOphxsJ280gUQJFuDi0uuDo2TRpsh+HoBkY?=
 =?iso-8859-1?Q?ZlVskxXQh+0JPbGXUCqgU/mZkZk3Gi8SkrNvbPkSvWGUufiAjAxaMtab2r?=
 =?iso-8859-1?Q?0tv+extOtiD3d+LNPJlTH6TvEPP0SuHAQb59rlGkmIQySJgSpsY3FIqLck?=
 =?iso-8859-1?Q?XPbdp0I5Y0BxU3fsIci7Kq5kUBhVoD5nWjAIZ17BKdrokOhtVzX9ha/d9y?=
 =?iso-8859-1?Q?nXrcgr3sbbahi0F1rKJOknQIK6KBzmD9TXtRflVLVYDxXdDwf0hqmC7lXS?=
 =?iso-8859-1?Q?SEDGZ6zMj5tw3/IROC5AXNZ+J9oLLbF8sqzhrt5YbPsyhp1d6Hq4drX3yW?=
 =?iso-8859-1?Q?DzWa+tLVHOZcPHl3baOZgI20dQvwII/zOsIsOFQhJ68Ltn29TaVsanJb+l?=
 =?iso-8859-1?Q?BFpOF2corBdEB2OCwNj70UjcIQ28lf+zXqUPdVubEtLwD/iTRi/wbc2vX+?=
 =?iso-8859-1?Q?by/wJpabK+zE5gVEAGoTFdtWHvjLUI31JUP7MdP9vFE5J/j3HO2bSPz9ac?=
 =?iso-8859-1?Q?IFiqP3Es/n8dLBMgJ8n7qk0ZRGEY7hNV+YeNGMwwBSmq9WGfU8bFKXiQhR?=
 =?iso-8859-1?Q?LWFsHUi96kzR1h9SSykn8uOL7knuJ9LFHLjYsfs8ODKlLkuyb8mzzoPv93?=
 =?iso-8859-1?Q?EjVkDW+E0qRKNhOGiopi1qq1l8xdh0ywxHserNunJuJ1l0HKXdcVfFIyrV?=
 =?iso-8859-1?Q?vK/zdWw2vcNOuEVfFV5rkkMd5GnJEc/a16BzbL4o50Ff27ulTklBzhY0lJ?=
 =?iso-8859-1?Q?ppC0LMRtJS+nW0rXebCRk2cymdCxdfmsBmeEeQn8zgkyN3JnfaDQ5+sQCT?=
 =?iso-8859-1?Q?JeJ3V8452pi/Gf/b9MrBjcBfSVnPtFI/Etb5e8htU8qHUua9DiThHwwh0h?=
 =?iso-8859-1?Q?hnNtlXnZOf94vQvRAjvlgFtx/GYgh3nrlVrPWSekRVIofsNha2mXuP+XWN?=
 =?iso-8859-1?Q?GSaN3iKCab6BkivqFAvrd4f0W0T7rT8KNLuCkQ7/Nnibg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;6:QviO3JuPlNkBKbSR07s9gsoam7RE6exI5ybbW8nUSATOBwGrNB1d3qyGJ7vmJEi2Wv66hWHg9zSjQ7Q2Lq2bOErvn0PDmLliaQd+ptuP9vfo7ixFWvp7C/UtH3PXLbpatn4bpLZ9c6f01a2c5G/UkC3heJUpSac5fYR40cCafR30mLmoevKUkggogCZwPCUQPMeboaqiFKpR4zwEVC4UETEjv1AfDLxLmRJSHQSnFZL/6DSaS3TkIDqFORu2ixooYe9g0z7UMefcHSbiNJyI64ExRfJkvr7poGKBfaArocQ=;5:0bh+TKLwDB91BeqfWAobo5OQE/ws6vJcjzxi5xLKWkAW+gjI4jkakPCvDCecumQKztIiMEVN1iOVXP5LTU357ZUT7UPwB8xDxDUtIdtfHecYkrhMDRGR6L5ejQYDxBZIyiXEGveGTif2r2nwQCmf9w==;24:Kmx9HhouGk6545GiSOFnvJDkS0dw9XC9+zZ0dB9Nxs6+XHo3UpIMWPbI1X46LGssbgFLa7v59W01JWmkUX+vHPZvrlUbibWBz6xYeD9ITsc=;7:C/Onjp8C99rYlQMi3HmhTsI4WQ4JO01lrSDx8uoSBeuXS04tAdaqad3IQOmleNkaawcaNbOiGsggLaz3h1+IPdkXXN4HowFtZ7S8LoGJCRawo+ONjMIpXdSEKVfP79jW74pFEi3mT9pODs2FQ6r3aMaPvZD3DT4KejsfEV6iFey31qbkegOGA7xpwDssSVl+uHF43+I3rPyUrrTQHMZ5C6reP5VgHlFUR9hRh0uFRNF2yTiGsLzo03mcHpB4F2VK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2016 22:36:21.8096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2139
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54514
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

On 08/12/2016 02:38 PM, Aaro Koskinen wrote:
> Hi,
>
> On Fri, Jul 08, 2016 at 09:45:01PM -0500, Steven J. Hill wrote:
>> Update OCTEON port mangling code to support readq() and
>> writeq() functions to allow driver code to be more portable.
>> Updates also for word and long function pairs. We also
>> remove SWAP_IO_SPACE for OCTEON platforms as the function
>> macros are redundant with the new mangling code.
>>
>> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
>> Acked-by: David Daney <david.daney@cavium.com>
>
> [...]
>
>> +static inline bool __should_swizzle_bits(volatile void *a)
>> +{
>> +	extern const bool octeon_should_swizzle_table[];
>> +
>> +	unsigned long did = ((unsigned long)a >> 40) & 0xff;
>> +	return octeon_should_swizzle_table[did];
>> +}
>
> v4.8-rc1 OCTEON build is now broken with GCC 6.1 when support for 32-bit
> ABIs is enabled:

I don't get it.  The kernel is always 64-bit, so unsigned long will have 
a width of 64.

What kernel config are you using?

>
>    CC      arch/mips/vdso/gettimeofday-o32.o
> In file included from /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/includ
> e/asm/io.h:32:0,
>                   from /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/includ
> e/asm/page.h:194,
>                   from /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/vdso/v
> dso.h:26,
>                   from /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/vdso/g
> ettimeofday.c:11:
> /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/include/asm/mach-cavium-octe
> on/mangle-port.h: In function '__should_swizzle_bits':
> /home/aaro/los/work/shared/linux-v4.8-rc1/arch/mips/include/asm/mach-cavium-octe
> on/mangle-port.h:19:40: error: right shift count >= width of type [-Werror=shift
> -count-overflow]
>    unsigned long did = ((unsigned long)a >> 40) & 0xff;
>
> A.
>
