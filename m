Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 17:41:26 +0000 (GMT)
Received: from SMTP7.andrew.cmu.edu ([IPv6:::ffff:128.2.10.87]:31901 "EHLO
	smtp7.andrew.cmu.edu") by linux-mips.org with ESMTP
	id <S8225205AbTBNRl0>; Fri, 14 Feb 2003 17:41:26 +0000
Received: from XYZZY.WV.CC.cmu.edu (XYZZY.WV.CC.cmu.edu [128.2.70.110])
	by smtp7.andrew.cmu.edu (8.12.3.Beta2/8.12.3.Beta2) with ESMTP id h1EHfMBH016125;
	Fri, 14 Feb 2003 12:41:22 -0500
Subject: Re: [PATCH][2.5][4/14] smp_call_function_on_cpu - MIPS
From: Justin Carlson <justinca@cs.cmu.edu>
To: Zwane Mwaikambo <zwane@zwane.ca>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.50.0302140356050.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140356050.3518-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Feb 2003 12:41:06 -0500
Message-Id: <1045244466.1044.13.camel@PISTON.AHS.RI.CMU.EDU>
Mime-Version: 1.0
Return-Path: <justinca@cs.cmu.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinca@cs.cmu.edu
Precedence: bulk
X-list: linux-mips

On Fri, 2003-02-14 at 04:33, Zwane Mwaikambo wrote:
> +}
> +
> +int smp_call_function (void (*func) (void *info), void *info, int retry, int wait)
> +{
> +	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
>  }

IIRC, the semantics of smp_call_function() are to call the function on
all other cpus.  So shouldn't this be

	return smp_call_function_on_cpu(func, info, wait, cpu_online_map & ~(1<<smp_processor_id()));

?

Also, maybe you were planning to do this in a future patch, but
shouldn't smp_call_function() be moved to non-arch-specific code, given
this change?

-Justin
