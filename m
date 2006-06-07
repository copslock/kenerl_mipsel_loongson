Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 10:02:33 +0100 (BST)
Received: from mail.domino-uk.com ([193.131.116.193]:9225 "EHLO
	vMimePS1.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S8133385AbWFGJCZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Jun 2006 10:02:25 +0100
Received: from emea-exchange3.emea.dps.local (EMEA-EXCHANGE3) by 
    vMimePS1.domino-printing.com (Clearswift SMTPRS 5.2.3) with ESMTP id 
    <T78ba58dadac18374c11328@vMimePS1.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Wed, 7 Jun 2006 10:01:00 +0100
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Wed, 7 Jun 2006 11:03:35 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix some compiler warnings (field width, unused variable)
Date:	Wed, 7 Jun 2006 11:03:34 +0200
User-Agent: KMail/1.9.1
References: <20060601.010003.39154219.anemo@mba.ocn.ne.jp> 
    <Pine.LNX.4.62.0605311840170.18323@chinchilla.sonytel.be> 
    <20060602.015404.93020143.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060602.015404.93020143.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071103.34646.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 07 Jun 2006 09:03:35.0140 (UTC) 
    FILETIME=[41E76A40:01C68A11]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Thursday 01 June 2006 18:54, Atsushi Nemoto wrote:
>  			printk("initrd extends beyond end of memory "
> -			       "(0x%0*Lx > 0x%0*Lx)\ndisabling initrd\n",
> -			       width,
> -			       (unsigned long long) CPHYSADDR(initrd_end),
> -			       width,
> -			       (unsigned long long) PFN_PHYS(max_low_pfn));
> +			       "(0x%p > 0x%p)\ndisabling initrd\n",
> +			       (void *)CPHYSADDR(initrd_end),
> +			       (void *)PFN_PHYS(max_low_pfn));

I'm not so sure if this is a good idea because some systems have 36 bit 
physical addresses while they only have 32 bit void pointers, so long long is 
probably really the better solution.

I'm wondering if it would be worth having a special flag in printk to indicate 
a physical address ("%lp" perhaps?) so that you don't get the unimportant 
leading zeroes for the bits 36 to 63 for above mentioned platforms.

Uli


****************************************************
Visit our website at <http://www.domino-printing.com/>
****************************************************
This Email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this Email in error please notify the system manager.

This footnote also confirms that this Email message has been swept by MailSweeper for the presence of computer viruses.
****************************************************
