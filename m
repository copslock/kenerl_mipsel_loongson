Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:45:23 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:40680
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbeCWVpLQLBvS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 22:45:11 +0100
Received: by mail-pg0-x244.google.com with SMTP id g8so5072017pgv.7
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2018 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ysm1iQAK5/a3Ub6Di9aFk/yDRb2QyOnxd7YadyH62g0=;
        b=kVPQVE7p25yBdvm+pnLzqvPQMyHCVUbxZw+3KFy7s/tDHrBxCkeWA34hNes1ipl7G6
         ipkQA7V6xp9ej+MgBYTHejPAk9TgXlUEnczS+IDRhax9o923bK2fA1A4c0l/HlMWqbNR
         iduLdQ3eEeW0V48sNScpJbcSpTlXbuqwod7/VaxANRx+BDtXUwDyWnkvgUTe7eVO5gFI
         dylvwxClGes3dpKkHxApRBoQE8X2MW1dr5BBf1EST0HXsvSVBEQwHNq2+A+VlCNH1+Ts
         gTiFj17VVYvyJQ6SKtp1qbb9O4zq+DRiJ8cxzWf6iL8V1DSrdIxiyCKx2RFmc/J1suMm
         OwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ysm1iQAK5/a3Ub6Di9aFk/yDRb2QyOnxd7YadyH62g0=;
        b=UGaDQBvjsmcERoTMKibrXfhZtbZHSS8Cz0L6ax03uPLCKq3GzxqbG0lCbiKsWADvkH
         f/TgEdi3u5ZtMMp6kdTvqIHZ0Ac8L9rpK++4q0oIwkwjW7zxlDgi3q3KnehU5lMTNx7c
         foKeE2kQItVF6bhH/HVSSQs+wVLwwByL5hoC93L3hLLn6YoCpkjcyUWmPBxibTG41eth
         KBrF/3sSjIO6DqEIudvsKNmFKInJb0AzY6cZlS9nEJUCdkMNpdM9JH/uXGviotr5RDfi
         6GuHjVsW1MfnWC6QjvyeJsfDRcXWPkMe7SoedA9FeEYI80/Jk4spEXfbHEgwnXjZrDRn
         M2MQ==
X-Gm-Message-State: AElRT7FeHK6bMO0StGVt3VJLOoRtIcrFJKGfCEP7sOQ91g+kLmKY7PU+
        AVlH7/sG50BNNmxXRLQoLE0=
X-Google-Smtp-Source: AG47ELsDyVlP3Z7/Ux415Bmwa4MBiKM+MAfXll068ZEPvWunLix2pBvMb3VnAzia8oj4nPM1RzzEjg==
X-Received: by 10.99.110.5 with SMTP id j5mr13508116pgc.246.1521841504481;
        Fri, 23 Mar 2018 14:45:04 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id p12sm17465968pgn.91.2018.03.23.14.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:45:03 -0700 (PDT)
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
To:     Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
 <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
 <20180323212230.GA12808@piout.net> <20180323213344.GV24361@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <dcac43b7-2eb7-d409-a77c-4f671a8cfc3d@gmail.com>
Date:   Fri, 23 Mar 2018 14:44:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323213344.GV24361@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63202
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

On 03/23/2018 02:33 PM, Andrew Lunn wrote:
> On Fri, Mar 23, 2018 at 10:22:30PM +0100, Alexandre Belloni wrote:
>> On 23/03/2018 at 14:17:48 -0700, Florian Fainelli wrote:
>>> On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
>>>> +
>>>> +			phy0: ethernet-phy@0 {
>>>> +				reg = <0>;
>>>> +			};
>>>> +			phy1: ethernet-phy@1 {
>>>> +				reg = <1>;
>>>> +			};
>>>> +			phy2: ethernet-phy@2 {
>>>> +				reg = <2>;
>>>> +			};
>>>> +			phy3: ethernet-phy@3 {
>>>> +				reg = <3>;
>>>> +			};
>>>
>>> These PHYs should be defined at the board DTS level.
>>
>> Those are internal PHYs, present on the SoC, I doubt anyone will have
>> anything different while using the same SoC.
> 
> With DSA, there is no need to list internal PHYs.
> 
> That is the trade off of having a standalone MDIO bus driver.  Maybe
> add a phandle to the internal MDIO bus? The switch driver could then
> follow the phandle, and direct connect the internal PHYs?

This is more or less what patch 7 does, right?
-- 
Florian
