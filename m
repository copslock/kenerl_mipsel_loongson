Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2LM5rv09243
	for linux-mips-outgoing; Wed, 21 Mar 2001 14:05:53 -0800
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2LM5qM09240
	for <linux-mips@oss.sgi.com>; Wed, 21 Mar 2001 14:05:52 -0800
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 66A56109CE; Wed, 21 Mar 2001 14:06:17 -0800 (PST)
Date: Wed, 21 Mar 2001 14:06:16 -0800
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Phil Thompson <Phil.Thompson@pace.co.uk>
Cc: "'Erik Mullinix'" <Hesp@rainworks.org>, linux-mips@oss.sgi.com
Subject: Re: Recommended toolchain
Message-ID: <20010321140616.A3956@foobazco.org>
References: <1402C4C025C4D311B50D00508B8B74E281B151@exchange1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1402C4C025C4D311B50D00508B8B74E281B151@exchange1>; from Phil.Thompson@pace.co.uk on Wed, Mar 21, 2001 at 06:46:07PM -0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Mar 21, 2001 at 06:46:07PM -0000, Phil Thompson wrote:

> - compilation stops because loops_per_sec is undeclared as far as
> asm-mips/delay.h is concerned (although it seems fine in
> asm-mips64/delay.h).
> 
> This seems to imply that the mips architecture (as opposed to mips64) isn't
> being maintained. Is this the case? Should I be using mips64 - but what
> would be the point on an embedded CPU?

mips(32) is in fact being actively maintained.  It sounds like your
kernel sources may be out of date; I specifically remember removing
all references to loops_per_sec in favour of loops_per_jiffy in both
mips and mips64.

Ask again about fcntl.h after updating...

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
