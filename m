Received:  by oss.sgi.com id <S553725AbQJRB6D>;
	Tue, 17 Oct 2000 18:58:03 -0700
Received: from u-237.karlsruhe.ipdial.viaginterkom.de ([62.180.18.237]:46093
        "EHLO u-237.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553705AbQJRB5x>; Tue, 17 Oct 2000 18:57:53 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868617AbQJRB5T>;
        Wed, 18 Oct 2000 03:57:19 +0200
Date:   Wed, 18 Oct 2000 03:57:19 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: The initial results (Re: stable binutils, gcc, glibc ...
Message-ID: <20001018035719.F7865@bacchus.dhis.org>
References: <39E7EB73.9206D0DB@mvista.com> <39ED2166.9B5F970@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39ED2166.9B5F970@mvista.com>; from jsun@mvista.com on Tue, Oct 17, 2000 at 09:04:54PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 17, 2000 at 09:04:54PM -0700, Jun Sun wrote:

> (Ralf, you cannot find egcs-1.0.3a.tar.gz release on the net anymore. 
> You probably want to save this file on the same site with the diff
> file.)

1.0.3a is part of the srpm packages on oss.

> c) glibc 2.0.6 + mips patch
> 
> ftp://oss.sgi.com/pub/linux/mips/glibc/srpms/glibc-2.0.6-5lm.src.rpm

I have a glibc-2.0.6-7lm almost ready, still needs some more testing.

> I also had success with latest binutils CVS tree.  I gave a try to the
> latest gcc, but did not look into it further.

Same here with a tree that is a few days old.  I haven't yet tried to 
build a kernel but for userland I have no relevant problem compared
to 2.8.1 but tons of fixed ones.

One ancient bug which is about to become a serious one still exist in
gas.  Gas doesn't properly handle branch that exceed the +/- 128kb
range that can be encoded in the 16-bit branch offset.  It should
(SGI's as does) expand the branch as a macro instruction like this:

loop:
	[...]
	beq	r1, r2, loop

should be turned into:

loop:
	[...]
	bnez	r1, r2, 1f
	j	loop
1:

but of course only if the branch destination is outside the 16-bit range.
Thanks to the ever increasing code size there are now several realworld
examples which run into this problem.  Volunteers?

  Ralf
