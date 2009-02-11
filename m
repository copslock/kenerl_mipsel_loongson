Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Feb 2009 13:16:55 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:29864 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21102849AbZBKNQw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Feb 2009 13:16:52 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n1BDGorj001775;
	Wed, 11 Feb 2009 13:16:50 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n1BDGnDD001773;
	Wed, 11 Feb 2009 13:16:49 GMT
Date:	Wed, 11 Feb 2009 13:16:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	naresh kamboju <naresh.kernel@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: cacheflush system call-MIPS
Message-ID: <20090211131649.GA1365@linux-mips.org>
References: <f5a7b3810902100716t2658ce95t2dcc7f85634522@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a7b3810902100716t2658ce95t2dcc7f85634522@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 10, 2009 at 08:46:58PM +0530, naresh kamboju wrote:

> Hi Mr. Ralf,
> 
> I have tried to test cacheflush system call to generate EINVAL
> 
> on Toshiba RBTX4927/RBTX4937 board with 2.6.23 kernel.
> 
> I have referred latest Man pages there is a bug column.
> 
> Please let me know whether this is bug in source code or in the man page.
> 
> (arch/mips/mm/cache.c)

The answer is probably a bit of both.  The API and error behaviour was
defined by the earlier MIPS UNIX variant RISC/os or possibly even earlier.

Gcc relies on the existence of this syscall - or rather a library
function which usually will be implemented to execute this syscall because
the operating requires kernel priviledges - so Linux had to get an
implementation as well.

Now in practice there is only one good reason to perform explicit
cacheflushes from userspace and that's to ensure I-cache coherency and
that's the one thing the Linux implementation of cacheflush(2) is trying
to do.  Therefore the implementation ignores the cache argument and
will instead perform whatever is necessary to guarantee I-cache coherency -
whatever this means on a particlar implementation.

Similarly the implementation won't verify that every byte of the range
is accessible.  For a large range it instead may choose to perform a full
writeback / invalidation of some or all parts of the cache hierarchy
which might mean there will not be an error return even though part of
the address space may not be accessible.

Talking about bugs - the "BUGS" section of the man page is wrong.  A full
cacheflush is only performed if this is considered to be faster than a
cacheline-by-cacheline flush.

  Ralf
