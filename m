Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:50:40 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57989 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023108AbXIYNui (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 14:50:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8PDobGo019928;
	Tue, 25 Sep 2007 14:50:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8PDobPE019927;
	Tue, 25 Sep 2007 14:50:37 +0100
Date:	Tue, 25 Sep 2007 14:50:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/4] Rename BCM947XX into BCM47XX
Message-ID: <20070925135037.GA19803@linux-mips.org>
References: <20070925133847.GA14227@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070925133847.GA14227@hall.aurel32.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 25, 2007 at 03:38:47PM +0200, Aurelien Jarno wrote:

> The following 4 patches are replacing 4 already merged patches in order
> to rename BCM947XX into BCM47XX. I have been explained that the '9' in
> the name mean "development board", while the code refers to the CPU.

With those very highly integrated SOCs the boundary between a chip and
a board is beginning to be a bit fuzzy ...

  Ralf
