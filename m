Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 21:03:48 +0200 (CEST)
Received: from mail-by2on0068.outbound.protection.outlook.com ([207.46.100.68]:13402
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27027124AbcEWTDqg9pG9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 May 2016 21:03:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kH0MLGDFhfjw/no0RT+QhO9T5jMnPkzCVg3laws4sGY=;
 b=ahVM43sBbIYNfxExX19hzulP7DMrkrhceI3JjqR+hkq8Ok+SPR38P/JWuHbixfm5oItLG/GVsF7xY6R3iYeZG3lvxqRPCCIwVl51OY2GwuJDztuutq/ri4g9e+QF1WKA/L7H/q5aKwXDDu3PKahi/o3PJJx4cCgmTWPP/86to4A=
Authentication-Results: iki.fi; dkim=none (message not signed)
 header.d=none;iki.fi; dmarc=none action=none header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (50.233.148.158) by
 SN1PR07MB2143.namprd07.prod.outlook.com (10.164.47.13) with Microsoft SMTP
 Server (TLS) id 15.1.497.12; Mon, 23 May 2016 19:03:37 +0000
Message-ID: <57435406.1060104@caviumnetworks.com>
Date:   Mon, 23 May 2016 12:03:34 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Joshua Kinard <kumba@gentoo.org>, <linux-mips@linux-mips.org>,
        "Hill, Steven" <Steven.Hill@cavium.com>
Subject: Re: THP broken on OCTEON?
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net> <20160523152007.GB28729@linux-mips.org> <57432E02.9000008@gmail.com> <20160523185226.GA1253@raspberrypi.musicnaut.iki.fi>
In-Reply-To: <20160523185226.GA1253@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.158]
X-ClientProxiedBy: BLUPR07CA0033.namprd07.prod.outlook.com (10.255.223.146) To
 SN1PR07MB2143.namprd07.prod.outlook.com (10.164.47.13)
