Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4EFBFj14554
	for linux-mips-outgoing; Mon, 14 May 2001 08:11:15 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4EFBEF14551
	for <linux-mips@oss.sgi.com>; Mon, 14 May 2001 08:11:14 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id D8400F1A9; Mon, 14 May 2001 08:10:03 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id E47471F42B; Mon, 14 May 2001 08:10:39 -0700 (PDT)
Date: Mon, 14 May 2001 08:10:39 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Rafal Boni <rafal.boni@eDial.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: SGI O2 Port
Message-ID: <20010514081039.B18935@foobazco.org>
References: <20010512185211.C3092@foobazco.org> <200105141204.IAA19260@ninigret.metatel.office>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105141204.IAA19260@ninigret.metatel.office>; from rafal.boni@eDial.com on Mon, May 14, 2001 at 08:04:11AM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 14, 2001 at 08:04:11AM -0400, Rafal Boni wrote:

> What CPU's are supported currently?  Just the R5000, or are the R10k/R12k
> supported as well?  (I realize that the latter two are harder to support,
> but thought I'd ask nevertheless).

I have never built it for anything but r5k.  It's very likely that
52x0 will also run fine.  In theory r10k/r12k should work.  In
practice, however, I suspect that differences in the crime controllers
will make it impossible to boot; I can probably fix that.  As we run
uncached only at this time anyway, the spec writes thing should not be
an issue.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
