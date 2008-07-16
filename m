Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 09:15:35 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:9870 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28577366AbYGPIPd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 09:15:33 +0100
Received: (qmail 4536 invoked by uid 1000); 16 Jul 2008 10:15:32 +0200
Date:	Wed, 16 Jul 2008 10:15:32 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: Re: 2.6.26-gitX: insane number of section headers
Message-ID: <20080716081532.GB3184@roarinelk.homelinux.net>
References: <20080716075246.GA3184@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080716075246.GA3184@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2008 at 09:52:46AM +0200, Manuel Lauss wrote:
> Hello,
> 
> Todays 2.6.26-git kernel produces an insane amout of section headers in the
> vmlinux file, one for every function. Is that intentional, or a toolchain
> problem on my side (binutils-2.18, gcc-4.2.4)?

I see Ralf added -ffunction-sections with commit
372a775f50347f5c1dd87752b16e5c05ea965790.

Sorry for the noise.

	Manuel Lauss
