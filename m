Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA57711 for <linux-archive@neteng.engr.sgi.com>; Mon, 15 Feb 1999 07:08:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA38170
	for linux-list;
	Mon, 15 Feb 1999 07:07:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA24524;
	Mon, 15 Feb 1999 07:07:25 -0800 (PST)
	mail_from (uchac@pvt.net)
Received: from cbu.pvtnet.cz (cbu.pvtnet.cz [194.149.105.18]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA08233; Mon, 15 Feb 1999 07:07:20 -0800 (PST)
	mail_from (uchac@pvt.net)
Received: from pvt.net (popelka.pvt.net [194.149.101.115])
	by cbu.pvtnet.cz (8.9.2/8.9.1) with ESMTP id QAA01481;
	Mon, 15 Feb 1999 16:14:17 +0100 (MET)
Message-ID: <36C83813.C7E31D18@pvt.net>
Date: Mon, 15 Feb 1999 16:06:59 +0100
From: Radim Uchac <uchac@pvt.net>
Organization: http://www.pvt.net
X-Mailer: Mozilla 4.5 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Ariel Faigon <ariel@cthulhu.engr.sgi.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: mysql-3.22.16a-gamma
References: <199902101948.LAA73975@oz.engr.sgi.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



Ariel Faigon wrote:
> 
> What version of gcc are you using?
> 
>         gcc 2.8.x and later doesn't support o32 (i.e. need linking
>         with libs in /usr/lib32/...)
> 
>         gcc 2.7.x support only o32 (need linking with /usr/lib/...)
> 
> Also:
>         _never_ build on IRIX with '-lnsl'
> 
>         See:
>                 http://freeware.sgi.com/
>                 (Click on "Hints for building your own freeware")
> 
> All these are bugs in GNU autoconf as described in the above page.


hi
now is everything ok, but when I try to run mysqld I receive
"Can't create interrupt-thread (error 11, errno: -1)"
do you have some idea?
radim

**************************************************************
Radim Uchac                           e-mail:    uchac@pvt.net
PVT a.s.                              tel:     +420-2-66198409
Podvinny mlyn 6, Praha 9              fax:     +420-2-66198622
Czech Republic
**************************************************************
