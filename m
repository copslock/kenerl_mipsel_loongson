Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Apr 2006 00:34:55 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62861 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133576AbWD2Xeq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Apr 2006 00:34:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3TKe0do020539
	for <linux-mips@linux-mips.org>; Sat, 29 Apr 2006 21:40:00 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3TKe0QD020538;
	Sat, 29 Apr 2006 21:40:00 +0100
Date:	Sat, 29 Apr 2006 21:39:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	moreau francis <francis_moreau2000@yahoo.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: Re : module allocation
Message-ID: <20060429203959.GA20496@linux-mips.org>
References: <20060429094101.90843.qmail@web25806.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060429094101.90843.qmail@web25806.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 29, 2006 at 11:41:01AM +0200, moreau francis wrote:

> maybe that would make sense to do some benchmarks ?

It would be interesting to actually have some numbers, yes.  I expect the
impact to be significantly less than of the PIC code used for userspace.

  Ralf
