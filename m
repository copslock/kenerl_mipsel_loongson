Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2008 19:51:31 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:47009 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28592576AbYGHSvW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jul 2008 19:51:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m68IncZJ010235;
	Tue, 8 Jul 2008 19:49:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m68InVmR010192;
	Tue, 8 Jul 2008 19:49:31 +0100
Date:	Tue, 8 Jul 2008 19:49:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix section mismatches when compiling atlas and
	decstation defconfigs
Message-ID: <20080708184922.GA27245@linux-mips.org>
References: <E1KFH2c-0005iq-80@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1KFH2c-0005iq-80@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 05, 2008 at 05:19:42PM -0600, Shane McDonald wrote:

> From: Shane McDonald <mcdonald.shane@gmail.com>
> 
> Section mismatches are reported when compiling the default
> Atlas configuration and the default Decstation configuration.
> This patch resolves those mismatches by defining affected
> functions with the __cpuinit attribute, rather than __init.
> 
> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>

I already had an earlier version of your patch applied so I have only
applied the c-r4k.c part now with an adjusted comment.

Thanks,

  Ralf
