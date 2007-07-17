Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 19:02:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:411 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021681AbXGQSCs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jul 2007 19:02:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6HI2lHZ032689;
	Tue, 17 Jul 2007 19:02:47 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6HI2li3032688;
	Tue, 17 Jul 2007 19:02:47 +0100
Date:	Tue, 17 Jul 2007 19:02:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	KokHow.Teh@infineon.com
Cc:	linux-mips@linux-mips.org
Subject: Re: linux-2.6.20 setjmp/longjmp OR how to contain bus-error for
	non-existing PCI device during PCI device scan?
Message-ID: <20070717180247.GA32255@linux-mips.org>
References: <31E09F73562D7A4D82119D7F6C172986019B76D7@sinse303.ap.infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31E09F73562D7A4D82119D7F6C172986019B76D7@sinse303.ap.infineon.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 17, 2007 at 07:03:34PM +0800, KokHow.Teh@infineon.com wrote:

>    I am using linux-2.6.20 on MIPS24KE and I need to know what is the best way to contain bus error during PCI bus scan process for non-existing device? I thought of setjmp/longjmp but unfortunately, I have `googled` and `find` the whole kernel source tree there is no such support in the kernel for MIPS architecture. Any insight is appreciated.

Welcome to the kernel, there are no setjmp / longjmp.  You can can try to
use the functions from <asm/paccess.h> to protect your memory accesses
against bus error exceptions.  Note this won't work for cases where the
bus error exceptions is imprecise because then the EPC for the exception
isn't guranteed to have the proper value.  The get_dbe / put_dbe functions
are used just like get_user / put_user from <linux/uaccess.h> except that
those are meant to protect against TLB exceptions.

Or just temporarily disable the bus error in your PCI config space
accessors.

  Ralf
