Received:  by oss.sgi.com id <S42289AbQEaP5G>;
	Wed, 31 May 2000 08:57:06 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:14385 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42296AbQEaP4p>;
	Wed, 31 May 2000 08:56:45 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA18497; Wed, 31 May 2000 08:40:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id IAA77038; Wed, 31 May 2000 08:43:19 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA39574
	for linux-list;
	Wed, 31 May 2000 08:34:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA21960
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 31 May 2000 08:34:04 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09021
	for <linux@cthulhu.engr.sgi.com>; Wed, 31 May 2000 08:30:13 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port60.duesseldorf.ivm.de [195.247.65.60])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id RAA12063;
	Wed, 31 May 2000 17:29:56 +0200
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000531172933.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200005301752.CAA06812@newsa.net.arch.sony.co.jp>
Date:   Wed, 31 May 2000 17:29:33 +0200 (CEST)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Hiroshi Kawashima <kei@arch.sony.co.jp>
Subject: RE: Compile speed on SGI/Linux (like Indy)
Cc:     linux@cthulhu.engr.sgi.com
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi.

On 30-May-00 Hiroshi Kawashima wrote:
> I'm one of member of Linux-VR project (porting Linux on NEC VR41xx based WinCE
> machines) http://linux-vr.org/ .
> 
> I've almostly completed porting Kernel Floating Emulation of
> Linux/Mips to Linux-VR, so I'm moving to building userland (hard-float).
> 
> Since VR41xx based WinCE machine is very slow, I'm now considering to
> buy SGI machines to build userland binaries.

That won't help you, I´m afraid, if you want to natively build userland stuff. To
my knowledge all SGI boxes are configured in big endian mode, where all CE
machines are little endian.

A Cobalt RaQ would probably be better for what you want.

-- 
Regards,
Harald
