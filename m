Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 01:22:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64681 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20037703AbWHLAWW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Aug 2006 01:22:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7C0MFhb008574;
	Sat, 12 Aug 2006 01:22:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7C0MBDF008573;
	Sat, 12 Aug 2006 01:22:11 +0100
Date:	Sat, 12 Aug 2006 01:22:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dave Jones <davej@redhat.com>,
	Thomas Koeller <thomas@koeller.dyndns.org>, wim@iguana.be,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060812002211.GA8279@linux-mips.org>
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org> <20060812000636.GB28540@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060812000636.GB28540@redhat.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 11, 2006 at 08:06:36PM -0400, Dave Jones wrote:

>  > I think they are. Remember, the entire device is integrated in the
>  > processor. No external buses involved.
> 
> Ok.

I think it's ok in this case, we're unlikely to see these peripherals
on other chips than PMC-Sierra's - but that's of course just a guess.

With a broader perspective the embedded world is increasingly converging
to using standardized components (so called "IP") and on-chip
interconnects such as OCP for new designs and portable drivers should
reflect this.

  Ralf
