Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 16:22:06 +0100 (BST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:47596 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024690AbZE2PWA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 16:22:00 +0100
Received: from gandalf ([74.67.89.75]) by hrndva-omta02.mail.rr.com
          with ESMTP
          id <20090529152154178.ORYN11757@hrndva-omta02.mail.rr.com>;
          Fri, 29 May 2009 15:21:54 +0000
Date:	Fri, 29 May 2009 11:21:53 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	wuzhangjin@gmail.com
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Wu Zhangjin <wuzj@lemote.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH v2 3/6] add an endian argument to
 scripts/recordmcount.pl
In-Reply-To: <6f4f65069c0ace1f0cffd9ce152f226f09edad9b.1243604390.git.wuzj@lemote.com>
Message-ID: <alpine.DEB.2.00.0905291120190.31247@gandalf.stny.rr.com>
References: <cover.1243604390.git.wuzj@lemote.com> <6f4f65069c0ace1f0cffd9ce152f226f09edad9b.1243604390.git.wuzj@lemote.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips


On Fri, 29 May 2009, wuzhangjin@gmail.com wrote:

> From: Wu Zhangjin <wuzj@lemote.com>
> 
> mips architecture need this argument to handle big/little endian
> differently.

Actually, I was thinking that you add this before adding the mips code. 
That way we don't add a broken mips code first.

So could you swap this with patch 2?

-- Steve

> 
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
