Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9GK6Oh07305
	for linux-mips-outgoing; Tue, 16 Oct 2001 13:06:24 -0700
Received: from ex2k ([209.125.203.85])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9GK6ND07302
	for <linux-mips@oss.sgi.com>; Tue, 16 Oct 2001 13:06:23 -0700
Subject: system call fork in  init.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 16 Oct 2001 13:02:06 -0700
Message-ID: <84CE342693F11946B9F54B18C1AB837B14A7CE@ex2k.pcs.psdc.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: system call fork in  init.
Thread-Index: AcFWfW3Gu3EC1zgvQpWWM40gVJmllw==
From: "Steven Liu" <stevenliu@psdc.com>
To: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f9GK6ND07303
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, All:

Currently, I am porting Linux 2.2.12 to mips a r3000 CPU. When the init
program forked a child process and the the scheduler try to run it, the
child's stack are all zeros. 

Any one help will be greatly appreciated.

Thanks,

Steven Liu
