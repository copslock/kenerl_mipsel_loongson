Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 16:26:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:28098 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024221AbXJAP0Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 16:26:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l91FQMbw028844;
	Mon, 1 Oct 2007 16:26:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l91FQKMb028843;
	Mon, 1 Oct 2007 16:26:20 +0100
Date:	Mon, 1 Oct 2007 16:26:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	linux-mips@linux-mips.org
Subject: Re: cmpxchg broken in some situation
Message-ID: <20071001152620.GB15820@linux-mips.org>
References: <46FF7BC2.5050905@ict.ac.cn> <20071001025340.GA7091@linux-mips.org> <47010E15.7060109@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47010E15.7060109@ict.ac.cn>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 01, 2007 at 11:11:17PM +0800, Fuxin Zhang wrote:

> Sorry that it seems not work:
> the kernel oops at sysfs_open_file->sysfs_get_active with unaligned 
> access(last seen exception on screen, no serial console by hand so it 
> may not be the first exception). It is probably caused by 
> "atomic_cmpxchg" there.
> And keep the old kernel using new modules with patched cmpxchg also lead 
> to glxgears die(should be lock problem like before).

Can you look at the disassembly of the generated code?  It should hopefully
be relativly obvious in the disassembly.

  Ralf
