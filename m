Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAKGXHQ18152
	for linux-mips-outgoing; Tue, 20 Nov 2001 08:33:17 -0800
Received: from server3.toshibatv.com ([207.152.29.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAKGXEW18148
	for <linux-mips@oss.sgi.com>; Tue, 20 Nov 2001 08:33:15 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <VJ2W6X09>; Tue, 20 Nov 2001 09:32:57 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B7446@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "'Keith Owens'" <kaos@melbourne.sgi.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: RE: Memory mapping 
Date: Tue, 20 Nov 2001 09:32:04 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-> >OK, now that I've spent a couple weeks looking at Linux 
-> >memory management,
-> >can someone please help me straighten this out. First, I 
-> >have a requirement
-> >to "unobtrusively" hot-patch instruction code ( and 
-> >probably data also )
-> >segments in memory.
-> 
-> At the risk of stating the obvious, have you looked at the 
-> ptrace code
-> in arch/$(ARCH)/kernel/ptrace.c?  That already does all the work for
-> reading and writing code and data.
->

Yep, most of what it does I have in the simple patch case: replace existing
instructions. It did give me some things to check to make certain it works,
though. Thanks. The other case requires adding code, so kernel space memory
must be allocated and mmap'd. That's what I've been wrestling most with.
