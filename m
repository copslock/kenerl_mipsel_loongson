Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g26Lffk00343
	for linux-mips-outgoing; Wed, 6 Mar 2002 13:41:41 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g26LfW900329
	for <linux-mips@oss.sgi.com>; Wed, 6 Mar 2002 13:41:32 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g26KfVR04852;
	Wed, 6 Mar 2002 12:41:31 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Marc Karasek" <marc_karasek@ivivity.com>,
   "Linux MIPS" <linux-mips@oss.sgi.com>
Subject: RE: Questions?
Date: Wed, 6 Mar 2002 12:41:31 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIMEOKCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <25369470B6F0D41194820002B328BDD2195BB2@ATLOPS>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

We use kernel 2.4.17 right now (upgrade to 2.4.18 is planned), and we
use the toolchain that H.J. Liu put together (and is located on
oss.sgi.com).

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Marc Karasek [mailto:marc_karasek@ivivity.com]
> Sent: Wednesday, March 06, 2002 12:40 PM
> To: 'Matthew Dharm'; Linux MIPS
> Subject: RE: Questions?
>
>
> What kernel/tools do you provide?
>
> -----Original Message-----
> From: Matthew Dharm [mailto:mdharm@momenco.com]
> Sent: Wednesday, March 06, 2002 2:45 PM
> To: Marc Karasek; Linux MIPS
> Subject: RE: Questions?
>
>
> My company develops embedded MIPS systems, and Linux is one of our
> supported operating systems.
>
> We chose big-endian, mostly because it seemed the right choice given
> the state of the tree.  Some customers have recompiled our
> code to run
> little-endian with little problem, tho.
>
> Matt
>
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.
>  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
>
> > -----Original Message-----
> > From: owner-linux-mips@oss.sgi.com
> > [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Marc Karasek
> > Sent: Wednesday, March 06, 2002 9:25 AM
> > To: Linux MIPS
> > Subject: Questions?
> >
> >
> > I have some general questions for all:
> >
> > How many of you are involved with embedded linux
> development using a
> > MIPS processor?
> >
> > What endianess have you chosen for your project and why?
> >
> > If you have not guessed it, I am involved with a
> MIPS/Linux embedded
> > project and we are trying to determine if there are any
> > pros or cons in
> > one endianess over the other.
> >
> > --
> > /*************************
> > Marc Karasek
> > Sr. Firmware Engineer
> > iVivity Inc.
> > marc_karasek@ivivity.com
> > 678.990.1550 x238
> > 678.990.1551 Fax
> > *************************/
> >
>
