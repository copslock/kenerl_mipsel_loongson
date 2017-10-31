Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 18:22:49 +0100 (CET)
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com ([104.47.32.58]:15872
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992325AbdJaRWj6UbbA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Oct 2017 18:22:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5iZXrg5ApQmEjaGIo5rQNjuOK4g7V6UTju1KsByQCaw=;
 b=KoxEZNJw5fhbbavAEJT7lbyaU7w/aEF6PlenjWyvwoFt1DpWSHx72qgGhmmAilvr34Rz1BCB2qt/wCxrr0O6Ci8jBqwFoobq1J1pVK87A+0yDFDdWsA3yk8EcG2Hjaw8TtjeVzPD1kSOvw5GLpsKf7hNjCEFj+gJzN7XA6Y7xqs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Tue, 31 Oct 2017 17:22:28 +0000
Subject: Re: Octeon CN5010 - Kernel 4.4.92
To:     Gabriel Kuri <gkuri@ieee.org>, linux-mips@linux-mips.org
References: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <3d272dc1-4012-c7ed-7c34-876265afb25e@caviumnetworks.com>
Date:   Tue, 31 Oct 2017 10:22:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0068.namprd07.prod.outlook.com (10.174.192.36) To
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875431ee-860e-427c-e084-08d52083f69f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:7qg5WR4MM0O2pvqWEKBQN0eAT6h/zoF8ihvKlNcTX8wAmEHEEwrVOtPdmqm+nO3nM8JhT7OrbvAvlStOpTlxMLAz67GU28UaiRmQSNHsKLbMSuNWHEf76JFo8QOazKoQH2t0h/yS3Ra31ma9lWmGdKKxbMUZGmBa23RC8qQf7fW1h1zS6kbtACZNZmBtA1LJ+vUMVqKSpODtmU1RfBmO8/6xuqEZVjyOJx0LxfEJ895WFu/CZ7h5YpCvyRdwjK/N;25:OTszUL0OJfaYCDWWjLYlZVSdrozkRe/fCNmxkTLDNpVEbF0x4RrwJtEU/k7mV18vd9C1PPvlgbogh9CWSBnVqj82z5aTai0M/67W32gJazXJC/QPNylF9Q9eYDTjFmEW3NayxgEeSQCoN+VdiAep3UXEbceSCn3WprHuE4xw2SSqajv+NSXd4cBueNTwHqYdYkT4dvFTiNvXJ60je/1fkFsbJn3KGKGpZ5FdBBmCrYr8OgI8KqoeQP/LDvRkJMczM1h/cPMJXvrZwKo1k3S6hJy9cTaZaziym1l7cb+iU3dnMarACZUYaa3FLl54PR/jFw/xG/+yE5uny84mvYj7ZQ==;31:yshJT9qaziAd6Mpsiet3YMXwonY9fr4ena52kda2aHL+11ECAIAwmT1LbKvZvE476qugoZ8/Is0lWsBHOM5fitvfMiFk4Ml4DHugWSv/JVo/MPDblBUCQdGy7B3xVAK4BCL8mkJ6dsSzGbXkTh1AKuyUhXk8px9tKMISGSZ1kW8BkK4g4fWkIwYtaokJaeR9fa5955LLAdOaedC+FN0hrtqXcWFJStfiiMeTkpa8qqc=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:+goe+PuiZSIdaC1njDoQD9XCK64kl5kN1izCsTkVjOjUoVumvNj6l1LIeqgAtxmwJXWI/GgdZ6f+FJyE48Ym+sP9ANaO28+fttN2Uek6xrGlwgfwr1X3kHUkfDFkkaibP7fGvSO4JnkIZ2UMXiGN34zXTQWmpR5CzIqtkqSGvj5sAeWW5TbQAtVXmRN+eJwblxyIiS0WJz+RltD/GwiLbZoHpj5QZUgoHc+Jd7TJUeR2fPH/bqaEM8DNAt5Ds0VAeuS/sdDVdRDf2s4mwgkUlCX3neC8/3+LWeWGWFudG3KNLBsM0PWZ/WNTaydGekBkbMniMak5CNNvfBOCwNTaTOfFs6wTIs1RyZ/3fpMKsc5IBZt7TqH4zMbJdRc0fpQaJQRFeB/OCrrMKQQIb6IckhD90ERiBmWAq97P8T7Zh/D5VCu1QjJ/Tkn368OwlaGVXDwdB3Qu2rBtAVONfK7HJRgq9l1avlPgg8hWVgexiEppzb4vHUnw65TDGNf/suJWXxfOCkTfSJU9n4ktRc4VIY4gLufqLR5O1qCOaBrmTlmosxUwRkQKJXccz3Rip+BYg3+ARLCVeTtFP0wvJnX3F8HwtuzmzTpPrhIj2APXz7U=;4:V4HN16vSgHJZdrm4ALc+ShhiP/sKd8FNL2fnFt61q+FPiZwO0EltMjNKJ8gTYga9o9WidtTC5dY6KYYDlKiqTbn6toErL7bAwIR8POd6UpWlPa8Prp1Z9YtwA8uqOIFO9BpwptmSUDzhszyTfWmgAsAjsIx2xV2qAWXZ4HNWWzn/rMK4q67bdEwmy1o0wYGqSGVY6BWU1zZxXg15Q2Is4XmiI+RN/Kw4XDII0s2i47+2U7ZujSlLco5DrsmLkFvjwKahgjadjPqUveaYZhOMmw==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34945FEAAED2703C13E94958975E0@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(3002001)(3231020)(10201501046)(93006095)(6041248)(20161123558100)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 04772EA191
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(189002)(24454002)(5423002)(199003)(230700001)(58126008)(65806001)(65956001)(83506002)(66066001)(67846002)(23676003)(25786009)(229853002)(2906002)(97736004)(6512007)(316002)(16526018)(106356001)(69596002)(53416004)(105586002)(3846002)(6116002)(33646002)(50466002)(47776003)(64126003)(101416001)(305945005)(189998001)(76176999)(50986999)(54356999)(575784001)(5660300001)(31696002)(53546010)(6506006)(53936002)(7736002)(65826007)(6486002)(8676002)(81156014)(81166006)(8936002)(478600001)(6246003)(31686004)(68736007)(36756003)(6666003)(72206003)(42882006)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk0OzIzOjdwNnpualA3TXZNS1c0MjdkcllSbDFaREgv?=
 =?utf-8?B?NGJLeDEzN1VzZWZkN1Q3dy83dHhMYnRSRmUvUTZ0czZ0a3l6WkJhYnE0VDBp?=
 =?utf-8?B?KzF3Y3RxQm81VVhCNkVTSjM1RHU5L21oTWNsSkd5b21zOWZ3cHl1S0JmOTBN?=
 =?utf-8?B?RFlsSzQ5WVJwNUE5bkc2dXJXemRJak9tdWhtY1AzeUJsYkRRUFVRTGVsZW5T?=
 =?utf-8?B?RWpraXdsdUFmbGhpUFZ0UEYxUFhOaTNib3FHOWVkSkt2MHdSV3hNakJ3SWJO?=
 =?utf-8?B?b3RGQWJ1cHZXbzdQSlRVczhobVY1Y3JHM08zeE0wTVVqMkNMdkpmczJTQXJJ?=
 =?utf-8?B?ZjhNelFyZDU0TEc0eFpMVXAwMzY1d0MxVjZrRmNCeWJ0U0xXdmNQK2ZzTWJL?=
 =?utf-8?B?TU9Jd2diMFEzbkUxTERVS1JKb1ZUVjBqZHBwWkpWbm5qZ00rRkpIdHFIQUp2?=
 =?utf-8?B?TDJUcXFtclBabTFFa0R0b3V6dW41NGJSSTNkQ2E4TTEvVFVPaTRnTklURWxs?=
 =?utf-8?B?ejYzbUk2bmJKcThkZkVjY0lEaXF6VEttd2Y5UHNucGZBa2xJdUtWbkJPNTdC?=
 =?utf-8?B?LzZhSW0wQmx5MjMvMVVaaXJNSkkrOXdHcFZwaXhOaHNiNit0YUEzemgzQ0hO?=
 =?utf-8?B?VWdmMk1qSVFPOVo5ZDZJQUxyOE8zNnpJVFo5UXNBUkllYUoyZnJFb3BPaFpv?=
 =?utf-8?B?YnVIK1ptRGh6RXhIVzdNbDMvbG9UcXFSUzZlVktZbE52R3ZabmNHdDd3Vkhn?=
 =?utf-8?B?Tlc0Y3lMcXV2VENlTXo2Q3dwYUh0eGxTRUY3c0pjdzNScXI1WjRESTBHKzdG?=
 =?utf-8?B?T00vVEFuNVhwQndoSmhNQk5iRTBOSkVRT0pRY3plQmt0cXdML2JlanZEUUs5?=
 =?utf-8?B?NFNjMUpHODQvTFBMY1ZsOWhrSFNzU3FsWEk1WVBFbDhnc2ZmR1QzYlRVMGxM?=
 =?utf-8?B?VlhTdW1iZFk1bFE0NlhmZzZaNG9Id3ltbGpqamNnSHdJakY3TERoN013eFkz?=
 =?utf-8?B?dzZJblg4K1RvR1p6RktLMmVXVi9IOXBZdlc4QjFQNldiTGJFcEtCWFJUZlpL?=
 =?utf-8?B?RWVSVEVSMkZCWUFMT0pQWG9VZ2hNWjROU2YxVDhIcWFqQnYwN2RmL2NZZlBZ?=
 =?utf-8?B?YjAxbG5TSzRjUWxId0RIOEIxRzVwd0VXTmZ2dE9DVXdSVmN1WnMwYmVseitB?=
 =?utf-8?B?d0huMVpRcGtERFpIZVluVWJPdVB0Tzd4bGdDTDdJVFVpQU9qTkp0OWxSbzBY?=
 =?utf-8?B?QWpFbi9wK1RjZDllTkc4MytYNnFzcjcxNmdYV0VDSUZxcVcxS09aNmVmUFg4?=
 =?utf-8?B?QWRsamxGZk5XR3A1U0diVlVSK3RnQ0V5bHRRbGJzb3RaZFlCTUM4NUNocGtr?=
 =?utf-8?B?cGhiQnM4NnBPcHl5VDZZeXhKbUV4WmVmN0N5WE9uNld6RXNHZzk4Zi82TG9E?=
 =?utf-8?B?akNyQmNBQWRHb2VnUkdhYkt3VmZxWWpQS3RnTkYzVGhva2tJbVlXRXRRemFK?=
 =?utf-8?B?d05ZSlJVMUdCSVk1Nk8wbnkyNS9DdEZjSVBXcGFVTksxWWhEVkN0RmxiUVVT?=
 =?utf-8?B?R1BZN2tsYmkzRmJpYWNqZFBxVFd0ak9sbWNnbFJ3dGpRV0ZmTzl3dkdQQlBr?=
 =?utf-8?B?SGR6aFprdC8zdXM2OGJSM1p1cm1CdTNSNmdHcFpMMzAvNlpZYzU2aWJDd0JN?=
 =?utf-8?B?UG5HSVlzWm8rY3NNRVEvRWdPczhhekhqbnUvM3pWS2xvMmhMeTVCOCtFWjhz?=
 =?utf-8?B?SXdJcldyblFHQ1JLcE1OdGUyMW9zWDIxODdjU0dYVHBwdWQvTUNlRFlLa3dx?=
 =?utf-8?B?c01DRnRzUStvRXZQQ2FnYjZmb3BMUElHL1IxVVYzdFFiMG1BbGR5WWFKWG9S?=
 =?utf-8?Q?YKyyqb2WJcs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:YHyb50bvPYqq0wC1sXf7lfJvSuj+uMuO03CPi7RC5QHVCpAEArfs+CHBYdmcWN7uRIc0bDfhzVivIZRkD/5fBuAafNNdrSSZcBjZ9j/Nz0075bgs1+e39X2ajgc5dOA8YXpb/LUL49GlaNT+hEkd8wQbOxz5sQQMVWkcu2T7/Ab6bjaPQF1YyGOKlhl0yBHcavYbdTdavJf/zzqaDkB90NOvBehBsKMohI2j5DfB07PcFnIaR8OYx1sby/RZ39dWhfetNTItF4sl1qnABrjR6Jmt4CES4sAnMPPgwz/CpcfksxXE6om0b8KMy2oRmL7b1R7yyUdmie8ZxxWCZ2ebGd4pbaR9gAQ/3cAg147rUZE=;5:dyWHKew0kn9oXtwQy0Qp0AIFdDZcr8dfyND6EnOEmosYUkTiQYJlROHUB03Ys/bc9p/SKWC9Hgb+2RrP+G3/z9i9mUq/VfAHLxzcFQDaFzKaJPc1StRGP9laEpz0iWN3yKmkJVmgK3GST2REFbAgXyP1KGMVOErRX+Ri2uvDT4U=;24:qLfJ1pP8ovDxg4hqoi20gfy7sWRjbikSHln7eWNLrQSfhoc3WN0kQMxsJc1zpD30SIvphUTbdUPMLGKBDoEud/jH2F8wehR1lv8q0L0ecf4=;7:h91LH+9EXfeOkO9s5RKUDm2dJe5FjHddFKhqrhIwgjwQBEBZW9OXgGFS6PQSsoEPC8FB6T0QdmXewhhmGTlogTnhLiVQyucMnMEanq1IUJG2WYW5LMyLdUPESlTp18s65PvaheAn8dCZDSThzDQ2OALxtbOILBdD27jzx0hygeVKvuocmFl/C/NQVOPLpxGWNPKmbK1C/X758n8c5cc4Ws2gxfx4ga5oP/OynLkcjZR/rNEDXiiBleL3TjesOLAb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2017 17:22:28.8110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875431ee-860e-427c-e084-08d52083f69f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60612
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

On 10/31/2017 09:54 AM, Gabriel Kuri wrote:
> I'm working on getting Kernel 4.4.92 running on a board with a CN5010
> processor and 64MB RAM.
> 
> The issue I'm running in to is the kernel memory map seems to be
> messed up. It's only recognizing 46MB of RAM of the 64MB and only 21MB
> are usable of the 46MB it recognizes. Not sure what is wrong, but
> could someone give me some guidance on where I could troubleshoot?
> 

Look at the command line passed from u-boot.

With some kernels, not all memory is allocated to the kernel unless you 
pass "mem=0" on the command line.

Since special Octeon code consumes the "mem=..." parameter, it isn't 
available in userspace after the kernel is booted, so you must look at 
what is done in u-boot.


> Thanks
> 
> 
> Below is some relevant kernel output at boot ...
> 
> 
> ELF file is 64 bit
> Allocated memory for ELF segment: addr: 0x1100000, size 0x16189c8
> Loading .text @ 0x81100000 (0x355290 bytes)
> Loading __ex_table @ 0x81455290 (0x57c0 bytes)
> Loading .rodata @ 0x8145b000 (0xca300 bytes)
> Loading .pci_fixup @ 0x81525300 (0x1db8 bytes)
> Loading __ksymtab @ 0x815270b8 (0xbdd0 bytes)
> Loading __ksymtab_gpl @ 0x81532e88 (0x6710 bytes)
> Loading __ksymtab_strings @ 0x81539598 (0x14cfd bytes)
> Loading __param @ 0x8154e298 (0x988 bytes)
> Clearing __modver @ 0x8154ec20 (0x3e0 bytes)
> Loading .data @ 0x8154f000 (0x3cad8 bytes)
> Loading .data..page_aligned @ 0x8158c000 (0x4000 bytes)
> Loading .init.text @ 0x81590000 (0x2660c bytes)
> Loading .init.data @ 0x815b6620 (0x11308 bytes)
> Loading .data..percpu @ 0x815c8000 (0x3eb0 bytes)
> Clearing .bss @ 0x816d0000 (0x10489c8 bytes)
> ## Loading OS kernel with entry point: 0x81107920 ...
> Bootloader: Done loading app on coremask: 0x1
> [    0.000000] Linux version 4.4.92 (gkuri@galileo) (gcc version 5.4.0
> (LEDE GCC 5.4.0 r3560-79f57e422d) ) #0 SMP Tue7
> [    0.000000] CVMSEG size: 2 cache lines (256 bytes)
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 000d0601 (Cavium Octeon+)
> [    0.000000] Checking for the multiply/shift bug... no.
> [    0.000000] Checking for the daddiu bug... no.
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 0000000001800000 @ 0000000002800000 (usable)
> [    0.000000]  memory: 00000000016189c8 @ 0000000001100000 (usable)
> [    0.000000] Wasting 243712 bytes for tracking 4352 unused pages
> [    0.000000] Using internal Device Tree.
> [    0.000000] software IO TLB [mem 0x0280b000-0x0284b000] (0MB)
> mapped at [800000000280b000-800000000284afff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000001100000-0x00000000efffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000001100000-0x0000000002717fff]
> [    0.000000]   node   0: [mem 0x0000000002800000-0x0000000003ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000001100000-0x0000000003ffffff]
> [    0.000000] Primary instruction cache 32kB, virtually tagged, 4
> way, 64 sets, linesize 128 bytes.
> [    0.000000] Primary data cache 16kB, 64-way, 2 sets, linesize 128 bytes.
> [    0.000000] PERCPU: Embedded 13 pages/cpu @8000000002858000 s16048
> r8192 d29008 u53248
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 11635
> [    0.000000] Kernel command line:  bootoctlinux bed00000
> console=ttyS0,9600 bootver=APBoot 1.0.8.3/20343
> [    0.000000] PID hash table entries: 256 (order: -1, 2048 bytes)
> [    0.000000] Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.000000] Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] Memory: 20468K/47200K available (3411K kernel code,
> 261K rwdata, 976K rodata, 1280K init, 16674K bss, )
> [    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  CONFIG_RCU_FANOUT set to non-default value of 32
> [    0.000000]  RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
> 
> 
> 
> Some relevant output once booted ...
> 
> # cat /proc/iomem
> 01100000-027189c7 : System RAM
>    01100000-0145528f : Kernel code
>    01455290-0158ffff : Kernel data
> 02800000-03ffffff : System RAM
> 1f400000-1fbfffff : 1f400000.nor
> 1070000000800-10700000008ff : /soc@0/gpio-controller@1070000000800
> 1180000000800-118000000083f : serial
> 1180000000c00-1180000000c3f : serial
> 1180000001000-11800000011ff : /soc@0/i2c@1180000001000
> 1180000001800-118000000183f : /soc@0/mdio@1180000001800
> 1180040000000-118004000000f : octeon_rng
> 11b00f0000000-11b0130000000 : Octeon PCI MEM
>    11b00f0000000-11b00f000ffff : 0000:00:03.0
>    11b00f0010000-11b00f001ffff : 0000:00:04.0
> 1400000000000-1400000000007 : octeon_rng
> 
> 
> # free -m
>               total       used       free     shared    buffers     cached
> Mem:         21748      19616       2132         32       1012       2196
> -/+ buffers/cache:      16408       5340
> Swap:            0          0          0
> 
> # cat /proc/cpuinfo
> system type             : CN3010_EVB_HS5 (CN5010p1.1-500-SCP)
> machine                 : Unknown
> processor               : 0
> cpu model               : Cavium Octeon+ V0.1
> BogoMIPS                : 1000.00
> wait instruction        : yes
> microsecond timers      : yes
> tlb_entries             : 64
> extra interrupt vector  : yes
> hardware watchpoint     : yes, count: 2, address/irw mask: [0x0ffc, 0x0ffb]
> isa                     : mips1 mips2 mips3 mips4 mips5 mips64r2
> ASEs implemented        :
> shadow register sets    : 1
> kscratch registers      : 0
> package                 : 0
> core                    : 0
> VCED exceptions         : not available
> VCEI exceptions         : not available
> 
> 
> # cat /proc/meminfo
> MemTotal:          21748 kB
> MemFree:            2148 kB
> MemAvailable:       3256 kB
> Buffers:            1012 kB
> Cached:             2196 kB
> SwapCached:            0 kB
> Active:             3168 kB
> Inactive:            656 kB
> Active(anon):        644 kB
> Inactive(anon):        4 kB
> Active(file):       2524 kB
> Inactive(file):      652 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:                 0 kB
> Writeback:             0 kB
> AnonPages:           628 kB
> Mapped:             1320 kB
> Shmem:                32 kB
> Slab:               8416 kB
> SReclaimable:        984 kB
> SUnreclaim:         7432 kB
> KernelStack:         720 kB
> PageTables:           88 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:       10872 kB
> Committed_AS:       1620 kB
> VmallocTotal:   1069547512 kB
> VmallocUsed:           0 kB
> VmallocChunk:          0 kB
> 
> 
