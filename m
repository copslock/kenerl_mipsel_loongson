Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3JF6V8d005530
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Apr 2002 08:06:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3JF6VVI005529
	for linux-mips-outgoing; Fri, 19 Apr 2002 08:06:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3JF6R8d005523
	for <linux-mips@oss.sgi.com>; Fri, 19 Apr 2002 08:06:28 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 16yZym-0001ka-00; Fri, 19 Apr 2002 17:07:16 +0200
Date: Fri, 19 Apr 2002 17:07:16 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Jay Carlson <nop@nop.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: FYI: release of snow toolchain builder 1.4
Message-ID: <20020419150716.GA6686@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Jay Carlson <nop@nop.com>, linux-mips@oss.sgi.com
References: <FB40A540-52CC-11D6-A0DC-0030658AB11E@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB40A540-52CC-11D6-A0DC-0030658AB11E@nop.com>
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 18, 2002 at 09:05:39AM -0400, Jay Carlson wrote:
> Snow could be the basis for MIPS16 work, since -fpic MIPS16 looks 
> difficult.  However, the compiler I currently use, Debian gcc 2.95.4, is 
> completely broken for -mips16.  (I'd say "can't compile dhrystone" is a 
> good metric.  :-)  If anybody sends me a known-good MIPS16 platform, I'd 
> be delighted to make snow work on it.  (At this point, getting MIPS16 
> working under Linux is a matter of personal honor to me.)

I've just asked on the gcc mailing list, and someone at
Redhat is currently working on mips16 support on the
CVS trunk, i.e. it won't be in gcc-3.1. If it receives
sufficient testing, gcc-3.2 might work for mips16 stuff.
GNU-Pro from Redhat and the Algorithmics toolchain should
work, too.


Regards,
Johannes
