Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 13:48:43 +0100 (BST)
Received: from host191-212-dynamic.8-87-r.retail.telecomitalia.it ([87.8.212.191]:3981
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20023250AbXJDMsd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 13:48:33 +0100
Received: from [81.30.2.2] (helo=[192.168.12.252])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IdQ7r-00081C-Ca; Thu, 04 Oct 2007 14:48:25 +0200
Subject: kernel bug using 2.6.23-rc9
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Thu, 04 Oct 2007 14:49:13 +0200
Message-Id: <1191502153.10050.15.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi, while testing the latest kernel on SGI O2 I got may kernel bugs like
this:

Kernel bug detected[#9]:
Cpu 0
$ 0   : 0000000000000000 ffffffff9001fce0 0000000000000001 0000000000000f18
$ 4   : 980000000111b4b8 000000007f955f18 ffffffff80400000 0000000000003fff
$ 8   : 00000000000050f1 000000007f955f18 9800000006073d68 9800000006073d60
$12   : 0000000000000010 ffffffff80000008 ffffffff80091680 0000000000000000
$16   : 980000000111b4b8 980000000768ddd0 000000000000000e 000000007f955f18
$20   : 9800000000581908 9800000007898080 9800000006073d68 9800000006073d60
$24   : 0000000000478284 000000002ac30580                                  
$28   : 9800000006070000 9800000006073cd0 0000000000000000 ffffffff8001b390
Hi    : 000000000000f2d3
Lo    : 00000000000050f1
epc   : ffffffff8001c800 kmap_coherent+0x10/0x118     Tainted: G      D
ra    : ffffffff8001b390 __flush_anon_page+0x70/0x90
Status: 9001fce3    KX SX UX KERNEL EXL IE 
Cause : 00000034
PrId  : 00002321
Modules linked in: ppp_deflate zlib_deflate bsd_comp iptable_filter ipt_MASQUERADE xt_tcpudp iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack nfnetlink ppp_async crc_ccitt ip_tables x_tables ppp_generic slhc dm_snapshot dm_mirror dm_mod ehci_hcd ohci_hcd r8169 usbcore evdev
Process ps (pid: 30124, threadinfo=9800000006070000, task=98000000076c5908)
Stack : ffffffff80079dcc ffffffff80079b6c 0000000000000010 0000000000000000
        0000000000000001 9800000006073d68 9800000006073d60 0000000000000000
        9800000007898080 000000007f955f18 98000000015b0000 000000000000000f
        9800000007898080 0000000000000000 9800000000581908 9800000006073d68
        9800000000000000 ffffffff8007a11c 0000000000000000 980000000111b4b8
        98000000078980e0 98000000015b0000 9800000007898080 98000000015b0000
        000000000000000f 0000000000000000 9800000000581908 9800000006073e88
        0000000000001000 0000000000000000 0000000000000040 ffffffff800e0098
        98000000015b0000 9800000000581908 fffffffffffffff4 980000000164d6c0
        00000000000007ff 9800000006073e88 000000007fd4cce8 ffffffff800e25dc
        ...
Call Trace:
[<ffffffff8001c800>] kmap_coherent+0x10/0x118
[<ffffffff8001b390>] __flush_anon_page+0x70/0x90
[<ffffffff80079dcc>] get_user_pages+0x2dc/0x510
[<ffffffff8007a11c>] access_process_vm+0x11c/0x218
[<ffffffff800e0098>] proc_pid_cmdline+0xa8/0x170
[<ffffffff800e25dc>] proc_info_read+0x13c/0x180
[<ffffffff80091220>] vfs_read+0xc0/0x160
[<ffffffff800916cc>] sys_read+0x4c/0x90
[<ffffffff8001a1d4>] handle_sys+0x114/0x130


Code: 0002127a  00021000  30420001 <00028036> 8f820024  3c038048  24420001  af820024  dc62f100 
