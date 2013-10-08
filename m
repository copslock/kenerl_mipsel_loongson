Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 07:06:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37319 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832655Ab3JHFGgF9jRX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 07:06:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r9856YGw002781;
        Tue, 8 Oct 2013 07:06:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r9856Xex002780;
        Tue, 8 Oct 2013 07:06:33 +0200
Date:   Tue, 8 Oct 2013 07:06:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Add printing of ES bit when cache error occurs.
Message-ID: <20131008050633.GD1615@linux-mips.org>
References: <1381137952-18340-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381137952-18340-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, Oct 07, 2013 at 10:25:52AM +0100, Markos Chandras wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> Print out the source of request that caused the error (ES bit) when
> a cache error exception occurs.

The reason ES isn't being printed is that not all processors that support
a cache error exception have an ES bit.  The R4000 has it, R5000 doesn't,
R10000 CacheErr looks rather different - and in fact MIPS32/64 make the
entire register optional and its details implementation specific.

Don't even ask me anymore which processor the implementation in the
kernel is trying to support - probably something R7000ish, at least
that's what guess from the 1385617929e09545f9858785ea3dc1068fedfde1
commit log.

Short of some fancy engineering, I'd suggest throwing in a switch
statement and per processor type printks just as in parity_protection_init.

  Ralf
