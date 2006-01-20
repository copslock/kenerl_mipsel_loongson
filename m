Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 15:00:34 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:35076 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3686579AbWATO7o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 14:59:44 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 2DF1264D40; Fri, 20 Jan 2006 15:02:33 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 07AD18ECE; Fri, 20 Jan 2006 15:02:10 +0000 (GMT)
Date:	Fri, 20 Jan 2006 15:02:10 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Crash on Cobalt with CONFIG_SERIO=y
Message-ID: <20060120150210.GG4343@deprecation.cyrius.com>
References: <20060120004208.GA18327@deprecation.cyrius.com> <20060120144710.GA30415@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120144710.GA30415@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-01-20 15:47]:
> The i8042 error message is a little surprising.  The Cobalt boards afair
> have some sort of SuperIO chip on the board which includes PS/2 keyboard
> even though that has not been wired.  I wonder if anybody can take a
> look at the board what type of SuperIO is there?

Maybe Peter Horton can take a look.

> Anyway, the kernel code seems to be correct at a glance so I have to
> assume the PS/2 hardware really doesn't work and I propose below patch.

That's fine with me.
-- 
Martin Michlmayr
http://www.cyrius.com/
