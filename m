Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 06:13:10 +0100 (CET)
Received: from p508B6A78.dip.t-dialin.net ([80.139.106.120]:64896 "EHLO
	p508B6A78.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122165AbSKHFNJ>; Fri, 8 Nov 2002 06:13:09 +0100
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S868139AbSKHFMd>; Fri, 8 Nov 2002 06:12:33 +0100
Date: Fri, 8 Nov 2002 06:12:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Enabling pthreads to use ll/sc instead of emulate_load_store_insn
Message-ID: <20021108061233.A3314@bacchus.dhis.org>
References: <20021108035234.34238.qmail@web11903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021108035234.34238.qmail@web11903.mail.yahoo.com>; from wgowcher@yahoo.com on Thu, Nov 07, 2002 at 07:52:34PM -0800
X-Accept-Language: de,en,fr
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 07, 2002 at 07:52:34PM -0800, Wayne Gowcher wrote:

> The processor is an r4k and the application is being
> compiled with mips2 switch, which I thought would
> allow it to generate the ll/sc instructions natively
> and not have to generate system calls to emulate it.
> I am guessing this is because the pthread library I
> have is from the sgi ftp site and it was compiled for
> mips1 ??
>
> If someone has any insight into how to get libpthread
> to use ll/sc instructions instead of the mips system
> call I would really appreciate hearing from them.

Rebuild it with -mips2.  The inline code in glibc is coded such that it'll
automatically use ll/sc then.

  Ralf
