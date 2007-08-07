Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 13:07:05 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9933 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024082AbXHGMHD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Aug 2007 13:07:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l77C71sf022896
	for <linux-mips@linux-mips.org>; Tue, 7 Aug 2007 13:07:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l77C711f022895
	for linux-mips@linux-mips.org; Tue, 7 Aug 2007 13:07:01 +0100
Date:	Tue, 7 Aug 2007 13:07:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Defconfig updates
Message-ID: <20070807120701.GA22096@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Many of the MIPS defconfig files haven't been updated in quite a while,
so I've updated them for a few platforms.  Now that -rc2 is out and the
changes to Kconfig files have settled is probably a good time to do so,
so patches appreciated.

Thanks,

  Ralf
