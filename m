Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 16:03:16 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:2578 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133495AbWAPQCy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2006 16:02:54 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3D08B64D54; Mon, 16 Jan 2006 16:06:25 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A3E8E8517; Mon, 16 Jan 2006 16:05:42 +0000 (GMT)
Date:	Mon, 16 Jan 2006 16:05:42 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Mark Mason <mason@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Building the kernel for a Broadcom SB1
Message-ID: <20060116160542.GC28383@deprecation.cyrius.com>
References: <20050915205904.16380.qmail@web31515.mail.mud.yahoo.com> <4329ED24.50506@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4329ED24.50506@broadcom.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Mark Mason <mason@broadcom.com> [2005-09-15 14:52]:
> >I'm having a few issues building the current >2.6.14-rc1 for a
> Broadcom SB1 MIPS64 processor. (No >huge surprise there, building
> anything for that >processor is a pain.)
> >
> >Anyway, there are a few symbols undefined, which is >causing
> problems. First off the bat is TO_PHYS_MASK.  >There is no set of
> definitions in >include/asm-mips/addrspace.h for the SB1 processor.

> Here's the patch for that particular problem.  There's also a few other 
> patches for the SB1 floating around (check the email archives), but 
> there appears to be a backlog with getting them committed to the CVS 
> repository.

Can this patch be applied?

> HTH,
> Mark
> 
> Index: include/asm-mips/addrspace.h
> ===================================================================
> RCS file: /home/cvs/linux/include/asm-mips/addrspace.h,v
> retrieving revision 1.18
> diff -u -p -r1.18 addrspace.h
> --- include/asm-mips/addrspace.h    14 Jul 2005 12:05:08 -0000    1.18
> +++ include/asm-mips/addrspace.h    15 Sep 2005 21:46:56 -0000
> @@ -131,6 +131,8 @@
>     || defined (CONFIG_CPU_R5000)                    \
>     || defined (CONFIG_CPU_NEVADA)                    \
>     || defined (CONFIG_CPU_TX49XX)                    \
> +    || defined (CONFIG_CPU_SB1)                        \
> +    || defined (CONFIG_CPU_SB1A)                    \
>     || defined (CONFIG_CPU_MIPS64_R1)
> #define KUSIZE        _LLCONST_(0x0000010000000000)    /* 2^^40 */
> #define KUSIZE_64    _LLCONST_(0x0000010000000000)    /* 2^^40 */
> .
> 
-- 
Martin Michlmayr
http://www.cyrius.com/
