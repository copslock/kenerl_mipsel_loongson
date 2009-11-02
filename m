Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 06:58:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42327 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492160AbZKBF6T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 06:58:19 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA25xca6012954;
	Mon, 2 Nov 2009 06:59:38 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA25xZ6p012951;
	Mon, 2 Nov 2009 06:59:35 +0100
Date:	Mon, 2 Nov 2009 06:59:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Robert Richter <robert.richter@amd.com>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	John Levon <levon@movementarian.org>,
	oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] oprofile/loongson2: rename cpu_type from godson2 to
	loongson2
Message-ID: <20091102055934.GA10689@linux-mips.org>
References: <1256136706-27810-1-git-send-email-wuzhangjin@gmail.com> <20091021165907.GJ11972@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091021165907.GJ11972@erda.amd.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 21, 2009 at 06:59:07PM +0200, Robert Richter wrote:

> On 21.10.09 22:51:46, Wu Zhangjin wrote:
> > This patch try to unify the naming method between kernel and the
> > user-space oprofile tool. 'Cause loongson is used instead of godson in
> > most of the places, and just confer with the developer of the user-space
> > tool, we are agreed to use loongson instead, which will help a lot to
> > the future maintaining.
> > 
> > (This patch is very important to help the user-space support upstream,
> >  so, Ralf, could you please merge it into your -queue branch, thanks!)

Applied to master, not queue.  The name is part of an API, so cosmetic
changes like this are to be avoided.  Fortunately the oprofile code in
question is still fairly new, hasn't been art of any stable kernel
release yet so it better go into the kernel now than later.

> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Acked-by: Robert Richter <robert.richter@amd.com>
> 
> Ralf, please apply to your tree.

  Ralf
