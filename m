Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 23:03:54 +0000 (GMT)
Received: from p508B5DCD.dip.t-dialin.net ([IPv6:::ffff:80.139.93.205]:33706
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225376AbSLRXDs>; Wed, 18 Dec 2002 23:03:48 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBIN3Wp01340;
	Thu, 19 Dec 2002 00:03:32 +0100
Date: Thu, 19 Dec 2002 00:03:32 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
	linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: make prototype of printk available
Message-ID: <20021219000332.B1132@linux-mips.org>
References: <m23cowqeyn.fsf@demo.mitica> <Pine.GSO.3.96.1021218173641.5977C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021218173641.5977C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Dec 18, 2002 at 05:37:49PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 05:37:49PM +0100, Maciej W. Rozycki wrote:

> >         Once there, put a tag to the printk.
> 
>  Why is the default log level incorrect here?

This is a printk that's executed if a user program is just trying to
execute the right code, so a user could flood syslog that way.  Imho the
printk call should go away?

  Ralf
