Received:  by oss.sgi.com id <S553822AbQJNMOA>;
	Sat, 14 Oct 2000 05:14:00 -0700
Received: from u-118.karlsruhe.ipdial.viaginterkom.de ([62.180.21.118]:47881
        "EHLO u-118.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553817AbQJNMNv>; Sat, 14 Oct 2000 05:13:51 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870072AbQJNMNc>;
        Sat, 14 Oct 2000 14:13:32 +0200
Date:   Sat, 14 Oct 2000 14:13:32 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: ld problem
Message-ID: <20001014141332.B4396@bacchus.dhis.org>
References: <20001014011056.A27588@woody.ichilton.co.uk> <20001014123233.B4407@bacchus.dhis.org> <20001014130452.B28429@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001014130452.B28429@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Sat, Oct 14, 2000 at 01:04:52PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 01:04:52PM +0100, Ian Chilton wrote:

> > Which is probably the root of the evil - I assume at the point when it's
> > crashing the new /etc/ld.so.conf file is still incomplete.  I don't have
> > a theory what's causing that, sorry.
> 
> Do you think it could be something to do with the glibc-2.0.6-5lm?
> 
> or, what about ld.so?  I think I compiled v1.9.9

That explains it.  Don't use the ld.so package at all.  glibc has it's
own dynamic linker.

  Ralf
