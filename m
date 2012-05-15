Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 17:47:37 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64373 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903678Ab2EOPr2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 17:47:28 +0200
Received: by pbbrq13 with SMTP id rq13so8677528pbb.36
        for <linux-mips@linux-mips.org>; Tue, 15 May 2012 08:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=TiSfssx2ibFhfL1ULy5DjdW1IXY0oTIdmb71M5pmIvI=;
        b=m7Bb2t3aXmkQt2Z3zq12geNnZ93RZAMhgll82hZptseGctJR3DqYKrLsoFo/8nrdFi
         RIzdtQQdmNe0ArpBDasKK6Ks5uQ+W9Kq5S1NZJ4OKrXT1LgkFbPCRc4KfH2+AqAXNcZv
         xTHrtk4x9LUXO7jiGh+TMqQZWmuBU4n1XRfztUDPCYY/W7XF0yIin72hDbgLdrAI5TK0
         DNhmKksqeClv2s40Hc7IHV2FHPLw5FIVsWtsGIykunzUyXUDg0Xug5PeJQjGDYYujRue
         Q0WjFeZRV+XHn8IUyHD4Jjq1iP0U+dC761uSL8dKaBdmmZpvs7xRaFm6Ane7l+XlhXae
         WAAg==
Received: by 10.68.129.131 with SMTP id nw3mr6683147pbb.150.1337096841609;
        Tue, 15 May 2012 08:47:21 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id ny10sm2196017pbb.38.2012.05.15.08.47.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 May 2012 08:47:19 -0700 (PDT)
Date:   Tue, 15 May 2012 08:47:17 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 3/3] eeprom/of: Add device tree bindings to at25.
Message-ID: <20120515154717.GA15552@kroah.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
 <1336773923-17866-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1336773923-17866-4-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQm2KjJGtEnch6/uWzMbgtjBmwdJAMuSkW1AtJXw0G2YflNTUu0aPwrfvXknRbULafFcaIwo
X-archive-position: 33327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, May 11, 2012 at 03:05:23PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> We can extract the "pagesize", "size" and "address-width" from the
> device tree so that SPI eeproms can be fully specified in the device
> tree.
> 
> Also add a MODULE_DEVICE_TABLE so the drivers can be automatically bound.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Axel Lin <axel.lin@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
