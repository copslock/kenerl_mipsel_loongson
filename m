Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3HL9WA28538
	for linux-mips-outgoing; Tue, 17 Apr 2001 14:09:32 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3HL9VM28534
	for <linux-mips@oss.sgi.com>; Tue, 17 Apr 2001 14:09:31 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id QAA30355
	for <linux-mips@oss.sgi.com>; Tue, 17 Apr 2001 16:09:29 -0500
Message-ID: <3ADCBFAE.92957163@cotw.com>
Date: Tue, 17 Apr 2001 15:11:58 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: kernel/printk.c problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

struct console *console_drivers = NULL;                          <----
Need the NULL.

Otherwise, bad things can happen on the following statement in printk

~line 311

       if ((c->flags & CON_ENABLED) && c->write){



Scott
