Received:  by oss.sgi.com id <S553802AbQLHXdT>;
	Fri, 8 Dec 2000 15:33:19 -0800
Received: from wn42-146.sdc.org ([209.155.42.146]:34800 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S553798AbQLHXcp>;
	Fri, 8 Dec 2000 15:32:45 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869705AbQLHXcX>;
	Sat, 9 Dec 2000 00:32:23 +0100
Date:	Sat, 9 Dec 2000 00:32:23 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Jun Sun <jsun@mvista.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
Message-ID: <20001209003222.A10669@bacchus.dhis.org>
References: <3A3051C1.DCFC749B@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A3051C1.DCFC749B@mvista.com>; from jsun@mvista.com on Thu, Dec 07, 2000 at 07:13:05PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Dec 07, 2000 at 07:13:05PM -0800, Jun Sun wrote:

> Currently one cannot read memory area above 0x80000000 throught /dev/kmem.  In
> fact, an earlier bug would put the process into an infinite loop if you try to
> do that.  That seems to be fixed now.
> 
> It seems to be very useful if we do allow that access.  What do you think?

Actually there is almost nothing left that uses /dev/{mem,kmem} these days.
Nevertheless it's a supported interface, so we have to get it right.

> Ralf, if we do want to enable it - which is pretty simple to do -, should I
> give you the patch or shuld I submit it to somebody else who is maintaining
> /dev/kmem?

Send me the patch and I'll comment.

  Ralf
