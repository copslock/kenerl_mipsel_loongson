Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0A5JHg28921
	for linux-mips-outgoing; Wed, 9 Jan 2002 21:19:17 -0800
Received: from mta6.snfc21.pbi.net (mta6.snfc21.pbi.net [206.13.28.240])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0A5JGg28918
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 21:19:16 -0800
Received: from [10.2.2.67] ([63.194.214.47])
 by mta6.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GPP00LGZG00R0@mta6.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Wed, 09 Jan 2002 20:19:14 -0800 (PST)
Date: Wed, 09 Jan 2002 20:16:52 -0800
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: Galileo 64240
In-reply-to: <3C3C8370.2B1F1C54@patton.com>
To: paul@patton.com
Cc: Matthew Dharm <mdharm@momenco.com>, ellis@spinics.net,
   linux-mips <linux-mips@oss.sgi.com>
Message-id: <1010636216.1221.0.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <NEBBLJGMNKKEEMNLHGAIGELHCEAA.mdharm@momenco.com>
 <3C3C8370.2B1F1C54@patton.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The GT64260 is the PPC equivalent of the mips 64240.  I'm pretty sure
our PPC guys did some work with the 64260 and they might have one of the
serial ports working as a simple uart. Check the community PPC tree. If
you don't find anything there, post to the ppc mailing list to see what
people have done with the 64260.  Pretty much everything should be
portable to the 64240 and you might get feedback on hardware bugs and
workarounds.

Pete
