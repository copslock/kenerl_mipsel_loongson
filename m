Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA26587
	for <pstadt@stud.fh-heilbronn.de>; Wed, 29 Sep 1999 01:36:06 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA3594537; Tue, 28 Sep 1999 16:26:57 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA72975
	for linux-list;
	Tue, 28 Sep 1999 16:18:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA62344;
	Tue, 28 Sep 1999 16:18:28 -0700 (PDT)
	mail_from (neuroinc@unidial.com)
Received: from mail.unidial.com (unidial.com [206.112.0.9]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA3598659; Tue, 28 Sep 1999 16:18:26 -0700 (PDT)
	mail_from (neuroinc@unidial.com)
Received: from unidial.com (root@pool-209-138-6-143.ipls.grid.net [209.138.6.143])
	by mail.unidial.com (8.8.7/ntr.net 3.0.0) with ESMTP id XAA10877;
	Tue, 28 Sep 1999 23:16:43 GMT
Message-ID: <37F14445.866DE7F1@unidial.com>
Date: Tue, 28 Sep 1999 22:42:14 +0000
From: Alan Hoyt <neuroinc@unidial.com>
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: SGI Mips <linux@cthulhu.engr.sgi.com>
CC: "William J. Earl" <wje@cthulhu.engr.sgi.com>
Subject: Re: Linux->Indy->O2
References: <v04220602b415257a1e03@[216.63.49.245]>
		<37F1169E.B816C35E@unidial.com> <14321.9939.647579.563478@liveoak.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

"William J. Earl" wrote:

>       REX3 is "Newport", AKA "XL", graphics, which was the default on
> Indy and a lower-cost option on Indigo2.  Most Indigo2 and some Indy
> systems have more complex graphics adapters ("Elan", "Extreme", "XZ", "Impact").

Sorry, thought everyone knew - here is an excerpt from the SGI Hardware FAQ for those who are curious:

  Indy: IP22:
  Express (XZ ["GR3-Elan": 24, Z, 4 GE7, 1 RE3.1]),
  Newport (XL ["NG1": 8|24, soft Z, NG1, REX3])

  Indigo2: IP22:
  Express (XZ ["GR3-Elan": 24, Z, 4 GE7, 1 RE3.1]),
  Newport (XL ["NG1": 8|24, soft Z, NG1, REX3]),
  Newpress (Extreme+XL ["GU1-Extreme": 32 Z]),
  Ultra (Extreme ["GU1-Extreme", 32 Z])

What was the most prevalent graphics configuration on the Indigo2s?


 - Alan Hoyt -
