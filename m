Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UJxcnC001281
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 12:59:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UJxcC7001280
	for linux-mips-outgoing; Thu, 30 May 2002 12:59:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UJxZnC001277
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 12:59:35 -0700
Received: from branoic (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA06433
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 13:01:05 -0700 (PDT)
	mail_from (drow@branoic.them.org)
Received: from drow by branoic with local (Exim 3.35 #1 (Debian))
	id 17DVwj-0002l3-00; Thu, 30 May 2002 15:50:53 -0400
Date: Thu, 30 May 2002 15:50:52 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Justin Carlson <justinca@cs.cmu.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: Function pointers and #defines
Message-ID: <20020530195052.GA10587@branoic.them.org>
References: <1022787167.14210.472.camel@ldt-sj3-022.sj.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1022787167.14210.472.camel@ldt-sj3-022.sj.broadcom.com>
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 30, 2002 at 12:32:47PM -0700, Justin Carlson wrote:
> A fair number of places in the headers, we have stuff like this:
> 
> void (*_some_fn)(int arg1, int arg2);
> #define some_fn(arg1, arg2) _some_fn(arg1, arg2)
> 
> Why do we do this, as opposed to:
> 
> void (*some_fn)(int arg1, int arg2);
> 
> Both syntaxes result in being able to say
> 
> some_fn(1, 2);
> 
> but the latter is both clearer and shorter.  Is there some deep,
> mystical C reason that we use the former, or did someone do it that way
> a long time ago and no one has changed it?

At a guess, this prevents taking the address of the function
unintentionally...

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
