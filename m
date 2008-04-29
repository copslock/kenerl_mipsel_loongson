Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2008 19:53:40 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:50643 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28794116AbYD2Sxh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Apr 2008 19:53:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3TIrYod014624;
	Tue, 29 Apr 2008 19:53:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3TIrXvw014617;
	Tue, 29 Apr 2008 19:53:33 +0100
Date:	Tue, 29 Apr 2008 19:53:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Pb1000: bury the remnants of the PCI code
Message-ID: <20080429185333.GB14609@linux-mips.org>
References: <200804052259.29959.sshtylyov@ru.mvista.com> <48176D09.7030308@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48176D09.7030308@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 29, 2008 at 10:46:33PM +0400, Sergei Shtylyov wrote:

> Hello, I wrote:
>
>> PCI support for the Pb1000 board was ectomized by Pete Popov four years ago.
>> Unfortunately,  the header file  wasn't cleansed, so the remnants still get
>> in the way of the kernel build (due to macro redefinitions).
>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
>    Hm looks like I have somehow missed the remanants in 
> arch/mips/au1000/pb1000/board_setup.c... too bad that this patch has been 
> long merged. :-/

New patch, new luck ;-)

  Ralf
