Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 13:52:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61898 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20032953AbZDVLeZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2009 12:34:25 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3MBYLjP020587;
	Wed, 22 Apr 2009 13:34:22 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3MBYKUB020585;
	Wed, 22 Apr 2009 13:34:20 +0200
Date:	Wed, 22 Apr 2009 13:34:20 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	fredtan <tanflying@gmail.com>, linux-mips@linux-mips.org
Subject: Re: how to clear the D_cache and I_cache in the MIPS linux ?
Message-ID: <20090422113420.GA17792@linux-mips.org>
References: <23172497.post@talk.nabble.com> <m31vrlgdxf.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m31vrlgdxf.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 22, 2009 at 12:50:36PM +0200, Arnaud Patard wrote:

> fredtan <tanflying@gmail.com> writes:
> 
> > D_CACHE,then invalidate I_CACHE,then run the code. My MIPS does not have
> > SYNCI instruction,Cache 
> >
> > instruction is a privilege instruction, the program has no right to use it.
> > So , What can I do ?
> 
> use cacheflush()

It is preferable to always use cacheflush().  The plan is to eventually
enhance the cacheflush(3) library function to use SYNCI as applicable for
a particular platform.

  Ralf
