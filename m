Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 13:46:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:1994 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038632AbWI1Mqd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 13:46:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8SClPY2030617;
	Thu, 28 Sep 2006 13:47:26 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8SClPFc030616;
	Thu, 28 Sep 2006 13:47:25 +0100
Date:	Thu, 28 Sep 2006 13:47:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] QEMU - Add support for little endian mips
Message-ID: <20060928124725.GA30521@linux-mips.org>
References: <20060927210723.GA28334@bode.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927210723.GA28334@bode.aurel32.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 27, 2006 at 11:07:25PM +0200, Aurelien Jarno wrote:

> This very small patch adds support for little endian on the virtual QEMU
> mips platform. The status of this platform is the same as the big endian
> one, ie it is possible to boot a system with init=/bin/sh.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Applied.  Thanks,

  Ralf
