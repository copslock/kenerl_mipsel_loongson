Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f85HGk826947
	for linux-mips-outgoing; Wed, 5 Sep 2001 10:16:46 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f85HGhd26938
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 10:16:43 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A8CF77F5; Wed,  5 Sep 2001 19:16:40 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id CC3954608; Wed,  5 Sep 2001 19:15:50 +0200 (CEST)
Date: Wed, 5 Sep 2001 19:15:50 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Jim Paris <jim@jtan.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: segfault
Message-ID: <20010905191550.B1054@paradigm.rfc822.org>
References: <20010904235410.A8310@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010904235410.A8310@neurosis.mit.edu>
User-Agent: Mutt/1.3.20i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Sep 04, 2001 at 11:54:10PM -0400, Jim Paris wrote:
> 
> do_page_fault( )#2: sending SIGSEGV to test-prog for illegal write
> access to 00000fd4 (epc == 004027b8, ra == 00402730)
> 
> The strange part about this (and the reason why I suspect someone may
> be able to help me) is that the address 00000fd4 is always the same,
> implying that the binaries are all failing in the same way.  Has
> anyone seen this or does anyone have any ideas why this may be
> happening?

Do you have a fix for the sysmips(MIPS_ATOMIC_SET) in there ? Or do
you have the glibc compiled as -mips2 for usage of ll/sc ?

This bug might be a register corruption due to wrong return path
in the sysmips case.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
