Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 20:07:51 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:51652 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133524AbWAQUHa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 20:07:30 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1EyxAa-0002sl-2X
	for linux-mips@linux-mips.org; Tue, 17 Jan 2006 15:11:08 -0500
Date:	Tue, 17 Jan 2006 15:11:08 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Subject: Re: undefined reference to `__lshrdi3' error with GCC 4.0
Message-ID: <20060117201108.GA11011@nevyn.them.org>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20060117134838.GJ27047@deprecation.cyrius.com> <200601171617.16147.p_christ@hol.gr> <20060117190859.GA2061@linux-mips.org> <20060117193836.GJ18336@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117193836.GJ18336@lug-owl.de>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 17, 2006 at 08:38:36PM +0100, Jan-Benedict Glaw wrote:
> > +#else
> > +#error I feel sick.
> > +#endif
> 
> No, you feel PDP11ish. Though you'd put quotes about the warning
> message.

No, you wouldn't.

drow@nevyn:~% echo '#error A B' | gcc -E - 
# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "<stdin>"
<stdin>:1:2: error: #error A B
drow@nevyn:~% echo '#error "A B"' | gcc -E -
# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "<stdin>"
<stdin>:1:2: error: #error "A B"
drow@nevyn:~% 

-- 
Daniel Jacobowitz
CodeSourcery
