Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 14:11:06 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16768 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023873AbXJANLD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 14:11:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l91DB3uN012677;
	Mon, 1 Oct 2007 14:11:03 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l91DB3KA012676;
	Mon, 1 Oct 2007 14:11:03 +0100
Date:	Mon, 1 Oct 2007 14:11:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][URGENT] kernel/vmlinux.lds.S: Handle note sections
Message-ID: <20071001131103.GA10452@linux-mips.org>
References: <Pine.LNX.4.64N.0710011310120.27280@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710011310120.27280@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 01, 2007 at 01:24:04PM +0100, Maciej W. Rozycki wrote:

>  Store any note sections after the exception tables like the other 
> architectures do.  This is required for .note.gnu.build-id emitted from 
> binutils 2.18 onwards if nothing else.

Thanks for looking into this.  I knew the problem but didn't get around
to looking into it yet ...

Patch applied.

  Ralf
