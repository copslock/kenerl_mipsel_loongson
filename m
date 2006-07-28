Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 20:41:50 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62876 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8134075AbWG1Tlk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Jul 2006 20:41:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k6SJg6PQ003415;
	Fri, 28 Jul 2006 15:42:06 -0400
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k6SJg4c1003414;
	Fri, 28 Jul 2006 15:42:04 -0400
Date:	Fri, 28 Jul 2006 15:42:04 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ricardo Nabinger Sanchez <rnsanchez@gmail.com>
Cc:	freebsd-mips@freebsd.org, linux-mips@linux-mips.org
Subject: Re: ld: cannot open crt1.o
Message-ID: <20060728194204.GA28080@linux-mips.org>
References: <20060728162202.4567446d.rnsanchez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728162202.4567446d.rnsanchez@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@denk.linux-mips.net.redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 28, 2006 at 04:22:02PM -0300, Ricardo Nabinger Sanchez wrote:

> I'm trying to get my mipsel-linux environment to work, but no success:
>
> % mipsel-linux-gcc test.c
> /usr/local/lib/gcc-lib/mipsel-linux/2.97/../../../../mipsel-linux/bin/ld:
> cannot open crt1.o: No such file or directory
> collect2: ld returned 1 exit status
> Exit 1
> 
> % cat test.c 
> int main() {
>         return 0;
> }
> 
> % fgrep crt1.o -r /var/db/pkg/mipsel-linux-*
> Exit 1
> 
> Here there's only the crt1.o from the base gcc (not the MIPS one):
> % find /usr -type f -name crt1.o
> /usr/lib/crt1.o
> 
> 
> I feel like clearly missing something very basic here.  Aren't these ports
> enough?
> 
> 	devel/mipsel-linux-binutils
> 	devel/mipsel-linux-gcc
> 	devel/mipsel-linux-kernel-headers

crt1.o is part of glibc; you only seem to have installed cross versions of
binutils and gcc.

  Ralf
