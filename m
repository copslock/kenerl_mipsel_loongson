Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g07NoGM04009
	for linux-mips-outgoing; Mon, 7 Jan 2002 15:50:16 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g07NoCg04002
	for <linux-mips@oss.sgi.com>; Mon, 7 Jan 2002 15:50:12 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g07MnxX04725;
	Mon, 7 Jan 2002 14:49:59 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: <ellis@spinics.net>, <linux-mips@oss.sgi.com>
Subject: RE: Galileo 64240 
Date: Mon, 7 Jan 2002 14:49:59 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIMELECEAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200201072217.g07MHrY20022@spinics.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

We've got a 64240-based board that we're going to be porting Linux
to... tho we're not using the on-board MPSC ports.  I doubt anyone is
building a board using the MPSC ports -- it's just too difficult to
drive them, and 16550-like parts are too cheap.

If you're trying to bring up a 64240-based board under linux, perhaps
sharing work would be good?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of ellis@spinics.net
> Sent: Monday, January 07, 2002 2:18 PM
> To: linux-mips@oss.sgi.com
> Subject: Galileo 64240
>
>
> Is there any support code around for the Galileo 64240?  A serial
> driver would be really nice ;)
>
