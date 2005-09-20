Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 16:00:27 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:33558 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225202AbVITPAA>; Tue, 20 Sep 2005 16:00:00 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8KExroO013859;
	Tue, 20 Sep 2005 15:59:53 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8KExm3e013832;
	Tue, 20 Sep 2005 15:59:48 +0100
Date:	Tue, 20 Sep 2005 15:59:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Michael Uhler <uhler@mips.com>
Cc:	"'Matej Kupljen'" <matej.kupljen@ultra.si>,
	"'Maciej W. Rozycki'" <macro@linux-mips.org>,
	"'Daniel Jacobowitz'" <dan@debian.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix TCP/UDP checksums on the Broadcom SB-1
Message-ID: <20050920145948.GF3159@linux-mips.org>
References: <20050920110609.GB3159@linux-mips.org> <00da01c5bdef$596ee380$0502a8c0@MIPS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00da01c5bdef$596ee380$0502a8c0@MIPS.COM>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 20, 2005 at 07:26:54AM -0700, Michael Uhler wrote:

> For what it's worth, the 64-bit architecture, both prior to and with MIPS64,
> has always required that 64-bit GPRs be sign-extended when used with 32-bit
> operations.  I'm surprised that this wasn't seen on more 64-bit CPUs than
> just the SB1.

Usually resends will paper over this kind of problem.  It's only a question
of time until they succeed for any protocol that changed the packet
content sufficiently to make the checksum work eventually.  But of course
performance will suffer and as a matter of statistics certain IP address
and port ranges are going to suffer more than others.

  Ralf
