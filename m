Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Nov 2009 08:12:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43407 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492574AbZKAHMo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Nov 2009 08:12:44 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA17E7Z8009632;
	Sun, 1 Nov 2009 08:14:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA17E7lv009630;
	Sun, 1 Nov 2009 08:14:07 +0100
Date:	Sun, 1 Nov 2009 08:14:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"wilbur.chan" <wilbur512@gmail.com>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Problem in booting when calling calibrate_delay
Message-ID: <20091101071407.GC4551@linux-mips.org>
References: <e997b7420910281651p24b8e367m1e2ddbc1b95ac623@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e997b7420910281651p24b8e367m1e2ddbc1b95ac623@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 29, 2009 at 07:51:52AM +0800, wilbur.chan wrote:

> I was going to boot mips64  xlr408, which has 8 cores.

The XLR is not supported by the linux-mips.org rsp. kernel.org kernel
trees.

> Howerver, the code seemd to stop before calling 'start_kernel--->
> 
> calibrate_delay ' .
> 
> So Iadded some 'printk' in  calibrate_delay,  to check out why it failed.
>  However,  if I added a 'printk' in any 'if  branches'  in
> 
> 'calibrate_delay '  function  , the kernel would halt  before calling
> 
> 
> 'j  start_kernel'  in head.S. (in this situation ,printk seemed
> 
> unavailable, so  I  wrote directlly to serial address  to trace the
> 
> kernel).
> 
> 
> Can anyone tell me why this happed?

When something like this happens it is in most cases caused by timer
interrupt not working.

  Ralf
