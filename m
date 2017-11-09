Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 06:35:46 +0100 (CET)
Received: from asavdk4.altibox.net ([109.247.116.15]:33673 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990419AbdKIFfjvOqpQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 06:35:39 +0100
Received: from ravnborg.org (126.158-248-196.customer.lyse.net [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id EA8BC80307;
        Thu,  9 Nov 2017 06:35:30 +0100 (CET)
Date:   Thu, 9 Nov 2017 06:35:29 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH 1/2] kbuild: create built-in.o automatically if parent
 directory wants it
Message-ID: <20171109053529.GA12717@ravnborg.org>
References: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com>
 <1510072307-16819-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510072307-16819-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.2 cv=eqGd9chX c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=IVIVYO1bEUvHGqgSWusA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
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

Hi Masahiro.

Thanks for picking this up.

> A key point is, the parent Makefile knows whether built-in.o is needed
> or not.  If a subdirectory needs to create built-in.o, its parent can
> tell the fact when Kbuild descends into it.
Good observation!
> 
> diff --git a/Makefile b/Makefile
> index 008a4e5..cc0b618 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1003,7 +1003,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
>  
>  PHONY += $(vmlinux-dirs)
>  $(vmlinux-dirs): prepare scripts
> -	$(Q)$(MAKE) $(build)=$@
> +	$(Q)$(MAKE) $(build)=$@ need-builtin=1

The need-bultin may also be required for the shortcuts
that allows one to use:

	make <dir>/

    example:

	make net/

And maybe selftest, documentation shortcuts too?
Other than that - looks good.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
