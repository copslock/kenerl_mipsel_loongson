Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADHnJk14119
	for linux-mips-outgoing; Tue, 13 Nov 2001 09:49:19 -0800
Received: from smtp.psdc.com (smtp.psdc.com [209.125.203.83])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADHnH014116
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 09:49:17 -0800
Received: (from ex2k [172.19.1.1])
 by smtp.psdc.com (NAVGW 2.5.1.13) with SMTP id M2001111309494417238
 for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 09:49:44 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Which package rc.sysinit is in?
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
Date: Tue, 13 Nov 2001 09:44:05 -0800
Message-ID: <84CE342693F11946B9F54B18C1AB837B14AEBD@ex2k.pcs.psdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Which package rc.sysinit is in?
Thread-Index: AcFsaslJjm1dFUFqRI2pqdJUOlSDfA==
From: "Steven Liu" <stevenliu@psdc.com>
To: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id fADHnH014117
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All:

With your help, I have cross-built and tested the util-linux-2.9s
package for my mips r3000 CPU under linux-2.2.12. The system crushed in
the program rc.sysinit with pid=8 when it was booting up.

What and where is rc.sysinit?

Thanks,

Steven Liu
