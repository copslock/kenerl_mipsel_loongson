Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:29:18 +0100 (CET)
Received: from mail-wr0-x236.google.com ([IPv6:2a00:1450:400c:c0c::236]:38977
        "EHLO mail-wr0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991100AbdLAX3KnzUHp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Dec 2017 00:29:10 +0100
Received: by mail-wr0-x236.google.com with SMTP id a41so9787108wra.6;
        Fri, 01 Dec 2017 15:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X4bDkRG6l8JV2IRIp/ZjG2QgGh69+12/u3q3Hd9BS70=;
        b=Ms2rRsm9qbOelCMXHL942d/rSdc+Um+1KOpfR21pfUdVIl/L+dlHYrhx8SY9r3ffVL
         /uceUebdittS7Biz1n9Aq0uWenI9OrfJRLAIP4b1PmmXxO/LoX1vSZhaooTzFwhZPRyn
         TS1riSf1x0g2dKo3igvYKtAhStuiwHidPOle49bm/3KN8BGjGsvgGNu/125F4HVxwf4X
         YMDz6Jv7UdJz+djpMMYfpRfLoBM7FjvHuqJtWtX3G/ZN+gwcnAckRzbsS2W24ArVvswI
         J4xLpokY7Pr4dlgBXoSu8rMb1/GEr50b/6EGyAofDKncqRzFzMsjTkYmgkkCWAIJ/cHq
         K1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X4bDkRG6l8JV2IRIp/ZjG2QgGh69+12/u3q3Hd9BS70=;
        b=SOrILnVq+7buDwL4dLQmwLzytbkQi6Lm1JuxxTbzctn1epygKAruFxEW9Hlg90Cq7n
         k7vrSyEbRQ0WbzLGDbPO/wu9ebiZ/PjUHvM1uW+mXqoabNubwXhC05LNWZtwrVpzhqFr
         2PJ7JXbBm2BxZrXtj/EoWMGr/Zj9Fg7ICbPiQ7H7mp08h6BJ4hjemTNq8PGSBU21gS/i
         G4Q9LLjPDl8YgUwwe4kWg85Ih3jMASqa+pONw4jEm0Io7qcIUpTQEGqgjL3w09sIWhQN
         dZNKwDzEf1SrRiLt3Nk2wEWyrnlDMAwhzWyhByGoYryTFOm5TsbfgHr+Fk2SiUv7ZiRP
         YqEQ==
X-Gm-Message-State: AJaThX5gLAMmaG3XSADxmpHOTNFhncKoXCjkpauhjV4R1NNM5hvZ27Mz
        X4Xd8lmPmoJ6NeFxJtCV+0o=
X-Google-Smtp-Source: AGs4zMbaVL/eTBq4AU6bQ1CvRFi1/EeiGvtYOMeMwXKIFVzZOm9qop+wzdil989wCVle/JtDQPzNWw==
X-Received: by 10.223.171.177 with SMTP id s46mr6502897wrc.194.1512170943693;
        Fri, 01 Dec 2017 15:29:03 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:4d7d:8488:119c:738d? ([2001:470:d:73f:4d7d:8488:119c:738d])
        by smtp.gmail.com with ESMTPSA id 192sm2211099wmg.32.2017.12.01.15.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2017 15:29:02 -0800 (PST)
Subject: Re: [PATCH v5 net-next,mips 1/7] dt-bindings: Add Cavium Octeon
 Common Ethernet Interface.
To:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Carlos Munoz <cmunoz@cavium.com>
References: <20171201231807.25266-1-david.daney@cavium.com>
 <20171201231807.25266-2-david.daney@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <326f8c51-9487-efdf-5bca-737f26f91da5@gmail.com>
Date:   Fri, 1 Dec 2017 15:28:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171201231807.25266-2-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On 12/01/2017 03:18 PM, David Daney wrote:
> From: Carlos Munoz <cmunoz@cavium.com>
> 
> Add bindings for Common Ethernet Interface (BGX) block.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
