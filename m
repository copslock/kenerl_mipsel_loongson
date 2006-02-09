Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 00:44:40 +0000 (GMT)
Received: from mms2.broadcom.com ([216.31.210.18]:27401 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133409AbWBIAoa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2006 00:44:30 +0000
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 08 Feb 2006 16:50:02 -0800
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 61E802B4; Wed, 8 Feb 2006 16:50:02 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 4CADC2AF for
 <linux-mips@linux-mips.org>; Wed, 8 Feb 2006 16:50:02 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id CWR84704; Wed, 8 Feb 2006 16:49:58 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 3EFD220501 for <linux-mips@linux-mips.org>; Wed, 8 Feb 2006 16:49:59
 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: SB1 broken on lmo tip
Date:	Wed, 8 Feb 2006 16:49:57 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D0773A392@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: SB1 broken on lmo tip
Thread-Index: AcYtEr/bSiRQd6srR76aPQRB4ka0cw==
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006020809; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230382E34334541384645392E303031312D412D;
 ENG=IBF; TS=20060209005003; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006020809_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FF44E301SC4905762-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,
 
It looks like the following merge broke the SB1 ports in linux-mips.org:
 
	Merge with e3f749c4af69c4344d89f11e2293e3790eb4eaca from Linus.
 
Specifically:
    d166b5a220813a08a79312fc384d11e1c57e9072    works, and it's child
    a7900c9bdb64c11688719bef9f6373fbc4c276ab    does not.

Unfortunately, the diffs between the two are about 19,000 lines...
And they're neighbors, so 'git bisect' will do no good.

The failure mode is the following exceptions on boot (using the
bigsur_defconfig):

294667.532000] Detected 3 available secondary CPU(s)
[4294667.534000] CPU revision is: 03041100
[4294667.534000] FPU revision is: 000f0103
[4294667.534000] Primary instruction cache 32kB, 4-way, linesize 32
bytes.
[4294667.534000] Primary data cache 32kB, 4-way, linesize 32 bytes.
[4294667.534000] Synthesized TLB refill handler (35 instructions).
[4294667.554000] CPU 0 Unable to handle kernel paging request at virtual
address 0000000000000028, epc == ffffffff80129740, 0[4294667.554000]
Oops[#1]:
[4294667.554000] Cpu 0
[4294667.554000] $ 0   : 0000000000000000 ffffffff804552e0
0000000000000020 0000000000000000
[4294667.554000] $ 4   : a8000000043da048 0000000000000000
0000000000000000 0000000000000001
[4294667.554000] $ 8   : ffffffff8045b790 ffffffff8feef420
ffffffff80424108 0000000000000000
[4294667.554000] $12   : ffffffffffffffff ffffffff8026be28
a8000000004ac630 ffffffffffffffff
[4294667.554000] $16   : 0000000000000000 a8000000043da048
a800000003da1300 0000000000000000
[4294667.554000] $20   : 0000000000000000 a800000003da1300
0000000000000001 ffffffff804552e0
[4294667.554000] $24   : 0000000000000000 ffffffff8fe94dc8
[4294667.554000] $28   : a8000000043dc000 a8000000043dfe20
a8000000043dfe30 ffffffff80129bc0
[4294667.554000] Hi    : 0000000000005a99
[4294667.554000] Lo    : 9999999998bf9800
[4294667.554000] epc   : ffffffff80129740 enqueue_task+0x18/0x88     Not
tainted
[4294667.554000] ra    : ffffffff80129bc0 activate_task+0xe0/0x158
[4294667.554000] Status: 14001fe2    KX SX UX KERNEL EXL
[4294667.554000] Cause : 00808008
[4294667.554000] BadVA : 0000000000000028
[4294667.554000] PrId  : 01041100
[4294667.554000] Modules linked in:
[4294667.554000] Process swapper (pid: 1, threadinfo=a8000000043dc000,
task=a8000000043db8a8)
[4294667.554000] Stack : a8000000043dfe30 ffffffff8045aca0
a800000003da1300 ffffffff804552e0
[4294667.554000]         a8000000043da048 0000000000000001
a8000000043dfe60 ffffffff8012ad70
[4294667.554000]         0000000014001fe1 0000000000000000
0000000000000000 0000000000000000
[4294667.554000]         ffffffffffffffff 000000000000000f
0000000000000000 ffffffffffffffff
[4294667.554000]         ffffffff80451b38 0000000000000001
0000000000000001 ffffffff8045b758
[4294667.554000]         0000000000000000 0000000000000000
0000000000000000 0000000000000000
[4294667.554000]         a8000000043dfef0 ffffffff80130bd8
a8000000043f4000 a8000000043f7fe0
[4294667.554000]         ffffffff80451b38 0000000000000001
0000000000000002 ffffffff8045b758
[4294667.554000]         0000000000000000 0000000000000000
0000000000000000 0000000000000000
[4294667.554000]         0000000000000000 ffffffff8014c308
0000000000000001 0000000000000001
[4294667.554000]         ...
[4294667.554000] Call Trace:
[4294667.554000]  [<ffffffff8012ad70>] try_to_wake_up+0x530/0x600
[4294667.554000]  [<ffffffff80130bd8>] migration_call+0x210/0x228
[4294667.554000]  [<ffffffff8014c308>] notifier_call_chain+0x38/0x78
[4294667.554000]  [<ffffffff80435e6c>] cpu_up+0x13c/0x1c8
[4294667.554000]  [<ffffffff80100e90>] init+0x9b0/0xb20
[4294667.554000]  [<ffffffff80100570>] init+0x90/0xb20
[4294667.554000]  [<ffffffff80104fc0>] kernel_thread_helper+0x10/0x18
[4294667.554000]  [<ffffffff80104fb0>] kernel_thread_helper+0x0/0x18
[4294667.554000]
[4294667.554000]
[4294667.554000] Code: 00021138  0045102d  64420020 <dc470008> 64830040
fc430008  fc820040  fc670008  fce30000
[4294667.555000] Kernel panic - not syncing: Attempted to kill init!
[4294667.556000]  <0>Rebooting in 5 seconds..Passing control back to
CFE...

I'm going to start looking into it, but any & all suggestions on where
to look are most welcome.

Cheers,
Mark
