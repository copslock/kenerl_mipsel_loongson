Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2009 18:14:00 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50628 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21365683AbZBNSN5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Feb 2009 18:13:57 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n1EIDu9O025733;
	Sat, 14 Feb 2009 18:13:56 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n1EIDtpb025731;
	Sat, 14 Feb 2009 18:13:55 GMT
Date:	Sat, 14 Feb 2009 18:13:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Randrianasulu <randrik_a@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: gcc-4.4 svn and 2.6.29-rc4 compile error
Message-ID: <20090214181355.GA12982@linux-mips.org>
References: <549158.21115.qm@web59815.mail.ac4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549158.21115.qm@web59815.mail.ac4.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 13, 2009 at 03:10:13PM -0800, Andrew Randrianasulu wrote:

> and restart make with with LANG=C give this
> 
> guest@slax:/mnt/hdb1/src/linux-git/linux-2.6$ make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu- 
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   SYMLINK include/asm -> include/asm-mips
>   Checking missing-syscalls for O32
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CC      arch/mips/sgi-ip32/ip32-reset.o
> cc1: warnings being treated as errors
> arch/mips/sgi-ip32/ip32-reset.c: In function 'debounce':
> arch/mips/sgi-ip32/ip32-reset.c:97: error: 'reg_a' is used uninitialized in this function
> make[1]: *** [arch/mips/sgi-ip32/ip32-reset.o] Error 1
> make: *** [arch/mips/sgi-ip32] Error 2
> 
> Is this known error? Or I should downgrade toolchain/kernel?

The error message is correct.  Congratulations, you (or gcc) have found a
bug that's lurking in the kernel since April 7, 2003 :-)

  Ralf
