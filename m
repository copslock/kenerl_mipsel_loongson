Received:  by oss.sgi.com id <S553762AbRB0WXz>;
	Tue, 27 Feb 2001 14:23:55 -0800
Received: from enst.enst.fr ([137.194.2.16]:9115 "HELO enst.enst.fr")
	by oss.sgi.com with SMTP id <S553744AbRB0WXg>;
	Tue, 27 Feb 2001 14:23:36 -0800
Received: from email.enst.fr (muse.enst.fr [137.194.2.33])
	by enst.enst.fr (Postfix) with ESMTP
	id BD7781C913; Tue, 27 Feb 2001 23:23:33 +0100 (MET)
Received: from cal-ppp20.ppp.enst.fr (root@cal-ppp20.ppp.enst.fr [137.194.3.20])
	by email.enst.fr (8.9.3/8.9.3) with ESMTP id XAA29440;
	Tue, 27 Feb 2001 23:23:31 +0100 (MET)
Received: (from bellard@localhost)
	by cal-ppp20.ppp.enst.fr (8.9.3/8.9.3/Debian 8.9.3-21) id XAA00555;
	Tue, 27 Feb 2001 23:22:27 +0100
Date:   Tue, 27 Feb 2001 23:22:27 +0100
From:   Fabrice Bellard <bellard@email.enst.fr>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Serious bug in uaccess.h
Message-ID: <20010227232227.B384@email.enst.fr>
References: <Pine.GSO.4.02.10102271629230.22188-100000@donjuan.enst.fr> <Pine.GSO.3.96.1010227185131.9765A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010227185131.9765A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Feb 27, 2001 at 06:54:22PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Feb 27, 2001 at 06:54:22PM +0100, Maciej W. Rozycki wrote:
> > BTW, the kernel would be smaller by moving all the asm around __copy_user
> > in __copy_user itself. I am currently doing that. The cost is an added
> > 'jr' to jump to __memcpy. Do you think it is worthwhile to do that ?
> 
>  What asm do you mean?

I mean the code in arch/mips/lib/memcpy.S. It is possible to modify
__copy_user so that it has exactly the same calling convention of a C
function. Then, no asm is necessary in uaccess.h. It costs us a
supplementary jump.

Fabrice.
