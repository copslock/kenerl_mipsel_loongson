Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 23:07:44 +0200 (CEST)
Received: from mail-pf1-x441.google.com ([IPv6:2607:f8b0:4864:20::441]:43072
        "EHLO mail-pf1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992482AbeIOVHdpZjop (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 23:07:33 +0200
Received: by mail-pf1-x441.google.com with SMTP id j26-v6so5809494pfi.10;
        Sat, 15 Sep 2018 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fj0BsDTe0Vunlp169IKvL431u7kjnyVeeWMl6UD9plI=;
        b=suX/wVnnsH/9aRfvK8m+982q5dJO820/Pi8yR7432MHdjT4VOuwAI/jzGAYY6GyP9X
         bFLSEFJIPK8Uhyehf29p03KVEpQgs3DHyX4vfPWuHVFdWeV5dHsJzqx3XJuQmFkvQL0Q
         dTktlrPbTjkh3LzRXwrlhNrbS937BrP9jFMG2pexacWpW72wlwkV0qJiytxq5v3bEwba
         JxlOGRfrS2oGGUBwza6de46RSQvqjfED3wLLAHI/zxHHZkJvF43Q7dZw9dVlcEe+kOkD
         cPI+l968u5uFBKlSElJG/v61glXtfo7GYO58RndTHbY4/Cr04xaKRLrsU1M0M+eE12d9
         2N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fj0BsDTe0Vunlp169IKvL431u7kjnyVeeWMl6UD9plI=;
        b=j8zvfaKhHM4nU1AxOcsh62/Pa8CqxvZ7yGRdpoq/4JTftnBzzi3uCGbp/7JN5egAA3
         v990xcQv7/3ftS1MVnQgpGgHVArPqpM+jvzHfXN/L5NjN5y67xDTV7kJmCKAkcJFyVkT
         OtQhe1E/GBpeATORaWqt9k+yXdSChMzjufJ2c1VZEQgkZJEwCli556gPFmLnOuKfC7N8
         cqRt5l6TLBsSCGVR0T1jE+9pn1kK/DnY1upzuB3ydKiDEXTstpFDEH608/AUokuxX3ac
         S09MZhRFpbqdXyN+sWQUa9GRYceOqOe7lZeD05JJQWqUaEKH9Bif9bg9uorJJPxIgyIF
         9YPA==
X-Gm-Message-State: APzg51C1PfQGS3xK9nE23kOqjG12d/qsoRfdM1OLfTpsF9Rt4MDAZrwZ
        A6cRkOT6koPJzDv9c6rxFBw=
X-Google-Smtp-Source: ANB0VdaF2PXK+XTA0sy1I47uKo9MwrPGPtrjORO8MbNLcX1TeEECz/NamN+3p9g78QugiDzPUCnsMw==
X-Received: by 2002:a63:ce11:: with SMTP id y17-v6mr17331409pgf.201.1537045647616;
        Sat, 15 Sep 2018 14:07:27 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id z63-v6sm12681933pgd.69.2018.09.15.14.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:07:26 -0700 (PDT)
Subject: Re: [PATCH net-next v3 06/11] phy: add QSGMII and PCIE modes
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <52d9c9444175911a8f6ee3dfec8946646907135b.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e69b392a-86fa-7e8b-9803-aa1c529efca1@gmail.com>
Date:   Fri, 14 Sep 2018 19:27:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <52d9c9444175911a8f6ee3dfec8946646907135b.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66336
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
> Prepare for upcoming phys that'll handle QSGMII or PCIe.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
