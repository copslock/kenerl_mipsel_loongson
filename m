Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2003 22:46:29 +0000 (GMT)
Received: from p508B764E.dip.t-dialin.net ([IPv6:::ffff:80.139.118.78]:944
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225556AbTLAWq3>; Mon, 1 Dec 2003 22:46:29 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hB1MkPA0002495
	for <linux-mips@linux-mips.org>; Mon, 1 Dec 2003 23:46:26 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hB1MkO0h002494
	for linux-mips@linux-mips.org; Mon, 1 Dec 2003 23:46:24 +0100
Date: Mon, 1 Dec 2003 23:46:24 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Linux 2.4 future
Message-ID: <20031201224624.GA13412@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

For those of you who don't follow linux-kernel below Marcelo's posting
about the future of 2.4.  I think we should follow that for MIPS also,
so whatever new feature you still may have pending for 2.4, send it
soon - or for 2.6.

I also remind everybody that a 2.6.0 release is expect already before the
end of the year and the MIPS kernel is not exactly in the shape we'd
like it to be - time to switch to 2.6 for active development!

  Ralf

----- Forwarded message from Marcelo Tosatti <marcelo.tosatti@cyclades.com> -----

From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Date: Mon, 1 Dec 2003 12:25:23 -0200 (BRST)
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4 future 
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi, 

The intention of this email is to clarify my position on 2.4.x future.

2.6 is becoming more stable each day, and we will hopefully see a 2.6.0
release during this month or January.

Having that mentioned, I pretend to:

- Fix pending problems which might required more intrusive modifications
during 2.4.24. New drivers will be accept during this period (for example,
Cyclades PC300 driver, input userlevel driver support, or other sane
driver which might come up).

- From 2.4.25 on, fix only critical/security problems.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

  Ralf
