Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 22:43:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56553 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493466AbZJHUni (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Oct 2009 22:43:38 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n98KinwC014811;
	Thu, 8 Oct 2009 22:44:49 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n98KilOO014807;
	Thu, 8 Oct 2009 22:44:47 +0200
Date:	Thu, 8 Oct 2009 22:44:47 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
Message-ID: <20091008204447.GA14560@linux-mips.org>
References: <1255001548-30567-1-git-send-email-wuzhangjin@gmail.com> <200910082221.12649.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200910082221.12649.rjw@sisk.pl>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 08, 2009 at 10:21:12PM +0200, Rafael J. Wysocki wrote:

> > Here, we fix it via checking pfn is in the "System RAM" or not. and
> > Seems pfn_valid() is not called in assembly code, we move it to
> > "!__ASSEMBLY__" to ensure we can simply declare it via "extern int
> > pfn_valid(unsigned long)" without Compiling Error.
> > 
> > (This -v1 version incorporates feedback from Pavel Machek <pavel@ucw.cz>
> >  and Sergei Shtylyov <sshtylyov@ru.mvista.com>)
> 
> Hmm.  What exactly would be wrong with using register_nosave_region() or
> register_nosave_region_late() like x86 does?

That seems to be more the fix than pfn_valid / PageReserved fiddlery we were
discussing in the other thread.  Thanks!

  Ralf
