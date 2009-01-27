Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 09:11:11 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:24299 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366070AbZA0JLI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 09:11:08 +0000
Received: (qmail 15910 invoked by uid 1000); 27 Jan 2009 10:11:08 +0100
Date:	Tue, 27 Jan 2009 10:11:07 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Frank Neuber <linux-mips@kernelport.de>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
Message-ID: <20090127091107.GA15890@roarinelk.homelinux.net>
References: <1233045842.28527.459.camel@t60p>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1233045842.28527.459.camel@t60p>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2009 at 09:44:02AM +0100, Frank Neuber wrote:
> Hi,
> to find my PCI problem I want to use git to find the last working
> version.
> I just start with head and found a compile error:
> arch/mips/alchemy/common/time.c:93: error: incompatible types in
> initialization
> I comment this line ".cpumask        = CPU_MASK_ALL,"

you need to change it to "CPU_MASK_ALL_PTR".  Commenting it is not a very
good idea ;-)

Beste Grüsse,
	Manuel Lauss
