Received:  by oss.sgi.com id <S553760AbQJPBID>;
	Sun, 15 Oct 2000 18:08:03 -0700
Received: from u-227.karlsruhe.ipdial.viaginterkom.de ([62.180.21.227]:7691
        "EHLO u-227.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553700AbQJPBHt>; Sun, 15 Oct 2000 18:07:49 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868868AbQJPBHc>;
        Mon, 16 Oct 2000 03:07:32 +0200
Date:   Mon, 16 Oct 2000 03:07:32 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001016030732.H15377@bacchus.dhis.org>
References: <20001014181257.C6499@bacchus.dhis.org> <29516.971567257@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <29516.971567257@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Sun, Oct 15, 2000 at 10:47:37AM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Oct 15, 2000 at 10:47:37AM +1100, Keith Owens wrote:

> >Which why I guess we still have to maintain it for a while or even come
> >up with some alternative small libc.
> 
> Is there any reason that newlib is not being used for embedded systems?
> That is what it was developed for.  There is some MIPS support in
> newlib, I have no idea if it is complete but it would be better than
> starting from scratch.  http://sources.redhat.com/newlib/

Newlib, the libraries from eCOS and also libstand from NetBSD are three
candidates I know of.  I'm also interested in those small libraries as
the base for a standalone library that runs directly on the ARC firmware
or other firmware.

  Ralf
