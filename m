Received:  by oss.sgi.com id <S553822AbQKPB1v>;
	Wed, 15 Nov 2000 17:27:51 -0800
Received: from u-6.karlsruhe.ipdial.viaginterkom.de ([62.180.20.6]:55301 "EHLO
        u-6.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553687AbQKPB1e>; Wed, 15 Nov 2000 17:27:34 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868642AbQKPB1K>;
        Thu, 16 Nov 2000 02:27:10 +0100
Date:   Thu, 16 Nov 2000 02:27:10 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com
Subject: Re: Build failure for R3000 DECstation
Message-ID: <20001116022710.E6979@bacchus.dhis.org>
References: <20001115024358.A3182@bacchus.dhis.org> <Pine.GSO.3.96.1001115121537.25921A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1001115121537.25921A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Nov 15, 2000 at 12:18:57PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 15, 2000 at 12:18:57PM +0100, Maciej W. Rozycki wrote:

>  Great! -- I haven't thought of such a solution.  I'll prepare some code
> and see whether there are no races.  It should work fine, indeed.

I'm still not completly happy - it's a somewhat hackish solution.  I'm
thinking about a special file which can be mmaped into the process address
space and contains processor specific optimized code.  This also has other
uses.  One that comes to my mind are trampolines.  Right now we have to
make a syscall to flush the cache.  But on the RM7000 some cacheflush
operations are available in userspace.  I'm sure we can come up with more
uses.

  Ralf
