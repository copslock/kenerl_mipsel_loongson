Received:  by oss.sgi.com id <S305188AbQDRVza>;
	Tue, 18 Apr 2000 14:55:30 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:33135 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305195AbQDRVzJ>; Tue, 18 Apr 2000 14:55:09 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA01486; Tue, 18 Apr 2000 14:59:10 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA98660
	for linux-list;
	Tue, 18 Apr 2000 14:43:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dhcp-163-154-5-221.engr.sgi.com (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA96633
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 18 Apr 2000 14:43:04 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1405771AbQDRVj7>;
	Tue, 18 Apr 2000 14:39:59 -0700
Date:   Tue, 18 Apr 2000 14:39:59 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Mike Klar <mfklar@ponymail.com>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: Unaligned address handling, and the cause of that login prob
Message-ID: <20000418143959.C6271@uni-koblenz.de>
References: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com> <XFMail.000417183334.Harald.Koerfgen@home.ivm.de> <20000418105348.A1247@paradigm.rfc822.org> <20000418140410.A6271@uni-koblenz.de> <20000418231652.A866@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000418231652.A866@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Apr 18, 2000 at 11:16:52PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Apr 18, 2000 at 11:16:52PM +0200, Florian Lohoff wrote:

> Hasnt been there somethign with a missing syscall you wanted to add
> again to all kernels ? I remembered dark but couldnt find anything
> in the cvs. :)

Oh yes, it just got lost.  It's now in the works.

  Ralf
