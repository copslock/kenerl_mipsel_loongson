Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 14:11:09 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38278 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1490977Ab1ESMLH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 14:11:07 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4JCB9cl021009;
        Thu, 19 May 2011 13:11:09 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4JCB81J021006;
        Thu, 19 May 2011 13:11:08 +0100
Date:   Thu, 19 May 2011 13:11:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] MIPS: Move FIXADDR_TOP into spaces.h
Message-ID: <20110519121108.GB18668@linux-mips.org>
References: <55645e13fcf442f6641b3eb187cab302@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55645e13fcf442f6641b3eb187cab302@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

> Memory maps and addressing quirks are normally defined in <spaces.h>.
> There are already three targets that need to override FIXADDR_TOP, and
> others exist.  This will be a cleaner approach than adding lots of
> ifdefs in fixmap.h .

Good cleanup, also queued for 2.6.41.

  Ralf
