Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OGvPwJ026824
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 09:57:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OGvPPZ026823
	for linux-mips-outgoing; Wed, 24 Apr 2002 09:57:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from lahoo.mshome.net (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OGv0wJ026819
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 09:57:11 -0700
Received: from prefect.mshome.net ([192.168.0.76] helo=prefect)
	by lahoo.mshome.net with smtp (Exim 3.12 #1 (Debian))
	id 170Q3k-0000vc-00; Wed, 24 Apr 2002 12:56:00 -0400
Message-ID: <013401c1ebb1$12e39cd0$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <michael_pruznick@mvista.com>, <linux-mips@oss.sgi.com>
References: <3CC6CC21.45E7ABB1@mvista.com>
Subject: Re: ps2 keyboard -- no key down events
Date: Wed, 24 Apr 2002 12:57:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Could it be a level-trigger versus edge-trigger interrupt setting?

Regards,
Brad

----- Original Message ----- 
From: "Michael Pruznick" <michael_pruznick@mvista.com>
To: <linux-mips@oss.sgi.com>
Sent: Wednesday, April 24, 2002 11:15 AM
Subject: ps2 keyboard -- no key down events


> I'm working on this mips board with a smsc 90e66 south bridge and
> fdc37m812 super io.  I'm using the standard pc_keyb.c driver.  I only
> see keyboard interrupts and KBD_STAT_OBF set in response to "key up"
> events.  I never see them in response to "key down" events.  Thus, the
> shell running on the vga console never gets my input (since it is the
> "key down" events that pass the character typed to the shell).
> 
> At this point, I'm thinking that the standard driver needs some mods
> to work with the super io's ps2 controller.  The smsc doc only covers
> programming the plug and play registers and doesn't give any info about
> programming the ps2 controller.
> 
> I've looked around the web, but haven't found anything useful.
> 
> Can anyone point me towards some resources that might help out?
> 
> -- 
> Michael Pruznick, michael_pruznick@mvista.com, www.mvista.com
> MontaVista Software, 1237 East Arques Ave, Sunnyvale, CA 94085
> 
