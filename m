Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jun 2004 18:04:53 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:52723 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225617AbUFPREt>;
	Wed, 16 Jun 2004 18:04:49 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i5GH4l4O032121;
	Wed, 16 Jun 2004 10:04:47 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i5GH4kfo032120;
	Wed, 16 Jun 2004 10:04:46 -0700
Date: Wed, 16 Jun 2004 10:04:46 -0700
From: Jun Sun <jsun@mvista.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [PATCH] make ps2 mouse work ...
Message-ID: <20040616100446.J28403@mvista.com>
References: <20040615191023.G28403@mvista.com> <20040615205611.1e9cbfcc.akpm@osdl.org> <20040616121149.GA9325@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040616121149.GA9325@ucw.cz>; from vojtech@suse.cz on Wed, Jun 16, 2004 at 02:11:49PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jun 16, 2004 at 02:11:49PM +0200, Vojtech Pavlik wrote:
> On Tue, Jun 15, 2004 at 08:56:11PM -0700, Andrew Morton wrote:
> 
> > > I found this problem on a MIPS machine.  The problem is 
> > > likely to happen on other register-rich RISC arches too.
> > > 
> > > cmdcnt needs to be volatile since it is modified by
> > > irq routine and read by normal process context.
> > 
> > volatile is not the preferred way to fix this up.  This points at either a
> > locking error in the psmouse driver or a missing "memory" thingy in the
> > mips port somewhere.
> > 
> > Please describe the bug which led to this patch.  Where was it getting stuck?
> 
> My current BK tree has this fixed using atomic bitfields, which do
> compilation and memory barriers. I plan to sync it to Linus post 2.6.7.
> 

Can you post the patch here?  I am sure many people are eagerly waiting
for the right fix.  Plus there will be extra pairs of eyes to exam the fix.

Jun
