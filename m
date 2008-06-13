Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 16:06:09 +0100 (BST)
Received: from jehova.dsm.dk ([80.199.102.117]:25545 "EHLO jehova.dsm.dk")
	by ftp.linux-mips.org with ESMTP id S20035402AbYFMPGF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2008 16:06:05 +0100
Received: (qmail 26119 invoked by uid 1000); 13 Jun 2008 15:06:03 -0000
Date:	Fri, 13 Jun 2008 16:06:03 +0100 (BST)
From:	Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To:	linux-mips@linux-mips.org
cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [BUG] R5000 failure in kmap_coherent on Lasat board, bug that has
 been there for a while?
Message-ID: <Pine.LNX.4.40.0806131600540.25629-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <th@jehova.dsm.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@horsten.com
Precedence: bulk
X-list: linux-mips

Hi all,

(resending w/ more info because the first one didn't make it to the
list - I'm subscribed now so hopefully it'll go through this time):

This crash happens (late) during boot with 2.6.25.6. I think this is a
general R5k issue with the cache handling code. It only seems to
happen when the swap is in use like someone else observed, but usually
only after some big processes like mysql have been started.

As far as I can see it's the same issue that has been reported several
other places, but with no resolution in any of them:

http://www.linux-mips.org/archives/linux-mips/2007-12/msg00128.html
http://www.linux-mips.org/archives/linux-mips/2008-01/msg00132.html
and also seen by someone else here:
http://lists.debian.org/debian-mips/2007/11/msg00034.html

I'm thinking some subtle difference between R4k and R5k caches which
isn't taken into account, or an aliasing bug that only triggers on
R5k?

I also found what seems to be a related patch from OpenWRT but I have
no idea what it's supposed to solve as I could only find the raw
patch:

https://dev.openwrt.org/browser/trunk/target/linux/brcm47xx/patches-2.6.25/160-kmap_coherent.patch?rev=11155

In any case I tried to apply it to my Lasat kernel, but using the
_atomic functions instead of _coherent just causes a much earlier
crash.

Here's the output, hopefully without split long lines..:

