Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1F2ukr05499
	for linux-mips-outgoing; Thu, 14 Feb 2002 18:56:46 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1F2uj905495
	for <linux-mips@oss.sgi.com>; Thu, 14 Feb 2002 18:56:45 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g1F1sFB10416;
	Thu, 14 Feb 2002 17:54:15 -0800
Message-ID: <3C6C6ACF.CAD2FFC@mvista.com>
Date: Thu, 14 Feb 2002 17:56:31 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: FPU emulator unsafe for SMP?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I have been chasing a FPU register corruption problem on a SMP box.  The
curruption seems to be caused by FPU emulator code.  Is that code SMP safe? 
If not, what are the volunerable spots?

Just thought I'd check before I dive into it ....

BTW, I think even with the latest fpu emu patch, the classic fpu/signal
problem is still there.  I will post in a separate email later.

Jun
