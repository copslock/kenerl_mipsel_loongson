Received:  by oss.sgi.com id <S305195AbQDRVU3>;
	Tue, 18 Apr 2000 14:20:29 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23660 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305188AbQDRVUI>; Tue, 18 Apr 2000 14:20:08 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA00574; Tue, 18 Apr 2000 14:24:08 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA82122
	for linux-list;
	Tue, 18 Apr 2000 14:07:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dhcp-163-154-5-221.engr.sgi.com (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA87006
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 18 Apr 2000 14:07:24 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1403826AbQDRVEK>;
	Tue, 18 Apr 2000 14:04:10 -0700
Date:   Tue, 18 Apr 2000 14:04:10 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Mike Klar <mfklar@ponymail.com>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: Unaligned address handling, and the cause of that login prob
Message-ID: <20000418140410.A6271@uni-koblenz.de>
References: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com> <XFMail.000417183334.Harald.Koerfgen@home.ivm.de> <20000418105348.A1247@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000418105348.A1247@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Apr 18, 2000 at 10:53:48AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Apr 18, 2000 at 10:53:48AM +0200, Florian Lohoff wrote:

> But the (kernel) fix from Ralph concerning the sleep? syscalls seems
> to be incorrect or buggy - When calling top the display refreshes
> multiple times a second without a sleep and on the console i get
> an.
> 
> Setting flush to zero for top.
> schedule_timeout: wrong timeout value fffbd0b2 from 800942b8 

I'm fairly sure that my patch is not buggy - I haven't made any :-)

  Ralf
