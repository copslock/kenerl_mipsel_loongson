Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8P1Dmf06740
	for linux-mips-outgoing; Mon, 24 Sep 2001 18:13:48 -0700
Received: from ex2k.pcs.psdc.com ([209.125.203.85])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8P1DiD06737
	for <linux-mips@oss.sgi.com>; Mon, 24 Sep 2001 18:13:45 -0700
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Error in loading shared library glinc-2.0.6.so.
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Date: Mon, 24 Sep 2001 18:10:07 -0700
Message-ID: <84CE342693F11946B9F54B18C1AB837B14A1A4@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Error in loading shared library glinc-2.0.6.so.
Thread-Index: AcFFXtAjmvpqjEIMSYKsvvgmuTgjGw==
From: "Steven Liu" <stevenliu@psdc.com>
To: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8P1DkD06738
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, All:

I have a bootupproblem in my new Mips R3000 Linux system. 

I build the kernel 2.2.12, glibc-2.0.6, gcc and init utility. When it
boots up, it loads /sbin/init, /lib/ld-2.0.6.so,and /etc/ld.so.cache.
But it gives an error when it tries to load /lib/libc-2.0.6.so: "Error
in loading shared library glinc-2.0.6.so".

After I investigated the problem, I found that the virtual addresses for
/etc/ld.so.cache and /lib/libc.2.0.6.so are the same: 0x2aaac000 in
do_mmap( ).

I would be very appreciated if you can give me any help.

Thank you.

Steven Liu
