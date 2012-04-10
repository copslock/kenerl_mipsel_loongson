Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 18:43:33 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54737 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903710Ab2DJQn1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 18:43:27 +0200
Received: by pbcun4 with SMTP id un4so194270pbc.36
        for <linux-mips@linux-mips.org>; Tue, 10 Apr 2012 09:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=2eOEapD6MeZz+l48Wfd4vatS0WaK0FOCoYzBAom1OOk=;
        b=fXiEh1k8DgglyJNZaSEo9pJKTfR10DgyG86d6ZZuwC3f/5xptceB9GO0ybiGTQCHZl
         HVtRrUv6dsgT2fAILcPsvCPPlWjmc0KS9VDAlW7OLQ40m1nnAf20MU17p+U8y8tUoJjE
         V2h/X3afQEwqLJ/CUWoW5/AhjqcH+JX8bDC1tYwXCQ8kalxxUeFBAolIaPPf5UUPPcrA
         RAh4PYd0UyqWHIDxJs2WESj4xaiFvL0lN7c4ROo4p4GZQ15u7EYKwXc0nYIlu5kIcDw4
         sQ8EMx9z8w8xh1D494BO9ruq14Yg2emKg/nZy+sAnVwh1Vs/i1PA3xkLN5irPym2kZDo
         J62A==
Received: by 10.68.202.167 with SMTP id kj7mr31003824pbc.9.1334076200377;
        Tue, 10 Apr 2012 09:43:20 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id r10sm306604pbf.22.2012.04.10.09.43.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 09:43:18 -0700 (PDT)
Date:   Tue, 10 Apr 2012 09:43:16 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: octeon_ethernet: Convert to use device tree.
Message-ID: <20120410164316.GA15131@kroah.com>
References: <1332808075-8333-1-git-send-email-ddaney.cavm@gmail.com>
 <1332808075-8333-5-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332808075-8333-5-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQl6eDhsw+5bQG7m7+U5SwYkqFRYCyblm5xmczX4CBfNcCdvPwr2POabIcXgcXCSg5DmYI1Z
X-archive-position: 32924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Mar 26, 2012 at 05:27:54PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Get MAC address and PHY connection from the device tree.  The driver
> is converted to a platform driver.
> 
> Cc: netdev@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> 
> Should probably go via Ralf's linux-mips.org tree.

That's fine with me:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
