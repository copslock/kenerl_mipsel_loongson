Received:  by oss.sgi.com id <S42209AbQGIDOZ>;
	Sat, 8 Jul 2000 20:14:25 -0700
Received: from u-55.karlsruhe.ipdial.viaginterkom.de ([62.180.20.55]:49668
        "EHLO u-55.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42185AbQGIDOE>; Sat, 8 Jul 2000 20:14:04 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S639484AbQGIDNt>;
        Sun, 9 Jul 2000 05:13:49 +0200
Date:   Sun, 9 Jul 2000 05:13:49 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     clemej <clemej@mail.alum.rpi.edu>
Cc:     linux-mips@oss.sgi.com
Subject: Re: compilers...
Message-ID: <20000709051349.A4950@bacchus.dhis.org>
References: <200007070831.AA21955154@mail.alum.rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200007070831.AA21955154@mail.alum.rpi.edu>; from clemej@mail.alum.rpi.edu on Fri, Jul 07, 2000 at 08:31:17AM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jul 07, 2000 at 08:31:17AM -0400, clemej wrote:

> whats the word on using CVS binutils and CVS gcc (2.96?) for 
> compiling mips64?

You need special patches for cvs-gcc and cvs-binutils.  We're working
on getting them in but the gcc people don't seem to listen.

  Ralf
