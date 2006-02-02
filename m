Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 11:01:10 +0000 (GMT)
Received: from bender.bawue.de ([193.7.176.20]:39808 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133406AbWBBLAx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2006 11:00:53 +0000
Received: from lagash (unknown [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 2431849032; Thu,  2 Feb 2006 12:06:04 +0100 (MET)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1F4cHi-0000IL-Tp; Thu, 02 Feb 2006 11:05:54 +0000
Date:	Thu, 2 Feb 2006 11:05:54 +0000
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: linker script for non-4k page size
Message-ID: <20060202110554.GA26789@networkno.de>
References: <439B9104.6000605@ict.ac.cn> <439B9566.3020607@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439B9566.3020607@ict.ac.cn>
User-Agent: Mutt/1.5.11
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Sun, Dec 11, 2005 at 10:56:38AM +0800, Fuxin Zhang wrote:
> BTW: except this problem, 2.6.14 with 16k page size runs well on my
> machine. According to our experiences of 2.4 kernels, 16k page size
> has a bit benefit over 4k page size(average 6% improvement for spec
> cpu2000 int).
>   But to use 16k kernel, we have to convert binaries of debian/mips:
> their sections are often not 16k aligned untill the latest testing branch.

AFAIR a 64k alignment between code and data segments was introduced
in debian shortly before the sarge release, but no attempt to
systematically rebuild with that toolchain was made (because debian
sarge supports only 4k paged kernels). A rebuild of the respective
sarge packages should be enough to work around the problem.


Thiemo
