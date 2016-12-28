Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Dec 2016 02:16:01 +0100 (CET)
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36059 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991129AbcL1BPx6-8-Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Dec 2016 02:15:53 +0100
Received: by mail-pg0-f68.google.com with SMTP id n5so13957318pgh.3;
        Tue, 27 Dec 2016 17:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=kotmR9ZRLHWJYkUyYgKPvLXDhjWmrovYjfGiGH4gR3s=;
        b=SGGbVfBTCDooHnhr7YYko8BlFOuT3l3HyEQKnNiiM3ha8V3Fv0tqYJCcPt6UCI65MM
         BmTex47E01iEaeQFml4QEhmqJqEa8yFhrcuyWSeE5ldxN6nObewApjvDq/y9TEhOacLV
         ehttxTLIpCLyoagrENBBJcXJRBxwZA/AjpT9G4/639l2pGGcWED3FWM3zPWNpf7kt854
         eLV4OqZZloTrPRKa/PMulPU/UZfOkLqeGicwdWvCdusmJXw2caSz3MHvWM+0Gweolk7s
         wKGtTpiaVz7O3hydJci6PioliJXNN2QirzJypIh1CVjLWTcH7lbuqs38CAfzx5Dz2xqz
         b3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kotmR9ZRLHWJYkUyYgKPvLXDhjWmrovYjfGiGH4gR3s=;
        b=amGYRSFodGiV3s4k5MT0pE4Gp8F03nfbsi6pM0OEv/hyHSp+GxKj5TLx/DBjF36O97
         X7DE2mbzEDLtOUxMvU2FbzskOmH29lGfJN6Yjmelty7YjXX1DQ8D3SbzXfNpKAvKPy/y
         ciM6hLXuHeITQqg54XzmKIMWn8tlSwLyCglOqi8lY5EH+Yt6TLNG664U+T388e6NfspF
         zKHdYe4+rcKuVk6YbdCGHieZbZ45Tt8l0zV56aiAraTHteU1pA4zmYM5XUQ4o5eY/9qh
         pX4nmNAXte/E6F5kIRE8/k+NRE3Eszi7JUxa6ojMF6Df2Shk1kFkc6r0nFwFJQnjiL0E
         scKA==
X-Gm-Message-State: AIkVDXKLtRXQT5mms3RvVdblEh1dQ0WAyvzPh4FBTsw0/r+fZ4vt852sf+f91kWdwN34+A==
X-Received: by 10.84.197.1 with SMTP id m1mr73210591pld.159.1482887748062;
        Tue, 27 Dec 2016 17:15:48 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id i76sm92087963pfk.89.2016.12.27.17.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 17:15:47 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: bcm-qspi: Enable the driver on BMIPS_GENERIC
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20161227015923.882-1-jaedon.shin@gmail.com>
 <20161227015923.882-2-jaedon.shin@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <57636381-e1af-cbbd-6d88-a184178ab132@gmail.com>
Date:   Tue, 27 Dec 2016 17:15:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161227015923.882-2-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56129
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

On 12/26/2016 05:59 PM, Jaedon Shin wrote:
> The Broadcom BCM7XXX ARM and MIPS based SoCs share a similar hardware
> block for SPI.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
