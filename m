Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 11:05:07 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5639 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133406AbWAXLEt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 11:04:49 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 21F4EF5AFF;
	Tue, 24 Jan 2006 12:09:04 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18873-02; Tue, 24 Jan 2006 12:09:03 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C8584F5AE7;
	Tue, 24 Jan 2006 12:09:03 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0OB8wSU012490;
	Tue, 24 Jan 2006 12:08:58 +0100
Date:	Tue, 24 Jan 2006 11:09:07 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <20060123225040.GA23576@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
References: <20060123225040.GA23576@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="328795856-1808802394-1138100494=:11021"
Content-ID: <Pine.LNX.4.64N.0601241105550.11021@blysk.ds.pg.gda.pl>
X-Virus-Scanned: ClamAV 0.87.1/1248/Tue Jan 24 11:54:38 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--328795856-1808802394-1138100494=:11021
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64N.0601241105551.11021@blysk.ds.pg.gda.pl>

On Mon, 23 Jan 2006, Martin Michlmayr wrote:

> We're getting the following boot error on a DECstation with R3K CPU.
> It simply hangs after the "high precision timer" message.  Maciej, do
> you have some time to look into this issue, or does anyone else have
> any idea what's going on there?
[...]
> Using 24.999 MHz high precision timer.�

 It looks like a problem with initialization of the serial driver -- this 
is where the console is being set up.  See also the rubbish at the end -- 
that's a hint.  I am assuming you've got your console configuration right.

 I'll see if I can reproduce it.

  Maciej
--328795856-1808802394-1138100494=:11021--
