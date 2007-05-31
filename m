Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2007 13:10:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26568 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021395AbXEaMKA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 May 2007 13:10:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4VC9naJ028993;
	Thu, 31 May 2007 13:09:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4VC9nik028992;
	Thu, 31 May 2007 13:09:49 +0100
Date:	Thu, 31 May 2007 13:09:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] die(): Properly declare as non-returning
Message-ID: <20070531120949.GC28936@linux-mips.org>
References: <Pine.LNX.4.64N.0705291456520.14456@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0705291456520.14456@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 29, 2007 at 03:03:56PM +0100, Maciej W. Rozycki wrote:

>  This marks the declaration of die() correctly, removing "control reaches 
> end of non-void function" warnings from non-void functions that die() at 
> the end.

Applied.  Thanks,

  Ralf
