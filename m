Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2012 07:27:09 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61497 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903541Ab2ETF1B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 May 2012 07:27:01 +0200
Received: by pbbrq13 with SMTP id rq13so6400313pbb.36
        for <linux-mips@linux-mips.org>; Sat, 19 May 2012 22:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=TQSiwVqZnuPLsDhkUjUuz/0yo5ctYi9NjIzWr9kh7ac=;
        b=jSWxkvaiiaHT3nGIJ2hLKHDNOEr7V/Vky4Uz0MEn24XC4ghDIovq1sQkAfFtuYzp67
         Kjk5fVyXA0+W7bdDXs6H29hupo54lnij1X6JM++InvxWOmZxiS9ZnTPg3OmEoaqpi1xL
         Ev73OJfDuHU6gXDahB0D8wWcDa3xHERNcG2nwfCx67dDbFukZg8VdztehFofSXzaIGHl
         K7sEZpKrFaAwGPfQhUjii6eDb6gypnGZ1UK4L8OqBrVuzAwJ9uGM9YBarCYxcYd31w4V
         vizj1ebnY6UDn8VMdGlMFZBMEGH4GI4Ex0OmtTtgd3TLr0Kjrl2ku+Q/EtejYTK/jdqr
         fflg==
Received: by 10.68.219.166 with SMTP id pp6mr55330259pbc.35.1337491615148;
        Sat, 19 May 2012 22:26:55 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id rv8sm13116069pbc.64.2012.05.19.22.26.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 May 2012 22:26:54 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 590673E03B8; Sat, 19 May 2012 23:26:53 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
To:     David Daney <ddaney.cavm@gmail.com>,
        Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <4FB14B55.4070604@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com> <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <CAM=Q2csSQWbCOCQpubDok1=hmPvHU0MTEUg+-FGhp91=O5L6Hw@mail.gmail.com> <4FB14B55.4070604@gmail.com>
Date:   Sat, 19 May 2012 23:26:53 -0600
Message-Id: <20120520052653.590673E03B8@localhost>
X-Gm-Message-State: ALoCoQkeHaHKXL43PZMlQcIf4i2a3NtkwBASWtOPlAlVws4Xs+kI9O1Ac29M4vHsNo7NZMDfh6uM
X-archive-position: 33379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 14 May 2012 11:13:41 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> On 05/13/2012 10:46 PM, Shubhrajyoti Datta wrote:
> > Hi David,
> > A few comments.
> >
> > On Sat, May 12, 2012 at 3:04 AM, David Daney<ddaney.cavm@gmail.com>  wrote:
> [...]
> 
> >> +
> >> +#define DRV_VERSION "2.0" /* Version 1 was the out-of-tree driver */
> > This could be given a miss. As it is less meaningful once accepted.
> 
> 
> Well, this leads to the question, what is the purpose of the 
> 'MODULE_VERSION()' macro?  If I use that, I need to populate it with a 
> value.

Don't use MODULE_VERSION.  Just because it is there doesn't mean you
need to use it.  :-)  You'll notice that none of the other spi drivers
have it.

g.
