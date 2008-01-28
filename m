Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2008 21:18:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:206 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28584649AbYA1VSG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Jan 2008 21:18:06 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0SLI44M020481;
	Mon, 28 Jan 2008 21:18:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0SLI3h2020480;
	Mon, 28 Jan 2008 21:18:03 GMT
Date:	Mon, 28 Jan 2008 21:18:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"M. Warner Losh" <imp@bsdimp.com>
Cc:	cfriesen@nortel.com, linux-mips@linux-mips.org
Subject: Re: quick question on 64-bit values with 32-bit inline assembly
Message-ID: <20080128211803.GA20434@linux-mips.org>
References: <20080122175734.GA31013@linux-mips.org> <47963C31.2000403@nortel.com> <20080122200751.GA2672@linux-mips.org> <20080128.140245.-108809632.imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080128.140245.-108809632.imp@bsdimp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 28, 2008 at 02:02:45PM -0700, M. Warner Losh wrote:

> : this specific interaction of ABI and processor architecture then it was
> : probably found not to implement such a special read because it is messy
> : in more than one way.
> 
> When 64-bit operations are enabled, you get all 64-bits.  When they
> aren't, only the lower 32-bits of the counter are provided (with sign
> extension).  So when operating in 32-bit mode, saving the upper 32
> bits are not necessary (or even possible).

The architecture manual doesn't make a difference between 32-bit and
64-bit for rdhwr.  My reading is the entire 64-bit would have to be
transfered.

  Ralf
