Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:36:09 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:28344 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023086AbXIYNgH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 14:36:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8PDa4v6013600;
	Tue, 25 Sep 2007 14:36:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8PDa3Qr013590;
	Tue, 25 Sep 2007 14:36:03 +0100
Date:	Tue, 25 Sep 2007 14:36:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Fuxin Zhang <zhangfx@lemote.com>, debian-mips@lists.debian.org,
	linux-mips@linux-mips.org
Subject: Re: About openoffice linux/mips porting
Message-ID: <20070925133603.GA1749@linux-mips.org>
References: <46F90261.1000003@lemote.com> <Pine.LNX.4.64N.0709251406220.23669@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0709251406220.23669@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 25, 2007 at 02:10:31PM +0100, Maciej W. Rozycki wrote:

>  Hmm, why would anyone need to have asm snippets in a document processing 
> suite?  And it looks like the bits are ABI-dependent, so at least three 
> variations (if the changes are endianness-safe) would be required to 
> handle all the ABIs that we support.
> 
>  It smells like OpenOffice is doing something outrageously wrong here...

Normal madness of a (too!) complex piece of software.

  Ralf
