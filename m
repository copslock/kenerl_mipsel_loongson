Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2006 13:36:55 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12419 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038555AbWKJNgx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Nov 2006 13:36:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAADbJfX017324;
	Fri, 10 Nov 2006 13:37:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAADbJs0017323;
	Fri, 10 Nov 2006 13:37:19 GMT
Date:	Fri, 10 Nov 2006 13:37:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Gideon Stupp (gstupp)" <gstupp@cisco.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Sync operation in atomic_add_return()
Message-ID: <20061110133719.GA10119@linux-mips.org>
References: <E98CBCB9ACC07244969BE4541EC0A78303137105@xmb-ams-33b.emea.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E98CBCB9ACC07244969BE4541EC0A78303137105@xmb-ams-33b.emea.cisco.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 06, 2006 at 03:42:32PM +0100, Gideon Stupp (gstupp) wrote:

> I am trying to figure out why there is a sync operation in
> linux/include/asm-mips/atomic.h:atomic_add_return(). 
> I believe it was added in the linux-2.4.19 patch, but can't trace the
> reason. Can anyone help?

MIPS is a weakly ordered architecture.  In theory.  So those syncs are
required to ensure proper global ordering.  In practice only the Sibyte
SB1 and RM9000 CMPs are documented to be weakly ordered but I've never
actually observed a single reordering related bug on any MIPS
multiprocessor which may either mean no reordering happens in practice
or I'm a genious managed to fix all reordering related bugs before they
could strike.  I tend to assume the latter ;-)  On a uniprocessor these
syncs are definately not needed and I have a patch to remove the sync
for uniprocessor kernels and known to be strongly ordered SMPs waiting
for 2.6.20.

  Ralf
