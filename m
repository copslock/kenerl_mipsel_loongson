Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FMSfnC003143
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 15:28:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FMSfIg003142
	for linux-mips-outgoing; Wed, 15 May 2002 15:28:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FMSYnC003139
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 15:28:34 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Wed, 15 May 2002 15:28:59 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id PAA00011; Wed, 15 May 2002 15:29:01 -0700 (PDT)
Received: from broadcom.com (kwalker@dt-sj3-158 [10.21.64.158]) by
 mail-sj1-1.sj.broadcom.com (8.8.8/8.8.8/MS01) with ESMTP id PAA01292;
 Wed, 15 May 2002 15:29:01 -0700 (PDT)
Message-ID: <3CE2E12D.89DD6545@broadcom.com>
Date: Wed, 15 May 2002 15:29:01 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Matthew Dharm" <mdharm@momenco.com>
cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
References: <NEBBLJGMNKKEEMNLHGAICEACCHAA.mdharm@momenco.com>
X-WSS-ID: 10FC3EA1704813-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Yes... in my environment, I have firmware calls to find out what
physical memory exists, then I call add_memory_region as necessary.  See
arch/mips/sibyte/swarm/setup.c if you're interested.  Nothing too
interesting about it.

Kip

Matthew Dharm wrote:
> 
> Right....
> 
> So, how should my boot code convey that info?  With more
> add_memory_region() calls?  Is that really all I need?
> 
> Matt
> 
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
> 
> > -----Original Message-----
> > From: owner-linux-mips@oss.sgi.com
> > [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Kip Walker
> > Sent: Wednesday, May 15, 2002 3:15 PM
> > To: Matthew Dharm
> > Cc: Linux-MIPS
> > Subject: Re: MIPS 64?
> >
> >
> > Matthew Dharm wrote:
> > >
> > > I don't suppose anyone has a primer or white paper on the
> > High Memory
> > > stuff?  i.e. Applications, requirements, or a quick HOWTO?
> >
> > Well, the CONFIG option is at the bottom of the Machine
> > Selection menu.
> > With a fairly recent 2.4 or 2.5 kernel, it should build at work.
> > Basically, if your firmware/boot code conveys info about
> > regions above
> > physical address 0x1fffffff, the kernel will allocate "struct page"
> > entries for it, and add them to the pool of allocatable memory.  The
> > kernel gets at them by mapping them into Kseg2/Kseg3 temporarily.
> >
> > turn it on, see what happens!  I haven't looked for a primer.
> >
> > Kip
> >
