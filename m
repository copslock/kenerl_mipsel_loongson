Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 00:40:19 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32945 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026974AbcDSWkQk34RB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 00:40:16 +0200
Received: by mail-pa0-f43.google.com with SMTP id zm5so10863844pac.0;
        Tue, 19 Apr 2016 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Js3ffnp14vKB7Gxu/sBT1dw1Mk9ETGMukmybabxby7Q=;
        b=Tfd/9wW0I2hc0F6YwawfsLUBEHGo74mpCkj+XCcIEXaUDS3bPrrakfVLBjMKbR69gV
         lDeco9VzQL0Mu0BbilTphAIcQukc3dT4Xppc0PgssK5R72OGVsZ+NDNnfJ8CQPJlIjh1
         BorDyjIfqKlGuc4DKJjA23gavtp/ZeYT/hXHgLc+9qnUSB7I2BJH4PaIr77/tzTTso0R
         oGbZ9DhTQoopTl7oFyBGnrqQNM0+mzXAP73RGl92z37MNZTMUHLFkyQmYEKcGzRp3RKK
         paDD/tYEeyTd9yi3/0UT4ziA/c2eUikkJvlcA2g8cAzKsKif9gOeI4sKA2f31+fsr8ZC
         md+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Js3ffnp14vKB7Gxu/sBT1dw1Mk9ETGMukmybabxby7Q=;
        b=IsfVw0o3hcXkoAPbGSzPvbjFqU7AhxWGE3c1DKWKgjWesDHh9RhhQIRKg1mD/QeYy/
         HGg2r+iDXemtg1m4EH708bb38zYiNL3FkzvzWFq58uqEMT8V0niYQxe1otjwlFCBIRrN
         PH6wLXfxM77KpYomvzC+egBzMBAMEqw+IP95ru0os17RVeDZKI+Cs2Lnwora3aHtdnht
         GlQGynkqxIVsl5bpJDQ8J7tAc+dGBvZHTwT9slD/zNZXHX8Eps4NVtN8/S+hUcf1nDyb
         0mLogpMeU6l7HzMvNrjdgoqxOUiF7Nxh/tMauhOlHfBTMKoT/2sD6qMcyMOl6Jwc4Mj+
         iedg==
X-Gm-Message-State: AOPr4FXx3wWePhb36YT0yQQQWmJqW2v9t6oriNJ20dWuQyVgJzyh8RHbjZXPfo9vFrRDow==
X-Received: by 10.67.4.69 with SMTP id cc5mr7652154pad.11.1461105610997;
        Tue, 19 Apr 2016 15:40:10 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id x184sm16422138pfb.53.2016.04.19.15.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Apr 2016 15:40:10 -0700 (PDT)
Subject: Re: [PATCH] MIPS: BMIPS: Adjust mips-hpt-frequency for BCM7435
To:     linux-mips@linux-mips.org
References: <1461104673-21878-1-git-send-email-f.fainelli@gmail.com>
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jaedon.shin@gmail.com,
        Florian Fainelli <florian.f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5716B349.9050703@gmail.com>
Date:   Tue, 19 Apr 2016 15:38:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1461104673-21878-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53108
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

On 19/04/16 15:24, Florian Fainelli wrote:
> From: Florian Fainelli <florian.f.fainelli@gmail.com>
> 
> The CPU actually runs at 1405Mhz which gives us a 175625000 Hz MIPS timer
> frequency (CPU frequency / 8).
> 
> Fixes: 8394968be4c7 ("MIPS: BMIPS: Add BCM7435 dtsi")
> Signed-off-by: Florian Fainelli <florian.f.fainelli@gmail.com>

Discarded this version in patchwork sorry for the noise.
-- 
Florian
