Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5IG0xnC022125
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 09:00:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5IG0x3X022124
	for linux-mips-outgoing; Tue, 18 Jun 2002 09:00:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5IG0unC022121
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 09:00:56 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5IG3I201203;
	Tue, 18 Jun 2002 09:03:18 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: Re: 64-bit kernel
From: Justin Carlson <justin@cs.cmu.edu>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3D0F28AE.7B0D822B@mips.com>
References: <3D0F28AE.7B0D822B@mips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 09:03:18 -0700
Message-Id: <1024416198.1166.1.camel@xyzzy.rlson.org>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-06-18 at 05:33, Carsten Langgaard wrote:
> I don't know if anymore has a interest in the 64-bit kernel, but I just
> found this bug (see patch below).
> It would be nice to know, how many are interested in the 64-bit kernel
> and who actually got something running.
> So please rise you voice.
> 

Been running 64-bit stuff here, but nothing even remotely fpu intensive.
It's quite possible we'd never run into this case.

-Justin
