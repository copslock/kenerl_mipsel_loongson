Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 14:42:24 +0000 (GMT)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:25259 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S21103512AbZAMOmW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 14:42:22 +0000
Received: from 10.8.0.20 ([10.8.0.20]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Tue, 13 Jan 2009 14:42:13 +0000
Received: from kh-d820 by webmail.razamicroelectronics.com; 13 Jan 2009 08:42:13 -0600
Subject: Re: [RFC PATCH] Alchemy: detect Au1300
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20090113143552.GA18721@roarinelk.homelinux.net>
References: <20090113135302.GA18442@roarinelk.homelinux.net>
	 <20090113143552.GA18721@roarinelk.homelinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 13 Jan 2009 08:42:13 -0600
Message-Id: <1231857733.11541.1.camel@kh-d820>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

It might make sense to hold off on this patch for now.  I am going to be
pushing out the first tested Au13xx code shortly.  This detection and
much more are covered.

=Kevin

On Tue, 2009-01-13 at 15:35 +0100, Manuel Lauss wrote:
> Add code to detect Au1300 and its variants.  c0_prid uses a layout
> different from previous Alchemy chips and company ID switched to RMI.
> 
> Core and cache-wise it is compatible with previous Alchemy chips.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
> This patch depends on "Alchemy: remove superfluous cpu-model constants."
> Information was pieced together from the Au1300 databook, and obviously
> only compile tested. (Also, the irq controller looks completely different
> so this patch alone is insufficient to get linux working on it).

-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P:  512.691.8044
