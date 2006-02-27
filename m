Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 18:23:13 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:4107 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133464AbWB0SXC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Feb 2006 18:23:02 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9CD8D64D3D; Mon, 27 Feb 2006 18:30:35 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 17DDF8FD8; Mon, 27 Feb 2006 19:30:26 +0100 (CET)
Date:	Mon, 27 Feb 2006 18:30:26 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	jblache@debian.org, rmk+serial@arm.linux.org.uk
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060227183026.GA21752@deprecation.cyrius.com>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com> <20060224190517.GA28013@lst.de> <20060227105236.GI12044@deprecation.cyrius.com> <Pine.LNX.4.62.0602271222120.18095@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0602271222120.18095@pademelon.sonytel.be>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Geert Uytterhoeven <geert@linux-m68k.org> [2006-02-27 12:22]:
> > Ralf suggested to see what other changes have been made to the
> > sunzilog driver recently and update the ip22zilog driver accordingly.
> > Russell, please queue the following patch for 2.6.17.
> Any chance they can be merged, to avoid such missed updates in the future?

Ladislav Michl mentioned on IRC that he made some progress towards a
unified driver a few months ago; but it seems that he currently
doesn't have time to finish it (nor can he test it on sparc).  Maybe
someone can do some work based on that patch.

ftp://ftp.linux-mips.org/pub/linux/mips/people/ladis/generic_zilog_driver.mbox

-- 
Martin Michlmayr
http://www.cyrius.com/
