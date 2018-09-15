Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 23:03:36 +0200 (CEST)
Received: from mail-pf1-x441.google.com ([IPv6:2607:f8b0:4864:20::441]:40838
        "EHLO mail-pf1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992494AbeIOVDcHue9p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 23:03:32 +0200
Received: by mail-pf1-x441.google.com with SMTP id s13-v6so5819049pfi.7;
        Sat, 15 Sep 2018 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HXZJcgW+WvZzVZmA613r9fLZvBiK5tou1MxALAsh8os=;
        b=fPfAQGw5u1jCVD2T3ZXOLiWIRpmej68Rr1YrNpv+7g48OWIMNe+rE8eNz5TqjcYYaY
         6UT38RjHeFEwVhq31eB5PpFDU21JCZ/U670QVIxYGAie01wJWAs5rCEcfCkDSSXbVLO1
         VryxTPsdQU45iRljqT4M3nbMaGcU+taDOTVykZqVaKh/JzPnnAmoUxvBvwARXqRcO27s
         ZjvmWC/Tyi0y2QoL34nmouRXkHK0vmhPk0knlMbt7Z82wvYWaWHNKZQpesldjwW73OAE
         E7jHOPCED1xzH513Vrv64R6TJ1OQd9sebHamaIxcnpDHgLE/Vx/MR2QGSDk+SfmxKKyW
         waDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HXZJcgW+WvZzVZmA613r9fLZvBiK5tou1MxALAsh8os=;
        b=V4CK+2dkfAgl+Bx69JWIfwYGqFzdBoDBGF/8RG+qp42Tl/uZ8R6qYIgQS5AnPvmanP
         Zv4bSulc50e2L8vDowWXQ57ps+J6i06XpyaAg0Jwpnf/e0dujeMr15gkiLIrABPFFMWQ
         mBtagZ5JkjhfbldUEJvlze+Au5KDTP82EBK2YXNu6m45YJozxwAIRPV74heM5V8fZ5n7
         EOxZcVsqc0+C6SgqoLU6snvypvSL9U8wWtwFmz7XousQ0Ne1rJWdcMHxH8Kwaqyb9/bg
         x5c7KPg+/Zr3mq3wWvLakd7wndOLgyj/Mu2SuJwGK0jq2IE9dPt8MNIocyOSXdEZQFcK
         0n5A==
X-Gm-Message-State: APzg51DIP/PHIkrLvxQvmRWAMhjTazg5VnVdJSsr4QNdTyLuSQ+T4OIr
        pXtnmr8ySyRmkda8CePg8wY=
X-Google-Smtp-Source: ANB0Vdbn4HbMHXqVAwXYWJSLZGtAyvsDtEeVZGeDvlD6OaWQ8SKY8W3mTA7EX7QyFH8WQUyZ6nJBzQ==
X-Received: by 2002:a63:d946:: with SMTP id e6-v6mr17425555pgj.24.1537045405435;
        Sat, 15 Sep 2018 14:03:25 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id y128-v6sm14687387pfb.56.2018.09.15.14.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:03:24 -0700 (PDT)
Subject: Re: [PATCH net-next v3 03/11] net: mscc: ocelot: get HSIO regmap from
 syscon
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <d9b23949e81272006e076e0b58d90e0541f80c7f.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <193ba88f-38ff-9ba1-8126-bd6da590e5a3@gmail.com>
Date:   Fri, 14 Sep 2018 19:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d9b23949e81272006e076e0b58d90e0541f80c7f.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66333
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



On 09/14/18 01:16, Quentin Schulz wrote:
> HSIO address space was moved to a syscon, hence we need to get the
> regmap of this address space from there and no more from the device
> node.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
