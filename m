Received:  by oss.sgi.com id <S553876AbQLPSEr>;
	Sat, 16 Dec 2000 10:04:47 -0800
Received: from wn42-146.sdc.org ([209.155.42.146]:54255 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S553874AbQLPSEc>;
	Sat, 16 Dec 2000 10:04:32 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S870677AbQLPLrG>;
	Sat, 16 Dec 2000 04:47:06 -0700
Date:	Sat, 16 Dec 2000 12:47:06 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	James McD <vile8@hotmail.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: memory hog
Message-ID: <20001216124705.B6896@bacchus.dhis.org>
References: <F2413yMJiQTyfPefLJG0000066a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <F2413yMJiQTyfPefLJG0000066a@hotmail.com>; from vile8@hotmail.com on Fri, Dec 15, 2000 at 04:10:56PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Dec 15, 2000 at 04:10:56PM +0000, James McD wrote:

> I have an SGI INDY r4600 133 with 64 megs of ram and a 1 gig drive. I have 
> simple linux and the 2.4test9 kernel running on it. Thank you for the advice 
> on getting it booting from the hard drive btw Guido!
>    Here is my dilema. It has nothing running other than standard services 
> ie. login, networking. No web server, none of the goodies yet, and I am 
> consuming 60 out of my 64 megs of available ram. I do not even have X 
> installed yet. I know 64 megs isnt alot, but it seems to be quite a high 
> consumption for no services being run. Please let me know if anybody knows 
> if an SGI handles memory differently, or if I should just get more and quit 
> whining.

That's a classic one - Linux uses most of it's `free' memory as disk cache,
so it doesn't show up as `free' in the free output.

  Ralf
