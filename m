Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jun 2004 13:12:43 +0100 (BST)
Received: from gprs187-64.eurotel.cz ([IPv6:::ffff:160.218.187.64]:64128 "EHLO
	midnight.ucw.cz") by linux-mips.org with ESMTP id <S8225544AbUFPMMi>;
	Wed, 16 Jun 2004 13:12:38 +0100
Received: by midnight.ucw.cz (Postfix, from userid 502)
	id D7C7374312; Wed, 16 Jun 2004 14:11:49 +0200 (CEST)
Date: Wed, 16 Jun 2004 14:11:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] make ps2 mouse work ...
Message-ID: <20040616121149.GA9325@ucw.cz>
References: <20040615191023.G28403@mvista.com> <20040615205611.1e9cbfcc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615205611.1e9cbfcc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Return-Path: <vojtech@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vojtech@suse.cz
Precedence: bulk
X-list: linux-mips

On Tue, Jun 15, 2004 at 08:56:11PM -0700, Andrew Morton wrote:

> > I found this problem on a MIPS machine.  The problem is 
> > likely to happen on other register-rich RISC arches too.
> > 
> > cmdcnt needs to be volatile since it is modified by
> > irq routine and read by normal process context.
> 
> volatile is not the preferred way to fix this up.  This points at either a
> locking error in the psmouse driver or a missing "memory" thingy in the
> mips port somewhere.
> 
> Please describe the bug which led to this patch.  Where was it getting stuck?

My current BK tree has this fixed using atomic bitfields, which do
compilation and memory barriers. I plan to sync it to Linus post 2.6.7.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
