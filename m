Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0EMHcs23195
	for linux-mips-outgoing; Mon, 14 Jan 2002 14:17:38 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0EMHXg23190
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 14:17:34 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g0ELHFt05877;
	Mon, 14 Jan 2002 21:17:16 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.0/8.8.7) id g0ELHCi02540;
	Mon, 14 Jan 2002 21:17:12 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15427.19160.15187.23375@gladsmuir.algor.co.uk>
Date: Mon, 14 Jan 2002 21:17:12 +0000 (GMT)
To: "Matthew Dharm" <mdharm@momenco.com>
Cc: "Jason Gunthorpe" <jgg@debian.org>, <linux-mips@oss.sgi.com>
Subject: RE: MIPS64 status?
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIEEMNCEAA.mdharm@momenco.com>
References: <Pine.LNX.3.96.1020114005113.14010F-100000@wakko.deltatee.com>
	<NEBBLJGMNKKEEMNLHGAIEEMNCEAA.mdharm@momenco.com>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Matthew Dharm (mdharm@momenco.com) writes:

> I guess what I'm looking for is what I should tell someone who wants
> to run MIPS Linux 64-bit with 8 gigs of RAM.

"Ask Ralf".  (at least, that's the best advice for the kernel, which
he worked on at SGI).

For a compiler, you should ask Algorithmics.  We haven't tried the
64-bit configuration yet, but we've done lots of GCC variants and it's
only a program...

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / home: +44 20 7226 0032
http://www.algor.co.uk
