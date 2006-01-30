Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 21:03:50 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:3357 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133639AbWA3VDd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 21:03:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0UL8b8d011370
	for <linux-mips@linux-mips.org>; Mon, 30 Jan 2006 21:08:37 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0UL8bjQ011369
	for linux-mips@linux-mips.org; Mon, 30 Jan 2006 21:08:37 GMT
Date:	Mon, 30 Jan 2006 21:08:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Kernel git repository
Message-ID: <20060130210837.GA11232@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

As some of you have been complained - the kernel git repository has become
rather large with it's currently slightly over 200MB.  Since most users
are not interested in the full 12 year project history I've prepared a
second, slimmed down repository.  It can be cloned at:

  git clone git://www.linux-mips.org/git/linux-2.6.15.git linux.git

This tree is just about 62MB in size and starts at 2.6.15.

  Ralf
