Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0N2FsG08894
	for linux-mips-outgoing; Tue, 22 Jan 2002 18:15:54 -0800
Received: from atlrel9.hp.com (atlrel9.hp.com [156.153.255.214])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0N2FpP08891
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 18:15:51 -0800
Received: from xatlrelay2.atl.hp.com (xatlrelay2.atl.hp.com [15.45.89.191])
	by atlrel9.hp.com (Postfix) with ESMTP id 6B567E00141
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 20:15:44 -0500 (EST)
Received: from xatlbh1.atl.hp.com (xatlbh1.atl.hp.com [15.45.89.186])
	by xatlrelay2.atl.hp.com (Postfix) with ESMTP id 568A9400135
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 20:15:44 -0500 (EST)
Received: by xatlbh1.atl.hp.com with Internet Mail Service (5.5.2653.19)
	id <DFGSK8QH>; Tue, 22 Jan 2002 20:15:44 -0500
Message-ID: <CBD6266EA291D5118144009027AA63353F92B7@xboi05.boi.hp.com>
From: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
To: linux-mips@oss.sgi.com
Subject: Mips IRQ support
Date: Tue, 22 Jan 2002 20:15:41 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Are there any plans to provide full MIPS irq support in the general mips irq
code?

The only machine that appears to attempt to fully support the MIPS interrupt
set currently is the gt64120/momenco_ocelot machine.

It uses the define CP0_S1_INTCONTROL ($20) to get at the upper interrupt
lines ( > 8 ).

Anyone else find that support for this MIPS hardware would be best placed in
the standard irq code rather than each machine variant having to
re-implement it itself (as the irq code was in the past).

Thanks,

Roger Twede
