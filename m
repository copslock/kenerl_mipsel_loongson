Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA71WDD24392
	for linux-mips-outgoing; Tue, 6 Nov 2001 17:32:13 -0800
Received: from smtp.psdc.com (smtp.psdc.com [209.125.203.83])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA71WA024388
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 17:32:11 -0800
Received: (from ex2k [172.19.1.1])
 by smtp.psdc.com (NAVGW 2.5.1.13) with SMTP id M2001110617323625328
 for <linux-mips@oss.sgi.com>; Tue, 06 Nov 2001 17:32:36 -0800
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: parent and child processes share the same stack.
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Date: Tue, 6 Nov 2001 17:27:08 -0800
Message-ID: <84CE342693F11946B9F54B18C1AB837B14AD5A@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: parent and child processes share the same stack.
Thread-Index: AcFnK1Av0WRceLoAQpK3YiWILOm51A==
From: "Steven Liu" <stevenliu@psdc.com>
To: <linux-mips@oss.sgi.com>
Cc: "Steven Liu" <stevenliu@psdc.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id fA71WB024389
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All:

I am porting Linux to my r3000 cpu now and meet with a problem when the
init program is running. 

When the init process (pid=1) forks the first child (pid=7), the parent
process called copy_thread( ) which did the following assignment:
childregs->regs[29] = usp ( Here, usp is the parent's stack pointer)
(see arch/mips/kerenel/process.c).  So, the child and the parent share
the same stack.

After the fork, the parent called write_utmp_wtmp( ) which then called
memset(&utmp,0,sizeof(utmp)) and erased the stack. As we know, this
stack is shared by the parent and the child, the child will die when the
child is scheduled to run because the contents of the stack are all
zeros.

I think the stack should not be shared by the parent and the child after
anyone tries to modify the stack, that is, the child and parent should
have separete stacks. I searched the code and could not find the place
where the separation is given. 

Any help would be greatly appreciated.

Thanks,

Steven Liu
