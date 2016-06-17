Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 18:22:39 +0200 (CEST)
Received: from mail-bn1on0058.outbound.protection.outlook.com ([157.56.110.58]:5760
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27042843AbcFQQWiBtHHf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 18:22:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iX3PUtIriZPDJtAq4W7Xu+kZGrXOkXcYa/JesTsqbHo=;
 b=V/5oH4snwuamYpz85liYgH0beytlIjdbETpbbrsfS4CLiUulmK7ow8ev5cJmcXLBSFa2CHXnJonXwm+qlR/hIAXsaYT/wMuY6ZgWYP0HMP1p7Yn7hdsj/Qq48v11U0BVfjKWMgbShdgttAEgmktAvXqlaWtQHzZjgSCEW2x92SM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.158) by
 SN1PR07MB2144.namprd07.prod.outlook.com (10.164.47.14) with Microsoft SMTP
 Server (TLS) id 15.1.517.8; Fri, 17 Jun 2016 16:22:29 +0000
Message-ID: <576423C2.9000408@caviumnetworks.com>
Date:   Fri, 17 Jun 2016 09:22:26 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nokia.com>, <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix page table corruption on THP permission changes.
References: <1466117431-18020-1-git-send-email-ddaney.cavm@gmail.com> <20160617120015.GJ3012@ak-desktop.emea.nsn-net.net>
In-Reply-To: <20160617120015.GJ3012@ak-desktop.emea.nsn-net.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.158]
X-ClientProxiedBy: DM2PR07CA0029.namprd07.prod.outlook.com (10.141.52.157) To
 SN1PR07MB2144.namprd07.prod.outlook.com (10.164.47.14)
