Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2005 20:25:57 +0100 (BST)
Received: from localhost.localdomain ([IPv6:::ffff:127.0.0.1]:40682 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225849AbVG0TZk>; Wed, 27 Jul 2005 20:25:40 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6RJSGWq015140;
	Wed, 27 Jul 2005 15:28:16 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6RJSGVV015139;
	Wed, 27 Jul 2005 15:28:16 -0400
Date:	Wed, 27 Jul 2005 15:28:16 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Niels Sterrenburg <pulsar@kpsws.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050727192816.GF3626@linux-mips.org>
References: <20050725213607Z8225534-3678+4335@linux-mips.org> <57480.194.171.252.100.1122478386.squirrel@mail.kpsws.com> <20050727172427.GB3626@linux-mips.org> <Pine.LNX.4.61L.0507271858050.13819@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507271858050.13819@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 27, 2005 at 07:03:16PM +0100, Maciej W. Rozycki wrote:

>  It doesn't wipe other rubbish like spaces followed by tabs, though -- 
> e.g. ones that would match "^ \t".  Perhaps `indent' could help with them, 
> but I trust my fingers and eyes instead. ;-)

Of course it does:

[ralf@box ~]$ echo -ne '  \t\t' | perl -pi -e 's/[ \t]+$//' | od -x
0000000
[ralf@box ~]$

  Ralf
