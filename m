Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 18:01:59 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:21920 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20023139AbXITRBu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 18:01:50 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IYPPN-0006La-OD; Thu, 20 Sep 2007 17:01:46 +0000
Message-ID: <46F2A779.2040904@pobox.com>
Date:	Thu, 20 Sep 2007 13:01:45 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac.c: De-typedef, de-volatile, de-etc...
References: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl> <46E8B56E.7060705@pobox.com> <Pine.LNX.4.64N.0709131506040.31069@blysk.ds.pg.gda.pl> <20070913151452.GB29665@linux-mips.org> <46E95C7F.1050302@pobox.com> <Pine.LNX.4.64N.0709141135290.1926@blysk.ds.pg.gda.pl> <46F1F2CE.7020300@pobox.com> <Pine.LNX.4.64N.0709201354320.30788@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709201354320.30788@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 20 Sep 2007, Jeff Garzik wrote:
> 
>>> You may be pleased (or less so) to hear that the version of sb1250-mac.c in
>>> your tree does not even build (because of
>>> 42d53d6be113f974d8152979c88e1061b953bd12) and the patch below does not
>>> address it.  I ran out of time in the evening, but I will send you a fix
>>> shortly.  To be honest I think even with bulk changes it may be worth
>>> checking whether they do not break stuff. ;-)
>> hrm.  I cannot get this to apply on top of linux-2.6.git,
>> netdev-2.6.git#upstream (prior to net-2.6.24 rebase) or
>> netdev-2.6.git#upstream (after net-2.6.24 rebase)
> 
>  It applies on top of current -mm.  It seems to apply to a copy of 
> netdev-2.6.git#upstream that I have got, but I am probably missing 
> something...  If I try to clone your repository again I get:
> 
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/linux-netdev-2.6.git linux
> Initialized empty Git repository in /home/macro/GIT-other/linux-netdev/linux/.git/
> fatal: The remote end hung up unexpectedly
> fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/linux-netdev-2.6.git' failed.

Remove the "linux-" prefix.

	Jeff
