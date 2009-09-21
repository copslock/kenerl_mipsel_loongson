Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2009 22:54:51 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33940 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493264AbZIUUyn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Sep 2009 22:54:43 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8LKtrgg024545;
	Mon, 21 Sep 2009 21:55:53 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8LKtqCw024543;
	Mon, 21 Sep 2009 21:55:52 +0100
Date:	Mon, 21 Sep 2009 21:55:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Julia Lawall <julia@diku.dk>, dmitri.vorobiev@gmail.com,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] arch/mips: remove duplicate structure field
	initialization
Message-ID: <20090921205551.GA20341@linux-mips.org>
References: <Pine.LNX.4.64.0909211708200.8549@pc-004.diku.dk> <20090921192520.GB17310@linux-mips.org> <4AB7E0D1.10506@paralogos.com> <4AB7E50D.4090509@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AB7E50D.4090509@paralogos.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 21, 2009 at 01:41:49PM -0700, Kevin D. Kissell wrote:

> Ha!  Found the breakage.  It wasn't a two-phase commit.  It was just an  
> overworked mantainer in a hurry, in July 2007.  See commit  
> 033890b084adfa367c544864451d7730552ce8bf

An overworked maintainer in cooperation with a broken compiler.  Worse -
it's not the first time this type of bug strikes but probably this was
never brought to the gcc maintainers' attention.

  Ralf
