Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2003 18:44:17 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:45038 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225205AbTELRoK>;
	Mon, 12 May 2003 18:44:10 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h4CHi8m24182;
	Mon, 12 May 2003 10:44:08 -0700
Date: Mon, 12 May 2003 10:44:08 -0700
From: Jun Sun <jsun@mvista.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: memory for exception vectors
Message-ID: <20030512104408.C24045@mvista.com>
References: <20030512115641.F17151@ftp.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030512115641.F17151@ftp.linux-mips.org>; from ladis@linux-mips.org on Mon, May 12, 2003 at 11:56:41AM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, May 12, 2003 at 11:56:41AM +0100, Ladislav Michl wrote:
> Could anyone tell me where is space for exception vectors reserved? Many boards
> (for example Alchemy Pb1000, Galileo EV96100 or Galileo EV64120A) simply
> registers all available RAM with add_memory_region call, but I didn't find code
> which reserves first 0x200 (on most CPUs) for exceptions vectors anywhere. I'd
> guess there is something obvious what I'm missing. Can you help me to see it?
>

Kernel only uses memory after the end of kernel image.  In that sense, all
memory before LOADADDR (see arch/mips/Makefile) is reserved.

Jun
