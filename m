Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f780cj022286
	for linux-mips-outgoing; Tue, 7 Aug 2001 17:38:45 -0700
Received: from ex2k.pcs.psdc.com ([209.125.203.85])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f780ciV22283
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 17:38:44 -0700
content-class: urn:content-classes:message
Subject: execve("sbin/init",argv_init,envp-init) in init() of main.c and sbin/init.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 7 Aug 2001 17:36:44 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
Message-ID: <84CE342693F11946B9F54B18C1AB837B0A2294@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: execve("sbin/init",argv_init,envp-init) in init() of main.c and sbin/init.
Thread-Index: AcEfojJqpJJKjWoETbGX1CrUnpmVpQ==
From: "Steven Liu" <stevenliu@psdc.com>
To: <linux-mips@oss.sgi.com>
Cc: <dankamura@mvista.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f780ciV22284
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, ALL:

I posted a message in this board regarding
execve("sbin/init",argv_init,envp-init) in init() of main.c this
morning. Pete gave some very good suggessions.Thank you very much, Pete.
I tried them but the problem has not been solved yet. My CPU is not
standard R3000 mips CPU with some registers added in and modified. For
example, ASID field in EntryHi register is of 8 bits instead of 6 bits.
This may creat some problems.

I want to investigate the "sbin/init" program but I do not know where I
can find the source code of this program. If you know any hint and let
me know, I would be very pleased.

Thank you for your help.

Regards,

Steven Liu
