Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KJx6106196
	for linux-mips-outgoing; Fri, 20 Apr 2001 12:59:06 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KJx3M06183;
	Fri, 20 Apr 2001 12:59:03 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 843C97F6; Fri, 20 Apr 2001 21:59:01 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id F2006F38F; Fri, 20 Apr 2001 21:48:32 +0200 (CEST)
Date: Fri, 20 Apr 2001 21:48:32 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
Message-ID: <20010420214832.C15990@paradigm.rfc822.org>
References: <20010311191639.A8587@paradigm.rfc822.org> <20010312122134.B1235@bacchus.dhis.org> <20010312144131.C7715@paradigm.rfc822.org> <3AE0885F.D1A3D26@mvista.com> <20010420161820.B5375@bacchus.dhis.org> <3AE08BA4.1B46655C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AE08BA4.1B46655C@mvista.com>; from ppopov@mvista.com on Fri, Apr 20, 2001 at 12:19:00PM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 20, 2001 at 12:19:00PM -0700, Pete Popov wrote:
> Are you talking about the fast_sysmips patch Florian posted? 
> 
> Florian, if you have a newer patch than what you last posted on the
> mailing list, would you mind sending it?

I havent got anything newer - I am using that patch now on 2 machines
running continuesly as a build machine open in the net. Nobody
yet has reported any problems (Which isnt a good indicator)

I am not shure if it is really correct so someone with deep knowledge
of the inners of sysmips should check if its really ok.

Nevertheless - It works for me ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
