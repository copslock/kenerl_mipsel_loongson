Received:  by oss.sgi.com id <S42240AbQEYPM4>;
	Thu, 25 May 2000 08:12:56 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15990 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEYPMv>; Thu, 25 May 2000 08:12:51 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA03257; Thu, 25 May 2000 09:17:31 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id JAA88448; Thu, 25 May 2000 09:12:16 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA39966
	for linux-list;
	Thu, 25 May 2000 09:04:03 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA45053
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 09:04:02 -0700 (PDT)
	mail_from (philippe.chauvat@exfo.com)
Received: from mail.exfo.com (mail.exfo.com [206.191.88.36]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA08500
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 09:04:00 -0700 (PDT)
	mail_from (philippe.chauvat@exfo.com)
Received: from exfo.com ([172.16.46.216]) by mail.exfo.com
          (Netscape Messaging Server 3.62)  with ESMTP id 387
          for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 12:02:58 -0400
Message-ID: <392D4F76.9B06C235@exfo.com>
Date:   Thu, 25 May 2000 12:06:14 -0400
From:   "Philippe Chauvat" <philippe.chauvat@exfo.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To:     Linux Mips <linux@cthulhu.engr.sgi.com>
Subject: [DHCP]
Content-Type: multipart/mixed;
 boundary="------------86B0C68B22FD5EA19F23FF31"
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

This is a multi-part message in MIME format.
--------------86B0C68B22FD5EA19F23FF31
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

I'm trying to install Linux on an Indy Box. I need some help to boot
from my Indy with bootp protocols.

My configuration is:
one Indy with Irix 6.2, nfs, dhcp and tftp server (I would like !)  --->
named _cream_ IP=192.0.2.2
one Indy with Irix 5.2 ----> named _pancake_ IP=192.0.2.3
one PC box with Mandrake 6.0  nfs, dhcp and tftp server ----> named
_pie_ IP=192.0.2.1
one HUB to connect everybody

I followed instructions from different HowTo's but...

1/When I use _cream_ as dhcp server (/usr/sbin/dhcpd -f -d) and try to
boot _pancake_ I receive a message something like
BOOT... (not RFC1048)
and then my _pancake_ does not boot.

2/ If I try to use _cream_ as dhcp server nothing appears

So, I would like to ask a lot of things!
-- can I use bootp from _pancake_ to boot on _cream_ or _pie_ ?
-- how can I see some information about bootp connection on _cream_ from
_pancake_ ?

Thanks a lot for your help.
Philippe

P.S. _cream_, _pancake_ and _pie_ names are only as example.

--------------86B0C68B22FD5EA19F23FF31
Content-Type: text/x-vcard; charset=us-ascii;
 name="philippe.chauvat.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Philippe Chauvat
Content-Disposition: attachment;
 filename="philippe.chauvat.vcf"

begin:vcard 
n:Chauvat;Philippe
tel;work:+1 (418) 683 0913 #3663
x-mozilla-html:FALSE
url:www.exfo.com
org:Exfo O.E. inc.
adr:;;465 Avenue Godin;Vanier;Quebec;G1M 3G7;Canada
version:2.1
email;internet:philippe.chauvat@exfo.com
title:Manager, Web Tools Deployment
fn:Philippe Chauvat
end:vcard

--------------86B0C68B22FD5EA19F23FF31--
