Received:  by oss.sgi.com id <S553989AbRAYTXj>;
	Thu, 25 Jan 2001 11:23:39 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:52497 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553986AbRAYTXN>;
	Thu, 25 Jan 2001 11:23:13 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8771C7FE; Thu, 25 Jan 2001 20:23:10 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 74E08EE9C; Thu, 25 Jan 2001 20:22:36 +0100 (CET)
Date:   Thu, 25 Jan 2001 20:22:36 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: OOps - very obscure
Message-ID: <20010125202236.A466@paradigm.rfc822.org>
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125134331.A11489@paradigm.rfc822.org> <3A70777B.F86123A5@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A70777B.F86123A5@mvista.com>; from jsun@mvista.com on Thu, Jan 25, 2001 at 10:59:07AM -0800
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 25, 2001 at 10:59:07AM -0800, Jun Sun wrote:
> Florian,
> 
> What is the kernel version?  Your symptom seems to remind me the corrupted s0
> bug in several syscalls. The bug is fixed around test9 I believe.  Check for
> "save_static_function(sys_sigsuspend);" statement in arch/mips/kernel/signal.c
> file.  If you have it, then you don't have the bug.

2.4.0 final - checkout on 20010111

And i have it ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
