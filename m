Received:  by oss.sgi.com id <S42240AbQEYPfQ>;
	Thu, 25 May 2000 08:35:16 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:61994 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42238AbQEYPfC>;
	Thu, 25 May 2000 08:35:02 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA19188; Thu, 25 May 2000 09:30:09 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA53640
	for linux-list;
	Thu, 25 May 2000 09:26:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA38856
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 09:26:54 -0700 (PDT)
	mail_from (watkinse@attens.com)
Received: from staff.cerf.net (staff.cerf.net [198.137.140.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA05154
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 09:26:42 -0700 (PDT)
	mail_from (watkinse@attens.com)
Received: from sdhqdt0132 (dhcp684.hq.sd.cerf.net [192.215.14.84])
	by staff.cerf.net (8.10.1/8.9.3) with SMTP id e4PGQc514749;
	Thu, 25 May 2000 16:26:38 GMT
From:   "Eric Watkins" <watkinse@attens.com>
To:     "Philippe Chauvat" <philippe.chauvat@exfo.com>,
        "Linux Mips" <linux@cthulhu.engr.sgi.com>
Subject: RE: [DHCP]
Date:   Thu, 25 May 2000 09:26:35 -0700
Message-ID: <001801bfc665$feabed20$540ed7c0@hq.sd.cerf.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
In-Reply-To: <392D4F76.9B06C235@exfo.com>
Importance: Normal
X-Filtered-By: VBFilter 1.0
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello,

I had lots of issues getting the ISC.org dhcpd to work properly. I switched
to the standard bootpd(slackware) daemon and things worked fine. I think
this may be just how I have the isc.org dhcpd.conf setup but the bootpd
daemon worked just fine out of the box.

Either the isc.org dhcpd sends things the SGIs aren't prepared to get or it
just not implementing bootpd the right way. I think it's just a config issue
but I've yet to get things right with the dhcpd.conf. You'll notice there
are 4 get requests in the log files before the SGI times out.

There is a post on the isc.org message boards about this. I don't have the
URL but I searched on SGI and bootp in the dhcpd client archives.

I'd suggest trying bootpd(rather thand dhcpd) and seeing if the SGI boots
right up. That worked for me after screwing around with dhcpd for a few
days.

Good luck.

> -----Original Message-----
> From: owner-linux@cthulhu.engr.sgi.com
> [mailto:owner-linux@cthulhu.engr.sgi.com]On Behalf Of Philippe Chauvat
> Sent: Thursday, May 25, 2000 9:06 AM
> To: Linux Mips
> Subject: [DHCP]
>
>
> Hello,
>
> I'm trying to install Linux on an Indy Box. I need some help to boot
> from my Indy with bootp protocols.
>
> My configuration is:
> one Indy with Irix 6.2, nfs, dhcp and tftp server (I would like !)  --->
> named _cream_ IP=192.0.2.2
> one Indy with Irix 5.2 ----> named _pancake_ IP=192.0.2.3
> one PC box with Mandrake 6.0  nfs, dhcp and tftp server ----> named
> _pie_ IP=192.0.2.1
> one HUB to connect everybody
>
> I followed instructions from different HowTo's but...
>
> 1/When I use _cream_ as dhcp server (/usr/sbin/dhcpd -f -d) and try to
> boot _pancake_ I receive a message something like
> BOOT... (not RFC1048)
> and then my _pancake_ does not boot.
>
> 2/ If I try to use _cream_ as dhcp server nothing appears
>
> So, I would like to ask a lot of things!
> -- can I use bootp from _pancake_ to boot on _cream_ or _pie_ ?
> -- how can I see some information about bootp connection on _cream_ from
> _pancake_ ?
>
> Thanks a lot for your help.
> Philippe
>
> P.S. _cream_, _pancake_ and _pie_ names are only as example.
>
