Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA11341
	for <pstadt@stud.fh-heilbronn.de>; Wed, 29 Sep 1999 02:27:19 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA01741; Tue, 28 Sep 1999 17:24:14 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA32875
	for linux-list;
	Tue, 28 Sep 1999 17:18:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [150.166.40.92])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA32755;
	Tue, 28 Sep 1999 17:18:28 -0700 (PDT)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id RAA23870;
	Tue, 28 Sep 1999 17:18:28 -0700
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From: "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14321.23251.949521.794817@liveoak.engr.sgi.com>
Date: Tue, 28 Sep 1999 17:18:27 -0700 (PDT)
To: Alan Hoyt <neuroinc@unidial.com>
Cc: SGI Mips <linux@cthulhu.engr.sgi.com>
Subject: Re: Linux->Indy->O2
In-Reply-To: <37F14445.866DE7F1@unidial.com>
References: <v04220602b415257a1e03@[216.63.49.245]>
	<37F1169E.B816C35E@unidial.com>
	<14321.9939.647579.563478@liveoak.engr.sgi.com>
	<37F14445.866DE7F1@unidial.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Alan Hoyt writes:
 > "William J. Earl" wrote:
 > 
 > >       REX3 is "Newport", AKA "XL", graphics, which was the default on
 > > Indy and a lower-cost option on Indigo2.  Most Indigo2 and some Indy
 > > systems have more complex graphics adapters ("Elan", "Extreme", "XZ", "Impact").
 > 
 > Sorry, thought everyone knew - here is an excerpt from the SGI Hardware FAQ for those who are curious:
 > 
 >   Indy: IP22:
 >   Express (XZ ["GR3-Elan": 24, Z, 4 GE7, 1 RE3.1]),
 >   Newport (XL ["NG1": 8|24, soft Z, NG1, REX3])
 > 
 >   Indigo2: IP22:
 >   Express (XZ ["GR3-Elan": 24, Z, 4 GE7, 1 RE3.1]),
 >   Newport (XL ["NG1": 8|24, soft Z, NG1, REX3]),
 >   Newpress (Extreme+XL ["GU1-Extreme": 32 Z]),
 >   Ultra (Extreme ["GU1-Extreme", 32 Z])
 > 
 > What was the most prevalent graphics configuration on the Indigo2s?

      XZ was probably the most common, until Impact was released.  On
the Indigo2 R10000, Impact (not on the above list) is probably the
most common.
