Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 02:00:36 +0200 (CEST)
Received: from mail-bn1bon0098.outbound.protection.outlook.com ([157.56.111.98]:30037
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012460AbbHFAAe1z-e1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Aug 2015 02:00:34 +0200
Received: from BY1PR0701MB1722.namprd07.prod.outlook.com (10.162.111.141) by
 BY1PR0701MB1658.namprd07.prod.outlook.com (10.162.110.20) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Thu, 6 Aug 2015 00:00:26 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BY1PR0701MB1722.namprd07.prod.outlook.com (10.162.111.141) with Microsoft
 SMTP Server (TLS) id 15.1.225.19; Thu, 6 Aug 2015 00:00:20 +0000
Message-ID: <55C2A38F.6000708@caviumnetworks.com>
Date:   Wed, 5 Aug 2015 17:00:15 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <daniel.sanders@imgtec.com>, <linux-mips@linux-mips.org>,
        <cernekee@gmail.com>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <heiko.carstens@de.ibm.com>,
        <paul.gortmaker@windriver.com>, <behanw@converseincode.com>,
        <macro@linux-mips.org>, <cl@linux.com>, <pkarat@mvista.com>,
        <linux@roeck-us.net>, <tkhai@yandex.ru>, <james.hogan@imgtec.com>,
        <alexinbeijing@gmail.com>, <rusty@rustcorp.com.au>,
        <Steven.Hill@imgtec.com>, <lars.persson@axis.com>,
        <aleksey.makarov@auriga.com>, <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <luto@amacapital.net>, <dahi@linux.vnet.ibm.com>,
        <markos.chandras@imgtec.com>, <eunb.song@samsung.com>,
        <kumba@gentoo.org>
Subject: Re: [PATCH v4 0/3] MIPS executable stack protection
References: <20150805234348.20722.71740.stgit@ubuntu-yegoshin>
In-Reply-To: <20150805234348.20722.71740.stgit@ubuntu-yegoshin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA071.namprd07.prod.outlook.com (25.160.24.26) To
 BY1PR0701MB1722.namprd07.prod.outlook.com (25.162.111.141)
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1722;2:YAnmggAG9HS3y0AEnhCj60ypoDxVCoWqEQawlxMyvvjsomOZroP3Nf3tcrao+bdWd7aGXooABsFqjOolPBcyvNnPT+pn6uf1pRrDEUNXITEB5ASD7kwFjBLWAN5UnXKRMZQnxW1QgFAG27aTvzvi0O7gXSTpTAXE+HRIKdFNwhE=;3:lOGQv7AxBUdtxerxkpJAALI9EvCPmCUchHiizNqjOxC8WT+jiF/CvsbnpIV721rBYZZPUzcaEI3/9/xAu+0h+/F7UuI9KlxN7/fE/Gv01L0wysBoTcqOI4iuQS/mW0EQZKGPPsgluTHCaQgFsWZWJQ==;25:II/+zGwj5VrWVhqG/Pj13z5o1nP53gqVNT6Ozho9bnoKJ1nfeLT8xIDDGerr1RtDDm8w87igZydrbf13h6rZc9lgQm99GXHc4yNFLLOe1niNrPmUZuZF9rDMbxrj3S7c3U/YZTL5S/EoqOuC9GoxmTY3WMi63plAecXCvWZigexgGwsgxSKy5srl6fwT9TI1DbWWBzQPFCm232FOoR7zkimW7qteau2UsR1vf81WkQSRNgYiDEf5fagO34kPrRPHTo4syVJ+9kXB3AYEPHWutg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1722;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1658;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1722;20:Jl/1rOjlNZP7ko64tbtOdL+Ocp3MtKdP52tsrpVtaiWVMWON5n3ssim5NkOXDKlFW2TaA2b/EfDSOZvnQrAtN1mFqo3iJA+c2ehxHjLEmZTs0OFE+hgygYHHaG/HEzAMsNscmNL0jtwrYscIOEMYq/hpjugBLM2MB8iQA2zwalUW2Vow57g37NozVp8Ckg/KSC4MiAk99IdLYrVZv56yGEn8cz4WdPP2SKaJbaNrEhParIaaPNzKyyVD/l1uvCp+EjfG+/DL9zq+XNMbsHKfGwsDGKK8UPaQXwKbjyCsKLvtb6saQmzbucp8MHmUzF57H8hTk5gplKj7bW4OgVn5mthjzBxV3CQO/Z3J8H0Ys3NlQ5RkO2k9KK3OiN59GBpLWeF35dtlrO0YRdNDWjM+Hf8kj6Wtx5YLOt9OIx713zAzPVhe2hQ66wIT1B3F25Hc41cVJqW4YfeexXzXBLHZhPgvvewj4YavhGXeK3qx2n1vv5mP67uc1fKPeyRj0Tc7kKKO4n6F3GwQzlCuqOgIiskNkMJdBKIC9xS3VlaSQkiEGTHyU4XCgY6epi4WF4DeCKkOHe0MQRmcp13asKe4QKMg4f1pTvIhlvOgLFBwzwc=;4:qNHCLIDrpwQua0fBkIN4EKbbQlt6zXYKLcW/1tZatuIpzNhk05hVl+8kILnD9DP/YNHzp3VL8rSKzoNSY20TmW4ZvBoSOcS9q7t+BrT6whsxA1jndower01Z4Zsif67/eVpv8k1TTCCGOt9LjQIlUDjjD3BrdHFBa+7HD5SF5ogpHvc86/j+1qV9VhGEynOZ57WO8ffaeh0E+oHktJdpXB8aRogLJArHPXc+O8QncP5kn9q1ywz2S38G7cKNMVhyi60UMMz6E13ylJdyiM3tjlWbbINHhcuJLbTNgLTlNT0=
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1722AE455172352E81E3746D9A740@BY1PR0701MB1722.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BY1PR0701MB1722;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1722;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(479174004)(377454003)(189002)(24454002)(4001350100001)(77156002)(42186005)(64126003)(83506001)(50986999)(5001830100001)(5001860100001)(81156007)(80316001)(97736004)(53416004)(23676002)(65816999)(47776003)(54356999)(4001540100001)(87976001)(64706001)(65806001)(65956001)(101416001)(76176999)(66066001)(87266999)(50466002)(92566002)(77096005)(2950100001)(5001960100002)(69596002)(59896002)(105586002)(106356001)(189998001)(62966003)(36756003)(33656002)(46102003)(40100003)(68736005)(122386002)(110136002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1722;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjA3MDFNQjE3MjI7MjM6c3gxWnk1VG82eVRVTzhZN2V5cW5TR0cv?=
 =?utf-8?B?U0RpZk5GU3ZaNmo2Wi96ZjBabXRvZFZuTnFOVzg0aW1ZWloxaUMyRlh4Qk1R?=
 =?utf-8?B?SkRteldyb3FWOHJQNDU2cmRQdWE0UXlHZGdNYUgveHl0cDhIY2loaTBLSE1h?=
 =?utf-8?B?Z3cwZHgzQkh0SHdUUmRVd1NnT0p3dDRjTDVwRS9wOXRtd1YrTUFWVlBmMXZY?=
 =?utf-8?B?V0RmT0lReEZlVDRaNjRhOE9sbTRBamRQaXdpZlk0Zy9wdFRpWHhpK3lZbTY5?=
 =?utf-8?B?cStSTWVFL28rNmpLOFNraUVleUl5N2lLZko1U25JbGk2bW5DcitMU1JXNTdn?=
 =?utf-8?B?N2ZTYU4rcU03em5lZGtOOEFacTY4UFRBckcwZ3JwZUtCRXp5WHZJWlNtQmVk?=
 =?utf-8?B?bk5BTnVXRUNjQ1g3aHJlUjBjS3pjTkpPOFZ4aVJSOWJKalg5aVpFTVZHci9a?=
 =?utf-8?B?V0RJRHZtRWp6L3luVVlFU09xT0VzaVFpVFdybEZMM09XY3RUdmxlQ204bm4y?=
 =?utf-8?B?N0JGL0x2cDF4TDMvV2tEN3VRQzQ3bWU3NG9yUW1FR1c4QTNuTi9GUVkvdThG?=
 =?utf-8?B?Ums3bEE1cENrR2Q1KzdOQXBFeld6YnFLaDU4VnBGVERoZXEwNndUdmtVbnYw?=
 =?utf-8?B?L3FhSEwzSTNZV1M1SG50UjRUeWlPNFlYa3JWdEdEZmtvaXVYVDFnKzQ3WVF4?=
 =?utf-8?B?ZkNCZTB0NmhkRGlJR1J2emptNWZGaWhaQkNpSzdpa1VQRDNTeldYZm93cXJh?=
 =?utf-8?B?eGx4RGtZZzc3c2tPaHY0Tk9UZGpWMWJHcWVtWXd4d1FZRXhkaks4RDdVSmsx?=
 =?utf-8?B?ZnZpNGs4QXN0bzZscVdPVHlNK2JMTit3RDdxSXlPNmlvWkl1TkxaVmd5endp?=
 =?utf-8?B?a1VZbE9EYUVlWFA0b256Y1A5Rmh4b1phUVpKbTZMb25GL3BLK0Jvckx4STRs?=
 =?utf-8?B?YmUybWVKbCt4TG1ITkNpQ1BtU2w1dS8vS1ZjMlJvdW1lWlB0djhUR1FYTWhP?=
 =?utf-8?B?bEoyeXdSN0lBL3J0ZHJKNG1SQTNqY1pRRlovOEZlOUtELzRMdVNIOVJ4RTVB?=
 =?utf-8?B?eGg4MEdNRDRyUGROOTVyQVJFdllkRGZ6ZXZrWmxYV1hxdjhpeGNwOHdCRDVm?=
 =?utf-8?B?eXcwbmVFQjVsTi9rSENUVlk2bU9WM0F0NHZhdTZFazVSSWsrbHhVRmlONE1P?=
 =?utf-8?B?eTk1RVJ1Ly9LamU3OFQ0L3d2aHU4VFhlUExBUTlpVmNkWFNsSGc2bTJEUUxK?=
 =?utf-8?B?Zko3enRRQ3BlYS9LTFI2cjhEU3lOa0I0MXlUWDZhSWFqQjR5dnBFMkd4VGZo?=
 =?utf-8?B?SFVMQllabTUrOGZuTHplMXFkZU5sOVFKdDdySVowWWJQV2JrUTYycHY4bHp4?=
 =?utf-8?B?b3JlOHhhcGlNN0RWb055VEhLbGk2Y3ljbVpyZnpRcUhGQ0R2aHdac1U0UU5t?=
 =?utf-8?B?VE5YM29WNHg1WHlvRjNXUk9hYkV3RExLVDVKQVlwbmN1bDlQTHZLUnMwSytZ?=
 =?utf-8?B?RkpwM2tybUQ5aThwL3BCenBFZkkzbzQvRHFreURkMU9EaUNrMHlEMCs3Kzh0?=
 =?utf-8?B?SGZPQWdGQU9kc0hQVUVFQ0lWSVV5T29lY3lreHNvWGJkMU9PM1lwYlNUUDZ1?=
 =?utf-8?B?TlVwUVBoNDZsU2FodVlRb0taVCtRdHRVdWZCZXliZStmdE5kT0srcXlUN1dm?=
 =?utf-8?Q?yoNCae16mGC9hucSoFQYlXiRQ3SamSO2ez5j1Xbv4?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1722;5:x2SLNXkjjaZKZpaQDIx3hS/nourenYxH3TtCBwt3+T60IAj1Xh3SK9Q6BCsfQS9a4C55qF539J17+Elbqr3BvGJ8hXk3NjSHn9nE2KgAfLU1UHcL0srM3sbcFpHbypcWW+f4+lXg5xoBtuWalwhrsA==;24:/+OICex9n2tGcShpQ4L4bLVrT9ZlvNf6KTNTXpwsrCfYngQXW1eXPyyvMFMMHk/EK/9TW7S/f8G3F37CfBEhXy9zLyK4Jdh9A94obGc5rRM=;20:ZfjK+kKsUcDJNIbZdf91neOAVmowpH0mG1W5KaXCS5q/5nd+6bucWnkTo6CP2ntqL3EshrhaHRCmjRoSleQzmQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2015 00:00:20.0820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1722
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1658;2:3B16xQMceFq+tDBD4/oKSUZcqYpMFLyU/oq7fTHGnxf3wgvjq32YA+ONd/hEM1pecmY6ULIQRCYK2LFbqnszgSuP0rbMcnPQXWZp78QIl1iaPrmSw3FV/aVnjgmfXBd1x829yumV7JUwciR9Ze0fb2g5ALnN6FDLi4zDQicCsvQ=;3:vG5E0bi0ajlZMPVDhkS+RyxCMs1as8xLClxULlWVYI5ELqpVnrxQvI1DcGN7eu8xhcUKjXx64OITiX99m4CUu3m9yuVIbiKgD0Oasj8H+07NJckY5jIx/BsrV31zUZwblIVs/6dMePmGYEgBvSGGFg==;25:SJkQrGLfZ2ltBCBekA+rSrDxaLaBoa1kQ+SMXQnbu0ii27mZPVo/d1usyjgeAPXM0QjH3h6cwH/W98nb0R54OQrMiZDld0PRoXrKy0Fn0aYSrLbCDI9N/aJdymkoWzaoUhUZLgqVzLoSYhq86JRGBhomfjQcIJfnXvdbhzTTXXBNq6lpbTV/Y8jUnWUkPOVWrGd2GfvgAWxdivcKLVWD6d0T4MiS9eQDc9ujcprOaniymAkCsSp+5tOHq5dfbG7zmP5gvNyKuuv9LiOph482gg==;23:pWFcsS84anxCu1vS1ur0eiCfQ/txRSGXE1VwcX6WcXrIbN6egDp/0tXXWvr11coXo4l54vTWGRq3vyqU+IJdCdJOjcRZMHssaam970ZrXvxoeXyu876z+WJaRlulVRtFjjnqW1+jwDcR0gSbb4ruGHKKB9GmqaLLsi55RqDUSg2KpEZTbj2amXv8LW0rrkP0UHdnzvk3/e6ka3pEqPMRCyolLeN4b6xoAOB1BiOIO3uRlXUknWbCoW3nsydGDO4K
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48635
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

On 08/05/2015 04:49 PM, Leonid Yegoshin wrote:
> The following series implements an executable stack protection in MIPS.
>
> It sets up a per-thread 'VDSO' page and appropriate TLB support.
> Page is set write-protected from user and is maintained via kernel VA.
> MIPS FPU emulation is shifted to new page and stack is relieved for
> execute protection as is as all data pages in default setup during ELF
> binary initialization.

Does it handle nested emulation?

   1) Emulation started on instruction in main program flow, we are 
about to re-enter user space..


   2) Asynchronous signal is received.


   3) Return to user space.  Where do we go?  Is it the signal handler 
