Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Nov 2010 15:48:14 +0100 (CET)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:40158 "EHLO
        mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492181Ab0KZOsK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Nov 2010 15:48:10 +0100
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id 40E701B4241;
        Fri, 26 Nov 2010 23:48:06 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Fri, 26 Nov 2010 23:48:06 +0900 (JST)
Date:   Fri, 26 Nov 2010 23:48:00 +0900 (JST)
Message-Id: <20101126.234800.21368703.anemo@mba.ocn.ne.jp>
To:     gary.murray@lakecommunications.com
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS register crobbeled during running thread
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <OFE79B8022.22148C23-ON802577E5.00443DB9-802577E5.00495F5C@lakecommunications.com>
References: <OFE79B8022.22148C23-ON802577E5.00443DB9-802577E5.00495F5C@lakecommunications.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 24 Nov 2010 13:21:25 +0000, gary.murray@lakecommunications.com wrote:
> The goal of this post is to jog the memory of the MIPS community.  We are 
> working of an old kernel 2.6.20.19. Unfortunately we are not in a position 
> to upgrade our kernel at this time. We understand by doing so our problems 
> could potentially disappear. But hopefully with the following description 
> and detailed analysis some of you will recognize it. 

You should post mail in text format not in HTML, otherwise your mail
will be filtered out.

> Our problem is essentially a register value changes under the running 
> thread resulting in kernel oops and panics.  The frequency of occurrence 
> is completely spurious as are the resulting oops reports i.e. it may take 
> 30 Hours for the issue to occur.   In trawling the archives we noticed two 
> patches dealing with context switching, saving and restoring registers. 
> The first patch "Disallow CpU exception in kernel again" was removed and 
> superseded.  Our kernel version includes these changes, but as they are 
> relatively new, maybe additional functionality or bug fixes occurred in 
> later releases.  Our kernel is configured with preempt enabled.
> 
> The PATCH "Retry {save,restore}_fp_context if failed in atomic context".
> http://www.linux-mips.org/archives/linux-mips/2007-04/msg00087.html
> 
> The patch first appeared in mainline 2.6.21.1.  There were some minor 
> tweaks that were cosmetic in nature. 
> 
> Below is an analysis of a kernel oops with disassembly demonstrating a 
> register change.  Note our kernel contains this patch, but this patch is 
> the most relevant resembling or addressing our problems. The issue could 
> very well be HW related. 

Your analysis looks correct, but I think above patches are irrelevant
since they are fixes for FPU registers, not for general purpose
registers.

