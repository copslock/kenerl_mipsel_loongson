Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2007 11:57:35 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:55175 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20031803AbXLGL5d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Dec 2007 11:57:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB7BupF2011305;
	Fri, 7 Dec 2007 11:56:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB7BuppY011304;
	Fri, 7 Dec 2007 11:56:51 GMT
Date:	Fri, 7 Dec 2007 11:56:51 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC PATCH] Alchemy: Au1210/Au1250 CPU support
Message-ID: <20071207115650.GB7680@linux-mips.org>
References: <20071206080755.GA20485@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071206080755.GA20485@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 06, 2007 at 09:07:55AM +0100, Manuel Lauss wrote:

> This patch adds IDs fornew Au1200 variants: Au1210 and Au1250.
> They are essentially identical to the Au1200 except for the Au1210
> which has a different SoC-ID in the PRId register [bits 31:24].
> The Au1250 is a "Au1200 V0.2".
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Looks ok, queued for 2.6.25.

  Ralf
