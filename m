Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 12:05:34 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:38301 "EHLO
	exterity.co.uk") by linux-mips.org with ESMTP id <S8225370AbVBWMFR>;
	Wed, 23 Feb 2005 12:05:17 +0000
Received: from [192.168.0.85] ([192.168.0.85]) by exterity.co.uk with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 23 Feb 2005 12:06:35 +0000
Subject: Re: Big Endian au1550
From:	JP Foster <jp.foster@exterity.co.uk>
To:	linux-mips@linux-mips.org
In-Reply-To: <000301c5199d$3154ad40$0300a8c0@Exterity.local>
References: <1109157737.16445.6.camel@localhost.localdomain>
	 <000301c5199d$3154ad40$0300a8c0@Exterity.local>
Content-Type: text/plain
Date:	Wed, 23 Feb 2005 12:05:13 +0000
Message-Id: <1109160313.16445.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2005 12:06:35.0500 (UTC) FILETIME=[1EF8A2C0:01C519A0]
Return-Path: <jpfoster@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jp.foster@exterity.co.uk
Precedence: bulk
X-list: linux-mips

Fair enough. Has anyone got big-endian au1xxx working ever?
I'm reasonably flexible to use mipsel, since this is a new board,
although all our other products are mipseb.

Since big doesn't work as far as I can see. This must a regression
as I'm sure I had built a running kernel a month or two back.
Currently building a pre-christmas linux-mips snapshot to see if that
works.

If that doesn't work I'll just start using a mipsel version as I would
be wary of using big endian if no one else is.

JP


On Wed, 2005-02-23 at 11:45 +0000, Ralf Baechle wrote:
>
>I recently rewrote the endianes selection in the Kconfig menus.  The
>individual platforms will now have to explicitly select
>SYS_SUPPORTS_LITTLE_ENDIAN rsp. SYS_SUPPORTS_BIG_ENDIAN to indicate
>which endianess they support.  I know that Alchemy supports big endian
>operation in hardware but no idea if all the Linux code is working
>properly, so I've been conservative and choose to limit the system
>to little endian until somebody reports big endianess support to be
>actually working.
>
>  Ralf
