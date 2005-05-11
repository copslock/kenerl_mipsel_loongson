Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2005 15:27:33 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:8729 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225941AbVEKO1S>; Wed, 11 May 2005 15:27:18 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j4BERCRH017168;
	Wed, 11 May 2005 15:27:12 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j4BER7X9017167;
	Wed, 11 May 2005 15:27:07 +0100
Date:	Wed, 11 May 2005 15:27:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mile Davidovic <mile.davidovic@micronasnit.com>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Mips 4KEC
Message-ID: <20050511142707.GF6072@linux-mips.org>
References: <200505111424.j4BEOu1p017560@krt.neobee.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505111424.j4BEOu1p017560@krt.neobee.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 11, 2005 at 04:20:53PM +0200, Mile Davidovic wrote:

> 1. I have question regarding toolchain, I use toolchain which came from
> uclibc buildroot
> application. Gcc version is 3.4.2, is it ok?

Yes.

> 2. I tried to use sde-lite 5.03 toolchain but this toolchain (sde-gcc)
> failed to build kernel. 
>     Please any comments regarding this issue? 

> 3. I tried to remove optimization from kernel: 

> I tried with googling but it seems that nobody faced similar problem? Is it
> possible to buidl kernel without optimization?

No.  That's FAQ since 10 years.

  Ralf
