Received:  by oss.sgi.com id <S42333AbQEZQ52>;
	Fri, 26 May 2000 09:57:28 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:34088 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42297AbQEYWOR>; Thu, 25 May 2000 15:14:17 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA03153; Thu, 25 May 2000 16:18:17 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA09889; Thu, 25 May 2000 16:13:06 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA48094
	for linux-list;
	Thu, 25 May 2000 16:03:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA09523
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 16:03:27 -0700 (PDT)
	mail_from (watkinse@attens.com)
Received: from staff.cerf.net (staff.cerf.net [198.137.140.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00036
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 16:03:27 -0700 (PDT)
	mail_from (watkinse@attens.com)
Received: from sdhqdt0132 (dhcp684.hq.sd.cerf.net [192.215.14.84])
	by staff.cerf.net (8.10.1/8.9.3) with SMTP id e4PN3Pe14246;
	Thu, 25 May 2000 23:03:25 GMT
From:   "Eric Watkins" <watkinse@attens.com>
To:     "Keith M Wesolowski" <wesolows@chem.unr.edu>
Cc:     "Philippe Chauvat" <philippe.chauvat@exfo.com>,
        "Linux Mips" <linux@cthulhu.engr.sgi.com>
Subject: RE: [DHCP]
Date:   Thu, 25 May 2000 16:03:27 -0700
Message-ID: <000f01bfc69d$6f792a40$540ed7c0@hq.sd.cerf.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
In-Reply-To: <20000525094735.A30683@chem.unr.edu>
Importance: Normal
X-Filtered-By: VBFilter 1.0
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ok. I've had about 4 replys so far about other people having issues with the
isc.org dhcpd daemon...

I've had great luck using it for other projects so AFAIK this is just an
issue with the way SGI does bootp. Perhaps we can find a workaround for the
ISC dhcpd.

I'll put a sniffer on the wire and watch a bootpd-->SGI exchange vs. a
dhcpd-->SGI exchange and see what's missing.

In the mean time can we get something posted to the FAQ or howto so that
other people don't sufer the same fate?

Thanks!

> -----Original Message-----
> From: owner-linux@cthulhu.engr.sgi.com
> [mailto:owner-linux@cthulhu.engr.sgi.com]On Behalf Of Keith M Wesolowski
> Sent: Thursday, May 25, 2000 9:48 AM
> To: Eric Watkins
> Cc: Philippe Chauvat; Linux Mips
> Subject: Re: [DHCP]
>
>
> On Thu, May 25, 2000 at 09:26:35AM -0700, Eric Watkins wrote:
>
> > Either the isc.org dhcpd sends things the SGIs aren't prepared
> to get or it
> > just not implementing bootpd the right way. I think it's just a
> config issue
> > but I've yet to get things right with the dhcpd.conf. You'll
> notice there
> > are 4 get requests in the log files before the SGI times out.
>
> I also had difficulty using ISC dhcpd to boot SGIs until I did an
> unsetenv netaddr before booting. I don't yet know why this works.
>
> --
> Keith M Wesolowski			wesolows@chem.unr.edu
> University of Nevada			http://www.chem.unr.edu
> Chemistry Department Systems and Network Administrator
>
