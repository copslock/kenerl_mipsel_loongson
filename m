Received:  by oss.sgi.com id <S554040AbRAQNuv>;
	Wed, 17 Jan 2001 05:50:51 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:12043 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554036AbRAQNug>;
	Wed, 17 Jan 2001 05:50:36 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A5C327FC; Wed, 17 Jan 2001 14:50:30 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 46BEBF597; Wed, 17 Jan 2001 14:50:34 +0100 (CET)
Date:   Wed, 17 Jan 2001 14:50:34 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ian Chilton <ian@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: 2.4.0 Kernel - Summary
Message-ID: <20010117145034.B2517@paradigm.rfc822.org>
References: <20010117131758.B29427@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117131758.B29427@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Wed, Jan 17, 2001 at 01:17:58PM +0000
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 17, 2001 at 01:17:58PM +0000, Ian Chilton wrote:
> Hello,
> 
> So, the outstanding issues so far are:
> 
> Major Issues:
> - Can't reboot (Flo and I get this)

I can reboot - but with "reboot -f" which is - Immediate reset
which is not good(tm) for your filesystems. The bug is definitly
a sgiserial.c problem as it doesnt happen on newport console.

Its probably a problem with console and tty output getting mixed.
Definitly a bigger issue as one should merge driver/sbus/zs.c and
driver/sgi/char/sgiserial.c to one driver. (And probably even
the Decstation one)

> Minor Issues:
> - Wierd thing in /proc/cpuinfo (Flo and I get this) 
Fixed ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
