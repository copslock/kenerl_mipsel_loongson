Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 17:54:38 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42598 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493299AbZKIQyf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Nov 2009 17:54:35 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA9GsVqj016629;
	Mon, 9 Nov 2009 17:54:31 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA9GsUUw016627;
	Mon, 9 Nov 2009 17:54:30 +0100
Date:	Mon, 9 Nov 2009 17:54:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 0/7] add support for lemote loongson2f machines
Message-ID: <20091109165429.GB15319@linux-mips.org>
References: <cover.1257781987.git.wuzhangjin@gmail.com> <20091109161127.GA15319@linux-mips.org> <1257784608.14315.11.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257784608.14315.11.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 12:36:48AM +0800, Wu Zhangjin wrote:

> > Grant Likely convinced me in Tokyo that this is the way to go.  He intends
> > to rewrite the FDT code into an easily re-usable library which he estimates
> > to take a month or two after which I'd like to start using it on MIPS.
> > This probably also means FDT support for PMON will eventually be needed.
> > 
> 
> Thanks for your pointer, Will take a look at FDT asap.
> 
> > Until then of course machtype=<whatever> is a fair solution.
> > 
> 
> are you ready to apply it? then I will push the Cpufreq and Standby
> support, and really hope we can get a full loongson2f support in the
> mainline's 33 version ;)

I had already taken the previous version into the -queue tree.

What are the changes since -v1?  I've done a few changes myself, mostly
tweaking the English language bits of the patch, so incremental patches
would be ideal.

  Ralf
