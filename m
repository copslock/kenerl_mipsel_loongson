Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 15:53:05 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:10724 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039073AbWI1OxB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 15:53:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8SErsoL002265;
	Thu, 28 Sep 2006 15:53:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8SErqRR002264;
	Thu, 28 Sep 2006 15:53:52 +0100
Date:	Thu, 28 Sep 2006 15:53:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Azer, William" <Bill.Azer@drs-ss.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: oprofile configure?
Message-ID: <20060928145352.GC3394@linux-mips.org>
References: <DEB94D90ABFC8240851346CFD4ACFF149E1C7F@gamd-ex-001.ss.drs.master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEB94D90ABFC8240851346CFD4ACFF149E1C7F@gamd-ex-001.ss.drs.master>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 26, 2006 at 10:34:12AM -0400, Azer, William wrote:

> i have natively built oprofile for sb1 platform and i get a lot of warnings from the compiler.  i had to use --disable-werror in order to build.  has anyone encountered this?  am i doing something wrong?

For a long time there has been no release of oprofile so only versions from
CVS did work on MIPS:  However there has been a release of 0.9.2 on
September 15 which so I hope is the first release of oprofile that will
work out of the box for MIPS.

I believe -Werror is a remarkably bad idea for any software release no
matter how beneficial it may be during development ...

  Ralf
