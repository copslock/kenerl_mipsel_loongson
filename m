Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2O0SfQ14514
	for linux-mips-outgoing; Fri, 23 Mar 2001 16:28:41 -0800
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2O0SfM14510
	for <linux-mips@oss.sgi.com>; Fri, 23 Mar 2001 16:28:41 -0800
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 9C77E109CE; Fri, 23 Mar 2001 16:29:05 -0800 (PST)
Date: Fri, 23 Mar 2001 16:29:05 -0800
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Justin Carlson <carlson@sibyte.com>
Cc: Matthew Dharm <mdharm@momenco.com>, linux-mips@oss.sgi.com
Subject: Re: Multiple processor support?
Message-ID: <20010323162904.A10387@foobazco.org>
References: <NEBBLJGMNKKEEMNLHGAIKELLCAAA.mdharm@momenco.com> <01032316143609.00779@plugh.sibyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01032316143609.00779@plugh.sibyte.com>; from carlson@sibyte.com on Fri, Mar 23, 2001 at 04:08:13PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Mar 23, 2001 at 04:08:13PM -0800, Justin Carlson wrote:

> To the best of my knowledge, the mips64 tree only works in SMP on the ip-27
> which is r10K based.  There would be a bit of work to get an RM7K  based
> multiprocessor system to run. A fair amount of the "generic" code in
> that tree is also pretty ip-27 specific, and so would need to be cleaned up.

In the particular case of SMP, this is probably still true.  However,
as of last weekend this tree compiles properly and boots part way on
Indy; I have more to do but the separation of the obviously
ip27-dependent stuff is done; you should at least be able to compile
other machines in mips64...if there were any.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
