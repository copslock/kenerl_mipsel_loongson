Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Oct 2006 10:22:39 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:11096 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039057AbWJNJWf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 14 Oct 2006 10:22:35 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1891209nfc
        for <linux-mips@linux-mips.org>; Sat, 14 Oct 2006 02:22:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sHHkQ2SMI6nMXB0A90ZbKwWQQ2Jjpr31GS74NY1/sFBbjeE0B4YiglAdeIisI2zkdALAObTndAeVh9aTWeoBfBX2fpx7hdQDhAZAVZDSLus/qPJu+iYWi/dJfyF8jUaCZrABdV0uZm7NN2h6P8VIH86fmaRvNsSWhAsBVV7N1+k=
Received: by 10.78.139.1 with SMTP id m1mr4939806hud;
        Sat, 14 Oct 2006 02:22:34 -0700 (PDT)
Received: by 10.78.124.19 with HTTP; Sat, 14 Oct 2006 02:22:34 -0700 (PDT)
Message-ID: <cda58cb80610140222t3b45a285r2715c3aab91f913f@mail.gmail.com>
Date:	Sat, 14 Oct 2006 11:22:34 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/7] page.h: remove __pa() usages.
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org
In-Reply-To: <20061014.012723.61508918.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
	 <11607431461941-git-send-email-fbuihuu@gmail.com>
	 <20061014.012723.61508918.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 10/13/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Fri, 13 Oct 2006 14:39:00 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > -#define virt_to_page(kaddr)  pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
> > -#define virt_addr_valid(kaddr)       pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
> > +#define virt_to_page(kaddr)  pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
> > +#define virt_addr_valid(kaddr)       pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
>
> It seems "#include <linux/pfn.h>" (and "#include <asm/io.h>" perhaps)
> required.
>

Well it just compiles fine for me and to be honest I have no strong
feeling here. So I'm following your recommendation.

thanks
-- 
               Franck
