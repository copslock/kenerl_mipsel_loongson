Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GKPND26027
	for linux-mips-outgoing; Mon, 16 Jul 2001 13:25:23 -0700
Received: from mailgate3.cinetic.de (mailgate3.cinetic.de [212.227.116.80])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GKPMV26009
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 13:25:22 -0700
Received: from smtp.web.de (smtp01.web.de [194.45.170.210])
	by mailgate3.cinetic.de (8.11.2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id f6GKPFg22166;
	Mon, 16 Jul 2001 22:25:16 +0200
Received: from intel by smtp.web.de with smtp
	(freemail 4.2.2.2 #11) id m15MEva-007oM9C; Mon, 16 Jul 2001 22:25 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
From: Harald Koerfgen <hkoerfg@web.de>
Organization: none to speak of
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [patch] 2.4.5: DECstation LK201 keyboard non-functional
Date: Mon, 16 Jul 2001 22:28:14 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
References: <Pine.GSO.3.96.1010716195815.12988F-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <Pine.GSO.3.96.1010716195815.12988F-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Message-Id: <01071622281400.00525@intel>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Monday 16 July 2001 20:43, Maciej W. Rozycki wrote:
[DECstation Keyboard]

>  Note while putting a file away from an arch-specific tree into a generic
> driver one might seem a bad move, it really is the right thing in this
> case.  The point is the decserial.c device is not arch-specific at all,
> i.e. no more than the 8250 serial.c device is.  DEC used the devices in a
> number of their systems, including DECstations (onboard SCC and DZ11 and
> TURBOchannel PMAC-A DZ11 devices), DEC 3000 Alpha systems (onboard SCC and
> PMAC-A devices) and VAXstations (onboard DZ11 and PMAC-A devices).  Thus I
> believe they should be treated as generic devices, especially as the VAX
> and the DEC 3000 Alpha (to some extent) Linux ports are underway.

I tend to agree, but maybe I'm biased.  On the other hand, it would prpbably 
be better to modularize the dz and zs drivers.

However, if nobody has any objections I'll commit this for the 2.4 series.

Greetings,
Harald
-- 
Don't look now, but there is a multi-legged creature on your shoulder.
