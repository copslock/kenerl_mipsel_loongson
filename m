Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2009 13:20:58 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38537 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023848AbZFIMUr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Jun 2009 13:20:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n59CKIAq014294;
	Tue, 9 Jun 2009 13:20:18 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n59CKHvC014292;
	Tue, 9 Jun 2009 13:20:17 +0100
Date:	Tue, 9 Jun 2009 13:20:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS: Outline udelay and fix a few issues.
Message-ID: <20090609122017.GA14202@linux-mips.org>
References: <S20022929AbZFHPuy/20090608155054Z+9196@ftp.linux-mips.org> <20090609.111248.161838296.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090609.111248.161838296.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 09, 2009 at 11:12:48AM +0900, Atsushi Nemoto wrote:

> > Relying on pure C for computation of the delay value removes the need for
> > explicit.  The price we pay is a slight slowdown of the computation - to
> > be fixed on another day.
> 
> Please fix this commit.

Sigh.  I wonder how this wrong version made it into my tree.  Oh well,
applied.  No time to fuzz around before 2.6.30 even though I'd like to
avoid the 64-bit arithmetic.

Applied.  Thanks!

  Ralf
