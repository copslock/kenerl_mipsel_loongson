Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f32Lq1Z07990
	for linux-mips-outgoing; Mon, 2 Apr 2001 14:52:01 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f32LpvM07986;
	Mon, 2 Apr 2001 14:51:58 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0C54D7F8; Mon,  2 Apr 2001 23:51:56 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7B43CF035; Mon,  2 Apr 2001 23:48:50 +0200 (CEST)
Date: Mon, 2 Apr 2001 23:48:50 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010402234850.B25228@paradigm.rfc822.org>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <20010402151425.A8471@bacchus.dhis.org> <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses>; from kevink@mips.com on Mon, Apr 02, 2001 at 09:20:44PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 02, 2001 at 09:20:44PM +0200, Kevin D. Kissell wrote:

> "Let them eat cake".  My Athlon is an order of magnitude
> faster than my 4Kc, and several times faster than my
> Algor/R5260.  It also has much more memory and a
> CD-RW unit for backup, unlike my MIPS boxes.  As
> MIPS/Linux becomes more an embedded platform
> and less an SGI/DEC legacy platform, people are in
> general not going to put up with being forced to buy
> old Indy's to do their target application work!

In not so far future their will be an complete distribution for both
endianesses available (and even kept up to date) containing everything
you need. Debian even now has cross-binutils available for mipsel and
just a couple of mails would be required to come with cross-binutils for
mips too. Compiling a cross-compiler from the debian gcc source package
is described somewhere (Just a matter of a single line imho)

Cross-compilation is IMHO so broken when it comes to userspace
than noone really thinking of having something reusable would
consider this. It all ends beeing a really ugly hack.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
