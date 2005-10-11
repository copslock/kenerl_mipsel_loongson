Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2005 23:34:33 +0100 (BST)
Received: from mx01.qsc.de ([213.148.129.14]:60647 "EHLO mx01.qsc.de")
	by ftp.linux-mips.org with ESMTP id S8133545AbVJKWeM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2005 23:34:12 +0100
Received: from port-195-158-179-121.dynamic.qsc.de ([195.158.179.121] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1EPSh9-0001Bx-00; Wed, 12 Oct 2005 00:34:03 +0200
Received: from ths by hattusa.textio with local (Exim 4.54)
	id 1EPSh7-0004YU-A5; Wed, 12 Oct 2005 00:34:01 +0200
Date:	Wed, 12 Oct 2005 00:34:01 +0200
To:	"D.J.Dimmich" <djd20@kent.ac.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: git, rsync, and firewalls...
Message-ID: <20051011223401.GH21761@hattusa.textio>
References: <5C1FD43E5F1B824E83985A74F396286E5E9528@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca> <434C0D3E.7010408@total-knowledge.com> <Pine.GSO.4.58.0510112147360.23481@myrtle.ukc.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0510112147360.23481@myrtle.ukc.ac.uk>
User-Agent: Mutt/1.5.11
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

D.J.Dimmich wrote:
> Hmm,
> 
> This is no good:
> 
> cg-clone http://www.linux-mips.org/pub/scm/linux.git linux-mips.git
> defaulting to local storage area
> 21:41:28 URL:http://www.linux-mips.org/pub/scm/linux.git/refs/heads/master
> [41/41] -> "refs/heads/origin" [1]
> progress: 2 objects, 1003 bytes
> error: File 658dc2bb726238c6eb05edf3eb2d35050c8beb1d
> (http://www.linux-mips.org/pub/scm/linux.git/objects/65/8dc2bb726238c6eb05edf3eb2d35050c8beb1d)
> corrupt
> 
> Cannot obtain needed blob 658dc2bb726238c6eb05edf3eb2d35050c8beb1d
> while processing commit 0000000000000000000000000000000000000000.
> error: cannot map sha1 file 658dc2bb726238c6eb05edf3eb2d35050c8beb1d
> cg-pull: objects pull failed
> cg-init: pull failed
> 
> cg (cogito) are wrapper scripts around git...  Something's no good...  the
> rsync method bombs out at 97% - just hangs....
> 
> Any suggestions?

Use a sufficiently new git, and raw git instead of cogito (as described
in the wiki page at www.linux-mips.org). At least this works for me.


Thiemo
