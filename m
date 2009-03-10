Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Mar 2009 21:30:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:50341 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20808035AbZCJVaP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Mar 2009 21:30:15 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2ALUChO018560;
	Tue, 10 Mar 2009 22:30:12 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2ALU8EH018558;
	Tue, 10 Mar 2009 22:30:08 +0100
Date:	Tue, 10 Mar 2009 22:30:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Xiaotian Feng <Xiaotian.Feng@windriver.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] mips: fix mips syscall wrapper sys_32_ipc bug
Message-ID: <20090310213008.GA18047@linux-mips.org>
References: <1236563112-24287-1-git-send-email-Xiaotian.Feng@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1236563112-24287-1-git-send-email-Xiaotian.Feng@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 09, 2009 at 09:45:12AM +0800, Xiaotian Feng wrote:

> 
> There's a typo in mips syscall wrapper sys_32_ipc. If CONFIG_SYSVIPC
> is not set, it will cause mips linux compile error.
> 
> Signed-off-by: Xiaotian Feng <xiaotian.feng@windriver.com>

Thanks, applied.

  Ralf
