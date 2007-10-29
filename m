Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 11:26:14 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2434 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573946AbXJ2LZY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 11:25:24 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9T907Y8032526;
	Mon, 29 Oct 2007 09:00:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9T906T5032525;
	Mon, 29 Oct 2007 09:00:06 GMT
Date:	Mon, 29 Oct 2007 09:00:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] R4000/R4400 daddiu erratum workaround
Message-ID: <20071029090006.GD28580@linux-mips.org>
References: <Pine.LNX.4.64N.0710222036210.14902@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710222036210.14902@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 23, 2007 at 12:43:25PM +0100, Maciej W. Rozycki wrote:

Same for this patch, Can be considered a bug fix but is intrusive enough to
be a potencial source of bugs and I'd rather burn the time on fixing the
time stuff, so I've queued this for 2.6.25.

Thanks,

  Ralf
