Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 22:05:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38749 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493885AbZJPUFB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Oct 2009 22:05:01 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9GK6LJd028249;
	Fri, 16 Oct 2009 22:06:21 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9GK6K0F028247;
	Fri, 16 Oct 2009 22:06:20 +0200
Date:	Fri, 16 Oct 2009 22:06:20 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: fix dma.c compiled bug
Message-ID: <20091016200620.GA25689@linux-mips.org>
References: <1255721276-27561-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255721276-27561-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 09:27:56PM +0200, Manuel Lauss wrote:

> Patch "MIPS: Alchemy: get rid of superfluous UART definitions" breaks
> dma.c.

Thanks, I folded your patch into that other patch.

  Ralf
