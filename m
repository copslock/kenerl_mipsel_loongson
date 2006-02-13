Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 23:21:02 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:61957 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3467599AbWBMXUx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 23:20:53 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 13AE564D3D; Mon, 13 Feb 2006 23:27:11 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 4F9DA82BB; Mon, 13 Feb 2006 23:27:04 +0000 (GMT)
Date:	Mon, 13 Feb 2006 23:27:04 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Peter 'p2' De Schrijver <p2@mind.be>,
	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060213232704.GA8360@deprecation.cyrius.com>
References: <20060123225040.GA23576@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl> <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver> <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl> <20060203150232.GA25701@deprecation.cyrius.com> <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-02-13 09:15]:
> The following change fixes the problem for me -- it looks like an
> omission from some recent changes elsewhere.  Ralf, please apply.

Apparently it boots with current git and your fix.  I think p2 will
confirm later.

However, it doesn't boot with 2.6.15 from a few weeks ago plus some
random fixes plus your patch.  Any idea what else might have changed?
-- 
Martin Michlmayr
http://www.cyrius.com/
