Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2009 13:03:47 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51701 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492788AbZFPLDl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jun 2009 13:03:41 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5GB1uaF031702;
	Tue, 16 Jun 2009 12:01:57 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5GB1ruF031701;
	Tue, 16 Jun 2009 12:01:53 +0100
Date:	Tue, 16 Jun 2009 12:01:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Yan Hua <yanh@lemote.com>, Zhang Fuxin <zhangfx@lemote.com>,
	Pavel Machek <pavel@ucw.cz>, Wu Zhangjin <wuzj@lemote.com>,
	Hu Hongbing <huhb@lemote.com>
Subject: Re: [PATCH-v2] Hibernation Support in mips system
Message-ID: <20090616110153.GA31576@linux-mips.org>
References: <9c9bc070f3c272c41254304537e9dec398245b94.1244118419.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9bc070f3c272c41254304537e9dec398245b94.1244118419.git.wuzj@lemote.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 04, 2009 at 08:27:10PM +0800, wuzhangjin@gmail.com wrote:

> This is pulled from the to-mips branch of
> http://dev.lemote.com/code/linux_loongson, the original author is Hu
> Hongbing from www.lemote.com
> 
> according to the feedback from Atsushi Nemoto, Arnaud Patard, Yanhua,
> Pavel Machek and Ralf Baechle. I removed the a0-a7,v1 registers
> saving/restoring, added cache/tlb flushing and fpu,dsp registers
> saving/restoring, and also tuned some coding style problem with the
> support of scripts/checkpatch.pl and added GPL notice.

SMP support requires CPU hotplugging which MIPS currently doesn't support.
As implemented in this patch cache and tlb flushing will also be
invoked with interrupts disabled so smp_call_function() will blow up in
charming ways.  My request to move the cache and tlb flushing code was
ignored but since this matter will need revisiting anyway and hibernation
is a very useful feature I decieded to take the patch but limit hibernation
to !SMP.

Thanks folks!

  Ralf
