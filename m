Received:  by oss.sgi.com id <S553769AbRAHPJj>;
	Mon, 8 Jan 2001 07:09:39 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:44260 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553766AbRAHPJV>;
	Mon, 8 Jan 2001 07:09:21 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA02303;
	Mon, 8 Jan 2001 16:07:32 +0100 (MET)
Date:   Mon, 8 Jan 2001 16:07:31 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     linux-mips@oss.sgi.com, Carsten Langgaard <carstenl@mips.com>,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
In-Reply-To: <00d801c0797d$5cc410c0$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010108151854.23234G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 8 Jan 2001, Kevin D. Kissell wrote:

> Back in the Ancient Old Days of System V, every architecture
> had an architecture-specific system call entry, the first parameter
> of which expressed what needed to be done.  Do we have
> such a thing in Linux?   That would be the logical place to
> things like cache flush and the atomic operations that were
> being discussed here a couple of weeks ago.

 The only case caches need to be synchronized is modifying some code.  The
ptrace syscall does it automatically for text writes -- it's needed and
used by gdb to set breakpoints, for example.  For other code there is
cacheflush() which allows you to flush a cache range relevant to a given
virtual address (I see it's not implemented very well at the moment).

 Obviously, you don't want to allow unprivileged users to flush caches as
a whole as it could lead to a DoS. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
