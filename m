Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Oct 2007 08:08:25 +0100 (BST)
Received: from host160-223-dynamic.15-87-r.retail.telecomitalia.it ([87.15.223.160]:40405
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022156AbXJFHIR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 6 Oct 2007 08:08:17 +0100
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with smtp (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Ie3li-0000Zb-OH
	for linux-mips@linux-mips.org; Sat, 06 Oct 2007 09:08:12 +0200
Date:	Sat, 6 Oct 2007 09:08:09 +0200
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Subject: Re: kernel bug using 2.6.23-rc9
Message-Id: <20071006090809.bb738bab.giuseppe@eppesuigoccas.homedns.org>
In-Reply-To: <20071005122543.GB22239@linux-mips.org>
References: <1191502153.10050.15.camel@scarafaggio>
	<20071005122543.GB22239@linux-mips.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

On Fri, 5 Oct 2007 13:25:43 +0100 Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Oct 04, 2007 at 02:49:13PM +0200, Giuseppe Sacco wrote:
> 
> > Hi, while testing the latest kernel on SGI O2 I got may kernel bugs like
> > this:
[...]
> Very interesting.  Can you describe me your setup or maybe even come up
> with a test case for this?

I may reproduce it without problems. The failing command is "ps aux". Once the command starts, the kernel log the bug and the command stay blocked: no shell prompt, no control-c working. Since the ps command does not work, I cannot check the prosess status :-)

This is a new log:

Code: 0002127a  00021000  30420001 <00028036> 8f820024  00052b3a  24420001  af820024  3c0236db 
Kernel bug detected[#2]:
Cpu 0
$ 0   : 0000000000000000 ffffffff804a0000 0000000000000001 0000000000002f18
$ 4   : 980000000101cff8 000000007f94bf18 000000007f94bf18 6800000000000000
$ 8   : 0000000000000849 000000007f94bf18 980000000461bd68 980000000461bd60
$12   : 0000000000000010 ffffffff80000008 ffffffff800a3810 0000000000000000
$16   : 980000000101cff8 98000000035a3dd0 000000000000000e 000000007f94bf18
$20   : 98000000005d4048 9800000000506360 980000000461bd68 980000000461bd60
$24   : 0000000000000000 000000002abcc580                                  
$28   : 9800000004618000 980000000461bcd0 0000000000000000 ffffffff8001da30
Hi    : 00000000000018db
Lo    : 0000000000000849
epc   : ffffffff8001f1e0 kmap_coherent+0x10/0x128     Tainted: G      D
ra    : ffffffff8001da30 __flush_anon_page+0x90/0xc0
Status: 9001fce3    KX SX UX KERNEL EXL IE 
Cause : 00000034
PrId  : 00002321
Modules linked in: parport_pc lp parport ppp_deflate zlib_deflate bsd_comp ppp_async crc_ccitt ip_tables x_table
s ipv6 ppp_generic slhc dm_snapshot dm_mirror dm_mod ehci_hcd ohci_hcd r8169 usbcore sg evdev
Process pidof (pid: 26867, threadinfo=9800000004618000, task=9800000001ea4cc8)
Stack : ffffffff80089844 ffffffff80089424 0000000000000010 0000000000000000
        0000000000000001 980000000461bd68 980000000461bd60 0000000000000000
        9800000000506360 000000007f94bf18 9800000005dfb000 000000000000000f
        9800000000506360 0000000000000000 98000000005d4048 980000000461bd68
        9800000000000000 ffffffff80089a0c 0000000000000000 980000000101cff8
        98000000005063c0 9800000005dfb000 9800000000506360 9800000005dfb000
        000000000000000f 0000000000000000 98000000005d4048 980000000461be88
        0000000000001000 000000007ff77c40 000000007ff77b40 ffffffff800f82f8
        9800000005dfb000 98000000005d4048 fffffffffffffff4 98000000078516d8
        0000000000000400 980000000461be88 000000002aac0000 ffffffff800faaec
        ...
Call Trace:
[<ffffffff8001f1e0>] kmap_coherent+0x10/0x128
[<ffffffff8001da30>] __flush_anon_page+0x90/0xc0
[<ffffffff80089844>] get_user_pages+0x49c/0x538
[<ffffffff80089a0c>] access_process_vm+0x12c/0x228
[<ffffffff800f82f8>] proc_pid_cmdline+0xa8/0x170
[<ffffffff800faaec>] proc_info_read+0x13c/0x180
[<ffffffff800a33b0>] vfs_read+0xf0/0x190
[<ffffffff800a385c>] sys_read+0x4c/0x90
[<ffffffff8001c674>] handle_sys+0x134/0x150

Code: 0002127a  00021000  30420001 <00028036> 8f820024  00052b3a  24420001  af820024  3c0236db 


In order to collect more information, I tried "strace ps aux". The last lines printed are:

stat("/proc/313", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/proc/313/stat", O_RDONLY)        = 6
read(6, "313 (kjournald) S 2 0 0 0 -1 328"..., 1023) = 157
close(6)                                = 0
open("/proc/313/status", O_RDONLY)      = 6
read(6, "Name:\tkjournald\nState:\tS (sleepi"..., 1023) = 489
close(6)                                = 0
open("/proc/313/cmdline", O_RDONLY)     = 6
read(6, "", 2047)                       = 0
close(6)                                = 0
stat64(0x2aca5318, 0x7fd6e228)          = 0
write(1, "root       313  0.0  0.0      0 "..., 77root       313  0.0  0.0      0     0 ?        S<   Oct05   0:15 [kjournald]
) = 77
stat("/proc/422", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
open("/proc/422/stat", O_RDONLY)        = 6
read(6, "422 (udevd) D 1 422 422 0 -1 420"..., 1023) = 217
close(6)                                = 0
open("/proc/422/status", O_RDONLY)      = 6
read(6, "Name:\tudevd\nState:\tD (disk sleep"..., 1023) = 677
close(6)                                = 0
open("/proc/422/cmdline", O_RDONLY)     = 6
