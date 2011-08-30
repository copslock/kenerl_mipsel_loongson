Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2011 07:57:26 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:37366 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491145Ab1H3F5W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2011 07:57:22 +0200
Received: by fxd20 with SMTP id 20so6422505fxd.36
        for <multiple recipients>; Mon, 29 Aug 2011 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C8+kqIjJnngXsz9wb5vtEdAg+LlgV5I05F0CALmz+y4=;
        b=QWYH6XSYimJn7dzLNKMiRwc1uiHozbCYMWjIReFuqbpsS98YsOhEFTWh676A4lMlbn
         LoQRbkI5Fn094q0ywqKoj9/fAllieBJ/u6XZV9mPyc4PqKwlEGsohnPC3H0DDvZUUoay
         Ki79VDy5u6X82zgFQJqqpuxYnz3ALvwe9i0YE=
Received: by 10.223.50.15 with SMTP id x15mr8474923faf.147.1314683836706;
        Mon, 29 Aug 2011 22:57:16 -0700 (PDT)
Received: from localhost (h59ec324b.selukar.dyn.perspektivbredband.net [89.236.50.75])
        by mx.google.com with ESMTPS id e2sm4308165fah.1.2011.08.29.22.57.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 22:57:11 -0700 (PDT)
Date:   Tue, 30 Aug 2011 07:57:09 +0200
From:   "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
Message-ID: <20110830055709.GA3989@zapo>
References: <20110829232029.GA15763@zapo>
 <4E5C2490.6040203@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E5C2490.6040203@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edgar.iglesias@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22124

On Mon, Aug 29, 2011 at 04:45:20PM -0700, David Daney wrote:
> On 08/29/2011 04:20 PM, Edgar E. Iglesias wrote:
> >Hi,
> >
> >Commit 362e696428590f7d0a5d0971a2d04b0372a761b8
> >reorders a bunch of insns to improve the flow of the pipeline but
> >for MT_SMTC kernels, AFAICT, the saving of CP0_STATUS seems wrong.
> 
> Indeed.
> 
> >
> >Am I missing something?
> >
> 
> It does look like in the MIPS_MT_SMTC case we are clobbering the
> value in v1.
> 
> >If not here is a patch, tested with qemu.
> >
> 
> How about the attached completely untested one instead?
> 
> David Daney

> From d0035295ae34bcf84d601b1e25e2642fe0802752 Mon Sep 17 00:00:00 2001
> From: David Daney <david.daney@cavium.com>
> Date: Mon, 29 Aug 2011 16:42:12 -0700
> Subject: [PATCH] MIPS: Don't clobber CP0_STATUS vaue for CONFIG_MIPS_MT_SMTC
> 
> Untested, but it looks nice.


Thanks, I like you patch better. But whichever version will do.

Cheers
