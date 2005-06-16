Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2005 11:19:23 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:5393 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224987AbVFPKTI>; Thu, 16 Jun 2005 11:19:08 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5GAG84J014165;
	Thu, 16 Jun 2005 11:16:08 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5GAG7UV014164;
	Thu, 16 Jun 2005 11:16:07 +0100
Date:	Thu, 16 Jun 2005 11:16:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tom =?iso-8859-1?Q?Vr=E1na?= <tom@voda.cz>
Cc:	linux-mips@linux-mips.org
Subject: Re: kernel compilation fails
Message-ID: <20050616101607.GF5202@linux-mips.org>
References: <42B0A38A.6050504@voda.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42B0A38A.6050504@voda.cz>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 15, 2005 at 11:54:18PM +0200, Tom Vrána wrote:

> I am desperately trying to compile 2.4.30 mips kernel using uclibc 
> buildroot gcc 3.3.4 It fails in the following manner:
> 
> mipsel-linux-gcc -D__KERNEL__ 
> -I/store/devel/adm/linux-2.4.30-mipscvs-20050614/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -I 

> Looks like a stupid typo somewhere, but I lack experience to find. BTW, 
> the some code is taken from 2.4.18 kernel...
> Can anyone please tell me where to look ?

Sympthoms of a botched makefile transplant, it's lacking the
USE_STANDARD_AS_RULE thing.

  Ralf
