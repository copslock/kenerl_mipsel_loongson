Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5C12Ds13730
	for linux-mips-outgoing; Mon, 11 Jun 2001 18:02:13 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5C12CV13719
	for <linux-mips@oss.sgi.com>; Mon, 11 Jun 2001 18:02:12 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id BC4723E90; Mon, 11 Jun 2001 17:58:44 -0700 (PDT)
Date: Mon, 11 Jun 2001 17:58:44 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Donovan Arellano <donovan@technodada.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: cross compile doc on sgi's site
Message-ID: <20010611175844.A6610@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0106111602210.6993-100000@grumpy.technodada.com>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 11, 2001 at 04:04:53PM -0800, Donovan Arellano wrote:

> Hi - there use to be a cross compile doc on the linux mips site. Does
> anyone have a copy of it or can you point me to the location that it
> lives.

There's a section on cross compiling in the FAQ/HOWTO at
http://oss.sgi.com/mips/mips-howto.html (section 10) which has been
there all along.

Or, you might see http://foobazco.org/~wesolows/mips-cross.html.

Of course you can always just follow standard GNU practice and pass
the requisite --target=mips-linux to configure and see what happens
(hint: it's close to all you need).

Or, you can pick up the make-cross package from
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev/, which
will do all the work for you, or one of a dozen similar pieces of
hackware out there.

Or read one of any number of other Google-accessible information
repositories with each author's own little tricks and tips for
building cross-toolchains.

There's really no excuse for anyone to keep asking about building
cross compilers.  Really, this stuff is as easy to find on the net as
pr0n and pyramid schemes.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
