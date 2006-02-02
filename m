Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 15:00:47 +0000 (GMT)
Received: from smtp.innovsys.com ([66.115.232.196]:54207 "EHLO
	mail.innovsys.com") by ftp.linux-mips.org with ESMTP
	id S3465637AbWBBPA2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2006 15:00:28 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 10/44] generic fls64()
Date:	Thu, 2 Feb 2006 09:05:33 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859547@ismail.innsys.innovsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 10/44] generic fls64()
Thread-Index: AcYnkFHrC3JXjhzOTROGBLzY99BOuAAeZ/rA
From:	"Rune Torgersen" <runet@innovsys.com>
To:	"Akinobu Mita" <mita@miraclelinux.com>,
	<linux-kernel@vger.kernel.org>
Cc:	<linux-mips@linux-mips.org>, <linux-ia64@vger.kernel.org>,
	"Ian Molton" <spyro@f2s.com>,
	"David Howells" <dhowells@redhat.com>, <linuxppc-dev@ozlabs.org>,
	"Greg Ungerer" <gerg@uclinux.org>, <sparclinux@vger.kernel.org>,
	"Miles Bader" <uclinux-v850@lsi.nec.co.jp>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Yoshinori Sato" <ysato@users.sourceforge.jp>,
	"Hirokazu Takata" <takata@linux-m32r.org>,
	<linuxsh-shmedia-dev@lists.sourceforge.net>,
	<linux-m68k@lists.linux-m68k.org>,
	"Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
	"Richard Henderson" <rth@twiddle.net>,
	"Chris Zankel" <chris@zankel.net>, <dev-etrax@axis.com>,
	<ultralinux@vger.kernel.org>, "Andi Kleen" <ak@suse.de>,
	<linuxsh-dev@lists.sourceforge.net>, <linux390@de.ibm.com>,
	"Russell King" <rmk@arm.linux.org.uk>,
	<parisc-linux@parisc-linux.org>
Return-Path: <runet@innovsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: runet@innovsys.com
Precedence: bulk
X-list: linux-mips

> From: Akinobu Mita
> Sent: Wednesday, February 01, 2006 03:03
> +static inline int fls64(__u64 x)
> +{
> +	__u32 h = x >> 32;
> +	if (h)
> +		return fls(x) + 32;

Shouldn't this be return fls(h) + 32; ??
                            ^^^
> +	return fls(x);
> +}
> +
> +#endif /* _ASM_GENERIC_BITOPS_FLS64_H_ */
> 
> --
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
