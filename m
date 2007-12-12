Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 06:41:17 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:45013 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20030236AbXLLGlI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 06:41:08 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 43AD23110FA;
	Wed, 12 Dec 2007 06:40:57 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 12 Dec 2007 06:40:56 +0000 (UTC)
Received: from [192.168.7.224] ([192.168.7.224]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 11 Dec 2007 22:40:50 -0800
Message-ID: <475F8272.6040702@avtrex.com>
Date:	Tue, 11 Dec 2007 22:40:50 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	Florian Lohoff <flo@rfc822.org>
Subject: Re: 2.6.24-rc2 crash in kmap_coherent
References: <20071211221327.GB2150@paradigm.rfc822.org> <475F13F1.2050109@avtrex.com>
In-Reply-To: <475F13F1.2050109@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2007 06:40:51.0046 (UTC) FILETIME=[EFBE2060:01C83C89]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Florian Lohoff wrote:
>> Hi,
>> i just discovered that my native gcc build on one of my Indys stopped. I
>> found this in the dmesg ;)
>>
>> Its a 2.6.24-rc2 on an R5k Indy 64M:
>>
>> Kernel bug detected[#1]:
>> Cpu 0
>> $ 0   : 0000000000000000 ffffffff9000cce0 0000000000000001
>> ffffffff80000000
>> $ 4   : ffffffff8921f910 000000007fda0f05 000000007fda0f05
>> ffffffff8b8ea000
>> $ 8   : ffffffff89b4ef05 000000000000000e ffffffff8921f910
>> 0000000000000f05
>> $12   : 0000000000000000 ffffffff80000008 ffffffff88090010
>> 00000000004038b4
>> $16   : ffffffff8921f910 000000007fda0f05 ffffffff8b8ea000
>> 000000000000000e
>> $20   : ffffffff8bdfb920 0000000000000000 ffffffff8bd88cc0
>> ffffffff8893fd58
>> $24   : 0000000000000006
>> ffffffff8801df00                                  $28   :
>> ffffffff8893c000 ffffffff8893fd20 ffffffff88430000 ffffffff8801c010
>> Hi    : 000000000001d1ea
>> Lo    : 0000000000009b4e
>> epc   : ffffffff8801bcf0 kmap_coherent+0x10/0x130     Not tainted
>> ra    : ffffffff8801c010 copy_from_user_page+0x40/0xb0
>> Status: 9000cce3    KX SX UX KERNEL EXL IE Cause : 00000034
>> PrId  : 00002321 (R5000)
>> Modules linked in: dm_snapshot dm_mirror dm_mod ipv6
>> Process cat (pid: 14553, threadinfo=ffffffff8893c000,
>> task=ffffffff88a52660)
>> Stack : 000000000000000e 000000007fda0f05 ffffffff8b8ea000
>> 0000000000000000
>>         ffffffff88079d10 ffffffff88079cc4 ffffffff8bfbd528
>> ffffffff8921f910
>>         ffffffff8bdfb980 ffffffff8b8ea000 ffffffff8bdfb920
>> 0000000000000000
>>         ffffffff8b8ea000 000000000000000e ffffffff8bd88cc0
>> ffffffff8893fe78
>>         0000000000447000 000000000052c7d8 0000000000000000
>> ffffffff880d9014
>>         ffffffff8bd88cc0 ffffffff8b8ea000 fffffffffffffff4
>> ffffffff8b863248
>>         0000000000000400 ffffffff8893fe78 0000000000447000
>> ffffffff880db188
>>         ffffffff8be6f6e0 0000000000000400 0000000000447000
>> ffffffff8893fe78
>>         0000000000447000 0000000000000003 0000000000000016
>> ffffffff8808fbdc
>>         ffffffff8be6f6e0 0000000000000400 0000000000447000
>> fffffffffffffff7
>>         ...
>> Call Trace:
>> [<ffffffff8801bcf0>] kmap_coherent+0x10/0x130
>> [<ffffffff8801c010>] copy_from_user_page+0x40/0xb0
>> [<ffffffff88079d10>] access_process_vm+0x168/0x1d8
>> [<ffffffff880d9014>] proc_pid_cmdline+0xac/0x140
>> [<ffffffff880db188>] proc_info_read+0x108/0x150
>> [<ffffffff8808fbdc>] vfs_read+0xec/0x178
>> [<ffffffff88090060>] sys_read+0x50/0x98
>> [<ffffffff88019718>] handle_sys+0x118/0x134
>>
>>
>> Code: 0002127a  00021000  30420001 <00028036> 8f820024  3c038843 
>> 24420001  af820024  dc62f390
>
> FWIW I get something very similar reading /proc/1/cmdline on
> 2.6.23-1/ip32 w/ R5000 and there have been other similar postings here
> recently.
>
> Maybe one day I will look into it, but it probably will not be real
> soon...
>
Here is some further data:
# cat /proc/version
Linux version 2.6.23.1-DD_Patched (daney@silver64.hq2.avtrex.com) (gcc
version 4.2.3 20071029 (prerelease)) #7 Sun Oct 28 23:40:58 PDT 2007
# cat /proc/cpuinfo
system type             : SGI O2
processor               : 0
cpu model               : R5000 V2.1  FPU V1.0
BogoMIPS                : 199.68
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 48
extra interrupt vector  : no
hardware watchpoint     : no
ASEs implemented        :
VCED exceptions         : not available
VCEI exceptions         : not available

Kernel bug detected[#3]:
Cpu 0
$ 0   : 0000000000000000 ffffffff80450000 0000000000000001 0000000000002ee4
$ 4   : 980000000116f2f8 000000007ffc3ee4 00000000068e9603 0000000000100177
$ 8   : 000000007ffc3ee4 000000000000000e 0000000000000000 9800000005e7bd60
$12   : 0000000000000000 ffffffff80000008 ffffffff800a4958 00000000004038b4
$16   : 980000000116f2f8 000000000000000e 980000000d9a02a8 000000007ffc3ee4
$20   : 980000000bba2ce8 980000000b402cc0 9800000005e7bd60 9800000005e7bd68
$24   : 0000000000000006 000000002ab9d1f4                                 
$28   : 9800000005e78000 9800000005e7bcc0 0000000000000000 ffffffff8001db68
Hi    : 0000000000013abb
Lo    : 00000000000068e9
epc   : ffffffff8001f370 kmap_coherent+0x10/0x128     Tainted: G      D
ra    : ffffffff8001db68 __flush_anon_page+0x90/0xc0
Status: b001fce3    KX SX UX KERNEL EXL IE
Cause : 00000034
PrId  : 00002321
Modules linked in: ipv6 dm_snapshot dm_mirror dm_mod sg evdev
Process cat (pid: 2851, threadinfo=9800000005e78000, task=980000000bd08cc8)
Stack : ffffffff8008a4a0 ffffffff8008a0c0 0000000000000001 0000000000000000
        9800000005e7bd68 9800000005e7bd60 0000000000000010 0000000000000006
        000000000000000e 0000000000000044 980000000b402cc0 980000000978d000
        0000000000000012 000000007ffc3ee4 980000000978d000 0000000000000012
        980000000b402cc0 0000000000000000 980000000bba2ce8 ffffffff8008a650
        0000000000000000 980000000116f2f8 980000000b402d20 980000000978d000
        980000000b402cc0 980000000978d000 0000000000000012 0000000000000000
        980000000bba2ce8 0000000000448000 0000000000001000 0000000000530328
        0000000000000000 ffffffff800f8c20 980000000978d000 980000000bba2ce8
        9800000009a49920 0000000000000400 9800000005e7be88 0000000000448000
        ...
Call Trace:
[<ffffffff8001f370>] kmap_coherent+0x10/0x128
[<ffffffff8001db68>] __flush_anon_page+0x90/0xc0
[<ffffffff8008a4a0>] get_user_pages+0x478/0x4f8
[<ffffffff8008a650>] access_process_vm+0x130/0x230
[<ffffffff800f8c20>] proc_pid_cmdline+0xa8/0x170
[<ffffffff800fb368>] proc_info_read+0x120/0x190
[<ffffffff800a44b8>] vfs_read+0xc0/0x160
[<ffffffff800a49a0>] sys_read+0x48/0xb0
[<ffffffff8001c7b4>] handle_sys+0x134/0x150


Code: 0002127a  00021000  30420001 <00028036> 8f820024  00052b3a 
24420001  af820024  3c0236db

This is the result of doing: cat /proc/2818/cmdline

2818 is sshd, but I think that does not really matter.  Before any pages
had been swapped out I was able to get the command line.  Then I did
some work (run gdb on a very large program) that caused some pages to be
swapped out.  After that the cat fails with a SIGSEGV in sys_read and
the above trace is produced.

My theory is that if the page containing the command line is present,
all is OK, but if it has been swapped out this happens.  However if I
turn off the swap device after the first occurrence of the problem, it
does not seem to correct itself, so I don't really know what is causing it.

The fault is caused by a 'tne' instruction in the first statement of
kmap_coherent in arch/mips/mm/init.c:
    BUG_ON(Page_dcache_dirty(page));

There seems to be a bit of a logic error here:

void __flush_anon_page(struct page *page, unsigned long vmaddr)
{
    if (pages_do_alias((unsigned long)page_address(page), vmaddr)) {
        void *kaddr;

        kaddr = kmap_coherent(page, vmaddr);
        flush_data_cache_page((unsigned long)kaddr);
        kunmap_coherent();
    }
}

We are calling kmap_coherent so that we can flush the cache for the
page, but the first thing kmap_coherent does is BUG_ON if the cache is
dirty...
