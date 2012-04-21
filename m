Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Apr 2012 23:26:15 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46846 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903739Ab2DUV0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Apr 2012 23:26:00 +0200
Received: by pbcun4 with SMTP id un4so2610954pbc.36
        for <linux-mips@linux-mips.org>; Sat, 21 Apr 2012 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XlkmnqEXnE3J4QpPQFNewtzLthR7K7yKda7Z4m6WWDc=;
        b=U9VjuO7/wTWz0JZHc0DE0Qg3ZI0WCETe75QyKRMiSp00E4eXzndSo02zeF/RUdoZaB
         bAnzvYkEpjB724s/2tiX50xaRZ+XlkA7OlpNc2PCtWsRiW92bjZCF5s+pHSV3/6PqrGc
         EQGXCKEdjiPcjwp65xeglgYxdtZ/reAXfK6R4nJpSW2PP1NX9KDzZXpKD+5224WE8gKb
         ZBMjsEI+5v1NV8vB1rnGN/4MW9wPhHb2tEywDQbucteIUdNVwUedcDnQ1vJbVo2S+VQA
         VS3MDncznym5Nj0h2urewpCTJh4asgny5fbFy+livZ0vxq4JKh3jAhDBG6q+jhjVQAXQ
         HYzQ==
Received: by 10.68.226.170 with SMTP id rt10mr2848018pbc.2.1335043553822;
        Sat, 21 Apr 2012 14:25:53 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-68-122-34-125.dsl.pltn13.pacbell.net. [68.122.34.125])
        by mx.google.com with ESMTPS id sj8sm396480pbc.38.2012.04.21.14.25.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Apr 2012 14:25:52 -0700 (PDT)
Message-ID: <4F9325DF.7020003@gmail.com>
Date:   Sat, 21 Apr 2012 14:25:51 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     ddaney.cavm@gmail.com, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, afleming@gmail.com,
        galak@kernel.crashing.org, david.daney@cavium.com
Subject: Re: [PATCH v5 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
References: <1334791254-15987-1-git-send-email-ddaney.cavm@gmail.com>        <1334791254-15987-3-git-send-email-ddaney.cavm@gmail.com> <20120421.153201.2103447307695063734.davem@davemloft.net>
In-Reply-To: <20120421.153201.2103447307695063734.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/21/2012 12:32 PM, David Miller wrote:
> From: David Daney<ddaney.cavm@gmail.com>
> Date: Wed, 18 Apr 2012 16:20:53 -0700
>
>> +config MDIO_BUS_MUX
>> +	tristate
>> +	help
>> +	  This module provides a driver framework for MDIO bus
>> +	  multiplexers which connect one of several child MDIO busses
>> +	  to a parent bus.  Switching between child busses is done by
>> +	  device specific drivers.
>> +
> This driver uses OF and OF_MDIO, and therefore need dependencies upon
> them.  Otherwise it can be enabled in configurations which will result
> in build failures.

Note that this symbol cannot be selected by the user, only indirectly 
via the MDIO_BUS_MUX_GPIO symbol (in patch 3/3) which has the proper 
dependencies.

If we were to specify the dependencies in both places, we gain nothing other than duplication of information.

However, if you insist, I will of course add it here too.

David Daney
