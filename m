Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0GKELk16241
	for linux-mips-outgoing; Wed, 16 Jan 2002 12:14:21 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0GKEFP16238;
	Wed, 16 Jan 2002 12:14:15 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g0GJEAt22356;
	Wed, 16 Jan 2002 19:14:10 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.0/8.8.7) id g0GItrJ08836;
	Wed, 16 Jan 2002 18:55:53 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15429.52408.364878.539323@gladsmuir.algor.co.uk>
Date: Wed, 16 Jan 2002 18:55:52 +0000 (GMT)
To: John Heil <mipsdev@scsoftware.sc-software.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Jason Gunthorpe <jgg@debian.org>,
   Matthew Dharm <mdharm@momenco.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
In-Reply-To: <Pine.LNX.3.95.1020115115824.6855A-100000@scsoftware.sc-software.com>
References: <20020114150751.B29242@dea.linux-mips.net>
	<Pine.LNX.3.95.1020115115824.6855A-100000@scsoftware.sc-software.com>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Who, if anyone, has a MIPS64 reference design board available ?

Algorithmics P-6064 (http://www.algor.co.uk/algor/info/p6064.html) 

> ...With >4G memory capacity ?

A mere 2Gbytes today - we've got two DIMM slots and 1Gbyte SDRAM DIMMs
are readily available.  The 1Gbyte boards have 32 x 256Mbit chips, but
I think there may even now be boards with more chips "stacked" in
pairs.

We've got no significant addressing restrictions on the memory
controller and the existing DIMM modules still have address lines
remaining...  We can support even larger memories when and if the
DIMMs show up.
