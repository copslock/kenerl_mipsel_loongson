Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 14:08:43 +0100 (BST)
Received: from p508B7E2B.dip.t-dialin.net ([IPv6:::ffff:80.139.126.43]:6474
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbUJUNIj>; Thu, 21 Oct 2004 14:08:39 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9LD8car027284
	for <linux-mips@linux-mips.org>; Thu, 21 Oct 2004 15:08:38 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9LD8cbl027283
	for linux-mips@linux-mips.org; Thu, 21 Oct 2004 15:08:38 +0200
Resent-Message-Id: <200410211308.i9LD8cbl027283@fluff.linux-mips.net>
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9LD3GMe027141;
	Thu, 21 Oct 2004 15:03:16 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9LD3G58027140;
	Thu, 21 Oct 2004 15:03:16 +0200
Date: Thu, 21 Oct 2004 15:03:16 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20041021130316.GA26440@linux-mips.org>
References: <20041020023431Z98555-1751+175@linux-mips.org> <200410201858.40582.thomas.koeller@baslerweb.com> <200410211119.50747.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410211119.50747.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Thu, 21 Oct 2004 15:08:38 +0200
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 21, 2004 at 11:19:50AM +0200, Thomas Koeller wrote:

> I have been consulting with PMC-Sierra and received confirmation that
> the problems described under errata items 2.15 and 2.16 still exist
> with rev. 1.2 silicon.

Linux does not use Hit_Writeback_D and Hit_Writeback_SD so these can't
possible be a problem.

  Ralf
