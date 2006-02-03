Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 08:28:29 +0000 (GMT)
Received: from mail.domino-uk.com ([193.131.116.193]:43535 "EHLO
	vMIMEsweeper.dps.local") by ftp.linux-mips.org with ESMTP
	id S8133350AbWBCI2K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 08:28:10 +0000
Received: from dps-exchange1.dps.local (dps-exchange1) by vMIMEsweeper.dps.local
 (Clearswift SMTPRS 5.0.4) with ESMTP id <T763b741b76c18374c1ba8@vMIMEsweeper.dps.local>;
 Fri, 3 Feb 2006 08:33:25 +0000
Received: from emea-exchange3.emea.dps.local ([192.168.50.10]) by dps-exchange1.dps.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 3 Feb 2006 08:33:25 +0000
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 3 Feb 2006 09:26:27 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Date:	Fri, 3 Feb 2006 09:31:42 +0100
User-Agent: KMail/1.8.3
Cc:	linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
References: <20060201090224.536581000@localhost.localdomain> <20060201090325.905071000@localhost.localdomain>
In-Reply-To: <20060201090325.905071000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602030931.43686.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 03 Feb 2006 08:26:27.0578 (UTC) FILETIME=[86F36DA0:01C6289B]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:
> unsigned int hweight32(unsigned int w);
> unsigned int hweight16(unsigned int w);
> unsigned int hweight8(unsigned int w);
> unsigned long hweight64(__u64 w);

IMHO, this should use explicitly sized integers like __u8, __u16 etc, unless 
there are stringent reasons like better register use - which is hard to tell 
for generic C code. Also, why on earth is the returntype for hweight64 a 
long?

> +static inline unsigned int hweight32(unsigned int w)
> +{
> +        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
> +        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
[...]

Why not use unsigned constants here?

> +static inline unsigned long hweight64(__u64 w)
> +{
[..]
> +	u64 res;
> +	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);

Why not use initialisation here, too?

just my 2c

Uli
