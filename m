Received:  by oss.sgi.com id <S42195AbQJLVGZ>;
	Thu, 12 Oct 2000 14:06:25 -0700
Received: from u-151.karlsruhe.ipdial.viaginterkom.de ([62.180.18.151]:51719
        "EHLO u-151.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42185AbQJLVGR>; Thu, 12 Oct 2000 14:06:17 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868674AbQJLVFU>;
        Thu, 12 Oct 2000 23:05:20 +0200
Date:   Thu, 12 Oct 2000 23:05:20 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Ian Chilton <mailinglist@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: Patches for CVS Glibc, Binutils, GCC
Message-ID: <20001012230520.B21634@bacchus.dhis.org>
References: <20001011181738.A22525@woody.ichilton.co.uk> <20001012063012.A14443@bacchus.dhis.org> <20001012154830.A24509@woody.ichilton.co.uk> <39E66230.C6010B25@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39E66230.C6010B25@mvista.com>; from jsun@mvista.com on Thu, Oct 12, 2000 at 06:15:28PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 12, 2000 at 06:15:28PM -0700, Jun Sun wrote:

> > humm...any chance you could have a directory on oss, where you always stick the patches when they are updated...maybe also a text file, with the date it was last changed...

> I agree.  A common way of doing it is to have a patch named after a
> date, which inidicates the patch can be applied against the CVS tree on
> that date.

In general all those patches are only fairly shortlived.  They're intended
to be tested and will then go into back to their original maintainers.
And probably noone of the hackers really like producing a large extra
administrative overhead to extra bookkeeping work ...

  Ralf
