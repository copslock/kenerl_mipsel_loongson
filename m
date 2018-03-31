Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Apr 2018 00:47:43 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:42508
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeCaWrhLe2a1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Apr 2018 00:47:37 +0200
Received: by mail-oi0-x241.google.com with SMTP id l190-v6so10294011oig.9
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2018 15:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d8x2hcjwmlYNaXm6mxeWI3iMN71sfj8nxBSyeB1rxRY=;
        b=CLcUV0IDV0akQ6A+VcjR0kim1j8aL+Du/3gacpq+YH57rY3bLGihCgTzNtGG55a5SN
         9o6IEZt/04pl8UCEWfJhC4Wnz6AT+FSxwVewt+qJTya7I98WKS35xPQzaKCEF7XkWvw/
         wmr0nXCzvvpLIogCBdPpt4QR+9IAHuYilOmARj8zZXLjFLkCXUnGzLK5weE2oiA/IRi9
         ThzySUW6DEVzPReoj8CeAVMVkojRN2/pFbR6XTZvKPkZENPvocPc1ZNevRs3XuRZBiCP
         DdG9oWxK4SvvDlufVCPx+i2MScWHB67/OCazrvGZs83PT7Em4qH9j/volnLhpsJXOdZl
         8ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d8x2hcjwmlYNaXm6mxeWI3iMN71sfj8nxBSyeB1rxRY=;
        b=EQpoIJfAGXrdgEeudHWAFg/GSW4S1+oKZ/cJtXT++4VVvIuGbpDuCQ8H3V6of+KkXx
         +Yy48lHV+b6Q+kgAPsUGBcyybTFO3UO6RD5APaTyGLscGkSkNbiThSjiSuUFdFcJjTTN
         ajB9JY1+eIV3ZIU+SOWEGjZYI6mWjumgL6BeD8O7tEyqs5lu1X8P3yMhMQRB8Lxp9zvF
         5u/DGEY8iH5Kap/WB3pVg205AMo6RrstqfdVppnGy0d6WrMAZlV27PeEc7d1HnldZLg6
         GNo6MqXzpIdxP1puUGe0lFEThUy8lXSePqoQd71M1I5X7gjs6hgbxoz4Piy/cTKEt/hB
         AY5A==
X-Gm-Message-State: ALQs6tC5J+4h5k1twuBjXauMRmmNzeK/+AZ+4bDFJt6zx2+tRtsmiZys
        sJQGl2NtgDXqoe1oI9VlXSGM3Nee
X-Google-Smtp-Source: AIpwx4/70ycbf7kFgH5kXUf35I/RkQNFtQmJ6thvo4PSBZd6OV4+Z1PElpK+VZEgKDNoq90gQyirhg==
X-Received: by 2002:aca:5484:: with SMTP id i126-v6mr2102584oib.219.1522536450469;
        Sat, 31 Mar 2018 15:47:30 -0700 (PDT)
Received: from [192.168.1.2] (ip68-109-195-31.pv.oc.cox.net. [68.109.195.31])
        by smtp.googlemail.com with ESMTPSA id s9-v6sm5845799ote.47.2018.03.31.15.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 15:47:29 -0700 (PDT)
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
To:     Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
 <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
 <20180330124537.GC14180@piout.net> <20180330135422.GA28244@lunn.ch>
 <20180330141634.GD14180@piout.net> <20180330145008.GE28244@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <244d3f20-f8f8-d9a2-a6b5-1a8fa4f0b655@gmail.com>
Date:   Sat, 31 Mar 2018 15:47:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180330145008.GE28244@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63374
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

Le 03/30/18 à 07:50, Andrew Lunn a écrit :
> On Fri, Mar 30, 2018 at 04:16:34PM +0200, Alexandre Belloni wrote:
>> On 30/03/2018 at 15:54:22 +0200, Andrew Lunn wrote:
>>>>> All of this sounds like it should be moved into the br_join/leave, this
>>>>> does not appear to be the right place to do that.
>>>>>
>>>>
>>>> No, I've triple checked because this is a comment that both Andrew and
>>>> you had. Once a port is added to the PGID MASK, it will start forwarding
>>>> frames so we really want that to happen only when the port is in
>>>> BR_STATE_FORWARDING state. Else, we may forward frames between the
>>>> addition of the port to the bridge and setting the port to the
>>>> BR_STATE_BLOCKING state.
>>>
>>> Hi Alexandre
>>>
>>> Interesting observation. I took a look at some of the other join
>>> implementations. mv88e6xxx does the join immediately. mt7539 does it
>>> immediately, if the port is enabled. lan9303 does it immediately.
>>> qca8k does it immediately. b53 does it immediately.
>>>
>>
>> I had a look at b53, my impression was that b53_br_join() adds the port
>> to the bridge but b53_br_set_stp_state() actually enables forwarding. So
>> as long as the default on the port is PORT_CTRL_DIS_STATE, the port will
>> not be forwarding frames. And this is the case because b53_enable_port()
>> does put 0 in B53_PORT_CTRL.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/dsa/b53/b53_regs.h#L71
> 
> It seems like, 0 means no STP at all. Which to me would mean, forward
> all packets. But i could be wrong. Florian?

Correct, 0 disables STP and therefore means forward all packets.

> 
>> The fact is that ocelot doesn't have separate controls. The port is
>> either forwarding or not. If it is not forwarding, then there is nothing
>> to tell the HW to do.
> 
> Think about the following sequence:
> 
> ip link set lan0 up
> 
> After this command, i expect to see packets on lan0 arrive at the
> host, tcpdump to work, etc. This probably means the port is in
> 'forwarding' mode, or for B53, STP is disabled.

In net/dsa/port.c::dsa_port_enable we have the following:

u8 stp_state = dp->bridge_dev ? BR_STATE_BLOCKING : BR_STATE_FORWARDING;

> 
> ip link add name br0 type bridge
> ip link set dev br0 up
> ip link set dev lan0 master br0
> 
> When the port is added to the bridge, there is a window of time
> between the join and the STP change to blocking/learning, when the
> port is in forwarding mode. You avoid this window. But the other
> drivers don't appear to.
> 
> So i would like to fix this of every driver. I'm not sure how yet...

Agreed, there does appear to be a window like you outlined in your
example if the port was already UP where we may be in an inconsistent
STP state. This window does not appear to be existing in case the port
was not UP prior to joining the bridge though.

It seems to me like the most natural place where to fix this would be in
the bridge code, but this has the potential to break several drivers so
within the scope of DSA, it might be as simple as this:

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 7acc1169d75e..e692b6f1a710 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -116,6 +116,8 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct
net_device *br)
        if (err)
                dp->bridge_dev = NULL;

+       dsa_port_set_state_now(dp, BR_STATE_BLOCKING);
+
        return err;
 }
-- 
Florian
