Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2003 20:01:27 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:48820 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225468AbTI2TAz>;
	Mon, 29 Sep 2003 20:00:55 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h8TIwLYY009021;
	Mon, 29 Sep 2003 11:58:22 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler-linux [192.168.65.120])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA25600;
	Mon, 29 Sep 2003 12:01:53 -0700 (PDT)
Subject: Re: 64 bit operations w/32 bit kernel
From: Michael Uhler <uhler@mips.com>
To: "Finney, Steve" <Steve.Finney@spirentcom.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB75C@iris.adtech-inc.com>
References: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB75C@iris.adtech-inc.com>
Content-Type: text/plain
Organization: MIPS Technologies, Inc.
Message-Id: <1064862114.11818.21.camel@uhler-linux.mips.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 29 Sep 2003 12:01:54 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

On Mon, 2003-09-29 at 10:31, Finney, Steve wrote:
> What would be the downside to enabling 64 bit operations in user space on a 32 bit kernel (setting the PX bit in the status register?). The particular issue is that I want to access 64 bit-memory mapped registers, and I really need to do it as an atomic operation. I tried borrowing sibyte/64bit.h from the kernel, but I get an illegal instruction on the double ops.
> 
The most glaring problem is you violate the rule that the 64-bit GPRs
are sign-extended when running a 32-bit binary.  There are all kinds
of assumptions in the hardware and software that depend on the
GPRs being sign-extended, and to violate this will risk some
serious instability of the software.

> Also, assuming this isn't a horrible idea, is there any obvious single place where "default" values in the CP0 status register get set?
> 
> Thanks,
> sf
-- 

Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com  Pager:uhler_p@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
