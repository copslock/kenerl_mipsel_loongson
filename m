Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JK9hnC020537
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 13:09:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JK9hop020536
	for linux-mips-outgoing; Wed, 19 Jun 2002 13:09:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail2.camcare.com ([206.193.125.77])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JK9WnC020524
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 13:09:33 -0700
Received: from KES.camcare.com (IS~KES [10.10.95.4]) by mail2.camcare.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2650.21)
	id NAXGJAR6; Wed, 19 Jun 2002 16:22:57 -0400
Received: by KES.camcare.com with Internet Mail Service (5.5.2650.21)
	id <HXGSHRV0>; Wed, 19 Jun 2002 16:10:58 -0400
Message-ID: <490E0430C3C72046ACF7F18B7CD76A2A568B84@KES.camcare.com>
From: "Smith, Todd" <Todd.Smith@camc.org>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: Linux and the Sony Playstation 2
Date: Wed, 19 Jun 2002 16:10:52 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello Kevin,

This list is been pretty quiet lately so I don't really know what is
happening on the Linux/MIPS front.  I am hoping that work is still slowly
proceeding on the DECstation that I have, but I don't really know.  I agree
with you that PS2 offer enormous power to the developer and as a cheap
source of computing power to other countries.

I don't know a great deal about it, but I am least willing to discuss it if
it will create some additional interest.

Todd Smith <todd.smith@camc.org>



-----Original Message-----
From: Kevin D. Kissell [mailto:kevink@mips.com]
Sent: Tuesday, June 18, 2002 10:00 AM
To: linux-mips@fnet.fr; linux-mips@oss.sgi.com
Subject: Linux and the Sony Playstation 2


The Sony PS2 Linux kit has been shipping for nearly
a month now, and I'm frankly astonished at how little
I've seen on this mailing list about it.  For better or
for worse, this changes everything for MIPS/Linux.
The number of MIPS/Linux users worldwide has
just gone up by at least an order of magnitude,
and they are on a platform running a 2.2.1-derived
kernel and using gcc 2.95.2.

It's a perfectly usable platform out of the box, but
Carsten has thrown "crashme" at it, and it goes down
relatively quickly.  People trying to port kaffe and
other programs that do double-precision float are
blocked because there's no double precision on the
R5900, and the Sony kernel lacks the Algorithmics
emulator.

It's not clear what Sony is going to put into further
development, and what they are going to expect the
user community to take over from here.  There is a 
group of people trying to take the kernel up to
2.2.20, but I'm not yet sure whether they know
what they are doing, and anyway, that box needs
to get to 2.4.x ASAP.

I respectfully submit that, within a year, any 
MIPS/Linux  source tree that does not support 
the PS2 will be considered obsolete.  And that
quite specifically includes the one at oss.sgi.com.
I personally would want to approach this in terms 
of merging the necessary PS2 code into something
that could be expressed as a patch over kernel.org's
2.4.19_or_better, and which would be provded 
as the default MIPS kernel technology by MIPS 
and SGI servers, and ultimately by kernel.org.

Is no one else here working on this?

            Regards,

            Kevin K.
