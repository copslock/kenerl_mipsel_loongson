Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 18:31:11 +0000 (GMT)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:60685 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225403AbVBWSa4>;
	Wed, 23 Feb 2005 18:30:56 +0000
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Wed, 23 Feb 2005 10:30:55 -0800
Received: by miles.echelon.com with Internet Mail Service (5.5.2653.19)
	id <19FLPZRC>; Wed, 23 Feb 2005 10:30:53 -0800
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB5901654513@miles.echelon.com>
From:	Prashant Viswanathan <vprashant@echelon.com>
To:	'JP Foster' <jp.foster@exterity.co.uk>, linux-mips@linux-mips.org
Subject: RE: Big Endian au1550
Date:	Wed, 23 Feb 2005 10:30:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips


 
> On Wed, 2005-02-23 at 11:45 +0000, Ralf Baechle wrote:
> >
> >I recently rewrote the endianes selection in the Kconfig menus.  The
> >individual platforms will now have to explicitly select
> >SYS_SUPPORTS_LITTLE_ENDIAN rsp. SYS_SUPPORTS_BIG_ENDIAN to indicate
> >which endianess they support.  I know that Alchemy supports big endian
> >operation in hardware but no idea if all the Linux code is working
> >properly, so I've been conservative and choose to limit the system
> >to little endian until somebody reports big endianess support to be
> >actually working.
> >
> >  Ralf
>
>
> Fair enough. Has anyone got big-endian au1xxx working ever?
> I'm reasonably flexible to use mipsel, since this is a new board,
> although all our other products are mipseb.
> 
> Since big doesn't work as far as I can see. This must a regression
> as I'm sure I had built a running kernel a month or two back.
> Currently building a pre-christmas linux-mips snapshot to see if that
> works.
> 
> If that doesn't work I'll just start using a mipsel version as I would
> be wary of using big endian if no one else is.
> 
> JP

I have Au1550 running in big endian mode and Linux kernel running on it. The
Linux kernel was compiled big endian using BE toolchain.

Prashant
