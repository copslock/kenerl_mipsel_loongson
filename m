Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 23:19:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35546 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011490AbcBDWTCSy3sj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 23:19:02 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 30FA3DC86F6E7;
        Thu,  4 Feb 2016 22:18:52 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 4 Feb 2016
 22:18:55 +0000
Date:   Thu, 4 Feb 2016 22:18:55 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Stop using dla in 32 bit kernels
In-Reply-To: <1454604037-17054-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.00.1602042212110.15885@tp.orcam.me.uk>
References: <1454604037-17054-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Thu, 4 Feb 2016, Paul Burton wrote:

> diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
> index 7b99efd..835c770 100644
> --- a/arch/mips/include/asm/hazards.h
> +++ b/arch/mips/include/asm/hazards.h
> @@ -65,8 +66,8 @@ do {									\
>  	unsigned long tmp;						\
>  									\
>  	__asm__ __volatile__(						\
> +	"	" __stringify(PTR_LA) "	%0, 1f			\n"	\
>  	"	.set "MIPS_ISA_LEVEL"				\n"	\
> -	"	dla	%0, 1f					\n"	\
>  	"	jr.hb	%0					\n"	\
>  	"	.set	mips0					\n"	\
>  	"1:							\n"	\

 This looks good to me if not obviously correct, however for consistency 
please apply the same change to the virtually the same code sequence 
further down the file, used for MIPSr1 builds.

 For the record -- it looks to me there needs to be `.insn' right after 
`1:' to ensure nothing strange happens in a microMIPS compilation.  We 
don't know for sure what GCC puts after the asm but we do want to ensure 
the target of the jump has the ISA bit set correctly.  It needs to be a 
separate change of course.

 Thanks,

  Maciej
