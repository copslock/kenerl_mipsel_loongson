Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 15:11:39 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28547 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026755AbXKMPLh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 15:11:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lADF8SMB008582;
	Tue, 13 Nov 2007 15:08:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lADF8KxJ008577;
	Tue, 13 Nov 2007 15:08:20 GMT
Date:	Tue, 13 Nov 2007 15:08:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Andrew Haley <aph-gcc@littlepinkcloud.com>,
	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	Richard Sandiford <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
Subject: Re: Cannot unwind through MIPS signal frames with
	ICACHE_REFILLS_WORKAROUND_WAR
Message-ID: <20071113150820.GB6582@linux-mips.org>
References: <473957B6.3030202@avtrex.com> <18233.36645.232058.964652@zebedee.pink> <20071113121036.GA6582@linux-mips.org> <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com> <019e01c82602$f5463bf0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019e01c82602$f5463bf0$10eca8c0@grendel>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 13, 2007 at 03:37:39PM +0100, Kevin D. Kissell wrote:

> True, though it should perhaps be noted that currently it's only on 4KSc/Sd
> systems (which I know you work on) where it's even possible for the stack
> *not* to have exec permissions, since the classical MIPS MMU gives
> execute permission to any page that is readable.

Disabling PROT_EXEC on a mapping tells the kernel it doesn't need to take
care of I-cache coherency.  So it's somewhat beneficial even in absence of
a protection bit in the actual TLB hardware.

Some of these performance optimizations are impossible because the kernel
can't have definate knowledge that certain addresses have never entered the
I-cache.

  Ralf
