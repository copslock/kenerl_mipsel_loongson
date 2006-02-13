Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 10:29:52 +0000 (GMT)
Received: from voldemort.codesourcery.com ([65.74.133.5]:15029 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S8133511AbWBMK3n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 10:29:43 +0000
Received: (qmail 5583 invoked by uid 1010); 13 Feb 2006 10:35:56 -0000
From:	Richard Sandiford <richard@codesourcery.com>
To:	Tomasz Chmielewski <mangoo@wpkg.org>
Mail-Followup-To: Tomasz Chmielewski <mangoo@wpkg.org>,David Daney <ddaney@avtrex.com>,  linux-mips@linux-mips.org, richard@codesourcery.com
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: native gcc for mipsel / uClibc (building or binaries)?
References: <43EF7C06.3080006@wpkg.org> <43EFA945.1030906@avtrex.com>
	<43EFAD1D.9010100@wpkg.org>
Date:	Mon, 13 Feb 2006 10:35:54 +0000
In-Reply-To: <43EFAD1D.9010100@wpkg.org> (Tomasz Chmielewski's message of
	"Sun, 12 Feb 2006 22:48:13 +0100")
Message-ID: <87slqnczqt.fsf@talisman.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <richard@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@codesourcery.com
Precedence: bulk
X-list: linux-mips

Tomasz Chmielewski <mangoo@wpkg.org> writes:
> Now, when I try to compile gcc (--build=i686-pc-linux-glibc
>  > --target=mipsel-linux --host=mipsel-linux), it breaks, as during the 
> build process gcc's ./configure has a schizophrenia: it tries to compile
> some parts for mipsel (as I'd expect), but it also tries to compile and
> execute the binaries during the build process.

Just to rule out one possibility, were the x86-hosted tools in
your path when you ran configure and make?  They need to be.

> This means, it creates some binaries/libs needed for the build process
> (like libiberty), then tries to run/use them, but as they are mipsel
> binaries, the build process breaks.

Recent versions compile two versions of libiberty, one for the build
machine and one for the host.  The build version is used for things
like genattrtab (a build-time tool used only to build gcc itself)
while the host version is linked into the final compilers.

Richard
