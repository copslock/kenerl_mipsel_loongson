Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6IH67B20721
	for linux-mips-outgoing; Wed, 18 Jul 2001 10:06:07 -0700
Received: from mail1.infineon.com (mail1.infineon.com [192.35.17.229])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6IH64V20718
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 10:06:04 -0700
X-Envelope-Sender-Is: thomas.langer@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id f6IH62211307
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 19:06:02 +0200 (MET DST)
Received: by mchb0b1w.muc.infineon.com with Internet Mail Service (5.5.2653.19)
	id <PCH6VASF>; Wed, 18 Jul 2001 19:05:40 +0200
Message-ID: <57427888BDF5D4118BA40008C7286B3E097B7A@MCHB0FXA>
From: thomas.langer@infineon.com
To: linux-mips@oss.sgi.com
Subject: Malta Board and PC Keyboard
Date: Wed, 18 Jul 2001 19:05:54 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Has somebody already used a PC Keyboard with the Malta development Board?
I have enabled the driver for the keyboard, but I get the bootmessage:
	initialize_kbd: Keyboard failed self test
	keyboard: Timeout - AT keyboard not present?

Maybe a problem with the mapping from Intel-IO to mmio?
I'm just starting development on MIPS and don't know where to search.

(My Kernel is 2.4.3-MIPS-01.00 from ftp.mips.com)

Thomas
