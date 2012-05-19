Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2012 08:07:43 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:40958 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901761Ab2ESGHg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 May 2012 08:07:36 +0200
Received: by pbbrq13 with SMTP id rq13so5510336pbb.36
        for <linux-mips@linux-mips.org>; Fri, 18 May 2012 23:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=JjX4YF3DtDzfWtskhLdM4hU4yQU2HVJ5xyzH3qSZRO0=;
        b=Do0zA37n65Ua9bCPF2PsmwqSmyx8toO4pEr+5xVpKrIgiJG5B48W2fpGmtkAeNidJ/
         ygDcP9G0goRanrJrWSzk8ZThMxeG+GVmmx67hvUIXYmDcUSBWaho1mb4a/2dOsqBcR54
         hDslRUb0Q6Y+htbvjt08wob+zUwAAQTHqlIaK3nDCvGj4iW/HyqtsyfVv10mnIUOTL73
         RWZC7pssp3+PGASsqJnYWD+0C/m2KI1Fq1ydOOvuYX6P18nd/O3xs7vmibDhUZ0xr5z+
         g8oBKEZjEpGUc+tSywELVj5wVmwTk1V7gHAJkHo9pff0OEgE0B1s+Rp/Px2ELhG0s1L0
         cmNg==
Received: by 10.68.203.225 with SMTP id kt1mr46558856pbc.133.1337407649731;
        Fri, 18 May 2012 23:07:29 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id ve6sm15251669pbc.75.2012.05.18.23.07.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 23:07:28 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id C455D3E046E; Sat, 19 May 2012 00:07:27 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/5] staging: octeon_ethernet: Convert to use device tree.
To:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1335489630-27017-5-git-send-email-ddaney.cavm@gmail.com>
References: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com> <1335489630-27017-5-git-send-email-ddaney.cavm@gmail.com>
Date:   Sat, 19 May 2012 00:07:27 -0600
Message-Id: <20120519060727.C455D3E046E@localhost>
X-Gm-Message-State: ALoCoQkj7MeVFtndlmFbgnzOGZEF1JDK6CDM17F6ZCbE+DWLHv5ata6gYOsbgk4fOQOTonFdU6/x
X-archive-position: 33373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 26 Apr 2012 18:20:29 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Get MAC address and PHY connection from the device tree.  The driver
> is converted to a platform driver.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: netdev@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: David S. Miller <davem@davemloft.net>

Acked-by: Grant Likely <grant.likely@secretlab.ca>
