Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 15:54:51 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60914 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492659AbZHJNyo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Aug 2009 15:54:44 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7ADtNv8027101;
	Mon, 10 Aug 2009 14:55:24 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7ADtLm5027098;
	Mon, 10 Aug 2009 14:55:21 +0100
Date:	Mon, 10 Aug 2009 14:55:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexander Clouter <alex@digriz.org.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: add support for gzip/bzip2/lzma compressed
	kernel images
Message-ID: <20090810135521.GA27737@linux-mips.org>
References: <1249757707-8876-1-git-send-email-wuzhangjin@gmail.com> <e4s3l6-dou.ln1@chipmunk.wormnet.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4s3l6-dou.ln1@chipmunk.wormnet.eu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 09, 2009 at 10:36:46PM +0100, Alexander Clouter wrote:

> As a side note, I would personally leave the DEBUG non-optional and 
> turned on as it all disappears at runtime anyway, but I'm no kernel 
> developer :)

Printing is hardware specific; the debug code will need to be changed for
practically every MIPS platform on the planet, so I'm not too fond of the
idea unless somebody comes up with a cleaner infrastructure to do so.
Unfortunately we're not setup very well to do configuration detection etc.
in that debug code without adding tons of baggage.

  Ralf