> CPU 0 Unable to handle kernel paging request at virtual address 03c9dabc, 
> epc == 800af9c8, ra == 800af974
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 00000001 00000001 00020000
> $ 4   : 00000001 82ab0228 00000000 834c31f8
> $ 8   : 00000000 00000000 00000001 00000000         t0, t1, t2, t3
> $12   : 03c9da80 80393a80 00000000 00000000         t4, t5, t6, t7
> $16   : 8390a000 00000019 03c9dab0 00000019         s0, s1, s2, s3
> $20   : 00000019 00000000 00000001 828f3e18
> $24   : 00000000 828a3d30
> $28   : 828f2000 828f3d78 80486de0 800af974
> Hi    : 00000fff
> Lo    : 97248a23
> epc   : 800af9c8 pipe_write+0xc8/0x840     Tainted: P
> ra    : 800af974 pipe_write+0x74/0x840
> Status: 1100ff03    KERNEL EXL IE
> Cause : 00800008
> BadVA : 03c9dabc
> PrId  : 00019641
> Modules linked in: ipt_REJECT ast_read_timer lakefxo zaptel drv_dect 
> drv_duslic xhfc mISDN_core drv_vinetic drv80c823 drv_vmmc drv_tapi 
> drv_fpga_core drv_mps cls_rsvp6 cls_rsvp xt_LED
> nf_nat_h323 nf_conntrack_h323 nf_nat_pptp nf_conntrack_pptp 
> nf_nat_proto_gre nf_conntrack_proto_gre nf_nat_sip nf_conntrack_sip 
> nf_nat_tftp nf_conntrack_tftp nf_nat_irc nf_conntrack_ir
> c nf_nat_ftp nf_conntrack_ftp ipt_LOG ipt_TCPMSS ipt_MASQUERADE xt_limit 
> xt_state xt_tcpudp iptable_nat nf_conntrack_ipv4 nf_nat nfnetlink 
> iptable_filter ip_tables x_tables ath_rate_sa
> mple ath_pci ath_hal(P) wlan_xauth wlan_wep wlan_tkip wlan_ccmp wlan_acl 
> wlan_scan_sta wlan_scan_ap wlan
> Process pabx (pid: 5977, threadinfo=828f2000, task=834c31f8)
> Stack : 00000001 00000000 00000004 00000000 00000001 828f3dd0 7ff047e8 
> 00000000
>         00000009 7ff04868 828f3dd0 800bc544 8183ac00 828f3db8 828f3f20 
> 80073db8
>         828f3dd0 828f3dd4 00000000 00000000 828f3de0 828f3de4 00000100 
> 825c6d90
>         828f3e20 80488e40 80486de0 fffffffd 828f3f18 ffffffff 00000009 
> 00000017
>         00000000 800a4de8 80052dbc 800b174c 1002678c 00000001 00000000 
> 00000000
>         ...
> Call Trace:
> [<800af9c8>] pipe_write+0xc8/0x840
> [<800a4de8>] do_sync_write+0xd0/0x240
> [<800a51c8>] vfs_write+0x270/0x290
> [<800a52dc>] sys_write+0x54/0xa0
> [<80012c04>] stack_done+0x20/0x3c
> 
> 
> Code: 000e6880  01b06021  25920034 <8e55000c> 8e4a0004  8e4b0008  8ea90000 
>  014b2021  152000d9
> 
> 
> (gdb) disassemble pipe_write
> Dump of assembler code for function pipe_write:
> .
> .
> 0x00000928 <pipe_write+184>:    addu    t6,t7,s2
> 0x0000092c <pipe_write+188>:    sll     t5,t6,0x2
> 0x00000930 <pipe_write+192>:    addu    t4,t5,s0
> 0x00000934 <pipe_write+196>:    addiu   s2,t4,52
> 0x00000938 <pipe_write+200>:  lw  s5,12(s2)  FAILING INSTRUCTION
> 0x0000093c <pipe_write+204>:    lw      t2,4(s2)
> 0x00000940 <pipe_write+208>:    lw      t3,8(s2)
> .
> .
> End of assembler dump.
> 
> 
> 000e6880  => sll     t6,t5,0x2
> 01b06021  => addu    t4,t5,s0
> 25920034  => addiu   s2,t4,52
> 8e55000c  => lw      s5,12(s2)
> 
> 
> The faulting instruction is marked above.  From this we see that t5($13) 
> contains the wrong value.  It should contain the value of t6($14) left 
> shifted 2 bits, that is to say zero.  Instead it contains a value 
> 80393a80.
> 
> At least one other register is not as expected.  a2($6) should not contain 
> the value 0, otherwise the branch at <pipe_write+156> would have been 
> taken.  Also, if the instruction at <pipe_write+144> was executed, then 
> a3($7) should contain either 0 or 1, not an address.  Likewise, t0($8) 
> should contain the value 1, given the value of s3($19).
> 
> 
> 
> (gdb) list *pipe_write+200
> 0x938 is in pipe_write (fs/pipe.c:368).
> 363             chars = total_len & (PAGE_SIZE-1); /* size of the last 
> buffer */
> 364             if (pipe->nrbufs && chars != 0) {
> 365                     int lastbuf = (pipe->curbuf + pipe->nrbufs - 1) &
> 366 (PIPE_BUFFERS-1);
> 367                     struct pipe_buffer *buf = pipe->bufs + lastbuf;
> 368   FAULTING C CODE                const struct pipe_buf_operations *ops 
> = buf->ops;
> 369                     int offset = buf->offset + buf->len;
> 370
> 371                     if (ops->can_merge && offset + chars <= PAGE_SIZE) 
> {
> 372                             int error, atomic = 1;
> 
> 
> 
> Any idea out there??

No idea for now...

---
Atsushi Nemoto
