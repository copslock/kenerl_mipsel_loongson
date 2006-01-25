Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 23:18:48 +0000 (GMT)
Received: from outmail1.freedom2surf.net ([194.106.33.237]:13964 "EHLO
	outmail.freedom2surf.net") by ftp.linux-mips.org with ESMTP
	id S8133463AbWAYXSa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 23:18:30 +0000
Received: from [192.168.1.2] (i-195-137-81-187.freedom2surf.net [195.137.81.187])
	by outmail.freedom2surf.net (8.12.10/8.12.10) with ESMTP id k0PNMLch029388;
	Wed, 25 Jan 2006 23:22:21 GMT
Message-ID: <43D808EE.9040906@f2s.com>
Date:	Wed, 25 Jan 2006 23:25:34 +0000
From:	Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Russell King <rmk+lkml@arm.linux.org.uk>
CC:	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk>
In-Reply-To: <20060125200250.GA26443@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <spyro@f2s.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spyro@f2s.com
Precedence: bulk
X-list: linux-mips

Russell King wrote:

> This code generates more expensive shifts than our (ARMs) existing C
> version.  This is a backward step.
> 
> Basically, shifts which depend on a variable are more expensive than
> constant-based shifts.

arm26 will have the same problem here.