X-MS-Office365-Filtering-Correlation-Id: 16d43a53-8d52-4234-2d3c-08d3833cf2ef
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;2:8nVNeyS66GKqSFgw7H9hFIDkDewGJIpIPlj56xhVcPCXXVyGTWzaIhOBVJCClfIhNdOKYo6Al5JfyVm0sxfnkFwprC64eK+8DNK8LOPWLM6qnAJ7G54KRH14j6QzryxFLts53g1iVK8B3b4HRfb+SMglCuGH1k1750Qbt9+59j0rRbmnPjr5zML4OhYK544S;3:TKAMdbRWUg+FIKvQIZVxM5GlL0o20RrcTA69+y4pzi+M/6YEvDm8TqgXBi7s1d/62rex7M2FPXn7BT91VPwtdwU74AZhmFatMZdvjC0XW6Q2DOkJIdk9bx3C7D7XufrA;25:TJwAsfMoV4z/KqzpSLL5LYD7rtX/vbpnwQHTVgjg1W9Wkv6OUCNOIkLneyTnG8gi4jdsoOl53ZIxKfl/kgpXJrGvm0SJyOJN6wsdmLhZAy5jIJcVTIW5YtdIyi0fT6WDBnToz18HwN1iyDWfqPwX7Pobvy53hWZ56Mic1umSxkzRTdALhVmaNqBsP0f/s+GylUrHH0ymtUC+5MkxEvusJapGqFRjnw02cXQ+1ZEizJdqfSRL6bnOG8/1ny9H2+s/kHLicgEdbDLOKzNaVgrCobjEhDPsHrDFXpZyOLVIZtqWyPJl5g4LxN5nhCsQpetLQ+oZnHxAuagQc3DK1cra89kAa9noUHem8ZavxUYxQ06KEDknl7z1oxSxUrPHNDGcAJLvpvVueImUeToVXAwLzPc+sS2mJ0PoiAG8QYvpQw8=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2143;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;20:vwT2Qm7+LLTZnRndeYVe58M3A4yjA7veRzqFUErLwXIeUIpGa+nQ6crdemdjH7retGYASVad5ySaE8sxqfKbHIN+5Y8+1Y4re+MuvCUGXtmsfMURi+j43nXC+XmX0I0NOKPuOUGtP6M+VhSbv6KKV0u08NFqgCj7bK35i3SVQjcqw1PAnXiW6BCASdDqaJ71VPClxqZpVAc2LRXy6vam8TFFNpSupqSCdpZRT4yvZ+Z/8JGPZOiZYLhToFEQvlUmiXg0sk4Z+onK5+SxE/1tfZDHZA9b5eyFppanq6/JzUhyQdRlCa45v7gamqZaMIVtbsZo8rQEg8vvyexDOEEKkjXksWf3EPmrXcODlsKKRV3DdsPobySxj5n95T/KJU1WjWmX/aOUr16y+pT3J+nEgp9D6KVuUq/bPkfwd7fsocJUz+Qiz+H3ZypaqfI/rThRQbmZkbuKgu/qSYHL4zN0kTCAVIp/HovEYT+M7iN4Sd567gvGeJ2bLDMpypSowHRgPHVKO5Ko3xLL+nWeNwDyjEjsD00LxU0cD/h73sAib7sQMjIrOlgV36L5FM0pK88qhguZonLR5cBlgGu+eopnB5PGjcSs8c9B0J0x1JVaJlQ=
X-Microsoft-Antispam-PRVS: <SN1PR07MB214343A041F7B44FC18B0BBA974E0@SN1PR07MB2143.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:SN1PR07MB2143;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2143;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;4:fAhh1NBSrGGdqpALZfXRtuYVXD8QjrpOxnqQ5a461CPWYRi0pzYLYYze/HfgO9bqnU3n992gjNmRLA4rSGNhh1d00J4hupKReq1ZiQj8lr4wuq7WnXC1Synd1KCNCqde1h+iIgun2L9p5lk6tdN3Wfdebj8Sb2ve3FuZpTwe9MdgBbSr8Onj7GDWC+MgRFFnE/t/fvLkaW76W3rFJZDj3x90tIUixTDgOt2zFoAhHiHAx+xNm6LtobZlvtnn8udtDCY4g3WcPWBWkmgFZ1DwAtX1QUvb2347gju+5ldCW/trqZy5tQx4FQw6n0QYFZ52cy9aZJLjYeQ4wDTVO6NyLf+Y07aPdXKNTGn6u470vvXLYk3SovxN6qKpacdMR7vX
X-Forefront-PRVS: 0951AB0A30
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(377454003)(24454002)(8676002)(4326007)(189998001)(23756003)(586003)(3480700004)(4001430100002)(99136001)(3846002)(122286003)(230700001)(65816999)(50986999)(110136002)(2906002)(50466002)(64126003)(107886002)(6116002)(4001350100001)(42186005)(66066001)(87266999)(54356999)(65956001)(93886004)(5008740100001)(83506001)(81166006)(2950100001)(53416004)(36756003)(117636001)(47776003)(76176999)(92566002)(65806001)(77096005)(5004730100002)(62816006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2143;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;SN1PR07MB2143;23:hF12skqjaqvaPE73geNqKF6oqdirHXBAQJx8bb+?=
 =?iso-8859-1?Q?0G7emxQkV4Ucd+ni8LNtlX7yENtuO0IBQpJZ3gnkzuoHNK3pLs4oYSgdFu?=
 =?iso-8859-1?Q?AjdCiuUzETp2cdw2Vt4kJscbp+5fENk3H6sVz/fkyYYxOqxDk+7u1x9hJ3?=
 =?iso-8859-1?Q?oLKrKDleVUeZJFGDzDC2iG++Qr2ppoTV1pOnm//yZOTgGMHjcst+OuWO93?=
 =?iso-8859-1?Q?se0+woEluNFDClXxqEjhaVZhEXO+uXhVcwphzhCHA8IdR6iDku+PvUsOrI?=
 =?iso-8859-1?Q?4eOAL3OI9ibeFibJvao7MPBj+Fbg1t7QVIps26juuavYhGK39CVlU3OXXW?=
 =?iso-8859-1?Q?f3CNrmg97vg3OFxFkTBGzEnrICgYvJZTq2vdLe/+C7xnYb+srs2e/kWVIZ?=
 =?iso-8859-1?Q?BinAUDBeANN9J4Lwy1foHlO2lhuT3J+5czWIXfL2vjspf27341ZCGSP2uc?=
 =?iso-8859-1?Q?f66F56ivxJGIUtrbN8QKUO9G5ztWDtvQ/1Wru/ukZQndB2qM9G9vjw5nEM?=
 =?iso-8859-1?Q?KAbpTn51MbJJy+KXP2KuW+KK7JH6GrG59ZfoqVaRB+d+N7LPicVk+FlsY0?=
 =?iso-8859-1?Q?+Vj0pNcggVKTM2O5PICtBtCMWbOnLROp4mMoXczWnC/rU5NmIkTCVLpOla?=
 =?iso-8859-1?Q?tEHDTCuJY9YNpjZlro/r4OFRM5PKEEP695L+SNGDmSo6HWdG4wDlcIKdJd?=
 =?iso-8859-1?Q?ZnUHW7SZvtTHZlr5TIQKtim6H7Py7NrxfxZmm797CGR4bXkjkxxt2OD2Cf?=
 =?iso-8859-1?Q?mceVF6q3fXcI0vmr2IKRWJnzWIu3rGi3FjInsXUOqyDGFUbBqOwMLSkwuH?=
 =?iso-8859-1?Q?Cqey6AQ/0mX5s1rJsZVgjAeRRpV4w/lGUmITFF9RVbJ34rZoZUmpcRYet0?=
 =?iso-8859-1?Q?ESC7ZRhL/V8f9MjMynl1C/RgXpzUgeCMZzAB9g+Oaj/MJUsYhTq7gJMqbW?=
 =?iso-8859-1?Q?qeV9HK7w6E68ZzsEuLLZ/AXNJ3subxnCYcKoslzBGkeWgVeRXCZ9KPudjN?=
 =?iso-8859-1?Q?PLIbvQYPOr7AxTfkFnuBkaRcaoZwHiH41X6/U496Wqw/a7YryZwbGpLaK5?=
 =?iso-8859-1?Q?il1ISGEH+/nGGeMYom6ryzaaowBORhPFNyDa27zQ9mA6yNQdxAgnRQrADl?=
 =?iso-8859-1?Q?8er1/cAltbKZ3jjp4DNjLtoNtlXWUp3LIADswPciZroLuf1duR7kzK7eGz?=
 =?iso-8859-1?Q?R803A9M2MU481rgjRuw/Ukdob5Opy0sYg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2143;5:dwkJlVbzMfgu7rPJqI9G3C2zM3Kt9Qn7MYXb67UZzu3RqdF8O+adBKmTrgzjnml7iGKb6RbLekeBJlNUN8rCtIPSqKMZ36aFooiCoSHCnDYVYgDxaixexxidjG5y8v5V1SyxXyEYBMhXds4kQVnL8Q==;24:e6bu/R3io1IPYe+XlR9kXBoEVch5P3LJkpNJLZs4+XAQvWm7NH3qhOBHGvUUAK9Amspl1EG3qE0+aKQJ2GZgUDox0MwZN2nzoAPyn/ik3jI=;7:sm9DVzwkJ4a+C8utEn8oo6p1G6+ttUcdU/XkW1g8LOV7DFVluMVnlShZj+Jo/gOccIftZtG+vyAgRNyhOthkTf4u25S06FXa/5mwi72ihHSlKgpdodfjGmfjPzLpoeNzXwIE4Le0hS/dWEHp1OPA0SZWJhL35bKBXmMpBcz97x3RNALYTe+6JF71x3+CDcOs
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2016 19:03:37.8127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2143
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53621
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

On 05/23/2016 11:52 AM, Aaro Koskinen wrote:
> On Mon, May 23, 2016 at 09:21:22AM -0700, David Daney wrote:
>> On 05/23/2016 08:20 AM, Ralf Baechle wrote:
>>> On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
>>>> I'm getting kernel crashes (see below) reliably when building Perl in
>>>> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
>>>> Linux 4.6.
>>>>
>>>> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
>>>> issue - disabling it makes build go through fine.
>>>>
>>>> Any ideas?
>>>
>>> I thought it was working except on SGI Origin 200/2000 aka IP27 where
>>> Joshua Kinard (added to cc) was hitting issues as well.
>>>
>>> Joshua, does that similar to the issues you were hitting?
>>
>> There is nothing OCTEON specific in the THP code, or huge pages in general.
>>
>> That said, we have seen other THP related failures, and have never been able
>> to find the cause.
>>
>> If someone can come up with a reproducible test case that triggers quickly,
>> we can run it in our simulator and easily find the problem.
>
> Trying to build Perl is a reliable reproducer. Is that too heavyweight
> for your simulator?
>
> I was able to reproduce this also on EdgeRouter Pro, but there the kernel
> does not fail, only compiler dies with SIGBUS:
>
> [  315.095264] Data bus error, epc == 0000000000a801c4, ra == 0000000000a80624
>
> And without THP the build is fine.
>
> I also tried CN68XX board with 16 GB RAM and also there I get SIGBUS failure
> instead of Machine Check.
>

Yes.  I think the problem is some sort of corruption of the page tables. 
  This may show up as MachineCheck Errors, or bus errors, or SIGSEGV.

David.
