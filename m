Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 06:18:21 +0100 (CET)
Received: from p508B6A78.dip.t-dialin.net ([80.139.106.120]:5249 "EHLO
	p508B6A78.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122165AbSKHFSU>; Fri, 8 Nov 2002 06:18:20 +0100
Received: from sccrmhc03.attbi.com ([IPv6:::ffff:204.127.202.63]:5077 "EHLO
	sccrmhc03.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S868139AbSKHFRs>; Fri, 8 Nov 2002 06:17:48 +0100
Received: from lucon.org ([12.234.88.146]) by sccrmhc03.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021108051759.GVHN3205.sccrmhc03.attbi.com@lucon.org>;
          Fri, 8 Nov 2002 05:17:59 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 628A42C57C; Thu,  7 Nov 2002 21:17:59 -0800 (PST)
Date: Thu, 7 Nov 2002 21:17:59 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Wayne Gowcher <wgowcher@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: Enabling pthreads to use ll/sc instead of emulate_load_store_insn
Message-ID: <20021107211759.A6082@lucon.org>
References: <20021108035234.34238.qmail@web11903.mail.yahoo.com> <20021108061233.A3314@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021108061233.A3314@bacchus.dhis.org>; from ralf@linux-mips.org on Fri, Nov 08, 2002 at 06:12:33AM +0100
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 08, 2002 at 06:12:33AM +0100, Ralf Baechle wrote:
> On Thu, Nov 07, 2002 at 07:52:34PM -0800, Wayne Gowcher wrote:
> 
> > The processor is an r4k and the application is being
> > compiled with mips2 switch, which I thought would
> > allow it to generate the ll/sc instructions natively
> > and not have to generate system calls to emulate it.
> > I am guessing this is because the pthread library I
> > have is from the sgi ftp site and it was compiled for
> > mips1 ??
> >
> > If someone has any insight into how to get libpthread
> > to use ll/sc instructions instead of the mips system
> > call I would really appreciate hearing from them.
> 
> Rebuild it with -mips2.  The inline code in glibc is coded such that it'll
> automatically use ll/sc then.

I believe I enabled ll/sc unconditinally in glibc. Make sure you use
a recent glibc. The one from my RedHat 7.3 port should be ok.


H.J.
