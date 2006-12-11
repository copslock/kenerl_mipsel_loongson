Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2006 18:46:42 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:20898 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039510AbWLKSqk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Dec 2006 18:46:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kBBIkemx015120;
	Mon, 11 Dec 2006 18:46:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kBBIkeAE015119;
	Mon, 11 Dec 2006 18:46:40 GMT
Date:	Mon, 11 Dec 2006 18:46:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] FLATMEM: allow memory to start at pfn != 0
Message-ID: <20061211184640.GB1308@linux-mips.org>
References: <1165420110699-git-send-email-fbuihuu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165420110699-git-send-email-fbuihuu@gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 06, 2006 at 04:48:27PM +0100, Franck Bui-Huu wrote:

I just tested this on a Malta.  So patch 2/3 makes Malta die pretty
spectacularly, so I'm going to remve patches 2/3 and 3/3 again from my
tree.

Btw, there's spelling mistake in 2/3:

+               panic("Boggus memory mapping !!!");

  Ralf
