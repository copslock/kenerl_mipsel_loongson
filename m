Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 06:27:52 +0100 (CET)
Received: from p508B6A78.dip.t-dialin.net ([80.139.106.120]:12673 "EHLO
	p508B6A78.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122165AbSKHF1v>; Fri, 8 Nov 2002 06:27:51 +0100
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S868139AbSKHF1S>; Fri, 8 Nov 2002 06:27:18 +0100
Date: Fri, 8 Nov 2002 06:27:17 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Wayne Gowcher <wgowcher@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: Enabling pthreads to use ll/sc instead of emulate_load_store_insn
Message-ID: <20021108062717.A3489@bacchus.dhis.org>
References: <20021108035234.34238.qmail@web11903.mail.yahoo.com> <20021108061233.A3314@bacchus.dhis.org> <20021107211759.A6082@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021107211759.A6082@lucon.org>; from hjl@lucon.org on Thu, Nov 07, 2002 at 09:17:59PM -0800
X-Accept-Language: de,en,fr
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 07, 2002 at 09:17:59PM -0800, H. J. Lu wrote:

> > Rebuild it with -mips2.  The inline code in glibc is coded such that it'll
> > automatically use ll/sc then.
> 
> I believe I enabled ll/sc unconditinally in glibc. Make sure you use
> a recent glibc. The one from my RedHat 7.3 port should be ok.

That's a relativly recent change.  Wayne's libc obviously predates this
change ...

  Ralf
