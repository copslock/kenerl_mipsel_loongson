Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jul 2010 15:55:18 +0200 (CEST)
Received: from Inmumg02.tcs.com ([219.64.34.152]:38836 "EHLO inmumg02.tcs.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492935Ab0G3NzN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Jul 2010 15:55:13 +0200
X-IronPort-AV: E=Sophos;i="4.55,287,1278268200"; 
   d="scan'208";a="33813239"
To:     "Chris Friesen" <cfriesen@nortel.com>
Cc:     linux-mips@linux-mips.org
MIME-Version: 1.0
Subject: Need help in analyzing lockup on Octeon cores
X-KeepSent: 5CCCCABC:66965243-6525776F:0052158B;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.0.1 February 07, 2008
Message-ID: <OF5CCCCABC.66965243-ON6525776F.0052158B-65257770.004C7338@tcs.com>
From:   Sowmya Sridharan <sowmya.sridharan@tcs.com>
Date:   Fri, 30 Jul 2010 19:25:02 +0530
X-MIMETrack: Serialize by Router on InMumM12/TCS(Release 8.0.2HF1089 | June 2, 2009) at
 07/30/2010 19:25:04,
        Serialize complete at 07/30/2010 19:25:04
Content-Type: multipart/alternative; boundary="=_alternative 004C733765257770_="
Return-Path: <prvs=8205d7149=sowmya.sridharan@tcs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sowmya.sridharan@tcs.com
Precedence: bulk
X-list: linux-mips

This is a multipart message in MIME format.
--=_alternative 004C733765257770_=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"

We are running 2.6.14 kernel (patched) on an Octeon based hardware with 
multiple cores.
This lockup was detected due to which there were complaints from the 
scheduler, and eventually the card rebooted.
I need help in finding the probable scenario which might have lead to this 
lockup.

Looks like the same write_lock_bh has been taken by multiple cores 
successfully (Does this disable process preemption and bh processing?). 
The cores have proceeded to allot skb headroom for udp operation. This 
might have lead to spin-locking and eventually the delay in scheduling. 

Appreciate your insights that might help me track the issue.
Apologies for pasting a slightly longer call trace :)

