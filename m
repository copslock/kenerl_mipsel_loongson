Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:11:51 +0100 (CET)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:44673
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990656AbeCWVLobLBE1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 22:11:44 +0100
Received: by mail-pf0-x244.google.com with SMTP id m68so5198377pfm.11
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2018 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BlnKOha0mNMYHYAAyV3a0Jzlg0bey1HL044N7Nyb5z4=;
        b=YTyfsot/zgCnYXRtQSHQ4dG/PUea1Dq1z1EDPmxrYQF+zwcwsHbftXAs7bSA0Wh0lq
         8JV+vMDW516L3RFiTxCF5188/7Nb7hxDM77Rj6UH7bvOQpx62ZTPH016AMSRLKUP1dXi
         6Em/DhjLqzmDbo8beu8obHVE5c1ED5CiRCWoHooyiQKbjtseOjCNNp+5thum4eob+Wy3
         ObAOgMVkF2CZSOh1EP/S2LWBq5DEnAKL0Uw7IvKkIYamc3VJlLgHNqVERReLeusX4pYb
         t6bY8PtZegK2bguiU/w/UHaNP/SiV94Eg+WuGHJP5WvO9kCPg0FDybtTs5PySDbK1aNt
         f/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BlnKOha0mNMYHYAAyV3a0Jzlg0bey1HL044N7Nyb5z4=;
        b=lLf27GNvMHChqWZlSWIAWu2Drja5e6Xl73IFfzEX5dHcrHyBUV1xslLf40MvHG7Hu4
         r0MOS9Rkch5xIOwWosqvzMd8Af1zE6yUWbDRlpb99WpthtIuP2O9Iis7EZ1LKV5b+Ope
         Tfzdz7PyLd/7nZTsPdJLrcWVFfPZ1wKcCVPCwc5J9HfP5KobhJhsYDs2fSb/qTRxQTuM
         QYsPFXwZ9c3bU7v3kVHGmRPM0adbd0voJChQ3HZZ94u1Jc2cgKsojaecSqJSWuEl/6rV
         eKXJzzZGtEhqM4SHVRpuW1bJPCBHZPBYTvpzsP7kEm+1C6/M+nOCyfX9dYozdqW8ixBP
         w+XA==
X-Gm-Message-State: AElRT7Eup3sScU+04ki+CBDhaUrWJ1U0/RNEeTE+I7qTohfdN0ZQjPfD
        ByEaGLrUo+7OrCiLoAlkKVg=
X-Google-Smtp-Source: AG47ELtWo/MQhvnSwCS1RYJyrAJAcTxdvbRQ6ZBGmawXJEknZA+Jj30q1FHMWwfRiC4b+N5V1pwZzA==
X-Received: by 10.99.96.66 with SMTP id u63mr22178588pgb.22.1521839497433;
        Fri, 23 Mar 2018 14:11:37 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id g66sm11983095pfc.23.2018.03.23.14.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:11:36 -0700 (PDT)
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a5db6109-c5d9-f573-893c-f7d66c3168c2@gmail.com>
Date:   Fri, 23 Mar 2018 14:11:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-5-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63195
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

On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-ocelot.txt        | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> new file mode 100644
> index 000000000000..ee092a85b5a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> @@ -0,0 +1,62 @@
> +Microsemi Ocelot network Switch
> +===============================
> +
> +The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
> +VSC7514)
> +
> +Required properties:
> +- compatible: Should be "mscc,ocelot-switch"
> +- reg: Must contain an (offset, length) pair of the register set for each
> +  entry in reg-names.
> +- reg-names: Must include the following entries:
> +  - "sys"
> +  - "rew"
> +  - "qs"
> +  - "hsio"
> +  - "qsys"
> +  - "ana"
> +  - "portX" with X from 0 to the number of last port index available on that
> +    switch
> +- interrupts: Should contain the switch interrupts for frame extraction and
> +  frame injection
> +- interrupt-names: should contain the interrupt names: "xtr", "inj"

You are not documenting the "ports" subnode(s).Please move the
individual ports definition under a ports subnode, mainly for two reasons:

- it makes it easy at the .dtsi level to have all ports disabled by default

- this makes you strictly conforming to the DSA binding for Ethernet
switches and this is good for consistency (both parsing code and just
representation).
-- 
Florian
