Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 15:34:25 +0100 (BST)
Received: from alpha.total-knowledge.com ([205.217.158.170]:7828 "EHLO
	total-knowledge.com") by ftp.linux-mips.org with ESMTP
	id S20039066AbWJFOeT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Oct 2006 15:34:19 +0100
Received: (qmail 25494 invoked from network); 6 Oct 2006 07:34:15 -0700
Received: from unknown (HELO ?192.168.0.236?) (ilya@209.157.142.202)
  by alpha.total-knowledge.com with ESMTPA; 6 Oct 2006 07:34:15 -0700
Message-ID: <4526695E.5030702@total-knowledge.com>
Date:	Fri, 06 Oct 2006 07:34:06 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>
CC:	linux-mips@linux-mips.org
Subject: Re: /proc/cpuinfo makes false assumptions of uniformity on IP27
References: <34353.136.163.203.3.1160138023.squirrel@www.ferretporn.se>
In-Reply-To: <34353.136.163.203.3.1160138023.squirrel@www.ferretporn.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Try starting your O2K with R10K rack as primary, and you'll find out ;-)

Karl-Johan Karlsson wrote:
> 1. What about the CPU feature test macros in
> include/asm-mips/cpu-features.h? They claim
>   /*
>    * SMP assumption: Options of CPU 0 are a superset of all processors.
>    * This is true for all known MIPS systems.
>    */
> but is that really true, even on a mixed R12k/R10k system?
>
>   

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
