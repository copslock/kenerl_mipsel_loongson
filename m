Received:  by oss.sgi.com id <S554041AbRAWRNl>;
	Tue, 23 Jan 2001 09:13:41 -0800
Received: from sgigate.SGI.COM ([204.94.209.1]:49532 "EHLO
        gate-sgigate.sgi.com") by oss.sgi.com with ESMTP id <S554038AbRAWRNY>;
	Tue, 23 Jan 2001 09:13:24 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870753AbRAWRLC>; Tue, 23 Jan 2001 09:11:02 -0800
Date:	Tue, 23 Jan 2001 09:11:02 -0800
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"James McD" <vile8@hotmail.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Fwd: pthread in glibc 2.2.1
Message-ID: <20010123091102.D945@bacchus.dhis.org>
References: <F69IBJYduiFPUEOYMui000010a7@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F69IBJYduiFPUEOYMui000010a7@hotmail.com>; from vile8@hotmail.com on Mon, Jan 22, 2001 at 12:07:32AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> >even the simplest pthread-program dies with a bus error(see attachment)
> >on my I2.  glibc is 2.2.1(same for 2.1.97), kernel is 2.4.0-test9.
> >Interesting enough I can't even get a core dump. Any starting points to
> >track this down?

Last I checked the kernel didn't dump core for multithreaded programs
since the core file's data structure doesn't support that yet.

  Ralf
