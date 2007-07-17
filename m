Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 11:44:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:58323 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021435AbXGQKoG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jul 2007 11:44:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6HAi6nT006105
	for <linux-mips@linux-mips.org>; Tue, 17 Jul 2007 11:44:06 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6HAi6eB006104
	for linux-mips@linux-mips.org; Tue, 17 Jul 2007 11:44:06 +0100
Date:	Tue, 17 Jul 2007 11:44:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: early_serial_setup removed
Message-ID: <20070717104405.GA5581@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Several platforms were broken by today's merge which in changeset
18a8bd949d6adb311ea816125ff65050df1f3f6e removed among other functions
early_serial_setup.

  Ralf
