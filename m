Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A1xAI00999
	for linux-mips-outgoing; Thu, 9 Aug 2001 18:59:10 -0700
Received: from thor ([207.246.91.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A1x8V00996
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 18:59:08 -0700
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id VAA29136; Thu, 9 Aug 2001 21:58:30 -0400
Date: Thu, 9 Aug 2001 21:58:30 -0400
From: "J. Scott Kasten" <jsk@tetracon-eng.net>
To: Mike McDonald <mikemac@mikemac.com>
cc: <linux-mips@oss.sgi.com>
Subject: Re: R10K I2 Solid Impact
In-Reply-To: <200108100018.RAA29996@saturn.mikemac.com>
Message-ID: <Pine.SGI.4.33.0108092126050.29075-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


The site www.reputable.com is for a used equipment dealer (no affiliation,
but I bought my I2 from them), they have lots of really good links.  In
particular there is a multi-page SGI FAQ that will answer 70% of your
questions.  If I'm not mistaken the serial is RS-422 like on the older
Macs.  I'm not sure if the pinout is identical or not, but you can get a
matching connector in the Mac section of CompUSA and re-wire the other end
if you have too.  The audio connectors are like a standard PC.  The
keyboard and mouse appear to be standard PS/2 variety.  Amazingly, I even
had a QueCat and hacked Linux driver for it working under Irix when I
played with that durring its ten minutes of fame.  Mine is an extreeme,
but I suspect your Impact uses the same identical 13W3 connector, DB25
shell with 3 mini coax inserted with a dozen or so regular pins.  The
video will be sync on green.  There's some comments on the reputable site
on what it takes to get some monitors to use that.  There's a small
flat connector near the audio that has lots of really tiny pins in it.
That is the external SCSI.

This should get you started.  If you have any other general questions,
email me off list and I'll point you in the right direction.

--

J. Scott Kasten
Email: jsk AT tetracon-eng DOT net

"Nearly all men can stand adversity,
 but if you want to test a man's
 charater, give him power. - A Lincoln"

On Thu, 9 Aug 2001, Mike McDonald wrote:

>
>   I just got a R10K I2 Solid Impact that I'm going to attempt to play
> with linux on. But first I need to find some more basic info. Does
> anyone know where the connectors are documented? In particular, the
> video connectors on the Solid Impact. The SGI search engine just tells
> be they don't refurbish Indigos anymore. The serial port pinouts would
> be useful too. (Wasn't it 'man serial' once I get it running?)
>
>   It's been a while since I've played with an SGI, so any helpful
> information will be greatly appreciated.
>
>   Mike McDonald
>   mikemac@mikemac.com
>
