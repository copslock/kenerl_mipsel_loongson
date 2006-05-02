Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 16:05:52 +0100 (BST)
Received: from alpha.total-knowledge.com ([205.217.158.170]:25990 "EHLO
	total-knowledge.com") by ftp.linux-mips.org with ESMTP
	id S8133712AbWEBPFm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 16:05:42 +0100
Received: (qmail 485 invoked from network); 2 May 2006 08:05:40 -0700
Received: from unknown (HELO ?10.50.163.242?) (ilya@209.157.142.204)
  by alpha.total-knowledge.com with ESMTPA; 2 May 2006 08:05:40 -0700
Message-ID: <4457753E.3020001@total-knowledge.com>
Date:	Tue, 02 May 2006 08:05:34 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mail/News 1.5 (X11/20060420)
MIME-Version: 1.0
To:	Michele Carla` <goldfinger@member.fsf.org>
CC:	linux-mips@linux-mips.org
Subject: Re: ip27 not working
References: <1146567955.3112.5.camel@localhost>
In-Reply-To: <1146567955.3112.5.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Plain git will not work. Check out Gentoo patch set
for kernel - there are few IP27-specific patches that
are absolutely required.
http://gentoo.osuosl.org/distfiles/mips-sources-generic_patches-1.21.tar.bz2

Although I have to say that latest git even with relevant patches
applied gets me to starting init, but not further.

Michele Carla` wrote:
> Yesterday I have tried last 2.6 from git on a Origin-2000, I have
> xcompiled it with gcc-3.4, and booted it via tftpd with:
> "bootp(): console=ttyS0 root=/dev/sda1", but after downloading the
> kernel, it doesn't print anything and freeze ! any idea ?
>
> if needed I can provide an account on the Origin 
>
>   

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
