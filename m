Received:  by oss.sgi.com id <S553863AbRBIUOR>;
	Fri, 9 Feb 2001 12:14:17 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:9227 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553854AbRBIUNx>;
	Fri, 9 Feb 2001 12:13:53 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6B1157D9; Fri,  9 Feb 2001 21:13:41 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3D593EEAC; Fri,  9 Feb 2001 20:58:38 +0100 (CET)
Date:   Fri, 9 Feb 2001 20:58:38 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Jun Sun <jsun@mvista.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: config option vs. run-time detection (the debate continues ...)
Message-ID: <20010209205838.B26386@paradigm.rfc822.org>
References: <3A830135.B1304041@mvista.com> <01bf01c0921b$6de26620$0deca8c0@Ulysses> <3A83247D.FC52431D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A83247D.FC52431D@mvista.com>; from jsun@mvista.com on Thu, Feb 08, 2001 at 02:58:05PM -0800
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Feb 08, 2001 at 02:58:05PM -0800, Jun Sun wrote:

>  a) HAS_FPU & FPU_EMULATION - which is necessary when FPU is not a full
> implementation.
> 
>  b) !HAS_FPU & FPU_EMULATION - which allows one to run fpu-ful userland
> application

These 2 cases are perfectly good 

>  c) HAS_FPU & !FPU_EMULATION - when FPU is a full implementaion (or use the
> old incomplete emaulation?)
> 
>  d) !HAS_FPU & !FPU_EMULATION - it mandates non-fpu-ful userland (which to me
> is perfectly fine)

These 2 cases present a user/developer who decided not to have any
fpu support kernel/cpu wise. Kill his apps if using "illegal" instructions.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
