Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2007 10:57:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25300 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023670AbXERJ5t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 May 2007 10:57:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4I9vch1010325;
	Fri, 18 May 2007 11:57:38 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4I9vaxP010324;
	Fri, 18 May 2007 11:57:36 +0200
Date:	Fri, 18 May 2007 11:57:36 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] EMMA2RH: remove dead KGDB code
Message-ID: <20070518095736.GB10171@linux-mips.org>
References: <200705162035.13910.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200705162035.13910.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 16, 2007 at 08:35:13PM +0400, Sergei Shtylyov wrote:

> Get rid of the cross-arch KGDB specific code which shouldn't have been there in
> the first place...

Applied.

  Ralf