or the instruction emulation?

If we go to the signal handler and it needs emulation, what happens?

David Daney



> The real protection is controlled by GLIBC and
> it can do stack protected now as it is done in other architectures and
> I learned today that GLIBC team is ready for this.
>
> Note: actual execute-protection depends from HW capability, of course.
>
> This patch is required for MIPS32/64 R2 emulation on MIPS R6 architecture.
> Without it 'ssh-keygen' crashes pretty fast on attempt to execute instruction
> in stack.
>
> v2 changes:
>      - Added an optimization during mmap switch - doesn't switch if the same
>        thread is rescheduled and other threads don't intervene (Peter Zijlstra)
>      - Fixed uMIPS support (Paul Burton)
>      - Added unwinding of VDSO emulation stack at signal handler invocation,
>        hiding an emulation page (Andy Lutomirski note in other patch comments)
>
> V3 change: heavy preemption friendly.
>
> V4 changes:
>      - Fixed bug in supplementary TLB flush (change KVA to user address space)
>      - Rebased to 4.X kernel
> ---
>
> Leonid Yegoshin (3):
>        MIPS: mips_flush_cache_range is added
>        MIPS: Setup an instruction emulation in VDSO protected page instead of user stack
>        MIPS: set stack/data protection as non-executable
>
>
>   arch/mips/include/asm/cacheflush.h    |    3 +
>   arch/mips/include/asm/fpu_emulator.h  |    2
>   arch/mips/include/asm/mmu.h           |    3 +
>   arch/mips/include/asm/page.h          |    2
>   arch/mips/include/asm/processor.h     |    2
>   arch/mips/include/asm/switch_to.h     |   14 +++
>   arch/mips/include/asm/thread_info.h   |    3 +
>   arch/mips/include/asm/tlbmisc.h       |    1
>   arch/mips/include/asm/vdso.h          |    3 +
>   arch/mips/kernel/mips-r2-to-r6-emul.c |   10 +-
>   arch/mips/kernel/process.c            |    7 ++
>   arch/mips/kernel/signal.c             |    4 +
>   arch/mips/kernel/vdso.c               |   44 +++++++++
>   arch/mips/math-emu/cp1emu.c           |    8 +-
>   arch/mips/math-emu/dsemul.c           |  154 +++++++++++++++++++++++++++------
>   arch/mips/mm/c-octeon.c               |    8 ++
>   arch/mips/mm/c-r3k.c                  |    8 ++
>   arch/mips/mm/c-r4k.c                  |   43 +++++++++
>   arch/mips/mm/c-tx39.c                 |    9 ++
>   arch/mips/mm/cache.c                  |    4 +
>   arch/mips/mm/fault.c                  |    5 +
>   arch/mips/mm/tlb-r4k.c                |   42 +++++++++
>   22 files changed, 343 insertions(+), 36 deletions(-)
>
> --
> Signature
>
