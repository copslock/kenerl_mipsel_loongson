Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 23:26:44 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34913 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010009AbbJWV0mhEe6r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 23:26:42 +0200
Received: by pasz6 with SMTP id z6so127978365pas.2;
        Fri, 23 Oct 2015 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1K79GDfihNKNi0t/Aqa4SLWylkJgjuav301dnv5eDbk=;
        b=0BUFYQ6pN/laAo48dJ7U7z7xzUOO1bqP0Z9GkPAgtE3EuLmJP1UVdx0nyRNE0ttUGm
         28gsJ129hLZoSyUZRKweHhjH29XK+zrao8ObLNuOIUM3JfnVnJ9H9S7rydypreSnGvbm
         va/H1kxb+IzAyXWQyqanZCe6BBPrEPflSrgo6AkFRnSj9YHwaxsyesEZB6sZHaMgbXRh
         WUBVtM4UqPuWJpUH6xzS81Xq4xsSMo4L/zF3hME/GnbBLTqetEv3lz/Lp2ZP1k0x5dZM
         TJhHTBy8egjoZBXugIUMk/BL4exB5JK46YN9/krZuIPkkv0HReAcsfPx+XYbK2gLJemu
         Ua5A==
X-Received: by 10.68.225.66 with SMTP id ri2mr7203800pbc.59.1445635596430;
        Fri, 23 Oct 2015 14:26:36 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:2c06:ba91:afc7:e14d])
        by smtp.gmail.com with ESMTPSA id we9sm20667240pab.3.2015.10.23.14.26.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Oct 2015 14:26:36 -0700 (PDT)
Date:   Fri, 23 Oct 2015 14:26:34 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/10] ata: ahci_brcmstb: make the driver buildable on
 BMIPS_GENERIC
Message-ID: <20151023212634.GT13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <1445564663-66824-2-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445564663-66824-2-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Fri, Oct 23, 2015 at 10:44:14AM +0900, Jaedon Shin wrote:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Brian Norris <computersforpeace@gmail.com>
