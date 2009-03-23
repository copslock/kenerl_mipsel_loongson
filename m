Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2009 15:36:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:62663 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21367884AbZCWPgl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2009 15:36:41 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2NFadwH027882;
	Mon, 23 Mar 2009 16:36:39 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2NFacER027881;
	Mon, 23 Mar 2009 16:36:38 +0100
Date:	Mon, 23 Mar 2009 16:36:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Huang Weiyi <weiyi.huang@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: remove duplicated #include
Message-ID: <20090323153638.GB26942@linux-mips.org>
References: <1237614648-3840-1-git-send-email-weiyi.huang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1237614648-3840-1-git-send-email-weiyi.huang@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 21, 2009 at 01:50:48PM +0800, Huang Weiyi wrote:

> Remove duplicated #include in arch/mips/kernel/linux32.c.

Thanks applied.

  Ralf
