Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5IDoPnC015277
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 06:50:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5IDoPQH015276
	for linux-mips-outgoing; Tue, 18 Jun 2002 06:50:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5IDoJnC015273
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 06:50:19 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id GAA12118;
	Tue, 18 Jun 2002 06:53:06 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id GAA07442;
	Tue, 18 Jun 2002 06:53:04 -0700 (PDT)
Message-ID: <007601c216d0$6f7f0840$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
Subject: Linux and the Sony Playstation 2
Date: Tue, 18 Jun 2002 15:59:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

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
