Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5C14cN14168
	for linux-mips-outgoing; Mon, 11 Jun 2001 18:04:38 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5C14bV14162
	for <linux-mips@oss.sgi.com>; Mon, 11 Jun 2001 18:04:37 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 09BF23E90; Mon, 11 Jun 2001 18:01:09 -0700 (PDT)
Date: Mon, 11 Jun 2001 18:01:09 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Florian Lohoff <flo@rfc822.org>, Keith Owens <kaos@ocs.com.au>,
   linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010611180109.B6610@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1010612025658.18298A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 12, 2001 at 03:01:32AM +0200, Maciej W. Rozycki wrote:

>  Good it has a way to override the default, but wouldn't looking for
> objdump in the PATH variable (i.e. using execvp()) be more reasonable?
> This way ksymoops would always work in a cross-compilation environment
> (i.e. with $tooldir/bin preceding $bindir in PATH).

Actually, it would probably be preferable to try first arch-os-objdump
and maybe one or two other similar variants and then search the path.
Supposing I have multiple cross environments on my machine...

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
