Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78AP0T04407
	for linux-mips-outgoing; Wed, 8 Aug 2001 03:25:00 -0700
Received: from animal.pace.co.uk (gateway.pace.co.uk [195.44.197.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78AOwV04401
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 03:24:59 -0700
Received: from exchange1.cam.pace.co.uk (exchange1.cam.pace.co.uk [136.170.131.80])
	by animal.pace.co.uk (8.10.2/8.10.2) with ESMTP id f78AOqQ23131
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 11:24:52 +0100
Received: by exchange1.cam.pace.co.uk with Internet Mail Service (5.5.2650.21)
	id <QQGSKR7X>; Wed, 8 Aug 2001 11:24:52 +0100
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC56D@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Patch for i8259.c
Date: Wed, 8 Aug 2001 11:24:51 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C11FF4.5BD8F130"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C11FF4.5BD8F130
Content-Type: text/plain;
	charset="iso-8859-1"

Attached is a patch for i8259.c which fixes a problem where irq2 is setup
before the irq_desc array is initialised.

Phil


------_=_NextPart_000_01C11FF4.5BD8F130
Content-Type: application/octet-stream;
	name="i8259.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="i8259.c.patch"

--- i8259.c.orig	Wed Aug  8 10:52:48 2001=0A=
+++ i8259.c	Wed Aug  8 10:53:04 2001=0A=
@@ -295,7 +295,6 @@=0A=
 =0A=
 	request_resource(&ioport_resource, &pic1_io_resource);=0A=
 	request_resource(&ioport_resource, &pic2_io_resource);=0A=
-	setup_irq(2, &irq2);=0A=
 =0A=
 	init_8259A(0);=0A=
 =0A=
@@ -305,4 +304,6 @@=0A=
 		irq_desc[i].depth =3D 1;=0A=
 		irq_desc[i].handler =3D &i8259A_irq_type;=0A=
 	}=0A=
+=0A=
+	setup_irq(2, &irq2);=0A=
 }=0A=

------_=_NextPart_000_01C11FF4.5BD8F130--
