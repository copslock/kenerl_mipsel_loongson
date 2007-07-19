Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 12:47:33 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.178]:41079 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022542AbXGSLrb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 12:47:31 +0100
Received: by py-out-1112.google.com with SMTP id p76so1018176pyb
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 04:47:19 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g9K/NR/9/Ql2cLzgEzViVBldPs+6ITR98CJxYWKYxM4ZZlDzcE9aj8KVNe3VZ6+NaRORhKPXXXorFuaih7DAkbSgkU8+oYnh+tZMo/yNGxkpGlVu4KHTh2a8LCCMnGhTzLRmDujeNZsc0eekdz9AR3bqyXGlzy1geLNNYF9NkPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tD+DXxBRscJA8kANNqsUAftFwzxyD4kUYiN0r6Htm1AVZj1wcXDGDJJSs1X2zh4Us1VDXBnHQ/fbkqvqAnlH91NDvHck9Oe+Hk9SofXf9OTGKAiS8nXypiaHbO474IB4g0G1dq337GUmTGGsO4bi/+2YY8aXLtgkHOQubTXQCmw=
Received: by 10.64.193.2 with SMTP id q2mr4533698qbf.1184845639505;
        Thu, 19 Jul 2007 04:47:19 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 19 Jul 2007 04:47:19 -0700 (PDT)
Message-ID: <cda58cb80707190447m1cd9b37fye7d330b50331b199@mail.gmail.com>
Date:	Thu, 19 Jul 2007 13:47:19 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [RFC] User stack pointer randomisation
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070719111440.GA19916@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <469F0E5F.4050005@innova-card.com>
	 <20070719111440.GA19916@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On 7/19/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jul 19, 2007 at 09:10:23AM +0200, Franck Bui-Huu wrote:
>
> > This patch adds a page size range randomisation to the user
> > stack pointer.
>
> Looks fine to me aside of the issue Nigel raised.
>

I'll fix it.

> There is a constant defining the ABI-specific alignment in <asm/asm.h>:
>

I didn't know about them. ALSZ name is not really self speaking, don't
you think ?

> #if (_MIPS_SIM == _MIPS_SIM_ABI32)
> #define ALSZ    7
> #define ALMASK  ~7
> #endif
> #if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
> #define ALSZ    15
> #define ALMASK  ~15
> #endif
>

this is weird I would have defined them like this instead:

#if (_MIPS_SIM == _MIPS_SIM_ABI32)
#define ALSZ 8
#elif (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
#define ALSZ 16
#endif

#define ALMASK (~(ALSZ-1))


> This will unnecessarily increase the alignment of the stack wasting a few
> bytes of memory for O32 binaries running on 64-bit kernels but I'd just
> ignore this artefact; the cure would be uglier than the disease ;-)
>

specially that we don't care to waste a couple of bytes in this case...

Thanks
-- 
               Franck
