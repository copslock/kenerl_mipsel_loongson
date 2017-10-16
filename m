Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 18:13:52 +0200 (CEST)
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:38832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992091AbdJPQNna83lC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Oct 2017 18:13:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=stSGdci5Q4WWL3MF/JpmBDjVi0jHH0lNG2rneoF4A3w=;
 b=EiZ2u0ThDmSaRamLR/5sz2H03kZlPV+J+15VW00THq+v6BADUe3+SEx8KduAPDqPPEbZzziyKXR+1xohi7rhNBYWsiaypzXDsnAFRTTJgH79FiadR7sWYlVAoYXodwj/U5Av59bT5p9r2wsiFrmybreyTNV/oZFgTD0sQwGhP64=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Mon, 16 Oct 2017 16:13:32 +0000
Subject: Re: [PATCH 1/4] kexec-tools: mips: Merge adjacent memory ranges.
To:     Simon Horman <horms@verge.net.au>,
        David Daney <david.daney@cavium.com>
Cc:     kexec@lists.infradead.org, linux-mips@linux-mips.org
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-2-david.daney@cavium.com>
 <20171016065313.g5va4jel5si2udbm@verge.net.au>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <8a440fe8-0633-32e1-d142-44765b41c47b@caviumnetworks.com>
Date:   Mon, 16 Oct 2017 09:13:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171016065313.g5va4jel5si2udbm@verge.net.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0035.namprd07.prod.outlook.com (10.168.109.21) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a1782b2-7852-4e6c-f902-08d514b0d955
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:3AtWPbUFyo55sGu/VMcRKwVpgUCr6CrvB4MgSHPpwzahwG1IyIptok3l7bo7DSjBEmPtaOcFuDC6pAdxVivmx7XnCgGS74O0KW2CztBaU68+RZvM/hkONTNklTw8PnNMFnDuBGLlvwnh0vdGuWxgrlbE+ZoP1kkIkxp+npnF00bn/Byi3zZMtfAes5YaB/1eHSHM9Cpfv+W5+dnF6y8od0G88RFQGAFZp+he08ebVyqk8rBB2A3+1LW7cgYEkBmu;25:HUZFUTWwdQVclxoTIZONBI6+hDIE3Cic4eTRg1jeYwU2ZlmJEDl7ZXGAq0bkTe7FURWTFotTg8blpsm/CbIN1Rchy/EEkpdCR86t/++tPctSZLde7pOUXu2ehTokV0a3UdEzgqX/hWSegCvzc6uqkKv9aF8DKgQiWFxuZeG4vedBsg5U3uQlfslymMw620boV1Jk+S/N8JeevRaBNoH0qNWokPOfdgW2Bpu43Qpadj9Ij8eon0UJn2z/LloXb1T1h8Kv7J3OxJOGPS+5No+sP+fVQbRZQqANShyNI6oEXyYfSm4Fdf1CU5/xZ6g+fZ1xkAtTCBPsY+1jC42I7XG5AA==;31:VcHPG6A9DAPzjFkKzDz6CWD4jP34IAhb1pwiardqTB3QxH1pAugDa3TDgULUdqK4ssjmcFX6L1gfhv3mqV9OLhUdC+SZ3Xj3gczxVXGvaUkT4BlakdOIg66Nix9KF5CtqM0HQShEadhvYV1Y68VywoasN+T68L6GatZZFVREUrVaV8bnBLd4rfPzJHEMbrUEEzJD3fRgIhi0cTDhxuBGqK8RkKMy7IXkAjk9tL6oC00=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:RbrgAwm8fWBlV+ULX6KlSzKCmKkjAEjZitRinOohMwEoGvJdo3xcBbZaivuJZEbUK4KEoKrRtPE2KQ1qkV0U3lzghuJ5MKbRrF0dzsUT5lpg1Q9FZVE1ETug/XJNcPTC1chHJFRTptUyMFiF7sLPBlauPyEDdSahAEJE7wfyhJuxj0f1KEOTabyVB4CwDwZxgkur/bMh7/33gtB8uFlm07+9Ox27ml2FXsoJ0GYKMGWsrQDZytxfZYng2x5f/cExJjHCQgLzA1a5uCugIr1DLbZMtrhRway7A21MVX+jHhh/M72MrvCEER3sOsCNeqKjAvZEL0rV5OYyNRr+X9YS3e77WO1R56BEnhB/7Vclb5xsGN3E7BRnrjVFL5ux8zBOXeT44h5YxpkFoOqzbb+y03PakeIqPAI8TlZltsU177rtycdJpp6aj42XKfPbKERiGhelGNJEli1YCMeUbnNd9E9jJ9h2a8wZ2FR2/vbK/gHkQjIV4ynwsw8SEGl6iQGN2/IITS53oX+BzgQc/+rD66t9GAtyO2QFUcNhwsAiTuCsUBsS5F4Y5+jmOTaV1rQfh7iPIm1A2Q6GMb/BS5A46CibVxiZTXTOcApmqCKwHNM=;4:l9sNnK+9e9t0r86r1I6Uxyud8R1B2tg0jnjt0fu9Ld28tNSiFxGeFre/xRycJhMBkFwthfKc9073FsaB+wuLV7TSw4taP0FOmceVwiPJJgAoFg3M1H3kh5FJJmfJMV3OuOH97PnTPWimy3gwPLycrYEpBD5WZSW4P7q57vZ4AUWIqEjJ4Hg+2UdxoUiNRqsaaY3lq92QqUDhn8aEsEiuaRGk0k1O76/a2RavmvNRw9YtMF4zXfoGdDBmN/mTsrZ4EG9/r0Sbv2Kk2tjgoHRezJSlRZEN0duLPH76zMteU+A=
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-Microsoft-Antispam-PRVS: <MWHPR07MB3503296C27810EFC08518D8B974F0@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123562025)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 0462918D61
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(377454003)(199003)(24454002)(189002)(72206003)(66066001)(65956001)(65806001)(6246003)(230700001)(966005)(6486002)(47776003)(42882006)(2950100002)(68736007)(6306002)(6512007)(478600001)(1720100001)(229853002)(16526018)(69596002)(53546010)(58126008)(83506001)(31686004)(110136005)(53936002)(65826007)(189998001)(316002)(19273905006)(31696002)(36756003)(25786009)(76176999)(54356999)(101416001)(23676002)(53416004)(6116002)(3846002)(4326008)(50986999)(6506006)(33646002)(97736004)(8676002)(81156014)(81166006)(5660300001)(2906002)(105586002)(64126003)(50466002)(106356001)(8936002)(305945005)(7736002)(563064011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAzOzIzOnFSSXBURFlSbzk1RitLRTZrVUdMVHRQR0JZ?=
 =?utf-8?B?Z0xQTXVBemJtb0d5UmJybUM1QjkrWkZxNDlnQ2M1MVBnS0YrTmJZWCtOditD?=
 =?utf-8?B?K3pEandqa3N2VGpzc3pneE1sQ1BuYXU0QUNzR2p0dTh2ZVhpd1FqdXQ1d1pz?=
 =?utf-8?B?UXpNc3djZVUzcHRJU1JubS9sUTdKbmg4L3Iwam5PQ2xwbWZ6anNUMFhXMkk4?=
 =?utf-8?B?cnEwbnVCQlV4Ry9vN1Ixd3QvWHZlN2Ziek5ER0hTamI2UDFaU3gzSEVIUlY2?=
 =?utf-8?B?Rk5xSFM5U2E5Q1lOTnpqYTRtRnh2N2N2eUMvdEpCdEtGMFdDNkozOGFxRDlY?=
 =?utf-8?B?TjR4ZzRudzhyM092U3ozc3Fad2VrS0JaRjFkdm9CWjRzR0U0dmFDa2ZtUHBt?=
 =?utf-8?B?YTE5SVA2dlFmS2JsbSt1MldJMGFYSCtxM1R4a1lrTmRoc3pCWmY3ZkJ6Wk1B?=
 =?utf-8?B?anZWcjN0M2ZZL3FkQURIdzM3dDkwNlcxamV4eU5FTjAxUE5URUw0OWIwSmk4?=
 =?utf-8?B?cWpLVFBQNzZ2ZmdMeVRJUHBKbFF6M0pZZGJwdFh2ZlkvYTFURDJNdzZ2R1ln?=
 =?utf-8?B?WlNXdUtpTGpObTh3VWxMSzFmMWR0L05VRGYyNUdJQ3oyQnc1K3dSenZqRVdo?=
 =?utf-8?B?cjJVNklnRHB5dG5MV2FPU3JlcmFmcGRWclpUa2ltaVRhQkUxalAvVFdZMDFX?=
 =?utf-8?B?eXQyQVlmMlJzZ0srbSttcUEzU2Z1SlJ6VVJYa2tOeER1djMxNysyeUJmOUJl?=
 =?utf-8?B?aVpJWEljUFMwSldJbldSMWZxS2lBQ0I1a2hmNmlLTmZTZUFEUU9oQk5rQk9P?=
 =?utf-8?B?V0VLZEJGdVdwUEEwYyttWTRVSFBnVWRzZjJyeGNsSTVPWTYraDNISFNNTGpi?=
 =?utf-8?B?TURJMlZYbDF0dzhYMzlPVW9kbnVIL2lDdWl2Vkc0dWRGQmx3ejVHK1cxaTU2?=
 =?utf-8?B?TTN4T1ZvVExka05tWktLNWdMUktmZGpnREpuREV3a3o4SnZmZ1IybUN2QzZJ?=
 =?utf-8?B?ZmZhZEM4TXpyM1dTeWZBUE0zNnMzVU1VdTAwd1psUjA0S20zUFBBSjdsSVlN?=
 =?utf-8?B?eStyei93SlFLbXNpS2VYY21kNHBJYnFRdGFJWnR4UTFPTHFsU2VCdjBGYzAw?=
 =?utf-8?B?QXdSNk00d1UrYWFyNW00aTFFWnRLTWtTK1NXUlEwZkVmZkJMK0k2U2s5Wi9S?=
 =?utf-8?B?QWl5QldVNG1ZOGRWemRjc25IbnIrYmJORStUbHIwWWg4T0hBSEpCUTRuajhw?=
 =?utf-8?B?dk54RVlJdk43ajN3aS85L2dzNUVjTEE0VUFjZFpMeGlDVjdieWRZZllnZW1u?=
 =?utf-8?B?WVJYWTBST0xTd0NvY2luSFJydTBRKzdQbktPY2JMZnpNOW9uS3FZazRiY00x?=
 =?utf-8?B?QTk1SkZFQ3MwRWRaK3N2MGpGdWxmbU9UUkNVVXNUUzUxRjFZMDhoR1BRKzFt?=
 =?utf-8?B?OHA4ck0yTXhLWFpHZ2NxMHhVZzQ3dW9IQXFUWURaWlRGbDIvd3hzNVVRZEph?=
 =?utf-8?B?azAxNnhuQmg5cEZPNFV3WTJDUWxsWXRwTHBVUmpuTWpCeVlxNWJ2ZGxWQkhU?=
 =?utf-8?B?bU03aVdQZk5memF0ZDRvZ1Y2ZERUR2IzcGhFckJoMnlKWHIwQ2dkZkF2NEtQ?=
 =?utf-8?B?WlZDTUcyMGx0SUZ1Yk9DbVVFa21WZlV4eWRGWW83VEhyeU5aVFVoWUYzUjhq?=
 =?utf-8?B?RmtqTVpxd3JDM3BtUmtzUXh3UnhVc0JGcUJyME5iZFdnNzRNUEREUmtlUHVV?=
 =?utf-8?B?NW96aUpYVTlHQnEvelF0RjMzcm4raGJ0OGxpelF1T1NmL29qVVBVejlxVGIv?=
 =?utf-8?B?RGFWbUtJOUVEWm05N1N3aVFEVmVHdWg5WWJnMXplenBoUkJwRDNiaGl1RmhW?=
 =?utf-8?B?M3JLbG5XVEZ5bHJPREcrZzlPaUZRQU5LN2NZTExpRUZ3bGtPcVF0M01wc0Er?=
 =?utf-8?B?ckM1Z3lqRzB5aHI5VmQxbEdzeHR6TmovbUluOU5tRGEyTXQzQzRmVjB5WXNO?=
 =?utf-8?Q?FDKEAT?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:j17HeJULtDdtquQXZ59zJRSGdXkqlsw8tU1a5EkToMbplcn/FnI8s27K3Za6riN83W4Ngb9XjJDUWYVcuM7kvYK3M5QBtVExodJQZRrNlyZG//WEU4+ZmyaWk8hVccuup7aHm4sV9rM4OanNokKtnHtpzpMaUNYlkdfotTGW9PUL1DjeyEAwGgOHf51eREWhjq2bbYHdTSlMhank/E6NrVTuk2nF6scXkI5D3Ovbro9E9IJkDi1koleX4uVYLNqTAAkyW2+l2Nefk/yui0zBtJWhE26EDBaIJMVmjX/rTwCkykUNa1V68PbhxM1SgDcW4zZ4Wc+497BBb3fL1Gp6Gg==;5:NKSYDX7uaHwMMmlp78988CRMd36e67XtDiPRo+wsB87B0zLQZVstWpMlvhfje6vEY7N4pLPbHfw58eZKBuSEyRhJSg1+yCPITNDk7w+vW9RyZLf8hrkSh+wRLb6OSNFi8BsXzoEpRj/sRDQnN3YYUw==;24:yECTavCL/141mYn9u6ovqGIa76UiTAH9NhJrtQ9+R/vpyO7WxMaUuP+scSPVZ7Ep8pykvKP02QTdvaWkl8mytEMdmTh1a375fbWOqhNZniI=;7:sC4+vjSZ/M48s700UVoUvb6kZ28U7pstYhamtPuDU5Us6zIzNvpCyvY4XMf49TO7aYEhTBKQxGMaLEGgZ6kateJH2veq7QytZSYl/9MwnkTgVcsSZdPKJElJyN9kBRtkoilhFlfJRYpVPzY/TUEnl0l9P5/QWVVIuWJzrHIkehyxWbT+F6JyNVQciAuBLn6cYqHVcOqO7Rc95eUyyUSviTKlY4UHYzOf9xM6Bw7mArA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2017 16:13:32.8851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60410
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

On 10/15/2017 11:53 PM, Simon Horman wrote:
> On Thu, Oct 12, 2017 at 02:02:25PM -0700, David Daney wrote:
>> Some kernel versions running on MIPS split the System RAM memory
>> regions reported in /proc/iomem.  This may cause loading of the kexec
>> kernel to fail if it crosses one of the splits.
>>
>> Fix by merging adjacent memory ranges that have the same type.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   kexec/arch/mips/kexec-mips.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
>> index 2e5b700..415c2ed 100644
>> --- a/kexec/arch/mips/kexec-mips.c
>> +++ b/kexec/arch/mips/kexec-mips.c
>> @@ -60,10 +60,16 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>>   		} else {
>>   			continue;
>>   		}
>> -		memory_range[memory_ranges].start = start;
>> -		memory_range[memory_ranges].end = end;
>> -		memory_range[memory_ranges].type = type;
>> -		memory_ranges++;
>> +		if (memory_ranges > 0 &&
> 
> It seems that this will never merge the first memory range
> with subsequent ones. Is that intentional?


With the first range (index 0), no other range yet exists to merge with. 
  We can only test for merging with the second and subsequent ranges 
(indices 1 and above).  To do otherwise would cause us to read things 
from *before* the beginning of the array ...

> 
> 
>> +		    memory_range[memory_ranges - 1].end == start &&

... here.

>> +		    memory_range[memory_ranges - 1].type == type) {
>> +			memory_range[memory_ranges - 1].end = end;
>> +		} else {
>> +			memory_range[memory_ranges].start = start;
>> +			memory_range[memory_ranges].end = end;
>> +			memory_range[memory_ranges].type = type;
>> +			memory_ranges++;
>> +		}
>>   	}
>>   	fclose(fp);
>>   	*range = memory_range;
>> -- 
>> 2.9.5
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
