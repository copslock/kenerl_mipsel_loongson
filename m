Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Aug 2009 20:41:47 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36081 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492880AbZHBSlk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 2 Aug 2009 20:41:40 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n72IftTo009237;
	Sun, 2 Aug 2009 19:41:55 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n72If5Q3009212;
	Sun, 2 Aug 2009 19:41:05 +0100
Date:	Sun, 2 Aug 2009 19:41:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Julia Lawall <julia@diku.dk>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 10/15] arch/mips: Use DIV_ROUND_CLOSEST
Message-ID: <20090802184024.GB9058@linux-mips.org>
References: <Pine.LNX.4.64.0908021047480.15557@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0908021047480.15557@ask.diku.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 02, 2009 at 10:48:08AM +0200, Julia Lawall wrote:

> 
> From: Julia Lawall <julia@diku.dk>
> 
> The kernel.h macro DIV_ROUND_CLOSEST performs the computation (x + d/2)/d
> but is perhaps more readable.

Applied.  Thanks Julia!

  Ralf
