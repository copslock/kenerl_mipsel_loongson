Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4ENZR227074
	for linux-mips-outgoing; Mon, 14 May 2001 16:35:27 -0700
Received: from sprint02.rtmx.net (IDENT:qmailr@sprint02.RTMX.NET [208.31.160.2])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4ENZQF27071
	for <linux-mips@oss.sgi.com>; Mon, 14 May 2001 16:35:26 -0700
Received: (qmail 2054 invoked by uid 102); 14 May 2001 23:35:24 -0000
Received: from host098.momenco.com (HELO beagle) (64.169.228.98)
  by 208.31.160.29 with SMTP; 14 May 2001 23:35:24 -0000
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>,
   "Ralf Baechle" <ralf@uni-koblenz.de>
Subject: PATCH: Momentum Computer Ocelot: Making the latest CVS tree build
Date: Mon, 14 May 2001 16:35:43 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIGEGOCBAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0014_01C0DC93.EBC1BE20"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0014_01C0DC93.EBC1BE20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Attached is a patch against the latest CVS tree (as of about 3 hours
ago).  It makes the Momentum Computer Ocelot board build again --
apparently, some of the PCI code has been changed.

It seems likely to me that this is not the best way to do this
patch... if it's unacceptable to the powers that be (Ralf?), could
someone point out to me the new convention for board-specific PCI
initialization?

Matt Dharm

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_0014_01C0DC93.EBC1BE20
Content-Type: application/octet-stream;
	name="mydiff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mydiff"

--- arch/mips/gt64120/common/irq.c	2001/03/09 20:33:46	1.2=0A=
+++ arch/mips/gt64120/common/irq.c	2001/05/14 23:25:01=0A=
@@ -61,6 +61,7 @@=0A=
 #define DBG(x...)=0A=
 #endif=0A=
 =0A=
+void (*irq_setup)(void);=0A=
 =0A=
 /*=0A=
  * Generic no controller code=0A=
--- arch/mips/gt64120/momenco_ocelot/setup.c	2001/02/05 01:33:01	1.1=0A=
+++ arch/mips/gt64120/momenco_ocelot/setup.c	2001/05/14 23:25:01=0A=
@@ -77,7 +77,7 @@=0A=
 {=0A=
 	unsigned int i, j;=0A=
 =0A=
-	irq_setup =3D momenco_ocelot_irq_setup;=0A=
+	irq_setup =3D momenco_ocelot_irq_setup; =0A=
 	board_time_init =3D gt64120_time_init;=0A=
 =0A=
 	mips_io_port_base =3D KSEG1;=0A=
--- fs/ext2/inode.c	2001/04/05 04:58:29	1.34=0A=
+++ fs/ext2/inode.c	2001/05/14 23:25:11=0A=
@@ -568,7 +568,7 @@=0A=
 =0A=
 changed:=0A=
 	while (partial > chain) {=0A=
-		bforget(partial->bh);=0A=
+		brelse(partial->bh);=0A=
 		partial--;=0A=
 	}=0A=
 	goto reread;=0A=
@@ -799,8 +799,8 @@=0A=
 				/* Writer: ->i_blocks */=0A=
 				inode->i_blocks -=3D blocks * count;=0A=
 				/* Writer: end */=0A=
-				ext2_free_blocks (inode, block_to_free, count);=0A=
 				mark_inode_dirty(inode);=0A=
+				ext2_free_blocks (inode, block_to_free, count);=0A=
 			free_this:=0A=
 				block_to_free =3D nr;=0A=
 				count =3D 1;=0A=
@@ -811,8 +811,8 @@=0A=
 		/* Writer: ->i_blocks */=0A=
 		inode->i_blocks -=3D blocks * count;=0A=
 		/* Writer: end */=0A=
-		ext2_free_blocks (inode, block_to_free, count);=0A=
 		mark_inode_dirty(inode);=0A=
+		ext2_free_blocks (inode, block_to_free, count);=0A=
 	}=0A=
 }=0A=
 =0A=

------=_NextPart_000_0014_01C0DC93.EBC1BE20--
