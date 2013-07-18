Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 16:57:14 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48788 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6838155Ab3GRKnUVLzZF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 12:43:20 +0200
Received: by mail-pa0-f48.google.com with SMTP id kp12so3056350pab.21
        for <multiple recipients>; Thu, 18 Jul 2013 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EgK2CAQTLC9wDoXmPxosI658puj7lXl3CkgHeVRan+I=;
        b=y1YRN2t9QhIgTw+cecK5Pzyoxpo6nis26iQ81UUFs9ESFk66zYch5DXpvGHBhrb9GV
         9koAcWDVR1wdZFYNgTqoYOTGdvNJEfBQsZ04/RBkDFwb92RFnjmxirRA02bGVPn/H83K
         p0FJitb9DHteemdbGi5UTV9DlWzBr2iJ2yTsz93Yf87KMDGyqB6UM9qPZeJj3TMM97DF
         4E1CS3JL9Iag5reElFoFyE3oqw9Z6S2Hm0HHu7YGdm9Uyzxr2j3+HmF0tbGqLyaitGwT
         CH7qL+VYkPQBrm17BrHV8tHu/AMLNJwUw+F9T5ogNCBpBCu3EfCiQQVxMzZjxOlT10Wt
         P5nQ==
X-Received: by 10.66.40.212 with SMTP id z20mr2996726pak.51.1374144193205;
        Thu, 18 Jul 2013 03:43:13 -0700 (PDT)
Received: from hades (111-243-154-117.dynamic.hinet.net. [111.243.154.117])
        by mx.google.com with ESMTPSA id te9sm16010844pab.6.2013.07.18.03.43.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 03:43:12 -0700 (PDT)
Date:   Thu, 18 Jul 2013 18:43:07 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     "Jayachandran C." <jchandra@broadcom.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: tlbex: Fix typo in r3000 tlb store handler
Message-ID: <20130718184214-tung7970@googlemail.com>
References: <20130717175840-tung7970@googlemail.com>
 <20130718064106.GA24373@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130718064106.GA24373@jayachandranc.netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

On Thu, Jul 18, 2013 at 12:11:07PM +0530, Jayachandran C. wrote:
> On Wed, Jul 17, 2013 at 05:59:47PM +0800, Tony Wu wrote:
> > Should test against handle_tlbs_end, not handle_tlbs.
> > 
> > Signed-off-by: Tony Wu <tung7970@gmail.com>
> > Cc: Jayachandran C <jchandra@broadcom.com>
> > ---
> >  arch/mips/mm/tlbex.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> > index 9ab0f90..605b6fc 100644
> > --- a/arch/mips/mm/tlbex.c
> > +++ b/arch/mips/mm/tlbex.c
> > @@ -1803,7 +1803,7 @@ static void __cpuinit build_r3000_tlb_store_handler(void)
> >  	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
> >  	uasm_i_nop(&p);
> >  
> > -	if (p >= handle_tlbs)
> > +	if (p >= handle_tlbs_end)
> >  		panic("TLB store handler fastpath space exceeded");
> >  
> >  	uasm_resolve_relocs(relocs, labels);
> 
> Thanks for fixing this.
> 
> Acked-by: Jayachandran C. <jchandra@broadcom.com>
> 
> You should add the commit which caused the trouble to the commit message,
> like:
> 
> commit 6ba045f (MIPS: Move generated code to .text for microMIPS) causes
> a panic at boot.
> 
> JC.

Thanks for the comment. Will send the updated patch.

Tony 
