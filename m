Received:  by oss.sgi.com id <S553771AbRCLLuP>;
	Mon, 12 Mar 2001 03:50:15 -0800
Received: from u-21-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.21]:64262
        "EHLO u-21-19.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553763AbRCLLuF>; Mon, 12 Mar 2001 03:50:05 -0800
Received: from dea ([193.98.169.28]:1664 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S869540AbRCLLti>;
	Mon, 12 Mar 2001 12:49:38 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2C9n3201304;
	Mon, 12 Mar 2001 10:49:03 +0100
Date:	Mon, 12 Mar 2001 10:49:03 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Klaus Naumann <spock@mgnet.de>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Failure 2.4.2 + glibc 2.2 still illegal instruction
Message-ID: <20010312104903.A1235@bacchus.dhis.org>
References: <20010310205028.B16121@paradigm.rfc822.org> <Pine.LNX.4.21.0103102131450.24319-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103102131450.24319-100000@spock.mgnet.de>; from spock@mgnet.de on Sat, Mar 10, 2001 at 09:34:00PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Mar 10, 2001 at 09:34:00PM +0100, Klaus Naumann wrote:

> > strace shows that the last system call called is
> > "sysmips(MIPS_ATOMIC_SET, ...)"
> 
> I have tried building strace but failed. What is your code base ? 

What is the sympthom?  I've tried strace from CVS on a mips64 kernel and
it works almost perfectly.

  Ralf
