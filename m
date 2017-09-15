Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 15:20:17 +0200 (CEST)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:28230 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991955AbdIONUKjAWnF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2017 15:20:10 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 696BF3F83E;
        Fri, 15 Sep 2017 15:20:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0s2_cM39976f; Fri, 15 Sep 2017 15:19:56 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 39C3A3F6D0;
        Fri, 15 Sep 2017 15:19:47 +0200 (CEST)
Date:   Fri, 15 Sep 2017 15:19:46 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add basic R5900 support
Message-ID: <20170915131945.GA32582@localhost.localdomain>
References: <20170827132309.GA32166@localhost.localdomain>
 <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
 <20170902102830.GA2602@localhost.localdomain>
 <alpine.DEB.2.00.1709091022180.4331@tp.orcam.me.uk>
 <alpine.DEB.2.00.1709110610290.5244@tp.orcam.me.uk>
 <20170912175826.GA2526@localhost.localdomain>
 <alpine.DEB.2.00.1709151136220.16752@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.00.1709151136220.16752@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Maciej,

>  I wonder if FS=1 hardwired also means the Underflow exception cannot 
> happen.  As the corresponding Cause and Enable bits cannot be set together 
> or an FPE exception will happen right away, and the Unimplemented 
> Operation exception is uncoditional so we need to leave it out, can you 
> please also try these masks in turns:
> 
> 	      " li   %1,0x0001f07c\n"
> 
> and:
> 
> 	      " li   %1,0x00000f80\n"
> 
> This will reveal if any of the Cause, Enable or Flag bits are hardwired.

The result is:

	FCSR 0x0001f07c old: 01000001, new: 0101c079
	FCSR 0x00000f80 old: 01000001, new: 01000001

I was looking for information on GCC for R5900 and found

https://gcc.gnu.org/ml/gcc-patches/2013-01/msg00658.html

where you and Jürgen Urban discuss this topic. Jürgen cites some FPU details
from the Emotion Engine core user's manual that is very helpful, in addition
to mentioning TX79 differences.

Fredrik