X-MS-Office365-Filtering-Correlation-Id: 53d1a083-90c8-4711-4f79-08d396cb9462
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;2:o4uO0oIOnC9oG41ivgJyQq+qpHhUBvRIrNtk/OowcITa6drBFj/F8E7y4RXrwA+xiHEEJyUrBhJtCP+M/PGra1g7up4BzvqsMRZa37B0WR0eqnwCYDrkm9uskVEkVmoMQgRfU3nmSZpgLSq0ypzQfrN8a4au5GK1fTvywtGLvFWRHrJEwTCgdVwD6Q4Nciz5;3:YemodnsUnM+4kTkPwJwDqkj+7lWEczcxmV60/n87ExkQvSZ6PPfBxb1yCOXrevqG4cUdpSEmABbauc12EQCJBs1XgxVr7Nc5kIXVgsUBhQVUkVsMMagz3w/u4MUdBCBx
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;25:/WVSjBERl83zGhSMrW4gnU3d04fqdyalYsE9dRMQ7WwzxxCbg6JY7Bq+1HGRjdjxfutPWIzudtxGzPFJ1hTgwaI8LCeHZYairDv82TQLJTjRkzDyQbOVkQxlfVepGblM5d+ZvdrEbIq6vmfO5P+OYI0E0hYOAr2jVGu2olvzKBSlW9PGQq8v2i8Zzwo9shRmywgfbW1YgGEZphgd4kwDS3jWtcnffNN2DQBa8+PAM8Tl4JBfYVrkwl2b0gqCjikbcK4h9siNoCBGk1LLj2Bvx9YiPwKVz079n3UrBsGNkKoihOdBYgeguAzC3gWUe/ePRLv9Y5TMu03zokc0fxv8Q3VN3IVXM1+4Nsoz5ARY/SFAc3KONIJ0CzAdjyFwJbBGomPh3Vj35vyzv6LiDCNIVAZwIqifKUtQxY5BWvl+7d6GlDgFsAW4s0vz1RmCK0xBxu7JdGD7QJ9RikFKzJaMh+aZ2S1Aklfdc60Cp0hu1TEw8oiKWUJ684QyggyyPxeVSJjK/ub0ymk6az+JY5yFbczG1gHJ2D9GHo0FhdRuKAeVUykCLvMFyV6ewlRzyILSWu1m/28HEyNbWUQSDewDp9X0y90EDZc95g01wMyWXodduiDDGD/g1txfh2vW49ZqmtkdA1GMmwmgPNbOIJ/5BdDXbN6TkI4opMHSNiC1FL51G2g0uFcgBwqmtmRLDiMO8Gts/BjrnonSgcCFbr+Tln2H4l7eTXfaqdPiWXB279I=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;20:pk8O0G4dQauZetUAGnHyvovoSkAS7ybEPmWFIhuLc0vvyq/ZXFjK6s269mioq9txNXs2LTeoARm6joOb531VsTiWqHFfo6F3R5yIGQs3aa7ZCxK8Th9dVthhDhM+Rg7P7VMufavLsT/MK+u6aiTLOTKRa06zcTis2eLxFke6KoSc8IvekJCbWqwZgLBxVPHpqxIgy9kIb8hMUlsJdr58PkDTdir7MfeafzimD0sZrT3fI07eDTegQXnAvVzVYr0t6I3DR0E+ZSInGApPzwSlLhV39vyWmCIn5tsCTk1kdKgHOjOsAXfTzCYgZ29LyvSveF9wVWOk1049h/bqV3LISo+PGGiky1FFkSJ8A0Oe3GufF4zIaSX4V1/7GNn8Ss92a93R6vb/1z+eeaz7swHCLZM2PeG347w/Dk9xoEZ/azrtJgRVnYP3etHWShc/GChwCUg7PwSTCjhlCSznF+9yorM0rfgoTOxsBu1gy8AunUPu3LiQONFlAGbhfcczV1eQtXzFHNTmdoa/j9G/X81iQf2j8G0xux1c9cp3kbs4bDD/eH0Qql6N/xvxG9a/QF/jaRhjzPZNunKMpXXTpUgvBB7n3OdSnDIbiTUBjCzyp6M=
X-Microsoft-Antispam-PRVS: <SN1PR07MB2144073F6FBCD4A7CEC6F16B97570@SN1PR07MB2144.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:SN1PR07MB2144;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;4:VxJsx0UX32gbCzCL+l3Isb4oG1vgUGCeVpdm63QmWkvOAEEtPD1Fl64cv4iIrf5HeKqsAzf3bIgukukuRY3qtKltjuY51O+jSDuEJ5BIUcLAFTKmbfPcDmoqDeWJP2pxOMAVvobANIZd7ODTpZ4VzLsPeQ/wmHNCFzXtW7KPevDtZjNaOBbbYPCUvCEz1L8OGE3e0MW/AYvjNPlCq/L3Ns/N+UMweMU+yABU+e/WmGq9Er57lwg87a/R2xEaaoL3Kd/Z0IrTGc+n0gjlMKYZtG626Ca6QG7vTW+eHEXki9vQLQ7h3NHRIUHBPjXaHVHa41jVJ3PYc1ksP8VGAHrPxd4f/CSdPqBKkZEaiFhD5GXXAtYUFWWPresOy92SBMdV79XmL8JlcPEo7N1syCyiq2mXjegSIPOWwf1qtTjcR7k=
X-Forefront-PRVS: 09760A0505
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(189002)(24454002)(377454003)(47776003)(33656002)(64126003)(106356001)(50466002)(42186005)(83506001)(105586002)(65806001)(65956001)(36756003)(7846002)(53416004)(66066001)(92566002)(59896002)(5004730100002)(23756003)(80316001)(575784001)(77096005)(5001770100001)(97736004)(586003)(81156014)(19580405001)(69596002)(99136001)(2950100001)(2906002)(4326007)(19580395003)(81166006)(50986999)(8676002)(189998001)(65816999)(87266999)(230700001)(101416001)(54356999)(76176999)(6116002)(3846002)(68736007)(4001350100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2144;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;CAT:NONE;LANG:en;CAT:NONE;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;SN1PR07MB2144;23:H71YZRxjraCL+D5msArbfkdLsrh/1/u6EaOfKdW?=
 =?iso-8859-1?Q?SwnU7J2dNncyw7gLAhHtLjWDOS2QPtVTEEa1ZPthkT4gt42uPlFvQW+laX?=
 =?iso-8859-1?Q?TbgIqVzA7NGIk8IUO0NjH6Tw9NJr13Q+vb/ftfX++9KD6AFkn/YQ8eQ/pv?=
 =?iso-8859-1?Q?kjJoE5B0KP9brjGXcJMlpo98I+feGm7wnLcFVZY2jkxY25vm1Yp7EJ4qXU?=
 =?iso-8859-1?Q?XNvQB0Zi6ZtkGFxI6KA/NAYTTPhxYvIxaZy68yYDf5+upn2sev1v4TrOib?=
 =?iso-8859-1?Q?xNqXw11APGCmqoI62nOFrkM8F+YBqM65JJi3likBWX/h0wmiFVQsYt9O6b?=
 =?iso-8859-1?Q?iKkORgWguKTv2jJF6bkD304NUaEc4dwZ+n5kqPLJRr1p+Q9TQOPT1/Ji3J?=
 =?iso-8859-1?Q?H2tf+L14YDcjRkjHuf/uzdnGnFCF/J99GfdY2GtajbmlX+C+N3IzGTXTLl?=
 =?iso-8859-1?Q?6xRy0CSMYgdCVR0v+6c2oG773HwEvxEqfpEeRUEl1NlfYNYePaIFMNbXdy?=
 =?iso-8859-1?Q?0X4y2NNAZ5cDt8opnDMgzBTRrwMVbkiASh2cETH/E+EtN9i2F6zeA1VAwp?=
 =?iso-8859-1?Q?ujghSoyRIZnBieDz2XePT6slvEc/T7vHQVwvRWc3V0rai7r7sE9ouZBlVU?=
 =?iso-8859-1?Q?v/I6BpuhrrOfPl6u6cymP3Oki5wVamQpZ9ze/SgXGm+oI4jLhperXpSed3?=
 =?iso-8859-1?Q?mtpZONCKbG7Zd19tW8KrpS6Kkgadfpu9ipbVO7CDx2sCHEqSQ2rDcz5T58?=
 =?iso-8859-1?Q?vXDZR7s0CT5z3Se7BYIjX7xc1ZTcyNg/PGCZuQ1qdWasq+eaQESJ9wNEl1?=
 =?iso-8859-1?Q?zAlRB8qfTrzfpd0W0tet/JmOGkRGZBKS+aCz9Q9CbLdUUFH6g0uDAlsFUE?=
 =?iso-8859-1?Q?+3yIz+V2Ts7bcuMbGtEMJlS2aUYu3sZWJIss+l6vNrwS4RJmHmT2vmk7o1?=
 =?iso-8859-1?Q?sVvKUSeO5ZnDXlu/g056QyEEutOdOgGKsQ7wQkgGup7PnPMUAemh808UM0?=
 =?iso-8859-1?Q?ofJzZFXmm1Uir63PoY+1Y57GT5135CdYqlZ8VCQdSm8Ig3JXsTnJNUxRob?=
 =?iso-8859-1?Q?MuW4EDNJMyMwxcmBZfxjpcTGtIsB2I/pDKxUqViFRAWpvuTphPgvLUXCDt?=
 =?iso-8859-1?Q?f2hvPs9cBjhieHDUcRAkZfr6tmZLp5QFM8GzRoLsub78xjA0pg9Ij8gXwQ?=
 =?iso-8859-1?Q?mxFhG5EQ6vseUn91EHTSbE3t4fRGXhTFxFUeivTlLO0dlTYXb0BYeLvoFL?=
 =?iso-8859-1?Q?+gxOjQei3Nwp/an2LRIeHmSji5gGSufcfGT75Ixt0kuYgqX4Q6TyLuh4BJ?=
 =?iso-8859-1?Q?YbIlJNA9UYN1vWWBAQpHwMhM0/V48pjEutNAKlCP1flupuG+/hUnwdXLZu?=
 =?iso-8859-1?Q?r+0LaXVZNkUpXiR9c5uzx/8SrFzmj?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;6:G7NfLpKO75FxS3/j2Nl+XsMhCLLj/2VT0qnxFKb520ZVlm/2xL55uqQ3gK6rrGf3a1wtgNGA86eogIdyQsZqeJ9MxNL+/UfhzY8fZqSm8ew5F1mkgm6XR37HErZN9h0LE1RKtH/B2/DcuyNgaSdXggVCutAVrRKKKMeU7pJKmZb2kt9rc4QkaTbVqmEEYltxJXexohNfAhLl4UAr7Z3wedzYiexikos4Q53iqOO0UmSTjj7nU5vnM+uuhfcQZKSvKLNm0h48UKqImrGgj6Fss6xERZ/ywbex2RHlCqHzS7s=;5:Y8qj7gVPgCPJiNVyzYWdUuQwJCFDYwPr5I3b0oEtrtc1awRs9LoVIGwgOlCaj9GXidFpfS+rcfG/TsrV0W2Z90ob/+UiSTfCVo6jIyPOkDfzjNFPY23EC5pGsiSYqu2N19uKkwpz22WFFvpf3eOEyQ==;24:Ex+PkO7UB2mOJU3jmUVeBc/blbm05yuY52m0i/IjY7DR8RW22w2xh/Yl/OUaFKhQzC8A1PkiUi8KzlkKEh5PeDIYCmoRImexVwIpGpf30jg=;7:htQTtXi4hcVGUHLXEOmDLZUaQsKbXB5ruYlAUw2mChGihkIWopRfThQPSx3xnQPu1oLjsq7Bkw5Ih0YB6LFI7nEO6icQJYtaCt8gl2IPxtRyijW6aENBjiCJSxd8vonaNQq6OmNSj+qC/6ZgH1AstpEj9QUgaL61L3e1YTjbNeO+wnZefiQV8QDqVf8I/RYzQr1tsEX7kR1klVVvbbB3tQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2016 16:22:29.3401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2144
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54106
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

On 06/17/2016 05:00 AM, Aaro Koskinen wrote:
> Hi,
>
> On Thu, Jun 16, 2016 at 03:50:31PM -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> When the core THP code is modifying the permissions of a huge page it
>> calls pmd_modify(), which unfortunately was clearing the _PAGE_HUGE bit
>> of the page table entry.  The result can be kernel messages like:
>>
>> mm/memory.c:397: bad pmd 000000040080004d.
>
> [...]
>
>> BUG: Bad rss-counter state mm:80000003fa168000 idx:1 val:1536
>>
>> Fix by not clearing _PAGE_HUGE bit.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   arch/mips/include/asm/pgtable.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
>> index a6b611f..477b1b1 100644
>> --- a/arch/mips/include/asm/pgtable.h
>> +++ b/arch/mips/include/asm/pgtable.h
>> @@ -632,7 +632,7 @@ static inline struct page *pmd_page(pmd_t pmd)
>>
>>   static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>   {
>> -	pmd_val(pmd) = (pmd_val(pmd) & _PAGE_CHG_MASK) | pgprot_val(newprot);
>> +	pmd_val(pmd) = (pmd_val(pmd) & (_PAGE_CHG_MASK | _PAGE_HUGE)) | pgprot_val(newprot);
>>   	return pmd;
>>   }
>
> The fix looks correct, but unfortunately at least EBH5600 still keeps
> crashing with THP enabled. :-(

OK, I think this patch is still necessary as it fixes other types of 
failures.

Your testing shows that even with this applied there still remain problems.

We need to carefully audit all the code in 
arch/mips/include/asm/pgtable.h that deals with huge page PTEs, to make 
sure that the _PAGE_HUGE bit is being set when necessary.

If the entry in the PMD were to gets its  _PAGE_HUGE bit erroneously 
cleared the TLB exception handlers would load garbage to the TLB, which 
could easily result in MCheck.

David.



>
> [  606.429974] Got mcheck at 000000ffebed8c2c
> [  606.442262] CPU: 6 PID: 6767 Comm: ld Not tainted 4.7.0-rc3-octeon-distro.git-v2.17-27-g5cc128c-12208-g7d9ecdf #1
> [  606.473026] task: 800000041f384880 ti: 80000000ed7b0000 task.ti: 80000000ed7b0000
> [  606.495454] $ 0   : 0000000000000000 3e000000038ac006 000000ffebba7028 000000ffebb9f020
> [  606.519588] $ 4   : 0000000001529d94 00000001204f4236 0000000000000000 0000000000000000
> [  606.543722] $ 8   : 0000000000000001 7efefefefefefeff ffa0a0998d9e9c8b 8101010101010100
> [  606.567856] $12   : 4040404040404040 ffffffff84080018 0000000000000000 6162002e74657874
> [  606.591991] $16   : 000000012032a7d0 00000001204f4229 00000001201483f0 0000000000000000
> [  606.616125] $20   : 0000000000000000 000000000000000c 00000000053cd125 00000001204edb70
> [  606.640259] $24   : 0000000000000034 000000ffebed8b50
> [  606.664393] $28   : 000000ffebfac000 000000ffff808160 00000001204b9ad0 000000ffebed9cc8
> [  606.688528] Hi    : 0000000000001001
> [  606.699237] Lo    : 00000000000014f4
> [  606.709951] epc   : 000000ffebed8c2c 0xffebed8c2c
> [  606.724048] ra    : 000000ffebed9cc8 0xffebed9cc8
> [  606.738144] Status: 00308cf3	KX SX UX USER EXL IE
> [  606.752704] Cause : 00800060 (ExcCode 18)
> [  606.764717] PrId  : 000d0409 (Cavium Octeon+)
> [  606.777770] Index    : 80000000
> [  606.787178] PageMask : 1fe000
> [  606.796064] EntryHi  : 000000012032a095
> [  606.807555] EntryLo0 : 00000000038a8006
> [  606.819046] EntryLo1 : 00000000038ac006
> [  606.830535] Wired    : 0
> [  606.838120] PageGrain: e0000000
> [  606.847525]
> [  606.851986] Index: 40 pgmask=4kb va=0ffebba6000 asid=95
> 	[ri=0 xi=1 pa=0041d2b2000 c=0 d=1 v=1 g=0] [ri=0 xi=1 pa=0041d2b3000 c=0 d=1 v=1 g=0]
> [  606.890740] Index: 41 pgmask=4kb va=0ffebbb6000 asid=95
> 	[ri=0 xi=1 pa=0041d26e000 c=0 d=1 v=1 g=0] [ri=0 xi=1 pa=0041d26f000 c=0 d=1 v=1 g=0]
> [  606.929492] Index: 42 pgmask=4kb va=00120148000 asid=95
> 	[ri=0 xi=0 pa=0041d6b7000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=0041dcd1000 c=0 d=1 v=1 g=0]
> [  606.968241] Index: 43 pgmask=4kb va=0012012c000 asid=95
> 	[ri=0 xi=1 pa=000e30e9000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=0041e5f8000 c=0 d=1 v=1 g=0]
> [  607.006990] Index: 44 pgmask=4kb va=001204ec000 asid=95
> 	[ri=0 xi=0 pa=000e317e000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000e32cf000 c=0 d=1 v=1 g=0]
> [  607.045743] Index: 45 pgmask=4kb va=001204fe000 asid=95
> 	[ri=0 xi=0 pa=000e4206000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000e308f000 c=0 d=1 v=1 g=0]
> [  607.084493] Index: 46 pgmask=4kb va=001204f4000 asid=95
> 	[ri=0 xi=0 pa=000e31d0000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000e2874000 c=0 d=1 v=1 g=0]
> [  607.123243] Index: 47 pgmask=4kb va=0ffebd3c000 asid=95
> 	[ri=0 xi=0 pa=000ef2fc000 c=0 d=0 v=1 g=0] [ri=0 xi=0 pa=000ef01f000 c=0 d=0 v=1 g=0]
> [  607.161992] Index: 48 pgmask=4kb va=0ffebf28000 asid=95
> 	[ri=0 xi=0 pa=000e3adf000 c=0 d=0 v=1 g=0] [ri=0 xi=0 pa=000e3ade000 c=0 d=0 v=1 g=0]
> [  607.200741] Index: 49 pgmask=4kb va=0ffff808000 asid=95
> 	[ri=0 xi=0 pa=000e34a8000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000e43bb000 c=0 d=1 v=1 g=0]
> [  607.239489] Index: 50 pgmask=4kb va=0ffebfa4000 asid=95
> 	[ri=0 xi=1 pa=000e35c6000 c=0 d=1 v=1 g=0] [ri=0 xi=1 pa=000e31eb000 c=0 d=1 v=1 g=0]
> [  607.278238] Index: 51 pgmask=4kb va=0ffebed8000 asid=95
> 	[ri=0 xi=0 pa=000e3dce000 c=0 d=0 v=1 g=0] [ri=0 xi=0 pa=000e49ed000 c=0 d=0 v=1 g=0]
> [  607.316985] Index: 52 pgmask=4kb va=00120274000 asid=95
> 	[ri=0 xi=0 pa=00000000000 c=0 d=0 v=0 g=0] [ri=0 xi=1 pa=00000000000 c=2 d=1 v=1 g=0]
> [  607.355734]
> [  607.360192]
> Code: de100000  12000014  00000000 <de020010> 1456fffb  df9991d0  de040008  0320f809  0220282d
> [  607.389654] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
> [  607.422806] ---[ end Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
>
> *** NMI Watchdog interrupt on Core 0x0 ***
>
> A.
>
