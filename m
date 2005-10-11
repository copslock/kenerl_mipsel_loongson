Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2005 21:51:03 +0100 (BST)
Received: from mx5.kent.ac.uk ([129.12.21.36]:50830 "EHLO mx5.kent.ac.uk")
	by ftp.linux-mips.org with ESMTP id S8133539AbVJKUuc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2005 21:50:32 +0100
Received: from hathor.ukc.ac.uk ([129.12.4.12])
	by mx5.kent.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EPR3y-0006Yi-No; Tue, 11 Oct 2005 21:49:30 +0100
Received: from myrtle.ukc.ac.uk ([129.12.3.176] ident=exim)
	by hathor.ukc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.50)
	id 1EPR3y-0006m9-KM; Tue, 11 Oct 2005 21:49:30 +0100
Received: from myrtle.ukc.ac.uk ([129.12.3.176] ident=djd20)
	by myrtle.ukc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.50)
	id 1EPR3y-0007YR-Cb; Tue, 11 Oct 2005 21:49:30 +0100
Date:	Tue, 11 Oct 2005 21:49:30 +0100 (BST)
From:	"D.J.Dimmich" <djd20@kent.ac.uk>
X-X-Sender: djd20@myrtle.ukc.ac.uk
To:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
cc:	Don Hiatt <Don_Hiatt@pmc-sierra.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: git, rsync, and firewalls...
In-Reply-To: <434C0D3E.7010408@total-knowledge.com>
Message-ID: <Pine.GSO.4.58.0510112147360.23481@myrtle.ukc.ac.uk>
References: <5C1FD43E5F1B824E83985A74F396286E5E9528@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
 <434C0D3E.7010408@total-knowledge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UKC-Mail-System: No virus detected
X-UKC-SpamCheck: 
X-UKC-MailScanner-From:	djd20@kent.ac.uk
Return-Path: <djd20@kent.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djd20@kent.ac.uk
Precedence: bulk
X-list: linux-mips

Hmm,

This is no good:

cg-clone http://www.linux-mips.org/pub/scm/linux.git linux-mips.git
defaulting to local storage area
21:41:28 URL:http://www.linux-mips.org/pub/scm/linux.git/refs/heads/master
[41/41] -> "refs/heads/origin" [1]
progress: 2 objects, 1003 bytes
error: File 658dc2bb726238c6eb05edf3eb2d35050c8beb1d
(http://www.linux-mips.org/pub/scm/linux.git/objects/65/8dc2bb726238c6eb05edf3eb2d35050c8beb1d)
corrupt

Cannot obtain needed blob 658dc2bb726238c6eb05edf3eb2d35050c8beb1d
while processing commit 0000000000000000000000000000000000000000.
error: cannot map sha1 file 658dc2bb726238c6eb05edf3eb2d35050c8beb1d
cg-pull: objects pull failed
cg-init: pull failed

cg (cogito) are wrapper scripts around git...  Something's no good...  the
rsync method bombs out at 97% - just hangs....

Any suggestions?

Thanks,
Damian

On Tue, 11 Oct 2005, Ilya A. Volynets-Evenbakh wrote:

> git clone http://www.linux-mips.org/pub/scm/linux.git
>
>
>
> Don Hiatt wrote:
>
> >Any ideas on how you would go about doing the initial git clone if
> >rsync is blocked? Of course I could do it at home and then carry
> >it back but all those bits get awful heavy.. :) Is it possible to
> >use wget to grab the repository?
> >
> >Cheers,
> >
> >don
> >
> >
> >
>
>
