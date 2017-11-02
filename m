Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 19:53:34 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:53002
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991978AbdKBSxUX4nAp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 19:53:20 +0100
Received: by mail-qk0-x242.google.com with SMTP id b15so576152qkg.9;
        Thu, 02 Nov 2017 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mh0+jf9IibybIPV36RiqOt8RtH03Clv4cQALQ0GYqCY=;
        b=OeFFs5cJaebKC0bDB9oNleGAugDNaqA1saloJ4xA4gc1Du8RMHh6i26QvLMNnycWvh
         tGC5u10o8x2LH7EsEDdtwp47CQcn4AXl9mkS2BDbK42UOVHD9hVkPA+8LKL9cpKRw2Rp
         fW8kxV6t2i75bD0qQOBLa+eWzPORjS8h5K8fz826BZjJBYoyif3MdRc60NuIZ8h+1wfc
         3rEShSfbRq/OYnUQX5XjOKGl0D3U/nKGNKBFA4rUGxzQwrC/7YgtR37FP2G+rEAUXfcK
         R5s5afP0ge54RM80gPlsnNPvbnc8XLKGp6cQ4QD7rHdarvcka5512bfJz0UXKpMxHPHu
         GHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mh0+jf9IibybIPV36RiqOt8RtH03Clv4cQALQ0GYqCY=;
        b=M/hCBXbuBlqHUjmltg1Knwrl+kfcnVJeClEefpjaSAtIw9W/OQ/Aegz4Ftq3dlMsd4
         +Loo+HBRSzo1m3p5ati4NGXNwp0kX4ds9paG/Il/gLagRDVZ34LHoZXgV6OlU7AIjLtL
         M/nQKGtVb42bc3HPr7hrloPlthk/754lfoiIt4TCnc6bkZnKDCX3CGorMwqt2MWtwJh0
         urvDCyJlV/TQYXIsSgHDLb4oOZpRP2lU81bqAq/SnNLOkhmfEGB1YSg6+EWsvicx73Bx
         PBRdsad6vK6nhLRhP2S0FumK3xgDPZAqKh0zEqbCL27s8cghMIl66u4OT40uXsoyBZ99
         r2kw==
X-Gm-Message-State: AMCzsaXnvVL1YxTo4h3I+Q8cYewVoGq4hzvnk70PfCOTPPfJCn17LMc/
        P7HAn0G8swGwHZyj0cwRpA56DRcV
X-Google-Smtp-Source: ABhQp+Q9h708l8VX79tswmSLgcoRiTXwKjFHnS9T9B6b/6nqteh3l2VL6/pT0H1dgp4uqcpUfSJ1fw==
X-Received: by 10.55.209.86 with SMTP id s83mr6438101qki.145.1509648792749;
        Thu, 02 Nov 2017 11:53:12 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id s19sm2509808qki.3.2017.11.02.11.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 11:53:11 -0700 (PDT)
Subject: Re: [PATCH 6/7] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
To:     David Daney <ddaney@caviumnetworks.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-7-david.daney@cavium.com>
 <20171102124339.GF4772@lunn.ch>
 <521d6b21-b7f0-66e0-4b49-cf95d83452d1@caviumnetworks.com>
 <20171102161016.GH24320@lunn.ch>
 <0f39046d-dc99-5c05-d918-10952cd20e1b@caviumnetworks.com>
 <20171102165605.GJ24320@lunn.ch>
 <0168761e-cb18-e489-4689-8c9062aa316b@caviumnetworks.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bad9f43c-b080-fe40-620e-d1e6e5ab0f75@gmail.com>
Date:   Thu, 2 Nov 2017 11:53:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <0168761e-cb18-e489-4689-8c9062aa316b@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60695
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

On 11/02/2017 11:31 AM, David Daney wrote:
> On 11/02/2017 09:56 AM, Andrew Lunn wrote:
>>> OK, now I think I understand.  Yes, the MAC can be hardwired to a
>>> switch.
>>> In fact, there are system designs that do exactly that.
>>>
>>> We try to handle this case by not having a "phy-handle" property in the
>>> device tree.  The link to the remote device (switch IC in this case) is
>>> brought up on ndo_open()
>>
>> O.K, so you totally ignore the Linux way of doing this and hack
>> together your own proprietary solution.
> 
> I am going to add handling of the "phy-mode" property, but other than
> that I don't know what the "Linux way" of specifying a hard MAC-to-MAC
> connection with no intervening phy devices is.  Wether the remote MAC is
> a switch, or something else, would seem to be irrelevant.  All we are
> concerned about in this code is putting the thing into a state where
> data flows in both directions through the MAC.

The canonical way to support that type of connections is to use use a
fixed-link property describing the link between the two MACs, ideally
putting the same fixed-link property on both sides.

> 
> A pointer to an existing device tree binding for an Ethernet device that
> has no (or an optional) phy device would be useful, we can try to do the
> same.
> 
> 
>>  
>>> There may be opportunities to improve how this works in the future,
>>> but the
>>> current code is serviceable.
>>
>> It might be serviceable, but it will never get into mainline. For
>> mainline, you need to use DSA.
>>
>> http://elixir.free-electrons.com/linux/v4.9.60/source/Documentation/networking/dsa/dsa.txt
>>
> 
> 
> I am truly at a loss here.  That DSA document states:
> 
>      Master network devices are regular, unmodified Linux
>      network device drivers for the CPU/management Ethernet
>      interface.
> 
> What modification do you suggest I make?

If you support normal phy_device and fixed-link devices, you should be
good as far as using PHYLIB and interfacing with Ethernet switchses
using DSA for instance. What Andrew is asking you though is to make sure
that the platform device dance between the bgx drivers and the other
modules preserves the Device Tree parenting, of_node pointers such that
a DSA switch, which needs to reference a CPU/management port, has a
chance to successfully look up that node via of_find_net_device_by_node().

> 
> 
>>
>> Getting back to my original point, having these platform devices can
>> cause issues for DSA. Freescale FMAN has a similar architecture, and
>> it took a while to restructure it to make DSA work.
>>
>> https://www.spinics.net/lists/netdev/msg459394.html
>>
>>     Andrew
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Florian
