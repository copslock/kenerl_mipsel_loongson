Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2009 22:00:15 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41011 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493376AbZIYUAG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Sep 2009 22:00:06 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8PK1N5c030160;
	Fri, 25 Sep 2009 21:01:23 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8PK1MPl030159;
	Fri, 25 Sep 2009 21:01:22 +0100
Date:	Fri, 25 Sep 2009 21:01:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark Mason <mmason@upwardaccess.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: linux-mips.git broken compiling for smp targets
Message-ID: <20090925200122.GA25773@linux-mips.org>
References: <20090924222719.GA18095@upwardaccess.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090924222719.GA18095@upwardaccess.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 24, 2009 at 03:27:19PM -0700, Mark Mason wrote:

> I'm getting the following compiling for my bcm1480:
> 
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CC      arch/mips/kernel/smp.o
> arch/mips/kernel/smp.c: In function `arch_send_call_function_single_ipi':
> arch/mips/kernel/smp.c:140: error: incompatible type for argument 1 of indirect function call
> make[1]: *** [arch/mips/kernel/smp.o] Error 1
> make: *** [arch/mips/kernel] Error 2
> 
> Anyone else running into this?

Yes, the code got Rusty.  I fixed that a few hours ago.

  Ralf
