Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 18:53:28 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:50111 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039511AbXBGSxX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Feb 2007 18:53:23 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l17IrNxY028857;
	Wed, 7 Feb 2007 18:53:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l17IrNUs028856;
	Wed, 7 Feb 2007 18:53:23 GMT
Date:	Wed, 7 Feb 2007 18:53:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] (2.6.20) Toshiba RBTX49x7: declare prom_getcmdline()
Message-ID: <20070207185323.GB25720@linux-mips.org>
References: <200702072041.36064.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200702072041.36064.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 07, 2007 at 08:41:36PM +0300, Sergei Shtylyov wrote:

> Fix a bunch of warnings caused by a missing prom_getcmdline() prototype.

Applied.  Thanks,

  Ralf
