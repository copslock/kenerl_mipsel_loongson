Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2006 12:02:41 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:57052 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20039161AbWJELCj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2006 12:02:39 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GVQzp-0005rz-B6; Thu, 05 Oct 2006 11:02:34 +0000
Message-ID: <4524E648.2000706@garzik.org>
Date:	Thu, 05 Oct 2006 07:02:32 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 1/6] 2.6.18: sb1250-mac: Broadcom PHY support
References: <Pine.LNX.4.64N.0610031457070.4642@blysk.ds.pg.gda.pl> <4524E5BD.1040000@pobox.com>
In-Reply-To: <4524E5BD.1040000@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Jeff Garzik wrote:
> Maciej W. Rozycki wrote:
>> Hello,
> [...]
>>  Please consider.
>>
>>   Maciej
> 
> 
> Please don't include this in the patch description.  It must be 
> hand-edited out, before applying with git-applymbox.  All comments 
> should be placed AFTER the "---" separator, which terminates the patch 
> description.
> 
> Applied patches 1-3, patch #4 failed due to drivers/net/Kconfig breakage

Also, in your email subject line, the kernel version should be included 
in the [PATCH...] brackets.  Please see 
http://linux.yyz.us/patch-format.html and 
Documentation/SubmittingPatches for more info.

	Jeff
