Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 09:22:23 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.191]:19444
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224858AbVBCJWI>; Thu, 3 Feb 2005 09:22:08 +0000
Received: from [212.227.126.209] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CwdBd-0000SO-00
	for linux-mips@linux-mips.org; Thu, 03 Feb 2005 10:22:05 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CwdBd-00043N-00
	for linux-mips@linux-mips.org; Thu, 03 Feb 2005 10:22:05 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Kernel compile error - rtc.c
Date:	Thu, 3 Feb 2005 10:24:23 +0100
User-Agent: KMail/1.7.1
References: <000f01c509cb$c7420190$642aa8c0@of0>
In-Reply-To: <000f01c509cb$c7420190$642aa8c0@of0>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502031024.24321.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Etienne Bauermeister wrote:
> CC      drivers/char/rtc.o
> drivers/char/rtc.c: In function `rtc_init':
> drivers/char/rtc.c:955: `r' undeclared (first use in this function)

Just declare it at the top of the function, it was (accidentially) deleted 
during some recent cleanups.

> A second question relates to some warnings I got earlier in the
> compilation process stating that some 'variables' (I assume) are
> 'deprecated'.  Is this anything to be concerned about?

Maybe. Impossible to say without more info. 

BTW: you're mailing plain text and HTML...

cheers 

Uli
