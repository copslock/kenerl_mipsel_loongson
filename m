Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 10:13:17 +0200 (CEST)
Received: from mail-lb0-f196.google.com ([209.85.217.196]:33653 "EHLO
        mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024739AbcDDINQaOFz3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 10:13:16 +0200
Received: by mail-lb0-f196.google.com with SMTP id bc4so20560329lbc.0;
        Mon, 04 Apr 2016 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JxKUXSaQ1gNcKhmBB6j9OLEF/kBlTtB7CY13VqYkeOs=;
        b=vVgEE+/qLJx0NhwCOYz+GiNTWSG8T5S9QXo4vPN4/YMY/B9Q0sKz2wBy8Kc/Ft9rYo
         Ckm//uXLhllaWh8cssDwhmGCk0ghsAAI5OUGK1Dochmvbq925G0119/S5G8D3kidz+X9
         NJsMsAGl/us6GsE/JocaSTgWnhZX9G7lsGuRl0WDoxVYTe4OHu0PD+XoLG53sOk3eB1q
         mcXWzs8yg95uFbTTgyTJfNuqBB2kfLmaf/yFUPnRb4oD6vfypcE9S/eLSb5SbNX+dLpq
         jjIAxMWwkykr+DCLVsyJwX3Z9/WnSIUqUl5hFV3A8YBiSI5T7dVRuecHpZMdFQEI3o6W
         lIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JxKUXSaQ1gNcKhmBB6j9OLEF/kBlTtB7CY13VqYkeOs=;
        b=gcMUKT7eI5c4HJ16uEFNajV6wiA+UfEqAccPIJZ2tmovreZMgXJVOwjX/jhnqsq4qq
         zM7BWw2clYnga6Lxc0Lm/GfozQYrAd6WH/1cIZssZYRqO+e9rs+k7I/JD6CC9cSXbPcF
         wNZuNxv2OGwcYjittVJhpq/4ucOH0HlLtY+pfaR4Y7Yq2cwgVnBAl4B2eXYpGjhZV2VN
         34ucnYq867e4NozAvSSQSsHeyGKigtSda3whYYX/YcQhZu/QXHhilB+KnCAyVQ7CDa4V
         ZZAsMJw4rOLCQaMrRCVNZNCc4v/rJ0Skl7pILgulNwPNVbRNat6Y4se6BIT5giUOSQXX
         SMJg==
X-Gm-Message-State: AD7BkJLcgyD8QxHsQhiH5chRbyJYoMIQhDT6FALg7ZrEFrqEibXJe55Ite1p//IhNP7BRQ==
X-Received: by 10.28.88.81 with SMTP id m78mr10604182wmb.58.1459757591170;
        Mon, 04 Apr 2016 01:13:11 -0700 (PDT)
Received: from [172.20.10.2] ([31.221.134.196])
        by smtp.gmail.com with ESMTPSA id r8sm27716986wjz.34.2016.04.04.01.13.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 01:13:10 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/3] MIPS: BMIPS: improve BCM6358 device tree
From:   =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20160403231010.GA6518@linux-mips.org>
Date:   Mon, 4 Apr 2016 10:13:07 +0200
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        jogo@openwrt.org, cernekee@gmail.com, simon@fire.lp0.eu
Content-Transfer-Encoding: 8BIT
Message-Id: <1BA9312E-2743-472E-B07E-BE69C54573DE@gmail.com>
References: <1459685585-11747-1-git-send-email-noltari@gmail.com> <1459685585-11747-2-git-send-email-noltari@gmail.com> <20160403231010.GA6518@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.3124)
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

Done,

Álvaro.

> El 4 abr 2016, a las 1:10, Ralf Baechle <ralf@linux-mips.org> escribió:
> 
> On Sun, Apr 03, 2016 at 02:13:04PM +0200, Álvaro Fernández Rojas wrote:
> 
>> - Switch to bcm6345-l1-intc interrupt controller.
>> - Add ehci0 and ohci0 nodes.
>> - Use proper native-endian syscon property.
>> 
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>> ---
>> arch/mips/boot/dts/brcm/bcm6358.dtsi | 29 ++++++++++++++++++++++++-----
> 
> Any reason Why didn't you fold this patch into the "[v3,2/2] bmips: add
> device tree example for BCM6358" patch of the other series?
> 
>  Ralf
> 
