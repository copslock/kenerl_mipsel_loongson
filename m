Received:  by oss.sgi.com id <S553840AbQJNQNY>;
	Sat, 14 Oct 2000 09:13:24 -0700
Received: from u-97.karlsruhe.ipdial.viaginterkom.de ([62.180.10.97]:32522
        "EHLO u-97.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553837AbQJNQNN>; Sat, 14 Oct 2000 09:13:13 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870076AbQJNQM5>;
        Sat, 14 Oct 2000 18:12:57 +0200
Date:   Sat, 14 Oct 2000 18:12:57 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jay Carlson <nop@nop.com>
Cc:     Jay Carlson <nop@place.org>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001014181257.C6499@bacchus.dhis.org>
References: <20001014170928.B6499@bacchus.dhis.org> <KEEOIBGCMINLAHMMNDJNGECBCAAA.nop@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <KEEOIBGCMINLAHMMNDJNGECBCAAA.nop@nop.com>; from nop@nop.com on Sat, Oct 14, 2000 at 12:11:39PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 12:11:39PM -0400, Jay Carlson wrote:

> > Actually I'm trying to kill this entire naming problem by getting all
> > patches back to the respective maintainers.  Result:  no pending patches
> > for cvs binutils, only tiny ones for glibc-current and egcs-current.
> 
> What's going to happen to glibc 2.0.6?  I suspect the embedded people are
> going to be stuck using it until we figure out how to trim down the binary
> size of 2.2.

Which why I guess we still have to maintain it for a while or even come
up with some alternative small libc.

  Ralf
