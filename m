Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2009 16:14:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62381 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023695AbZDFPOt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2009 16:14:49 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n36FEmFO020424;
	Mon, 6 Apr 2009 17:14:48 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n36FElrn020422;
	Mon, 6 Apr 2009 17:14:47 +0200
Date:	Mon, 6 Apr 2009 17:14:47 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix build error if CONFIG_CEVT_R4K was not defined
Message-ID: <20090406151447.GB16069@linux-mips.org>
References: <1239030295-14080-1-git-send-email-anemo@mba.ocn.ne.jp> <49DA1B30.8080408@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DA1B30.8080408@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 06, 2009 at 05:09:36PM +0200, Kevin D. Kissell wrote:

> Drat, and I was *sure* that I'd tested that in a non-SMTC
> configuration!  Thanks!

I ran into it when upgrading the IP35 port to master.  At least IP27 would
should have been affected by the issue as well.  It's may be possible that
you missed the issue due to an ancient compiler.

  Ralf
