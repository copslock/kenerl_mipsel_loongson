Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2016 11:33:37 +0200 (CEST)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:43128 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034340AbcEZJdg3ksZz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 May 2016 11:33:36 +0200
Received: from resomta-ch2-15v.sys.comcast.net ([69.252.207.111])
        by comcast with SMTP
        id 5rfWbWpjl8DPn5rfWbg2Ll; Thu, 26 May 2016 09:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1464255210;
        bh=2ipXOqKCLhorH9TroWcnkQRU0BgOf7aUYOmGEjRdMn0=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=Mq+YABLZmP12wfvsYJYRHmBmV0A0ZF/5nzOO7e0yqyLL9o5GSGeHX0eToLJwxtQ9H
         hpxSEO4am/k0g8MqCh0gKrrkCLOjA2aQOy3Pk4x1CQd2A1gBlYJ0Q+4YFbB68MyutW
         HRxtZhnQGtHRctfMwevQlaYpAGW6J7lnboriF1orurYI14YOJpwlJaXj5S1wi+QUDs
         0Dkxntyro9rVMRzveqx5pgpHQM0o0LtRboMQ/shpQXC1lHRq0MsZNwnUy+Ai47aEXH
         XmPy5SRBIyAXVLMswvi/8TyWYvPD0erOvIOvaWkel3WAdllaEsFXLlNMxDKxZWTYfV
         A6CgYvtvnOHGg==
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-15v.sys.comcast.net with comcast
        id yxZU1s00D0w5D3801xZVbb; Thu, 26 May 2016 09:33:30 +0000
Subject: Re: THP broken on OCTEON?
To:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160525134152.GG23204@ak-desktop.emea.nsn-net.net>
Cc:     David Daney <ddaney.cavm@gmail.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <e64bac43-7524-1656-fa57-c1bd7f48c026@gentoo.org>
Date:   Thu, 26 May 2016 05:33:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160525134152.GG23204@ak-desktop.emea.nsn-net.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53661
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

On 05/25/2016 09:41, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
>> I'm getting kernel crashes (see below) reliably when building Perl in
>> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
>> Linux 4.6.
>>
>> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
>> issue - disabling it makes build go through fine.
> 
> Seems to be also reproducible on MIPS64/Malta/QEMU (UP, 2 GB RAM). This
> happened during Perl's Configure script on the first try:
> 
> ...

What do you have for CONFIG_FORCE_MAX_ZONEORDER?  I don't see that in your
config?  Also, what do you have for CONFIG_PAGE_SIZE_*?



> killpg() found.
>  
> lchown() found.
>  
> LDBL_DIG found.
>  
> <math.h> found.
>  
> Checking to see if your libm supports _LIB_VERSION...
> [ 1180.488704] Data bus error, epc == 000000fff4c0ae10, ra == 000000fff4df5d3c
> [ 1180.650437] Unhandled kernel unaligned access[#1]:

Unhandled kernel unaligned access is one of the errors I got before under THP
on the IP27 as well.  This can't be coincidental.


> [ 1180.651021] CPU: 0 PID: 3213 Comm: ld Not tainted 4.6.0-mipsqemu-distro.git-v2.16-3-g8f2e042-dirty-00002-g97bf1a1 #1
> [ 1180.651619] task: 98000000fdc6e300 ti: 98000000fdd98000 task.ti: 98000000fdd98000
> [ 1180.652049] $ 0   : 0000000000000000 ffffffff8021b2c8 9800000001000600 00000000f1a005bf
> [ 1180.652928] $ 4   : 00000000f1a005bf 0000000120200000 00000000000f1a00 0000000000100077
> [ 1180.653417] $ 8   : 000000000000001c 98000000fdd9ba60 98000000fdd9ba68 0000000000000000
> [ 1180.653852] $12   : 98000000fdd9ba58 000000000000a400 0000000000000000 0000000000000000
> [ 1180.654309] $16   : 0000000120200000 0000000120200000 0000000120200000 98000000fdcfd500
> [ 1180.654764] $20   : 0000000000000000 ffffffff80e10000 0000000000000003 00000001206f5000
> [ 1180.655220] $24   : 0000000000000000 ffffffff801629d0                                  
> [ 1180.655725] $28   : 98000000fdd98000 98000000fdd9ba20 0000000000000000 ffffffff8021b2c8
> [ 1180.656219] Hi    : 00000000002d4e00
> [ 1180.656453] Lo    : 00000000000f1a00
> [ 1180.657115] epc   : ffffffff8012c990 r4k_flush_cache_page+0x80/0x4f0
> [ 1180.657529] ra    : ffffffff8021b2c8 get_dump_page+0x90/0xb8
> [ 1180.657809] Status: 1400a4e3	KX SX UX KERNEL EXL IE 
> [ 1180.658268] Cause : 00800010 (ExcCode 04)
> [ 1180.658500] BadVA : 00000000f1a005bf
> [ 1180.658703] PrId  : 000182a0 (MIPS 20Kc)
> [ 1180.658931] Modules linked in: autofs4
> [ 1180.659360] Process ld (pid: 3213, threadinfo=98000000fdd98000, task=98000000fdc6e300, tls=000000fff4eba700)
> [ 1180.659821] Stack : 0000000120200000 98000000fdee2480 0000000120200000 98000000fdee2a80
> 	  0000000000000000 98000000fdc95580 0000000000000003 ffffffff8021b2c8
> 	  98000000044db600 98000000fdc95580 98000000fe602100 ffffffff802ad418
> 	  98000000fe636800 ffffffff806c0188 0000000300000088 98000000fe602300
> 	  ffffffff806c0188 5349474900000080 98000000fdd9bae8 ffffffff806c0188
> 	  0000000600000120 98000000fdcfd630 ffffffff806c0188 46494c45000004c7
> 	  c000000000171000 0000000a00000080 0000000000000000 0000000000000000
> 	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> 	  ...
> [ 1180.664677] Call Trace:
> [ 1180.665054] [<ffffffff8012c990>] r4k_flush_cache_page+0x80/0x4f0
> [ 1180.666422] [<ffffffff8021b2c8>] get_dump_page+0x90/0xb8
> [ 1180.667099] [<ffffffff802ad418>] elf_core_dump+0x11a0/0x1350
> [ 1180.667813] [<ffffffff802b1b30>] do_coredump+0x5a0/0xdf0
> [ 1180.668500] [<ffffffff80143bfc>] get_signal+0x2bc/0x688
> [ 1180.669172] [<ffffffff8010a874>] do_signal+0x24/0x1e8
> [ 1180.669808] [<ffffffff8010b740>] do_notify_resume+0xa8/0xc8
> [ 1180.670504] [<ffffffff80105d00>] work_notifysig+0x10/0x18
> [ 1180.671514] 
> [ 1180.671806] 
> Code: 00111a7a  30630ff8  0064182d <dc630000> 30640001  1080005b  00000000  df840000  dc8402b8 
> [ 1180.674251] ---[ end trace b03bb9be4922a576 ]---
> [ 1180.675178] Fatal exception: panic in 5 seconds
> [ 1185.681555] Kernel panic - not syncing: Fatal exception
> [ 1185.682849] ---[ end Kernel panic - not syncing: Fatal exception
> 

[snip]

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
