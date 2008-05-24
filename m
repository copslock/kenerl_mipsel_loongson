Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 May 2008 12:53:56 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:11447 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20033767AbYEXLxx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 May 2008 12:53:53 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m4OBrou6029890;
	Sat, 24 May 2008 12:53:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4OBrnCj029886;
	Sat, 24 May 2008 12:53:49 +0100
Date:	Sat, 24 May 2008 12:53:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP27: Fix bootmem memory setup
Message-ID: <20080524115349.GA20822@linux-mips.org>
References: <20080408214346.ECFF7C2C03@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080408214346.ECFF7C2C03@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 08, 2008 at 11:43:46PM +0200, Thomas Bogendoerfer wrote:
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Date: Tue,  8 Apr 2008 23:43:46 +0200 (CEST)
> To: linux-mips@linux-mips.org
> cc: ralf@linux-mips.org
> Subject: [PATCH] IP27: Fix bootmem memory setup
> 
> Changes in the generic bootmem code broke memory setup for IP27. This
> patch fixes this by replacing lots of special IP27 code with generic
> bootmon code. This has been tested only on a single node.

Applied,

  Ralf
