Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2006 00:32:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:35499 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039572AbWJGXcP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Oct 2006 00:32:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k97NWK4v031559;
	Sun, 8 Oct 2006 00:32:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k97NWJMa031558;
	Sun, 8 Oct 2006 00:32:19 +0100
Date:	Sun, 8 Oct 2006 00:32:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Scott Ashcroft <scott.ashcroft@talk21.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Time runs too quickly on Cobalt
Message-ID: <20061007233219.GB31472@linux-mips.org>
References: <45267C4E.8090101@talk21.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45267C4E.8090101@talk21.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 06, 2006 at 04:54:54PM +0100, Scott Ashcroft wrote:

> If I build a kernel with HZ==250 then time runs about 4 four times too 
> quickly on my Cobalt RaQ2.
> 
> The following patch seems to fix it but I'm not sure this is the correct 
> thing to do.

Looks right to me.
