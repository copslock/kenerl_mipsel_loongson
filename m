Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 14:30:44 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:39945 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133401AbWEKMaf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 May 2006 14:30:35 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id CC85164D55; Thu, 11 May 2006 12:30:26 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 6147066F5B; Thu, 11 May 2006 14:30:16 +0200 (CEST)
Date:	Thu, 11 May 2006 14:30:16 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	karsten@excalibur.cologne.de, linux-mips@linux-mips.org
Subject: Re: pmag* drivers don't build on 2.6
Message-ID: <20060511123016.GH7827@deprecation.cyrius.com>
References: <20060510204601.GA23786@deprecation.cyrius.com> <Pine.LNX.4.64N.0605111305490.20004@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0605111305490.20004@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-05-11 13:21]:
> > The pmag* fb drivers (DECstation) don't build on 2.6.  Can someone
> > port them to the 2.6 api (and possibly merge both files into one)?
> 
>  The pmag-ba-fb and pmagb-b-fb drivers have been ported.  If there is any 
> problem with them, then I'd like to know about that.
> 
>  The pmag-aa-fb driver has not been ported.

Ah, yeah, sorry.  I saw a build failure in pmag-aa-fb and thought all
pmag* drivers were out of date so I didn't try to compile the other
drivers.  I'm glad to hear that you have ported the other two!
-- 
Martin Michlmayr
http://www.cyrius.com/
