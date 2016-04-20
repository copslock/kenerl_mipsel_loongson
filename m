Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 13:24:18 +0200 (CEST)
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35061 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026633AbcDTLYRKaxS9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 13:24:17 +0200
Received: by mail-wm0-f42.google.com with SMTP id e201so46624823wme.0
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LcTva6iXAdONZ+5Tx3ninH4DQ3MHjYyBITL3Wyx5qDc=;
        b=f8txfkDDWrXk6qQgMixwTPZ3PBMfxW1kX6NDPcSkMRYn0iciOG6YERoiub0BTPyqs0
         EXJs5/oedMe9+B/u3w9MZL2Vt91Rho+p90GN3sruvfkAr1Z6T/rfqJCkbcTI1fd6AOin
         cqSc6cMYoEi47NlbjdY+igH6WYaFfMq0DxuFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LcTva6iXAdONZ+5Tx3ninH4DQ3MHjYyBITL3Wyx5qDc=;
        b=HBBU38m+Ee7z07b7MeNry9GxsO9qqxyvPWDE47fUcVvTSG/oT+Zd7B4gwe5js6drgu
         8jZvOK8veOK3NDKjBdKEiqyjsbLADtZpY/XlLhPAPrFvwus0DmO+62jqTZlTl5i1JwGO
         LQsAhmV8bYdXzE8Da59NyM0Os7TTaJwQ0LOmhUu90+0OO5LnyGt1awLP4NNSS56seW8z
         UIsTOU7iIwZ7oXF9G5m+ZL8D5wnEbHZZFycnSmzRyBapRZi96QjMR9Ehmqf0LmIHZtIx
         gIlB3MU00h4H2EC9FL6n1tIis6aI7x/hC45/C8+myklF8Rpqyubjj/r9ujxXS6PImC9f
         OQ0A==
X-Gm-Message-State: AOPr4FU4DJ7eP0w6ci5rbXuw2gH9X8tJO7d/8bCmo+PMCMsE0IwjIpiAATH17vu2D1GPgA==
X-Received: by 10.28.145.67 with SMTP id t64mr9229922wmd.56.1461151451792;
        Wed, 20 Apr 2016 04:24:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56b5:0:ac27:b86c:7764:9429])
        by smtp.gmail.com with ESMTPSA id iv1sm5094856wjb.34.2016.04.20.04.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 04:24:11 -0700 (PDT)
Date:   Wed, 20 Apr 2016 13:24:09 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg KH <greg@kroah.com>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] drm: Loongson-3 doesn't fully support wc memory
Message-ID: <20160420112409.GN2510@phenom.ffwll.local>
References: <1461064751-17873-1-git-send-email-chenhc@lemote.com>
 <CADnq5_OyS_pCu-4wW5uFpnr5kvqkHK5uPdmBKgHHmfZ-dOdXvw@mail.gmail.com>
 <CAAhV-H6EsxUhuXAAYBhun-S4+tM-xhWxKbXD4Jg0btK4sLfjGg@mail.gmail.com>
 <20160420064923.GA698@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160420064923.GA698@kroah.com>
X-Operating-System: Linux phenom 4.4.0-1-amd64 
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <daniel@ffwll.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@ffwll.ch
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

On Wed, Apr 20, 2016 at 03:49:23PM +0900, Greg KH wrote:
> On Wed, Apr 20, 2016 at 02:18:20PM +0800, Huacai Chen wrote:
> > Cc: stable@vger.kernel.org
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>

Not sure what exactly your script latched onto, but at least in the drm
subsystem it's pretty common to remind maintainers with a reply just
containing

Cc: stable@vger.kernel.org

that they need to add that to the patch when applying. Often combined with
an r-b/a-b tag. And Damien is working to teach patchwork to auto-add
those, so yeah it's indeed the right way to submit a patch for stable. At
least here ;-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
