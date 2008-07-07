Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2008 06:28:59 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:30621 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20033740AbYGGF2y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jul 2008 06:28:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m675Ra0h016482;
	Mon, 7 Jul 2008 07:28:02 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m675RZjj016481;
	Mon, 7 Jul 2008 06:27:35 +0100
Date:	Mon, 7 Jul 2008 06:27:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix section mismatches when compiling atlas and
	decstation defconfigs
Message-ID: <20080707052735.GB26850@linux-mips.org>
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
X-archive-position: 19726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 05, 2008 at 05:19:42PM -0600, Shane McDonald wrote:

> From: Shane McDonald <mcdonald.shane@gmail.com>

Btw, while it doesn't harm there is no need to insert this From: line into
the patch if it's identical to the sender's email address as in your case.
Where it's missing git will just pick the From: address from the email
headers.

> Section mismatches are reported when compiling the default
> Atlas configuration and the default Decstation configuration.
> This patch resolves those mismatches by defining affected
> functions with the __cpuinit attribute, rather than __init.
> 
> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>

Thanks, applied.

  Ralf
