Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 20:30:06 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48005 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491876Ab0KDTaD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Nov 2010 20:30:03 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA4JTiml028529;
        Thu, 4 Nov 2010 19:29:45 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA4JThru028526;
        Thu, 4 Nov 2010 19:29:43 GMT
Date:   Thu, 4 Nov 2010 19:29:43 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Robert Millan <rmh@gnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
Message-ID: <20101104192943.GA28245@linux-mips.org>
References: <1288873119.12965.1@thorin>
 <4CD2E2F7.4090701@caviumnetworks.com>
 <4CD2EE64.5060404@aurel32.net>
 <AANLkTik3SH8EmhcgY9HNQLLk9Np+E6LGo8jVoGQiQCx4@mail.gmail.com>
 <4CD30551.1000006@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CD30551.1000006@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 04, 2010 at 12:11:13PM -0700, David Daney wrote:

> >Well I appreciate consistency with GCC flag names, so I'd rather keep
> >the dash, but then again it's not my decision to make.  In any case,
> >whoever commits this can adjust the name to his/her liking.
> 
> I don't like to put words into Ralf's mouth, but it is easier to
> work with patches that have been tested and are ready to go, rather
> than having to re-write everything.

Indeed.  I modify lots of patches that I can't test on my hardware
collection so any change I have to do also increases of me adding bugs.
Heck, I do most of my builds on fairly modest dual core machines so I
can't even afford test builds which is how occasionally the most stupid
errors end up getting committed.

Which is why I'm increasingly asking people to do trivial changes to
patches, not because I'm lazy.

> Some of the strings in use are "i686", "x86_64", "octeon",
> "octeon2", "PARISC", "PARISC32", tilegx-m32", "v4l", "v3l", "v4b",
> and "v3b", these last for for ARM and they don't match the GCC
> -mcpu= values.
> 
> So I guess what ever you want.

It's probably reasonable if the names don't diverge too far from each
other.  Then again with the number of cpu type synonyms accepted by gcc
that may just be wishful thinking.

  Ralf
