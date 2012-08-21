Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 21:30:31 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:35111 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903534Ab2HUTa1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 21:30:27 +0200
Received: by dajq27 with SMTP id q27so108356daj.36
        for <linux-mips@linux-mips.org>; Tue, 21 Aug 2012 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Jd1d6N8N22IftvL+uqboOcHwz7DbOyyaDHMpm67Sg/c=;
        b=kR4w3s42AfFNa+shw4hUpUBW/EGnntIpYwEEXKgQ/XRUQkb66YT7YbeMf/QLCIjVin
         w9tv3jS3UwNXuNBbuKY7xWLqgnJThFj0l13RjP0sCi+C5/a9cS8unIs/xFPgiYz/HP3O
         F+c8ae+JMnbKDdzsY8p5KNx7pePtb2Og8SQ/gtwgoRdcEwgdNWEIH+DImeVml2Hr9sd0
         Hn8qDR3TKUxljnbP4R8SwQgBCW7QBuBd4wPO5rWiRGOrp/iI17O3hjZPMZ2f0YknTw/k
         N6W4eVLMs35gNVYBKfAjTL2qBbjBhWuDCbX0Dq/2Op7tUphKVTMpd6s9FQTBWSA/feWI
         O9XQ==
Received: by 10.68.200.98 with SMTP id jr2mr46665007pbc.81.1345577420503;
        Tue, 21 Aug 2012 12:30:20 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ox5sm1992509pbc.75.2012.08.21.12.30.18
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 12:30:19 -0700 (PDT)
Message-ID: <5033E1CA.8050107@gmail.com>
Date:   Tue, 21 Aug 2012 12:30:18 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com> <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <20120520054657.091DA3E03B8@localhost>
In-Reply-To: <20120520054657.091DA3E03B8@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/19/2012 10:46 PM, Grant Likely wrote:
> On Fri, 11 May 2012 14:34:46 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Add the driver, link it into the kbuild system and provide device tree
>> binding documentation.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>
> Some comments below, but you can add my a-b:
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
[...]
>> +	p->register_base = (u64)devm_ioremap(&pdev->dev, res_mem->start,
>> +					     resource_size(res_mem));
>
> Nasty cast.  p->register_base needs to be an __iomem pointer
> variable.

No, it is only ever used as an argument to cvmx_{read,write}_csr(),
which want the u64 type.

>  The fact taht cvmx_read_csr accepts a uint64_t instead of
> an __iomem pointer looks really wrong.  Why is it written that way?


Register addresses on OCTEON are 64-bits wide.  In a 32-bit kernel,
pointers are only 32-bits wide.  Thus was born the cvmx_read_csr()
function that takes a u64 address.

We no longer support 32-bit kernels, but the legacy of the interface
lives on.

David Daney