20C0EA46AA71: 19/05/2010 UTC 09:02:50, cpu2: jiffies: 4342253075, hrtime: 
36012936285754, 500 ms without calling schedule() since scheduler 
requested
20C0EA46CA32: 19/05/2010 UTC 09:02:50, Call Trace
20C0EA472DA8: 19/05/2010 UTC 09:02:50,
20C0EA476BFF: 19/05/2010 UTC 09:02:50,  [<ffffffff8113fcc8>]
20C0EA47A030: 19/05/2010 UTC 09:02:50, scheduler_tick+0x488/0xbb8
20C0EA47C95C: 19/05/2010 UTC 09:02:50,  [<ffffffff8139ee4c>]
20C0EA47E803: 19/05/2010 UTC 09:02:50, ip_output+0x29c/0x448
20C0EA47FE6C: 19/05/2010 UTC 09:02:50,  [<ffffffff8139ede8>]
20C0EA48152C: 19/05/2010 UTC 09:02:50, ip_output+0x238/0x448
20C0EA483F47: 19/05/2010 UTC 09:02:50,  [<ffffffff8115a004>]
20C0EA486875: 19/05/2010 UTC 09:02:50, update_process_times+0xc4/0x1f8
20C0EA487EFC: 19/05/2010 UTC 09:02:50,  [<ffffffff81159f7c>]
20C0EA489EC2: 19/05/2010 UTC 09:02:50, update_process_times+0x3c/0x1f8
20C0EA48BD48: 19/05/2010 UTC 09:02:50,  [<ffffffff81101c74>]
20C0EA48E03A: 19/05/2010 UTC 09:02:50, 
octeon_main_timer_interrupt+0x54/0x90
20C0EA48FB10: 19/05/2010 UTC 09:02:50,  [<ffffffff81186738>]
20C0EA491745: 19/05/2010 UTC 09:02:50, handle_IRQ_event+0x180/0x638
20C0EA4A272E: 19/05/2010 UTC 09:02:50,  [<ffffffff81186738>]
20C0EA4A4282: 19/05/2010 UTC 09:02:50, handle_IRQ_event+0x180/0x638
20C0EA4A9933: 19/05/2010 UTC 09:02:50,  [<ffffffff81186cc4>]
20C0EA4AB05A: 19/05/2010 UTC 09:02:50, __do_IRQ+0xd4/0x230
20C0EA4AD49A: 19/05/2010 UTC 09:02:50,  [<ffffffff81109f60>]
20C0EA4AF40B: 19/05/2010 UTC 09:02:50, do_IRQ+0x198/0x618
20C0EA4B4795: 19/05/2010 UTC 09:02:50,  [<ffffffff811081b0>]
20C0EA4B619A: 19/05/2010 UTC 09:02:50, ret_from_irq+0x0/0x10
20C0EA4B7A99: 19/05/2010 UTC 09:02:50,  [<ffffffff8118fc4c>]
20C0EA4B9BB5: 19/05/2010 UTC 09:02:50, __alloc_pages+0x37c/0x518
20C0EA4BD5EA: 19/05/2010 UTC 09:02:50,  [<ffffffff81364400>]
20C0EA4BF575: 19/05/2010 UTC 09:02:50, sys_bind+0x0/0x90
20C0EA4C2B49: 19/05/2010 UTC 09:02:50,  [<ffffffff813c3e84>]
20C0EA4C46F5: 19/05/2010 UTC 09:02:50, udp_v4_get_port+0x34/0x3d8
20C0EA4C66C0: 19/05/2010 UTC 09:02:50,  [<ffffffff81426c50>]
20C0EA4C82F9: 19/05/2010 UTC 09:02:50, _write_lock_bh+0x10/0x30
20C0EA4CA81C: 19/05/2010 UTC 09:02:50,  [<ffffffff813d0af4>]
20C0EA4CC6C2: 19/05/2010 UTC 09:02:50, inet_bind+0x184/0x310
20C0EA4CDCFB: 19/05/2010 UTC 09:02:50,  [<ffffffff813d0a74>]
20C0EA4CF68D: 19/05/2010 UTC 09:02:50, inet_bind+0x104/0x310
20C0EA4D179A: 19/05/2010 UTC 09:02:50,  [<ffffffff81364464>]
20C0EA4D31DC: 19/05/2010 UTC 09:02:50, sys_bind+0x64/0x90
20C0EA4D5D59: 19/05/2010 UTC 09:02:50,  [<ffffffff811fdd10>]
20C0EA4D8077: 19/05/2010 UTC 09:02:50, compat_sys_fcntl64+0x318/0x358
20C0EA4DA7C1: 19/05/2010 UTC 09:02:50,  [<ffffffff81129714>]
20C0EA4DCDFF: 19/05/2010 UTC 09:02:50, no_dpa_call+0x44/0x94
20C0EA4DF40A: 19/05/2010 UTC 09:02:50,  [<ffffffff81364400>]
20C0EA4E0D58: 19/05/2010 UTC 09:02:50, sys_bind+0x0/0x90
20C0EA4E3A84: 19/05/2010 UTC 09:02:50,  [<ffffffff811fd9f8>]
20C0EA4E5809: 19/05/2010 UTC 09:02:50, compat_sys_fcntl64+0x0/0x358
20C0EA4EA095: 19/05/2010 UTC 09:02:50,
20C0EADE3231: 19/05/2010 UTC 09:02:50, cpu0: jiffies: 4342253089, hrtime: 
36012946222571, 500 ms without calling schedule() since scheduler 
requested
20C0EADE44AE: 19/05/2010 UTC 09:02:50, Call Trace
20C0EADE4B9A: 19/05/2010 UTC 09:02:50,
20C0EADE74EB: 19/05/2010 UTC 09:02:50,  [<ffffffff8113fcc8>]
20C0EADE9807: 19/05/2010 UTC 09:02:50, scheduler_tick+0x488/0xbb8
20C0EADED8C4: 19/05/2010 UTC 09:02:50,  [<ffffffff8115a004>]
20C0EADEFA3B: 19/05/2010 UTC 09:02:50, update_process_times+0xc4/0x1f8
20C0EADF115A: 19/05/2010 UTC 09:02:50,  [<ffffffff81159ffc>]
20C0EADF30F1: 19/05/2010 UTC 09:02:50, update_process_times+0xbc/0x1f8
20C0EADF4FDE: 19/05/2010 UTC 09:02:50,  [<ffffffff8110e848>]
20C0EADF7331: 19/05/2010 UTC 09:02:50, timer_interrupt+0x288/0x4c8
20C0EADF92A4: 19/05/2010 UTC 09:02:50,  [<ffffffff81101c98>]
20C0EADFB247: 19/05/2010 UTC 09:02:50, 
octeon_main_timer_interrupt+0x78/0x90
20C0EADFCF1B: 19/05/2010 UTC 09:02:50,  [<ffffffff81186738>]
20C0EADFEA33: 19/05/2010 UTC 09:02:50, handle_IRQ_event+0x180/0x638
20C0EADFFFE7: 19/05/2010 UTC 09:02:50,  [<ffffffff81186738>]
20C0EAE01A36: 19/05/2010 UTC 09:02:50, handle_IRQ_event+0x180/0x638
20C0EAE07009: 19/05/2010 UTC 09:02:50,  [<ffffffff81186cc4>]
20C0EAE08637: 19/05/2010 UTC 09:02:50, __do_IRQ+0xd4/0x230
20C0EAE0A967: 19/05/2010 UTC 09:02:50,  [<ffffffff81109f60>]
20C0EAE0C44C: 19/05/2010 UTC 09:02:50, do_IRQ+0x198/0x618
20C0EAE0DC57: 19/05/2010 UTC 09:02:50,  [<ffffffff8110a158>]
20C0EAE0F5CA: 19/05/2010 UTC 09:02:50, do_IRQ+0x390/0x618
20C0EAE12C8B: 19/05/2010 UTC 09:02:50,  [<ffffffff8110a158>]
20C0EAE146E8: 19/05/2010 UTC 09:02:50, do_IRQ+0x390/0x618
20C0EAE17243: 19/05/2010 UTC 09:02:50,  [<ffffffff811081b0>]
20C0EAE18C8A: 19/05/2010 UTC 09:02:50, ret_from_irq+0x0/0x10
20C0EAE1A4EE: 19/05/2010 UTC 09:02:50,  [<ffffffff811081b0>]
20C0EAE1BF3D: 19/05/2010 UTC 09:02:50, ret_from_irq+0x0/0x10
20C0EAE1DBD1: 19/05/2010 UTC 09:02:50,  [<ffffffff8116f248>]
20C0EAE1F759: 19/05/2010 UTC 09:02:50, get_futex_key+0x50/0x140
20C0EAE227A9: 19/05/2010 UTC 09:02:50,  [<ffffffff81364400>]
20C0EAE2415A: 19/05/2010 UTC 09:02:50, sys_bind+0x0/0x90
20C0EAE27664: 19/05/2010 UTC 09:02:50,  [<ffffffff813c3e84>]
20C0EAE29168: 19/05/2010 UTC 09:02:50, udp_v4_get_port+0x34/0x3d8
20C0EAE2B173: 19/05/2010 UTC 09:02:50,  [<ffffffff81426c4c>]
20C0EAE2CAE5: 19/05/2010 UTC 09:02:50, _write_lock_bh+0xc/0x30
20C0EAE2F062: 19/05/2010 UTC 09:02:50,  [<ffffffff813d0af4>]
20C0EAE309EF: 19/05/2010 UTC 09:02:50, inet_bind+0x184/0x310
20C0EAE32030: 19/05/2010 UTC 09:02:50,  [<ffffffff813d0a74>]
20C0EAE338A5: 19/05/2010 UTC 09:02:50, inet_bind+0x104/0x310
20C0EAE3591A: 19/05/2010 UTC 09:02:50,  [<ffffffff81364464>]
20C0EAE37320: 19/05/2010 UTC 09:02:50, sys_bind+0x64/0x90
20C0EAE39E3E: 19/05/2010 UTC 09:02:50,  [<ffffffff811fdd10>]
20C0EAE3BCF5: 19/05/2010 UTC 09:02:50, compat_sys_fcntl64+0x318/0x358
20C0EAE3E558: 19/05/2010 UTC 09:02:50,  [<ffffffff81129714>]
20C0EAE4038D: 19/05/2010 UTC 09:02:50, no_dpa_call+0x44/0x94
20C0EAE427E1: 19/05/2010 UTC 09:02:50,  [<ffffffff81364400>]
20C0EAE440D2: 19/05/2010 UTC 09:02:50, sys_bind+0x0/0x90
20C0EAE46EC0: 19/05/2010 UTC 09:02:50,  [<ffffffff811fd9f8>]
20C0EAE48BFF: 19/05/2010 UTC 09:02:50, compat_sys_fcntl64+0x0/0x358
20C0EAE4D59A: 19/05/2010 UTC 09:02:50,
20C0EB09F165: 19/05/2010 UTC 09:02:50, cpu11: jiffies: 4342253092, hrtime: 
36012949089575, 500 ms without calling schedule() since scheduler 
requested
20C0EB09FFA0: 19/05/2010 UTC 09:02:50, Call Trace
20C0EB0A06D6: 19/05/2010 UTC 09:02:50,
20C0EB0A2F5A: 19/05/2010 UTC 09:02:50,  [<ffffffff8113fcc8>]
20C0EB0A51CC: 19/05/2010 UTC 09:02:50, scheduler_tick+0x488/0xbb8
20C0EB0A7B64: 19/05/2010 UTC 09:02:50,  [<ffffffff8139ee4c>]
20C0EB0A95DB: 19/05/2010 UTC 09:02:50, ip_output+0x29c/0x448
20C0EB0AAB9B: 19/05/2010 UTC 09:02:50,  [<ffffffff8139ede8>]
20C0EB0AC2C8: 19/05/2010 UTC 09:02:50, ip_output+0x238/0x448
20C0EB0AEC48: 19/05/2010 UTC 09:02:50,  [<ffffffff8115a004>]
20C0EB0B0E13: 19/05/2010 UTC 09:02:50, update_process_times+0xc4/0x1f8
20C0EB0B2466: 19/05/2010 UTC 09:02:50,  [<ffffffff81159f7c>]
20C0EB0B4366: 19/05/2010 UTC 09:02:50, update_process_times+0x3c/0x1f8
20C0EB0B62B4: 19/05/2010 UTC 09:02:50,  [<ffffffff81101c74>]
20C0EB0B8296: 19/05/2010 UTC 09:02:50, 
octeon_main_timer_interrupt+0x54/0x90
20C0EB0B9D77: 19/05/2010 UTC 09:02:50,  [<ffffffff81186738>]
20C0EB0BB92A: 19/05/2010 UTC 09:02:50, handle_IRQ_event+0x180/0x638
20C0EB0BCEB1: 19/05/2010 UTC 09:02:50,  [<ffffffff81186738>]
20C0EB0BE902: 19/05/2010 UTC 09:02:50, handle_IRQ_event+0x180/0x638
20C0EB0C2CB5: 19/05/2010 UTC 09:02:50,  [<ffffffff81152194>]
20C0EB0C48C3: 19/05/2010 UTC 09:02:50, __do_softirq+0x394/0x898
20C0EB0C7075: 19/05/2010 UTC 09:02:50,  [<ffffffff81186cc4>]
20C0EB0C8722: 19/05/2010 UTC 09:02:50, __do_IRQ+0xd4/0x230
20C0EB0CAA45: 19/05/2010 UTC 09:02:50,  [<ffffffff81109f60>]
20C0EB0CC4BD: 19/05/2010 UTC 09:02:50, do_IRQ+0x198/0x618
20C0EB0CFB23: 19/05/2010 UTC 09:02:50,  [<ffffffff81152730>]
20C0EB0D1404: 19/05/2010 UTC 09:02:50, do_softirq+0x98/0xb8
20C0EB0D2BDB: 19/05/2010 UTC 09:02:50,  [<ffffffff8110a158>]
20C0EB0D4609: 19/05/2010 UTC 09:02:50, do_IRQ+0x390/0x618
20C0EB0D7160: 19/05/2010 UTC 09:02:50,  [<ffffffff811081b0>]
20C0EB0D8BBB: 19/05/2010 UTC 09:02:50, ret_from_irq+0x0/0x10
20C0EB0DC84D: 19/05/2010 UTC 09:02:50,  [<ffffffff81364400>]
20C0EB0DE192: 19/05/2010 UTC 09:02:50, sys_bind+0x0/0x90
20C0EB0E1596: 19/05/2010 UTC 09:02:50,  [<ffffffff813c3e84>]
20C0EB0E2FD6: 19/05/2010 UTC 09:02:50, udp_v4_get_port+0x34/0x3d8
20C0EB0E50E7: 19/05/2010 UTC 09:02:50,  [<ffffffff81426c4c>]
20C0EB0E69B6: 19/05/2010 UTC 09:02:50, _write_lock_bh+0xc/0x30
20C0EB0E8EFB: 19/05/2010 UTC 09:02:50,  [<ffffffff813d0af4>]
20C0EB0EAA0F: 19/05/2010 UTC 09:02:50, inet_bind+0x184/0x310
20C0EB0EC02D: 19/05/2010 UTC 09:02:50,  [<ffffffff813d0a74>]
20C0EB0ED834: 19/05/2010 UTC 09:02:50, inet_bind+0x104/0x310
20C0EB0EF90C: 19/05/2010 UTC 09:02:50,  [<ffffffff81364464>]
20C0EB0F137D: 19/05/2010 UTC 09:02:50, sys_bind+0x64/0x90
20C0EB0F3E5C: 19/05/2010 UTC 09:02:50,  [<ffffffff811fdd10>]
20C0EB0F5D7C: 19/05/2010 UTC 09:02:50, compat_sys_fcntl64+0x318/0x358
20C0EB0F860A: 19/05/2010 UTC 09:02:50,  [<ffffffff81129714>]
20C0EB0FA436: 19/05/2010 UTC 09:02:50, no_dpa_call+0x44/0x94
20C0EB0FC93B: 19/05/2010 UTC 09:02:50,  [<ffffffff81364400>]
20C0EB0FE284: 19/05/2010 UTC 09:02:50, sys_bind+0x0/0x90
20C0EB100EFA: 19/05/2010 UTC 09:02:50,  [<ffffffff811fd9f8>]
20C0EB102C1C: 19/05/2010 UTC 09:02:50, compat_sys_fcntl64+0x0/0x358


