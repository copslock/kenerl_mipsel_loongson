Received:  by oss.sgi.com id <S305178AbQDBEVB>;
	Sat, 1 Apr 2000 20:21:01 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:32809 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305177AbQDBEUx>; Sat, 1 Apr 2000 20:20:53 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id UAA05423; Sat, 1 Apr 2000 20:24:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA31571
	for linux-list;
	Sat, 1 Apr 2000 20:14:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA31656
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Apr 2000 20:14:10 -0800 (PST)
	mail_from (gnava@sirio.tecmor.mx)
Received: from sirio.tecmor.mx (root@sirio.tecmor.mx [200.33.171.1]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA23156
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Apr 2000 20:09:30 -0800 (PST)
	mail_from (gnava@sirio.tecmor.mx)
Received: from localhost (gnava@localhost)
	by sirio.tecmor.mx (8.9.3/8.9.3) with ESMTP id WAA05134;
	Sat, 1 Apr 2000 22:16:58 -0600
Date:   Sat, 1 Apr 2000 22:16:58 -0600 (CST)
From:   Gabriel Nava Vazquez <gnava@sirio.tecmor.mx>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: boot/nfsroot probles
In-Reply-To: <20000401141030.F3970@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.10.10004012213300.5130-100000@sirio.tecmor.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,

I had the same problem two weeks ago, and the problem was that the
installation program didn't install the package dev...rpm, so i did it
manually via the upgrade program,in the shell at alt-f2.

sda is mounted at /mnt and rpm is available to execute

Gabriel Nava Vazquez
Instituto Tecnologico de Morelia, Mexico
