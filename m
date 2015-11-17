Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 03:22:52 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36367 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012875AbbKQCWtFlkmE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2015 03:22:49 +0100
Received: by pacdm15 with SMTP id dm15so194318580pac.3;
        Mon, 16 Nov 2015 18:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1TpxIzeuxPg1bBgywsn/tiaRfjPEIBy4RyUbYszvcds=;
        b=pTVOT0nUzxkpE8PBM4iZxzH5JWAxo2AL2bmIZBNSufbh22e7Oqtbf/4wzy67ynbbUe
         QVh7FIgXoelwkhcZzTFYm62t1/KEGdW4buJXk6CdSAj1AESLWlJtm/lE/Ac/cKSpU+bZ
         jmwc8ECl0NBXNG2xnzWKjVQHe5K5x1qgO2gSW64QGJg7+S8fQyfhemnCOQ0khKlyBGe5
         jXMBq6dHtnx7larspKmHnbXLLDZghY3IwC2CurG7kjgA2Xki/dEEWgzgB+nSdKXdguaP
         7I4GrFKbkiPyiX1dxBVZckAjW8QdcP7a+joYF26CETGhXgu964QpTM4aV28TXNcyUMg7
         V8MA==
X-Received: by 10.68.219.98 with SMTP id pn2mr59088303pbc.141.1447726963085;
        Mon, 16 Nov 2015 18:22:43 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:64ae:171:73e1:bc49])
        by smtp.gmail.com with ESMTPSA id bn1sm39209099pad.17.2015.11.16.18.22.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Nov 2015 18:22:42 -0800 (PST)
Date:   Mon, 16 Nov 2015 18:22:40 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: Re: [v4 00/10] add support SATA for BMIPS_GENERIC
Message-ID: <20151117022240.GX8456@google.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49959
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

On Fri, Oct 30, 2015 at 11:01:14PM +0900, Jaedon Shin wrote:
> Hi all,
> 
> This patch series add support SATA for BMIPS_GENERIC.
> 
> Changes in v4:
> - remove unused properties from bcm{7425,7342,7362}.dtsi
> 
> Changes in v3:
> - fix typo quirk instead of quick
> - disable NCQ before initialzing SATA controller endianness
> - fix misnomer controlling phy interface
> - remove brcm,broken-ncq and brcm,broken-phy properties from devicetree
> - use compatible string for quirks
> - use list for compatible strings
> - add "Acked-by:" tags
> 
> Changes in v2:
> - adds quirk for ncq
> - adds quirk for phy interface control
> - remove unused definitions in ahci_brcmstb
> - combines compatible string

For the drivers portions (including patch 2, if you fix the error I
pointed out):

Acked-by: Brian Norris <computersforpeace@gmail.com>
