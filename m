Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Oct 2002 19:53:51 +0200 (CEST)
Received: from 12-234-88-146.client.attbi.com ([12.234.88.146]:57069 "EHLO
	lucon.org") by linux-mips.org with ESMTP id <S1123398AbSJKRxu>;
	Fri, 11 Oct 2002 19:53:50 +0200
Received: by lucon.org (Postfix, from userid 1000)
	id BDDCA2C4EC; Fri, 11 Oct 2002 10:53:32 -0700 (PDT)
Date: Fri, 11 Oct 2002 10:53:32 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Lyle Bainbridge <lyle@zevion.com>
Cc: linux-mips@linux-mips.org
Subject: Re: GCC 3.2 to build mips-linux kernel
Message-ID: <20021011105332.A11498@lucon.org>
References: <NCBBKGDBOEEBDOELAFOFAEPMDAAA.lyle@zevion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NCBBKGDBOEEBDOELAFOFAEPMDAAA.lyle@zevion.com>; from lyle@zevion.com on Fri, Oct 11, 2002 at 12:34:53PM -0500
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 11, 2002 at 12:34:53PM -0500, Lyle Bainbridge wrote:
> 
> I built a mips-linix 2.4.18 kernel for an AU1500 board using:
>   gcc-3.2  /   binutils-2.13   /   glibc-2.2.5
		^^^^^^^^^^^^^^^
		Bad choice.
> 
> It builds and executes but is unsuccessful during startup.
> I have attached the log at the end of this message.  It
> appears to have skipped a number of steps.  I noticed that
> a working kernel built with gcc 2.95.3 is 800K larger.
> (~3MB versus !2.2MB).
> 
> I'm a little confused, and wondered if the 3.2 compiler requires
> some patching to work for mips-linux.
> 

gcc 3.2 I released for Linux/mips builds 2.4.20-pre6 kernel for malta
just fine. But you are strongly recommended to use my latest Linux
binutils.


H.J.
