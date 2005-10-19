Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 16:54:21 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:38414 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465650AbVJSPyG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 16:54:06 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9JFrvS8017847;
	Wed, 19 Oct 2005 16:53:57 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9JFrvjc017845;
	Wed, 19 Oct 2005 16:53:57 +0100
Date:	Wed, 19 Oct 2005 16:53:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fwd: How to improve performance of 2.6 kernel
Message-ID: <20051019155357.GH2616@linux-mips.org>
References: <f69849430510170429t2735ed0fo3caa862c1dfea83a@mail.gmail.com> <43539ADF.6040504@gentoo.org> <00b201c5d32e$2de780b0$0302a8c0@Ulysses> <3888b5a785ca8313b05d10eec9871fe6@embeddedalley.com> <f69849430510182255m59d62726h7a4b9c96e1a7f07c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69849430510182255m59d62726h7a4b9c96e1a7f07c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 19, 2005 at 10:55:01AM +0500, kernel coder wrote:

> I did lmbench benchmarks tests... and the results i got were pretty
> weird.. I am attaching the jpegs :) of the graphs i made in MS Excel.

We're happy with cold, raw ASCII numbers :)

> Btw, I have implemented NAPI in both 2.4.20 and 2.6.10. I ported the
> code to linux-2.6 in order to increase the board's efficiency but I'm
> quite dissapointed with the results so far :(.

NAPI is doing it's job which is keeping a system responsive under extreme
loads very well.  The pre-NAPI behaviour was simply locking up thus making
systems easily DOS-able.  NAPI is not meant to improve latency; it isn't
meant but frequently mistaken to.

  Ralf
