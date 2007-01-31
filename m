Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2007 18:14:30 +0000 (GMT)
Received: from mx1.wp.pl ([212.77.101.5]:4466 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S20038787AbXAaSOZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2007 18:14:25 +0000
Received: (wp-smtpd smtp.wp.pl 26547 invoked from network); 31 Jan 2007 19:13:20 +0100
Received: from apn-236-153.gprsbal.plusgsm.pl (HELO [87.251.236.153]) (laurentp@[87.251.236.153])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with RC4-MD5 encrypted SMTP
          for <linux-mips@linux-mips.org>; 31 Jan 2007 19:13:20 +0100
Message-ID: <45C0DCEE.3040108@wp.pl>
Date:	Wed, 31 Jan 2007 19:16:14 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Advice needed.
References: <45C0C956.2050009@wp.pl> <45C0D060.1070903@avtrex.com>
In-Reply-To: <45C0D060.1070903@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

<cut>

> If there is a /dev/mtdblock? perhaps.

There is only one node related to mtd:

brw-rw-rw-    1 0        0         31,   0 Aug 29  2006 mtd

Kernel modules supposed by me to be related: mtdlink.o or mtdlink_gw.o
(different size), probably supplied by Realtek or Edimax -> there are
some closed source modules/tools in this toolchain. Kernel is 2.4.18,
gcc 3.3.3, uClibc.

/proc/mtd shows:

mtd0: 00200000 00010000 "DiskOnChip Millennium"

> http://www.linux-mtd.infradead.org/ 

I will, thanks.

I'm looking for the simpliest reliable method of not using webs-included
procedures for programming flash.
What i want, is to be able to reprogram flash with image generated on
PC, that i may download to BR system.

If more information is needed please tell.

W.P.
