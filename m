Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5JGSUQ22492
	for linux-mips-outgoing; Tue, 19 Jun 2001 09:28:30 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5JGSTV22489
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 09:28:29 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 196D53E90; Tue, 19 Jun 2001 09:24:01 -0700 (PDT)
Date: Tue, 19 Jun 2001 09:24:01 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Shay Deloya <shay@miya.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Creating a mips tool chain for mips3
Message-ID: <20010619092400.B6828@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01061919142200.12304@miya>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 19, 2001 at 07:14:22PM +0300, Shay Deloya wrote:

> How can I configure the gcc and glibc to be compiled as mips3 and not mips1 
> by default ? 

Getting libgcc built as non-mips1 is something I haven't figured out
yet.  At least, not without gross hacks.  glibc is easy - put -mips2
in CFLAGS when you call configure.

In any case you must not use mips3 userland on 32-bit kernels, on
account of 64-bit istructions being used.  You must use mips2.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
