Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 13:20:58 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:50450 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20022559AbXGSMU4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2007 13:20:56 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1IBV04-0006Q0-00; Thu, 19 Jul 2007 13:20:56 +0100
Received: from highbury.mips.com ([192.168.192.236])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1IBUzu-0006bH-00; Thu, 19 Jul 2007 13:20:46 +0100
Message-ID: <469F571E.5080408@mips.com>
Date:	Thu, 19 Jul 2007 13:20:46 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	franck.bui-huu@innova-card.com
CC:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] User stack pointer randomisation
References: <469F5345.5010209@innova-card.com>
In-Reply-To: <469F5345.5010209@innova-card.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Franck Bui-Huu wrote:
> +/*
> + * Don't forget that the stack pointer must be aligned on a 8 bytes
> + * boundary for 32-bits ABI and 16 bytes for 64-bits ABI.
> + */
> +unsigned long arch_align_stack(unsigned long sp)
> +{
> +	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
> +		sp -= get_random_int() & ~PAGE_MASK;
> +
> +	return sp & ALMASK;
> +}
>   

Hmm, the kernel isn't necessarily built using the same ABI as
applications. While this will in fact do the right thing for O32 apps
running on 64-bit kernels, it's kind of by accident, and suggests some
equivalence which isn't really there. Would it be better to force 16
byte alignment (the maximum alignment required by any ABI) in all cases,
rather than relying on the kernel's ALMASK being correct for user
applications? Just a thought.

Nigel
