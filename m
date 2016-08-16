Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 10:11:33 +0200 (CEST)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:55132 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992617AbcHPILZHIfeN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Aug 2016 10:11:25 +0200
Received: from resomta-ch2-18v.sys.comcast.net ([69.252.207.114])
        by resqmta-ch2-10v.sys.comcast.net with SMTP
        id ZZSvbaFyHRingZZSvby3Uz; Tue, 16 Aug 2016 08:11:17 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-18v.sys.comcast.net with SMTP
        id ZZSube7j7QXKMZZSubSjkV; Tue, 16 Aug 2016 08:11:17 +0000
Subject: Re: [PATCH] MIPS: Fix page table corruption on THP permission
 changes.
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
References: <1466117431-18020-1-git-send-email-ddaney.cavm@gmail.com>
 <20160705151026.GN7075@linux-mips.org>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        stable@vger.kernel.org
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <ad97e83e-3fcd-4d8e-bb5d-f4ff12cf8b1a@gentoo.org>
Date:   Tue, 16 Aug 2016 04:11:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160705151026.GN7075@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAL/60gEOUppXHDasEso02klHH5RdHM/JKEj5lOv3uECVWcGvujsnyhqRz6cLKA8AxwRhG4zeI46VBWU4nryMyw8X1awSROKTnFaE7KkrYcLGFwzcIi6
 ejLEFfI9ibSycrqpb6g1yE7jueqwGSwzkQ53c1cT++ysLuX+F4Y+UjKKYKoRUxsOqxwu7anYK4D9cUVFiDEiT8gSC2Vn2aEeETl+GM59wmlu7fMYpeFqq1Nx
 A4UpO1DPiZ4Jv9KUImy4xT44BuWD7M9ezZdUjdgJBWMAve6+dqyBlsA+E2fVHGpWxCGQAZNMd7xdPM3LxglXKg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 07/05/2016 11:10, Ralf Baechle wrote:
> On Thu, Jun 16, 2016 at 03:50:31PM -0700, David Daney wrote:
> 
>> From: David Daney <david.daney@cavium.com>
>>
>> When the core THP code is modifying the permissions of a huge page it
>> calls pmd_modify(), which unfortunately was clearing the _PAGE_HUGE bit
>> of the page table entry.  The result can be kernel messages like:
>>
>> mm/memory.c:397: bad pmd 000000040080004d.
>> mm/memory.c:397: bad pmd 00000003ff00004d.
>> mm/memory.c:397: bad pmd 000000040100004d.
>>
>> or:
>>
>> ------------[ cut here ]------------
>> WARNING: at mm/mmap.c:3200 exit_mmap+0x150/0x158()
>> Modules linked in: ipv6 at24 octeon3_ethernet octeon_srio_nexus m25p80
>> CPU: 12 PID: 1295 Comm: pmderr Not tainted 3.10.87-rt80-Cavium-Octeon #4
>> Stack : 0000000040808000 0000000014009ce1 0000000000400004 ffffffff81076ba0
>>           0000000000000000 0000000000000000 ffffffff85110000 0000000000000119
>>           0000000000000004 0000000000000000 0000000000000119 43617669756d2d4f
>>           0000000000000000 ffffffff850fda40 ffffffff85110000 0000000000000000
>>           0000000000000000 0000000000000009 ffffffff809207a0 0000000000000c80
>>           ffffffff80f1bf20 0000000000000001 000000ffeca36828 0000000000000001
>>           0000000000000000 0000000000000001 000000ffeca7e700 ffffffff80886924
>>           80000003fd7a0000 80000003fd7a39b0 80000003fdea8000 ffffffff80885780
>>           80000003fdea8000 ffffffff80f12218 000000000000000c 000000000000050f
>>           0000000000000000 ffffffff80865c4c 0000000000000000 0000000000000000
>>           ...
>> Call Trace:
>> [<ffffffff80865c4c>] show_stack+0x6c/0xf8
>> [<ffffffff80885780>] warn_slowpath_common+0x78/0xa8
>> [<ffffffff809207a0>] exit_mmap+0x150/0x158
>> [<ffffffff80882d44>] mmput+0x5c/0x110
>> [<ffffffff8088b450>] do_exit+0x230/0xa68
>> [<ffffffff8088be34>] do_group_exit+0x54/0x1d0
>> [<ffffffff8088bfc0>] __wake_up_parent+0x0/0x18
>>
>> ---[ end trace c7b38293191c57dc ]---
>> BUG: Bad rss-counter state mm:80000003fa168000 idx:1 val:1536
>>
>> Fix by not clearing _PAGE_HUGE bit.
> 
> I resolved the conflict with my recent other fix for pmd_modify
> and just applied and pushed this.
> 
>   Ralf

Eh, it looks like I've stumbled into another odd corner case of THP.  Only
affects the SGI Octane so far.  So it might be an Octane bug, but I'm at a loss
to explain why/how.

If I have THP/HugeTLBFS enabled, BUT disable only CONFIG_CPU_IDLE_GOV_LADDER
(while keeping the Menu governor and basic idle support in), then on userland
boot, there's about a 1-in-2 chance it'll start to throw instruction bus
errors.  If I keep the ladder governor compiled in, no bus errors.

The other way to trigger it, regardless of the above condition, is to modify
arch/mips/kernel/idle.c and force the R1x000 CPU's to use 'r4k_wait' for
cpu_wait.  Compile and run that, and virtually an IBE on every boot.

If I disable THP/HugeTLBFS, then with either of the conditions above, the
system appears to boot fine.  I honestly have no idea if the R10000-family of
CPUs even supports the 'wait' instruction, as I can't find any solid
documentation (except for one vague NEC reference) that suggests otherwise, but
I am not seeing any illegal instruction issues arising out of its use, unless
the R10k treats it as a nop or such.

That said, THP does appear to work now on both IP27 and IP30.  IP27 seems to
run it fine w/o the CPU idle framework at all.  Doesn't hit very often in
/proc/vmstat, though.

Thoughts?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
