Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JJ52nC017364
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 12:05:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JJ52P8017363
	for linux-mips-outgoing; Wed, 19 Jun 2002 12:05:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from host099.momenco.com (IDENT:root@jeeves.momenco.com [64.169.228.99])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JJ4unC017325
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 12:04:56 -0700
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g5JJ7p626662;
	Wed, 19 Jun 2002 12:07:51 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Balakrishnan Ananthanarayanan" <balakris_ananth@email.com>,
   <linux-mips@oss.sgi.com>, <linux-kernel@vger.kernel.org>,
   <redhat-list@redhat.com>
Subject: RE: MIPS - Serial port
Date: Wed, 19 Jun 2002 12:07:51 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAICEIECHAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20020619120414.8473.qmail@email.com>
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The RM7000 does not have an on-chip serial port.  The EV board has
it's own UART.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Balakrishnan
> Ananthanarayanan
> Sent: Wednesday, June 19, 2002 5:04 AM
> To: linux-mips@oss.sgi.com; linux-kernel@vger.kernel.org;
> redhat-list@redhat.com
> Subject: MIPS - Serial port
>
>
> Hi all,
>
>    Is there anyone who has accessed the serial port of an
> RM7000 MIPS processor? If u can provide me the code please
> - or atleast the Serial PORT number of an RM7000 proc.
> mounted on an EV64120A Galileo Board?
>
> Balakrishnan
>
> --
> __________________________________________________________
> Sign-up for your own FREE Personalized E-mail at Mail.com
> http://www.mail.com/?sr=signup
>
> Save up to $160 by signing up for NetZero Platinum Internet service.
> http://www.netzero.net/?refcd=N2P0602NEP8
>