Kernel bug detected[#1]:
Cpu 0
$ 0   : 00000000 90008401 00000001 00081c40
$ 4   : 81081c40 7f810000 81000000 000040e2
$ 8   : 80350000 1000001e 00000000 86908000
$12   : 312d0000 00000001 00000000 00000000
$16   : 7f810000 00100177 87d545e0 00000000
$20   : 80333740 838b84c4 7f8105dc 87d545e0
$24   : 00000000 2b0cffe0
$28   : 86a6e000 86a6fd90 040e2603 80011674
Hi    : 307f9ded
Lo    : 12c81c40
epc   : 8000e75c kmap_coherent+0xc/0xe0     Not tainted
ra    : 80011674 local_r4k_flush_cache_page+0x1a4/0x2c4
Status: 90008403    KERNEL EXL IE
Cause : 00000034
PrId  : 00002340 (R5000)
Modules linked in: nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs ipv6 xt_mark cls_u32 cls_fw xt_dscp xt_MARK sch_sfq sch_htb iptable_mangle iptable_nat xt_conntrack xt_tcpudp ipt_LOG iptable_filter ip_tables x_tables nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_nat nf_conntrack_ipv4 nf_conntrack_ftp nf_conntrack pata_cmd64x ata_generic libata scsi_mod ide_pci_generic ohci1394 ieee1394 ehci_hcd uhci_hcd usbcore
Process sshd (pid: 4991, threadinfo=86a6e000, task=87d884f0)
Stack : 8006307c 80063074 1000109c 001200d2 00000000 81081c40 86978040 00000000
        80333740 80011820 80086940 00000922 00000004 01242000 838b84c4 7f8105dc
        000040e2 00000000 8007882c 80078804 0000000b 0040b000 810deda0 2aac5000
        838b84c4 040e2603 8034ee80 7f8105dc 00000001 8391c7f8 00000040 7f8105dc
        838b84c4 8007ab74 2aac5000 003ff000 2aac5000 8007939c 8391c7f8 87d54620
        ...
Call Trace:
[<8000e75c>] kmap_coherent+0xc/0xe0
[<80011674>] local_r4k_flush_cache_page+0x1a4/0x2c4
[<80011820>] r4k_flush_cache_page+0x1c/0x28
[<8007882c>] do_wp_page+0x240/0x81c
[<8007ab74>] handle_mm_fault+0x684/0x7e0
[<8000e4e0>] do_page_fault+0x130/0x3a0
[<80003520>] ret_from_exception+0x0/0x20


Code: 8c820000  00021242  30420001 <00028036> 8f820014  3c038035  24420001  af820014  8c62ef20
Kernel bug detected[#2]:
Cpu 0
$ 0   : 00000000 90008401 00000001 0001fec0
$ 4   : 8101fec0 7fd89000 81000000 00000ff6
$ 8   : 80350000 00ff6603 00000040 00000001
$12   : 802fedc4 87cd8bd4 00001000 00000000
$16   : 7fd89000 00100177 87d16e40 868421d0
$20   : 80333740 8101fec0 00000000 87c2dab8
$24   : 00000001 8014dbc8
$28   : 87c2c000 87c2d9a8 00100100 80011674
Hi    : 3080257a
Lo    : 94a6b960
epc   : 8000e75c kmap_coherent+0xc/0xe0     Tainted: G      D
ra    : 80011674 local_r4k_flush_cache_page+0x1a4/0x2c4
Status: 90008403    KERNEL EXL IE
Cause : 00000034
PrId  : 00002340 (R5000)
Modules linked in: nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs ipv6 xt_mark cls_u32 cls_fw xt_dscp xt_MARK sch_sfq sch_htb iptable_mangle iptable_nat xt_conntrack xt_tcpudp ipt_LOG iptable_filter ip_tables x_tables nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_nat nf_conntrack_ipv4 nf_conntrack_ftp nf_conntrack pata_cmd64x ata_generic libata scsi_mod ide_pci_generic ohci1394 ieee1394 ehci_hcd uhci_hcd usbcore
Process khelper (pid: 6, threadinfo=87c2c000, task=87c164b0)
Stack : 817dca40 841af7b8 860e64e0 800c9b88 7fd89000 86820624 87d16e40 868421d0
        00000000 80011820 80150528 87a8017c 80162ac0 802fe6fc 868421d0 7fd89000
        00000ff6 86652e9c 800825d4 00000004 87e177e0 00000000 00000000 00000010
        87d16e80 810dd260 868421d0 87c4ce40 8101fec0 00000001 87c4ce41 00000000
        8008286c 00000000 838b47d0 0000003f 87d86bf0 00000026 80084c10 800c9d58
        ...
Call Trace:
[<8000e75c>] kmap_coherent+0xc/0xe0
[<80011674>] local_r4k_flush_cache_page+0x1a4/0x2c4
[<80011820>] r4k_flush_cache_page+0x1c/0x28
[<800825d4>] try_to_unmap_one+0x154/0x2cc
[<8008286c>] try_to_unmap+0x120/0x584
[<80073a0c>] shrink_page_list+0x29c/0xd08
[<80074658>] shrink_inactive_list+0x1e0/0x86c
[<80074d94>] shrink_zone+0xb0/0x130
[<8007523c>] try_to_free_pages+0x174/0x2d0
[<8006b2e0>] __alloc_pages+0x174/0x3e0
[<8008fa88>] cache_alloc_refill+0x35c/0x7cc
[<8008f724>] kmem_cache_alloc+0xdc/0xe4
[<80025630>] copy_process+0x114/0x1a5c
[<8002726c>] do_fork+0x70/0x300
[<80005778>] kernel_thread+0x7c/0x98
[<8003ce4c>] __call_usermodehelper+0x3c/0xb8
[<8003d860>] run_workqueue+0xa0/0x24c
[<8003e77c>] worker_thread+0x74/0x118
[<800427a0>] kthread+0x80/0xa8
[<800057a4>] kernel_thread_helper+0x10/0x18


Code: 8c820000  00021242  30420001 <00028036> 8f820014  3c038035  24420001  af820014  8c62ef20
Kernel bug detected[#3]:
Cpu 0
$ 0   : 00000000 90008401 00000001 0004d5c0
$ 4   : 8104d5c0 7fb8c000 81000000 000026ae
$ 8   : 80350000 1000001e 00000000 00000000
$12   : 00000000 00000000 e357dc80 00000080
$16   : 7fb8c000 00100177 87d54a00 00000000
$20   : 80333740 8394617c 7fb8c600 87d54a00
$24   : 00000000 8026c990
$28   : 83874000 83875c98 026ae603 80011674
Hi    : 3080de35
Lo    : ed44d5c0
epc   : 8000e75c kmap_coherent+0xc/0xe0     Tainted: G      D
ra    : 80011674 local_r4k_flush_cache_page+0x1a4/0x2c4
Status: 90008403    KERNEL EXL IE
Cause : 00000034
PrId  : 00002340 (R5000)
Modules linked in: nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs ipv6 xt_mark cls_u32 cls_fw xt_dscp xt_MARK sch_sfq sch_htb iptable_mangle iptable_nat xt_conntrack xt_tcpudp ipt_LOG iptable_filter ip_tables x_tables nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_nat nf_conntrack_ipv4 nf_conntrack_ftp nf_conntrack pata_cmd64x ata_generic libata scsi_mod ide_pci_generic ohci1394 ieee1394 ehci_hcd uhci_hcd usbcore
Process xfs (pid: 5087, threadinfo=83874000, task=8387eda0)
Stack : 00000c8c 80333740 8010c350 800fb744 00000000 8104d5c0 83967e30 00000000
        80333740 80011820 80086940 00000000 83875dc0 10014a40 8394617c 7fb8c600
        000026ae 00000000 8007882c 80078804 00000000 00000c8c 00000c8c 80023588
        8394617c 026ae603 8034ee80 7fb8c600 00000001 8394f7f8 00000e30 7fb8c600
        8394617c 8007ab74 00000000 00000000 00000000 802f8000 8394f7f8 87d54a40
        ...
Call Trace:
[<8000e75c>] kmap_coherent+0xc/0xe0
[<80011674>] local_r4k_flush_cache_page+0x1a4/0x2c4
[<80011820>] r4k_flush_cache_page+0x1c/0x28
[<8007882c>] do_wp_page+0x240/0x81c
[<8007ab74>] handle_mm_fault+0x684/0x7e0
[<8000e4e0>] do_page_fault+0x130/0x3a0
[<80003520>] ret_from_exception+0x0/0x20
[<80168338>] __copy_user+0xd4/0x2bc
[<800a6ac4>] sys_select+0x230/0x268
[<8000c24c>] stack_done+0x20/0x3c


Code: 8c820000  00021242  30420001 <00028036> 8f820014  3c038035  24420001  af820014  8c62ef20

I've got a couple of other fixes for Lasat boards (interrupts were
completely broken), which I'll submit later but it won't be much use if
this doesn't get addressed first and I'm not at all sure what's going on
here.

I'd really like to get the latest kernel back to working on Lasat
boards, and will try any suggestions.

// Thomas
