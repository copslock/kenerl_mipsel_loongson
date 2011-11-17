Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 00:58:06 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:61585 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904095Ab1KQX57 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 00:57:59 +0100
Received: by iapp10 with SMTP id p10so3987257iap.36
        for <linux-mips@linux-mips.org>; Thu, 17 Nov 2011 15:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=FCcT1/i26AwKaG78VwkIp/cF+DLrukJMrjpbKW+zYyk=;
        b=O8exKDIfXSHTXghvORxv7SslgoH5dg5SujYaD4bOX88UKadMYxc8X7uzIVeW+62D5s
         Radn6Bpi4hoKsrzOhULQ==
Received: by 10.42.202.17 with SMTP id fc17mr311311icb.15.1321574273389;
        Thu, 17 Nov 2011 15:57:53 -0800 (PST)
Received: by 10.42.202.17 with SMTP id fc17mr311275icb.15.1321574273283;
        Thu, 17 Nov 2011 15:57:53 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id eb23sm7564933ibb.2.2011.11.17.15.57.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 15:57:52 -0800 (PST)
Date:   Thu, 17 Nov 2011 15:57:50 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Robin Holt <holt@sgi.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and
 HPAGE_SIZE
In-Reply-To: <4EC59E3C.5070204@gmail.com>
Message-ID: <alpine.DEB.2.00.1111171553440.13555@chino.kir.corp.google.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com> <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com> <20111117153526.f90ee248.akpm@linux-foundation.org>
 <alpine.DEB.2.00.1111171538540.13555@chino.kir.corp.google.com> <4EC59E3C.5070204@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14992

On Thu, 17 Nov 2011, David Daney wrote:

> A counter argument would be:
> 
> There are hundreds of places in the kernel where dummy definitions are
> selected by !CONFIG_* so that we can do:
> 
>    if (test_something()) {
>       do_one_thing();
>    } else {
>       do_the_other_thing();
>    }
> 
> 
> Rather than:
> 
> #ifdef CONFIG_SOMETHING
>    if (test_something()) {
>       do_one_thing();
>    } else
> #else
>    {
>       do_the_other_thing();
>    }
> 
> 
> 
> We even do this all over the place with dummy definitions selected by
> CONFIG_HUGETLB_PAGE, What exactly makes HPAGE_MASK special and not the
> hundreds of other similar situations?
> 

Dummy functions that return 0 when a feature isn't enabled isn't the 
problem, that's very convenient.  Definitions of constants are a 
completely separate story because they can be easily used outside the 
required context and cause brekage.  What happens if you reference a 
variable in a function that is declarated in a different function?  Does 
the compiler put a BUG() in there and let you explode at runtime?  This is 
just absurd, every other arch has done the necessary declarations in their 
own header files and everything works fine because there's a clear config 
dependency on using HPAGE_*.  Adding dummy definitions to panic at runtime 
is irresponsibly to an extreme.
