Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Oct 2005 14:30:22 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:23565 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133455AbVJLN34 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Oct 2005 14:29:56 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9CDTesQ010098;
	Wed, 12 Oct 2005 14:29:41 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9CDTaKu010097;
	Wed, 12 Oct 2005 14:29:36 +0100
Date:	Wed, 12 Oct 2005 14:29:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"D.J.Dimmich" <djd20@kent.ac.uk>
Cc:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>,
	Don Hiatt <Don_Hiatt@pmc-sierra.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: git, rsync, and firewalls...
Message-ID: <20051012132935.GB6955@linux-mips.org>
References: <5C1FD43E5F1B824E83985A74F396286E5E9528@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca> <434C0D3E.7010408@total-knowledge.com> <Pine.GSO.4.58.0510112147360.23481@myrtle.ukc.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0510112147360.23481@myrtle.ukc.ac.uk>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 11, 2005 at 09:49:30PM +0100, D.J.Dimmich wrote:

> Cannot obtain needed blob 658dc2bb726238c6eb05edf3eb2d35050c8beb1d
> while processing commit 0000000000000000000000000000000000000000.
> error: cannot map sha1 file 658dc2bb726238c6eb05edf3eb2d35050c8beb1d
> cg-pull: objects pull failed
> cg-init: pull failed
> 
> cg (cogito) are wrapper scripts around git...  Something's no good...  the
> rsync method bombs out at 97% - just hangs....

I've seen rsync hanging like this frequently when certain types of
firewall configurations were involved.  The #1 troublemaker have been
certain older Cisco PIX versions but there are others.

Anyway, cloning via http works fine, I've just verified that.

  Ralf
