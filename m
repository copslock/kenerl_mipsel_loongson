Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2LG6pu31576
	for linux-mips-outgoing; Wed, 21 Mar 2001 08:06:51 -0800
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2LG6oM31573
	for <linux-mips@oss.sgi.com>; Wed, 21 Mar 2001 08:06:50 -0800
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id A3C24109CE; Wed, 21 Mar 2001 08:07:15 -0800 (PST)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id E00901F429; Wed, 21 Mar 2001 08:06:47 -0800 (PST)
Date: Wed, 21 Mar 2001 08:06:47 -0800
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Phil Thompson <Phil.Thompson@pace.co.uk>
Cc: linux-mips@oss.sgi.com
Subject: Re: Recommended toolchain
Message-ID: <20010321080647.A4223@foobazco.org>
References: <1402C4C025C4D311B50D00508B8B74E281B14D@exchange1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1402C4C025C4D311B50D00508B8B74E281B14D@exchange1>; from Phil.Thompson@pace.co.uk on Wed, Mar 21, 2001 at 02:00:22PM -0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Mar 21, 2001 at 02:00:22PM -0000, Phil Thompson wrote:

> So, going back to the original question, what are the recommended versions -
> particularly if you are building 2.4.x kernels?

I don't really know that there is one.  I am using the gcc 3.0 branch
and binutils from CVS (2.11.90).  You can find the same toolchain
that's building my kernels on
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev at all
times, including patches.  No binaries, source and patches only.

This linker has a bug in it regarding section placement, but the
current cvs kernel has a workaround for it.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
