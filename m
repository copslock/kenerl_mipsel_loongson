Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57FXLn20754
	for linux-mips-outgoing; Thu, 7 Jun 2001 08:33:21 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57FXKh20749
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 08:33:20 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 5729F3E90; Thu,  7 Jun 2001 08:30:23 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id B2CCB1416D; Thu,  7 Jun 2001 08:31:14 -0700 (PDT)
Date: Thu, 7 Jun 2001 08:31:14 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: julien <julien@iside.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: new comer question
Message-ID: <20010607083114.A25672@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c501c0ef60$ceb4d3f0$662d44c3@yoshi>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 07, 2001 at 04:47:42PM +0200, julien wrote:

> I'm following this list's discussions since many months, and I decided
> to get linux running on my Indy box (R4400, Newport gfx)... To do so, I
> followed standard installation instructions and used the hardhat5.1
> archive located at ftp://oss.sgi.com/pub/linux/mips/redhat ...  I set up
> the tftp / bootp / nfs root  on a FreeBSD box as we don't have any Linux
> here, but this shouldn't be a problem, should it ?

Of course not.  You can use any system as the server.  When you say
"standard installation instructions" what does that mean exactly?
More importantly, which kernel did you use and where did it come from?

> $0 : <some hexdump>                        <-- do you need these dumps

It depends.  If this kernel is a newish 2.4 kernel or current CVS 2.2,
then yes, the dumps are needed to solve the problem.  If this is an
old or ancient kernel you might want to send the dumps anyway but most
people will ignore you.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
