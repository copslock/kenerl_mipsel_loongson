Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7R3Adf12468
	for linux-mips-outgoing; Sun, 26 Aug 2001 20:10:39 -0700
Received: from zok.sgi.com (zok.sgi.com [204.94.215.101])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7R3Acd12465
	for <linux-mips@oss.sgi.com>; Sun, 26 Aug 2001 20:10:38 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.11.4/8.11.4/linux-outbound_gateway-1.0) with SMTP id f7R3H5a17889
	for <linux-mips@oss.sgi.com>; Sun, 26 Aug 2001 20:17:05 -0700
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA23885; Mon, 27 Aug 2001 14:09:08 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: __dbe_table iteration #2 
In-reply-to: Your message of "Fri, 24 Aug 2001 17:44:08 +0200."
             <Pine.GSO.3.96.1010824150106.11987B-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Aug 2001 13:09:08 +1000
Message-ID: <21302.998881748@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 24 Aug 2001 17:44:08 +0200 (MET DST), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> Ok, that's not much readable, indeed.  Thus I've invented a macro.  See
>a following patch hiding implementation details.

Patch looks good, please send it to Alan Cox.  2.4.8-ac12 introduced
another case of arch specific module data, this time for PPC.