Regards,
Sowmya
email: sowmya.sridharan@tcs.com
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you



--=_alternative 004C733765257770_=
Content-Transfer-Encoding: 7bit
Content-Type: text/html; charset="us-ascii"


<br><font size=2 face="Courier New">We are running 2.6.14 kernel (patched)
on an Octeon based hardware with multiple cores.</font>
<br><font size=2 face="Courier New">This lockup was detected due to which
there were complaints from the scheduler, and eventually the card rebooted.</font>
<br><font size=2 face="Courier New">I need help in finding the probable
scenario which might have lead to this lockup.</font>
<br>
<br><font size=2 face="Courier New">Looks like the same write_lock_bh has
been taken by multiple cores successfully (Does this disable process preemption
and bh processing?). The cores have proceeded to allot skb headroom for
udp operation. This might have lead to spin-locking and eventually the
delay in scheduling. </font>
<br>
<br><font size=2 face="Courier New">Appreciate your insights that might
help me track the issue.</font>
<br><font size=2 face="Courier New">Apologies for pasting a slightly longer
call trace :)</font>
<br>
<br><font size=2 face="Courier New">20C0EA46AA71: 19/05/2010 UTC 09:02:50,
cpu2: jiffies: 4342253075, hrtime: 36012936285754, 500 ms without calling
schedule() since scheduler requested</font>
<br><font size=2 face="Courier New">20C0EA46CA32: 19/05/2010 UTC 09:02:50,
Call Trace</font>
<br><font size=2 face="Courier New">20C0EA472DA8: 19/05/2010 UTC 09:02:50,</font>
<br><font size=2 face="Courier New">20C0EA476BFF: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8113fcc8&gt;]</font>
<br><font size=2 face="Courier New">20C0EA47A030: 19/05/2010 UTC 09:02:50,
scheduler_tick+0x488/0xbb8</font>
<br><font size=2 face="Courier New">20C0EA47C95C: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8139ee4c&gt;]</font>
<br><font size=2 face="Courier New">20C0EA47E803: 19/05/2010 UTC 09:02:50,
ip_output+0x29c/0x448</font>
<br><font size=2 face="Courier New">20C0EA47FE6C: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8139ede8&gt;]</font>
<br><font size=2 face="Courier New">20C0EA48152C: 19/05/2010 UTC 09:02:50,
ip_output+0x238/0x448</font>
<br><font size=2 face="Courier New">20C0EA483F47: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8115a004&gt;]</font>
<br><font size=2 face="Courier New">20C0EA486875: 19/05/2010 UTC 09:02:50,
update_process_times+0xc4/0x1f8</font>
<br><font size=2 face="Courier New">20C0EA487EFC: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81159f7c&gt;]</font>
<br><font size=2 face="Courier New">20C0EA489EC2: 19/05/2010 UTC 09:02:50,
update_process_times+0x3c/0x1f8</font>
<br><font size=2 face="Courier New">20C0EA48BD48: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81101c74&gt;]</font>
<br><font size=2 face="Courier New">20C0EA48E03A: 19/05/2010 UTC 09:02:50,
octeon_main_timer_interrupt+0x54/0x90</font>
<br><font size=2 face="Courier New">20C0EA48FB10: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81186738&gt;]</font>
<br><font size=2 face="Courier New">20C0EA491745: 19/05/2010 UTC 09:02:50,
handle_IRQ_event+0x180/0x638</font>
<br><font size=2 face="Courier New">20C0EA4A272E: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81186738&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4A4282: 19/05/2010 UTC 09:02:50,
handle_IRQ_event+0x180/0x638</font>
<br><font size=2 face="Courier New">20C0EA4A9933: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81186cc4&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4AB05A: 19/05/2010 UTC 09:02:50,
__do_IRQ+0xd4/0x230</font>
<br><font size=2 face="Courier New">20C0EA4AD49A: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81109f60&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4AF40B: 19/05/2010 UTC 09:02:50,
do_IRQ+0x198/0x618</font>
<br><font size=2 face="Courier New">20C0EA4B4795: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811081b0&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4B619A: 19/05/2010 UTC 09:02:50,
ret_from_irq+0x0/0x10</font>
<br><font size=2 face="Courier New">20C0EA4B7A99: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8118fc4c&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4B9BB5: 19/05/2010 UTC 09:02:50,
__alloc_pages+0x37c/0x518</font>
<br><font size=2 face="Courier New">20C0EA4BD5EA: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81364400&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4BF575: 19/05/2010 UTC 09:02:50,
sys_bind+0x0/0x90</font>
<br><font size=2 face="Courier New">20C0EA4C2B49: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff813c3e84&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4C46F5: 19/05/2010 UTC 09:02:50,
udp_v4_get_port+0x34/0x3d8</font>
<br><font size=2 face="Courier New">20C0EA4C66C0: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81426c50&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4C82F9: 19/05/2010 UTC 09:02:50,
_write_lock_bh+0x10/0x30</font>
<br><font size=2 face="Courier New">20C0EA4CA81C: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff813d0af4&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4CC6C2: 19/05/2010 UTC 09:02:50,
inet_bind+0x184/0x310</font>
<br><font size=2 face="Courier New">20C0EA4CDCFB: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff813d0a74&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4CF68D: 19/05/2010 UTC 09:02:50,
inet_bind+0x104/0x310</font>
<br><font size=2 face="Courier New">20C0EA4D179A: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81364464&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4D31DC: 19/05/2010 UTC 09:02:50,
sys_bind+0x64/0x90</font>
<br><font size=2 face="Courier New">20C0EA4D5D59: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811fdd10&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4D8077: 19/05/2010 UTC 09:02:50,
compat_sys_fcntl64+0x318/0x358</font>
<br><font size=2 face="Courier New">20C0EA4DA7C1: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81129714&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4DCDFF: 19/05/2010 UTC 09:02:50,
no_dpa_call+0x44/0x94</font>
<br><font size=2 face="Courier New">20C0EA4DF40A: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81364400&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4E0D58: 19/05/2010 UTC 09:02:50,
sys_bind+0x0/0x90</font>
<br><font size=2 face="Courier New">20C0EA4E3A84: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811fd9f8&gt;]</font>
<br><font size=2 face="Courier New">20C0EA4E5809: 19/05/2010 UTC 09:02:50,
compat_sys_fcntl64+0x0/0x358</font>
<br><font size=2 face="Courier New">20C0EA4EA095: 19/05/2010 UTC 09:02:50,</font>
<br><font size=2 face="Courier New">20C0EADE3231: 19/05/2010 UTC 09:02:50,
cpu0: jiffies: 4342253089, hrtime: 36012946222571, 500 ms without calling
schedule() since scheduler requested</font>
<br><font size=2 face="Courier New">20C0EADE44AE: 19/05/2010 UTC 09:02:50,
Call Trace</font>
<br><font size=2 face="Courier New">20C0EADE4B9A: 19/05/2010 UTC 09:02:50,</font>
<br><font size=2 face="Courier New">20C0EADE74EB: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8113fcc8&gt;]</font>
<br><font size=2 face="Courier New">20C0EADE9807: 19/05/2010 UTC 09:02:50,
scheduler_tick+0x488/0xbb8</font>
<br><font size=2 face="Courier New">20C0EADED8C4: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8115a004&gt;]</font>
<br><font size=2 face="Courier New">20C0EADEFA3B: 19/05/2010 UTC 09:02:50,
update_process_times+0xc4/0x1f8</font>
<br><font size=2 face="Courier New">20C0EADF115A: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81159ffc&gt;]</font>
<br><font size=2 face="Courier New">20C0EADF30F1: 19/05/2010 UTC 09:02:50,
update_process_times+0xbc/0x1f8</font>
<br><font size=2 face="Courier New">20C0EADF4FDE: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8110e848&gt;]</font>
<br><font size=2 face="Courier New">20C0EADF7331: 19/05/2010 UTC 09:02:50,
timer_interrupt+0x288/0x4c8</font>
<br><font size=2 face="Courier New">20C0EADF92A4: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81101c98&gt;]</font>
<br><font size=2 face="Courier New">20C0EADFB247: 19/05/2010 UTC 09:02:50,
octeon_main_timer_interrupt+0x78/0x90</font>
<br><font size=2 face="Courier New">20C0EADFCF1B: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81186738&gt;]</font>
<br><font size=2 face="Courier New">20C0EADFEA33: 19/05/2010 UTC 09:02:50,
handle_IRQ_event+0x180/0x638</font>
<br><font size=2 face="Courier New">20C0EADFFFE7: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81186738&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE01A36: 19/05/2010 UTC 09:02:50,
handle_IRQ_event+0x180/0x638</font>
<br><font size=2 face="Courier New">20C0EAE07009: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81186cc4&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE08637: 19/05/2010 UTC 09:02:50,
__do_IRQ+0xd4/0x230</font>
<br><font size=2 face="Courier New">20C0EAE0A967: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81109f60&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE0C44C: 19/05/2010 UTC 09:02:50,
do_IRQ+0x198/0x618</font>
<br><font size=2 face="Courier New">20C0EAE0DC57: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8110a158&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE0F5CA: 19/05/2010 UTC 09:02:50,
do_IRQ+0x390/0x618</font>
<br><font size=2 face="Courier New">20C0EAE12C8B: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8110a158&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE146E8: 19/05/2010 UTC 09:02:50,
do_IRQ+0x390/0x618</font>
<br><font size=2 face="Courier New">20C0EAE17243: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811081b0&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE18C8A: 19/05/2010 UTC 09:02:50,
ret_from_irq+0x0/0x10</font>
<br><font size=2 face="Courier New">20C0EAE1A4EE: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811081b0&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE1BF3D: 19/05/2010 UTC 09:02:50,
ret_from_irq+0x0/0x10</font>
<br><font size=2 face="Courier New">20C0EAE1DBD1: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8116f248&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE1F759: 19/05/2010 UTC 09:02:50,
get_futex_key+0x50/0x140</font>
<br><font size=2 face="Courier New">20C0EAE227A9: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81364400&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE2415A: 19/05/2010 UTC 09:02:50,
sys_bind+0x0/0x90</font>
<br><font size=2 face="Courier New">20C0EAE27664: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff813c3e84&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE29168: 19/05/2010 UTC 09:02:50,
udp_v4_get_port+0x34/0x3d8</font>
<br><font size=2 face="Courier New">20C0EAE2B173: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81426c4c&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE2CAE5: 19/05/2010 UTC 09:02:50,
_write_lock_bh+0xc/0x30</font>
<br><font size=2 face="Courier New">20C0EAE2F062: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff813d0af4&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE309EF: 19/05/2010 UTC 09:02:50,
inet_bind+0x184/0x310</font>
<br><font size=2 face="Courier New">20C0EAE32030: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff813d0a74&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE338A5: 19/05/2010 UTC 09:02:50,
inet_bind+0x104/0x310</font>
<br><font size=2 face="Courier New">20C0EAE3591A: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81364464&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE37320: 19/05/2010 UTC 09:02:50,
sys_bind+0x64/0x90</font>
<br><font size=2 face="Courier New">20C0EAE39E3E: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811fdd10&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE3BCF5: 19/05/2010 UTC 09:02:50,
compat_sys_fcntl64+0x318/0x358</font>
<br><font size=2 face="Courier New">20C0EAE3E558: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81129714&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE4038D: 19/05/2010 UTC 09:02:50,
no_dpa_call+0x44/0x94</font>
<br><font size=2 face="Courier New">20C0EAE427E1: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81364400&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE440D2: 19/05/2010 UTC 09:02:50,
sys_bind+0x0/0x90</font>
<br><font size=2 face="Courier New">20C0EAE46EC0: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811fd9f8&gt;]</font>
<br><font size=2 face="Courier New">20C0EAE48BFF: 19/05/2010 UTC 09:02:50,
compat_sys_fcntl64+0x0/0x358</font>
<br><font size=2 face="Courier New">20C0EAE4D59A: 19/05/2010 UTC 09:02:50,</font>
<br><font size=2 face="Courier New">20C0EB09F165: 19/05/2010 UTC 09:02:50,
cpu11: jiffies: 4342253092, hrtime: 36012949089575, 500 ms without calling
schedule() since scheduler requested</font>
<br><font size=2 face="Courier New">20C0EB09FFA0: 19/05/2010 UTC 09:02:50,
Call Trace</font>
<br><font size=2 face="Courier New">20C0EB0A06D6: 19/05/2010 UTC 09:02:50,</font>
<br><font size=2 face="Courier New">20C0EB0A2F5A: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8113fcc8&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0A51CC: 19/05/2010 UTC 09:02:50,
scheduler_tick+0x488/0xbb8</font>
<br><font size=2 face="Courier New">20C0EB0A7B64: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8139ee4c&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0A95DB: 19/05/2010 UTC 09:02:50,
ip_output+0x29c/0x448</font>
<br><font size=2 face="Courier New">20C0EB0AAB9B: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8139ede8&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0AC2C8: 19/05/2010 UTC 09:02:50,
ip_output+0x238/0x448</font>
<br><font size=2 face="Courier New">20C0EB0AEC48: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8115a004&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0B0E13: 19/05/2010 UTC 09:02:50,
update_process_times+0xc4/0x1f8</font>
<br><font size=2 face="Courier New">20C0EB0B2466: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81159f7c&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0B4366: 19/05/2010 UTC 09:02:50,
update_process_times+0x3c/0x1f8</font>
<br><font size=2 face="Courier New">20C0EB0B62B4: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81101c74&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0B8296: 19/05/2010 UTC 09:02:50,
octeon_main_timer_interrupt+0x54/0x90</font>
<br><font size=2 face="Courier New">20C0EB0B9D77: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81186738&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0BB92A: 19/05/2010 UTC 09:02:50,
handle_IRQ_event+0x180/0x638</font>
<br><font size=2 face="Courier New">20C0EB0BCEB1: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81186738&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0BE902: 19/05/2010 UTC 09:02:50,
handle_IRQ_event+0x180/0x638</font>
<br><font size=2 face="Courier New">20C0EB0C2CB5: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81152194&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0C48C3: 19/05/2010 UTC 09:02:50,
__do_softirq+0x394/0x898</font>
<br><font size=2 face="Courier New">20C0EB0C7075: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81186cc4&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0C8722: 19/05/2010 UTC 09:02:50,
__do_IRQ+0xd4/0x230</font>
<br><font size=2 face="Courier New">20C0EB0CAA45: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81109f60&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0CC4BD: 19/05/2010 UTC 09:02:50,
do_IRQ+0x198/0x618</font>
<br><font size=2 face="Courier New">20C0EB0CFB23: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81152730&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0D1404: 19/05/2010 UTC 09:02:50,
do_softirq+0x98/0xb8</font>
<br><font size=2 face="Courier New">20C0EB0D2BDB: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff8110a158&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0D4609: 19/05/2010 UTC 09:02:50,
do_IRQ+0x390/0x618</font>
<br><font size=2 face="Courier New">20C0EB0D7160: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811081b0&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0D8BBB: 19/05/2010 UTC 09:02:50,
ret_from_irq+0x0/0x10</font>
<br><font size=2 face="Courier New">20C0EB0DC84D: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81364400&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0DE192: 19/05/2010 UTC 09:02:50,
sys_bind+0x0/0x90</font>
<br><font size=2 face="Courier New">20C0EB0E1596: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff813c3e84&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0E2FD6: 19/05/2010 UTC 09:02:50,
udp_v4_get_port+0x34/0x3d8</font>
<br><font size=2 face="Courier New">20C0EB0E50E7: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81426c4c&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0E69B6: 19/05/2010 UTC 09:02:50,
_write_lock_bh+0xc/0x30</font>
<br><font size=2 face="Courier New">20C0EB0E8EFB: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff813d0af4&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0EAA0F: 19/05/2010 UTC 09:02:50,
inet_bind+0x184/0x310</font>
<br><font size=2 face="Courier New">20C0EB0EC02D: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff813d0a74&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0ED834: 19/05/2010 UTC 09:02:50,
inet_bind+0x104/0x310</font>
<br><font size=2 face="Courier New">20C0EB0EF90C: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81364464&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0F137D: 19/05/2010 UTC 09:02:50,
sys_bind+0x64/0x90</font>
<br><font size=2 face="Courier New">20C0EB0F3E5C: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811fdd10&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0F5D7C: 19/05/2010 UTC 09:02:50,
compat_sys_fcntl64+0x318/0x358</font>
<br><font size=2 face="Courier New">20C0EB0F860A: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81129714&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0FA436: 19/05/2010 UTC 09:02:50,
no_dpa_call+0x44/0x94</font>
<br><font size=2 face="Courier New">20C0EB0FC93B: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff81364400&gt;]</font>
<br><font size=2 face="Courier New">20C0EB0FE284: 19/05/2010 UTC 09:02:50,
sys_bind+0x0/0x90</font>
<br><font size=2 face="Courier New">20C0EB100EFA: 19/05/2010 UTC 09:02:50,
&nbsp;[&lt;ffffffff811fd9f8&gt;]</font>
<br><font size=2 face="Courier New">20C0EB102C1C: 19/05/2010 UTC 09:02:50,
compat_sys_fcntl64+0x0/0x358</font>
<br>
<br>
<br><font size=2 face="Courier New">Regards,</font>
<br><font size=2 face="Courier New">Sowmya</font>
<br><font size=2 face="Courier New">email: sowmya.sridharan@tcs.com</font><pre style="white-space:normal">=====-----=====-----=====<br>Notice: The information contained in this e-mail<br>message and/or attachments to it may contain <br>confidential or privileged information. If you are <br>not the intended recipient, any dissemination, use, <br>review, distribution, printing or copying of the <br>information contained in this e-mail message <br>and/or attachments to it are strictly prohibited. If <br>you have received this communication in error, <br>please notify us by reply e-mail or telephone and <br>immediately and permanently delete the message <br>and any attachments. Thank you<br><br><br></pre>
--=_alternative 004C733765257770_=--
