Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2008 17:47:20 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:23701 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24109300AbYLDRrN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2008 17:47:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mB4Hl0pO002129;
	Thu, 4 Dec 2008 17:47:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mB4HkvKg002125;
	Thu, 4 Dec 2008 17:46:57 GMT
Date:	Thu, 4 Dec 2008 17:46:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Return ENOSYS from sys32_syscall on 64bit
	kernels just like everywhere else.
Message-ID: <20081204174654.GE27896@linux-mips.org>
References: <490B4D0D.9060305@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490B4D0D.9060305@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 31, 2008 at 11:23:09AM -0700, David Daney wrote:

> When the o32 errno was changed to ENOSYS, we forgot to update the code
> for 64bit kernels.

Thanks, applied.

  Ralf
