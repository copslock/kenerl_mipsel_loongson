Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8L1TjP08261
	for linux-mips-outgoing; Thu, 20 Sep 2001 18:29:45 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8L1Tge08258
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 18:29:42 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8L1X4A07763;
	Thu, 20 Sep 2001 18:33:04 -0700
Message-ID: <3BAA962D.C55F2239@mvista.com>
Date: Thu, 20 Sep 2001 18:21:49 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: busybox does not like 2.4.8, or the other way around?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I have a small busybox userland that works fine with 2.4.2 kernel, but failed
with the latest 2.4.8 kernel.  The symptom is that it is stuck at the
following prompt:

================
....
Kernel command line: console=ttyS0,115200 ip=bootp
....
Freeing unused kernel memory: 4k freed
Algorithmics/MIPS FPU Emulator v1.4
serial console detected.  Disabling virtual terminals.
init started:  BusyBox v0.51 (2001.07.18-06:43+0000) multi-call binary

Please press Enter to activate this console.
================

A simple test shows the console is still working, i.e., pressing a key *does*
generate an interrupt and ISR *does* read the correct char value.

I really cannot think of anything else that might make busybox stuck here. 
Any clue?  Anybody else is using busybox with more recent kernels?

Jun
