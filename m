Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Apr 2004 13:13:42 +0100 (BST)
Received: from p508B6E98.dip.t-dialin.net ([IPv6:::ffff:80.139.110.152]:27676
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225208AbUDFMNl>; Tue, 6 Apr 2004 13:13:41 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i36CDexr007680
	for <linux-mips@linux-mips.org>; Tue, 6 Apr 2004 14:13:40 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i36CDdZF007679
	for linux-mips@linux-mips.org; Tue, 6 Apr 2004 14:13:39 +0200
Date: Tue, 6 Apr 2004 14:13:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: 64-bit module support
Message-ID: <20040406121339.GA7557@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I've added support for 64-bit modules in 2.4; the necessary patches for
modutils 2.4.21 and 2.4.27 can be found on ftp.linux-mips.org in
/pub/linux/mips/modutils/.

The 2.6 module code is a complete rewrite; it uses module-init-tools which
don't contain any architecture dependencies and therefore didn't need to
be changed; instead all the relocation business is done in the kernel
itself and those patches are already in CVS.

  Ralf
