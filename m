Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2QB3sB14271
	for linux-mips-outgoing; Tue, 26 Mar 2002 03:03:54 -0800
Received: from lists.samba.org (samba.sourceforge.net [198.186.203.85])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2QB3nq14268
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 03:03:49 -0800
Received: by lists.samba.org (Postfix, from userid 1020)
	id CCFE0467B; Tue, 26 Mar 2002 02:53:12 -0800 (PST)
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15520.21196.511499.316840@argo.ozlabs.ibm.com>
Date: Tue, 26 Mar 2002 21:51:56 +1100 (EST)
To: Theodore Tso <tytso@mit.edu>
Cc: Andrew Morton <akpm@zip.com.au>, "H . J . Lu" <hjl@lucon.org>,
   linux-mips@oss.sgi.com, linux kernel <linux-kernel@vger.kernel.org>,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
In-Reply-To: <20020326015440.A12162@thunk.org>
References: <20020323140728.A4306@lucon.org>
	<3C9D1C1D.E30B9B4B@zip.com.au>
	<20020323221627.A10953@lucon.org>
	<3C9D7A42.B106C62D@zip.com.au>
	<20020324012819.A13155@lucon.org>
	<20020325003159.A2340@thunk.org>
	<3C9EB8F6.247C7C3B@zip.com.au>
	<20020326015440.A12162@thunk.org>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Theodore Tso writes:

> 3)  RLIMIT_FILESIZE should not apply to block devices!!!

Absolutely.

I would go further and say that it should only apply to writes to a
regular file that would extend the file past the filesize limit.  At
the moment the check in generic_file_write is simply whether the file
offset is greater than the limit, or would be greater than the limit
after the write.  This doesn't seem right to me.  If, for example, my
RLIMIT_FILESIZE is 1MB, and I have write access to an existing 100MB
file, I think I should be able to write anywhere in that file as long
as I don't try to extend it.

If we did that then the block device case would fall out, since you
can't extend block devices (not by writing past the end of them
anyway).

Paul.
