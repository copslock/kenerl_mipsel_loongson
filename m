Received:  by oss.sgi.com id <S42195AbQJKW3m>;
	Wed, 11 Oct 2000 15:29:42 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:32529 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42180AbQJKW33>;
	Wed, 11 Oct 2000 15:29:29 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id BACA0809; Thu, 12 Oct 2000 00:28:46 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E9E289014; Thu, 12 Oct 2000 00:26:19 +0200 (CEST)
Date:   Thu, 12 Oct 2000 00:26:19 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Cort Dougan <cort@fsmlabs.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: modutils bug?  'if' clause executes incorrectly
Message-ID: <20001012002619.B678@paradigm.rfc822.org>
References: <20001010224317.I733@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001010224317.I733@hq.fsmlabs.com>; from cort@fsmlabs.com on Tue, Oct 10, 2000 at 10:43:17PM -0600
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 10, 2000 at 10:43:17PM -0600, Cort Dougan wrote:
> if A
>   B
> else
>   C
> 
> in the order A, C, B when A is false and correctly (A, B) when A is true.
> 
> This is with GCC version egcs-2.90.29 980515 (egcs-1.0.3 release) and
> binutils 2.8.1 (with BFD 2.8.1).
> 
> The asm in this routine looks good and I can keep the code from failing by
> removing the request_irq() and replacing it with something else that
> doesn't call into the kernel.  I can't reproduce this in user-code or in
> kernel code.
> 
> Does anyone have any suggestions?  Perhaps a suggestion for modutils
> version?

Please send the resulting asm code - I hear someone whispering
"Branch delay slot".

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
