Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 11:31:09 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:36118 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225359AbVBWLaz>; Wed, 23 Feb 2005 11:30:55 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1NBNe6B008282;
	Wed, 23 Feb 2005 11:23:40 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1NBNd18008281;
	Wed, 23 Feb 2005 11:23:39 GMT
Date:	Wed, 23 Feb 2005 11:23:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	JP Foster <jp.foster@exterity.co.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: Big Endian au1550
Message-ID: <20050223112339.GD6327@linux-mips.org>
References: <1109157737.16445.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109157737.16445.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 23, 2005 at 11:22:16AM +0000, JP Foster wrote:

> Hi all,
> In the linux-mips cvs big endian operation of the au1550 is not
> selectable. Is there a reason for this?
> what would I need to do to get big endian support?
> 
> The chip does run big endian, as I have yamon running on it here.
> And a previously the linux-mips kernel allowed this.
> The kernel will compile big end but I get an oops as the kernel
> starts up 

I recently rewrote the endianes selection in the Kconfig menus.  The
individual platforms will now have to explicitly select
SYS_SUPPORTS_LITTLE_ENDIAN rsp. SYS_SUPPORTS_BIG_ENDIAN to indicate
which endianess they support.  I know that Alchemy supports big endian
operation in hardware but no idea if all the Linux code is working
properly, so I've been conservative and choose to limit the system
to little endian until somebody reports big endianess support to be
actually working.

  Ralf
