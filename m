Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 23:23:56 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14263 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022907AbXCXXXz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Mar 2007 23:23:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2ONNoNj032572;
	Sat, 24 Mar 2007 23:23:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2ONNol3032571;
	Sat, 24 Mar 2007 23:23:50 GMT
Date:	Sat, 24 Mar 2007 23:23:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Sharp <tigerand@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 64-bit TO_PHYS_MASK macro for RM9000 processors
Message-ID: <20070324232349.GA23432@linux-mips.org>
References: <20070323191511.GA10277@onstor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070323191511.GA10277@onstor.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 23, 2007 at 12:15:18PM -0700, Andrew Sharp wrote:

> Either I'm missing something, or people don't run their RM9Ks in 64 bit
> mode too often.

Or they silently fix it up.  There is a giant gap between the number of
people hacking the kernel in some way and those who actually care and
contribute.

Thanks, applied.

  Ralf
