Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7L1WqB04409
	for linux-mips-outgoing; Mon, 20 Aug 2001 18:32:52 -0700
Received: from smtp.huawei.com (61.144.GD.CN [61.144.161.21] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7L1Wl904406;
	Mon, 20 Aug 2001 18:32:48 -0700
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GIE9J400.93L; Tue, 21 Aug 2001 09:30:40 +0800 
Message-ID: <001901c129e1$5aaaadc0$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net>
Subject: questions about some bits of STATUS register and exception priority...
Date: Tue, 21 Aug 2001 09:34:00 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello:

    I am confused about CU0 and UM(ERL EXL) bit of STATUS register.

    The user manual says that " CP0 is always usable when in Kernel mode,
regardless of the setting of CU0 bit". Does it mean that when in Kernel mode
, the CU0 bit is always 1 and in User mode, the CU0 bit is 0? If the CU0 is
0, can we be sure that it is in User mode?

     If a user program is running in User mode, an interrupt happens at this
time(or an error occurs), then it will switch to Kernel mode to run the
interrupt handler(or the error exception handler). We know that the EXL(or
ERL) bit of Status register will be set to 1 by hardware. What about the UM
bit of Status? Does it remain unchangeable or change to 1 too? The user
manual doesn't say anything about it.


Another question about exception priority:
In entry.S, some exception handlers enables global interrupt bit(IE) but
others disables it.
Also syscall exception handler enables global interrupt bit(IE). Since the
interrupt priority  is lowest,If an interrupt happens in a syscall exception
handler, will it pause the syscall exception handler and run the interrupt
handler? If not, why it enable the IE bit(STI) in the syscall exception
handler??

If two interrupts happens at the same time, how can we decide the larger
priority interrupt and run its ISR?

Thank you very much.

machael thailer
