Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id RAA15299
	for <pstadt@stud.fh-heilbronn.de>; Wed, 11 Aug 1999 17:21:53 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA07695; Wed, 11 Aug 1999 08:18:20 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA18584
	for linux-list;
	Wed, 11 Aug 1999 08:09:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA22528
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 11 Aug 1999 08:09:52 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id IAA07432
	for <linux@cthulhu.engr.sgi.com>; Wed, 11 Aug 1999 08:09:46 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 2710 invoked from network); 11 Aug 1999 15:09:42 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 11 Aug 1999 15:09:42 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <QT1YF6D7>; Wed, 11 Aug 1999 10:53:29 -0400
Message-ID: <E138DB347D10D3119C630008C79F5DEC11F4F6@BART>
From: Mike Hill <mikehill@hgeng.com>
To: "'Andrew R. Baker'" <andrewb@uab.edu>
Cc: linux@cthulhu.engr.sgi.com
Subject: RE: Floptical Drive
Date: Wed, 11 Aug 1999 10:53:26 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thanks Andrew, 2.2 compiles now.

Mike


> -----Original Message-----
> From:	Andrew R. Baker [SMTP:andrewb@uab.edu]
> Sent:	Monday, August 09, 1999 5:24 PM
> To:	Mike Hill
> Cc:	'Ulf Carlsson'; linux@cthulhu.engr.sgi.com
> Subject:	RE: Floptical Drive
> 
> 
> This patch should fix the error you are seing below, but probably won't do
> much for your original complaint.
> 
> --- sgiseeq.c~	Fri Aug  6 08:25:29 1999
> +++ sgiseeq.c	Mon Aug  9 16:18:16 1999
> @@ -32,6 +32,7 @@
>  #include <linux/skbuff.h>
>  
>  #include <asm/sgihpc.h>
> +#include <asm/sgint23.h>
>  #include <asm/sgialib.h>
>  
>  #include "sgiseeq.h"
> 
