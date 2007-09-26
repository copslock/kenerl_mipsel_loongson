Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 07:00:15 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:47625 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20022510AbXIZGAH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 07:00:07 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id AF0C7D8DF; Wed, 26 Sep 2007 05:59:30 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 08B40542CF; Wed, 26 Sep 2007 07:59:12 +0200 (CEST)
Date:	Wed, 26 Sep 2007 07:59:12 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
Message-ID: <20070926055912.GA3337@deprecation.cyrius.com>
References: <20070925181353.GA15412@deprecation.cyrius.com> <20070926.110814.41629599.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070926.110814.41629599.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Atsushi Nemoto <anemo@mba.ocn.ne.jp> [2007-09-26 11:08]:
> I think this is solved on current git a few weeks ago by this commit
> (not mainlined yet):
> > Subject: [MIPS] Fix CONFIG_BUILD_ELF64 kernels with symbols in CKSEG0.
> > Gitweb: http://www.linux-mips.org/g/linux/db423f6e
> It is just one liner and can be backported easily.

I put this into 2.6.22 and it works.  Thanks a lot for the link.

> I still think CONFIG_BUILD_ELF64=n is best choice.  You can get
> smaller and faster kernel with this.  Are there any reason to use
> CONFIG_BUILD_ELF64=y for IP32?

I don't know.  All I know is that it's enabled in the Debian kernel
for IP22 and IP32 and has broken the kernel.  Thiemo, do you remember
why this option is enabled in our kernels?

> (Note that CONFIG_BUILD_ELF64 and CONFIG_BOOT_ELF64 is separate
> thing.)

Yeah, I'm aware of this.  We want to keep CONFIG_BOOT_ELF64 but I'm
happy to turn CONFIG_BUILD_ELF64 off in the Debian kernel if Thiemo
agrees.

Thanks for your response.
-- 
Martin Michlmayr
http://www.cyrius.com/
