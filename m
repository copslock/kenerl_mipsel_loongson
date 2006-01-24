Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 12:23:24 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:2310 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133457AbWAXMWx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2006 12:22:53 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id C6DE264D3D; Tue, 24 Jan 2006 12:27:09 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 703F2854B; Tue, 24 Jan 2006 12:27:00 +0000 (GMT)
Date:	Tue, 24 Jan 2006 12:27:00 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060124122700.GA8527@deprecation.cyrius.com>
References: <20060123225040.GA23576@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-01-24 11:09]:
>  It looks like a problem with initialization of the serial driver -- this 
> is where the console is being set up.  See also the rubbish at the end -- 
> that's a hint.  I am assuming you've got your console configuration right.

We had the following settings: console=s and osconsole=3
The terminal emulation program should've been configured properly
too.

-- 
Martin Michlmayr
http://www.cyrius.com/
