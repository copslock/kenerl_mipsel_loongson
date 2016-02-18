Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 03:40:54 +0100 (CET)
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33732 "EHLO
        mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012795AbcBRCkwyWWQU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Feb 2016 03:40:52 +0100
Received: by mail-ob0-f181.google.com with SMTP id jq7so45961727obb.0;
        Wed, 17 Feb 2016 18:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=7W9K46wmes8YiVjL5z4gbKZQQk8wDkDVIEkjYLrdsW8=;
        b=S42csBSeO2Pbx/zTrrSd8V36bQEYJsA6DibylYSBjTRpgkyLw9r+9zAf+8zKKW266s
         S5ILRKkOQO3yhq1y702YxLShVXvpLGMveYFR7AYA9TjFywQKk9DQylDToug/2k3gGu2n
         5NjP8JTD/cXRsfxohJVhFEenzY5o2vzQsfRlfuVA5OZq2xO3kC7UrnLvDWNX5Mhq0lr7
         xg/iT1tN9mMqPEOx/xk92w9duOHD70Idc1Pfjlpe5RnldIA8R7bhGp5drzWlVIvn7mLZ
         snbPacRcXoPsd4cvH+SUVzOhk7m3NRGy/wr5Xip8m2B+nGWaBVXMGICGxzPcMlMX72o+
         2+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7W9K46wmes8YiVjL5z4gbKZQQk8wDkDVIEkjYLrdsW8=;
        b=f6AfQQOvPzqjGExU5EdRrBC5lPAi8YuUxDBZEpl5q+ynHTPKyQoZOGyETXfpWa0ndL
         X51zn4zyNQNaoZlVl2P/waXRf5z06f2C/Of/YnOUzQNGLWZ0qrTj3OUJZSyT0Zdqouwl
         FHXvzVEPtkbIhWyF/l1ghylwJR4DbkggBlnSl4YGGNe/1xBir7ZKT0kA2n2geepqkMRJ
         a62xjzyQoBNJpbBmMDvOyqBnWfvCTZ5f72BNvEOhPcC2UxRYny4B3KPxaz3IYG8Zo1fE
         kBGMIs17Ljo9DyAH/DpVzO82SBLbeJbJaaLicBr7ExjveMl6xacCsDJTFBWNpzvutQFL
         8UHQ==
X-Gm-Message-State: AG10YOSKAyDehOB2UxLUVXGJ3i8m+knY0vh8oGK1YpPlnPTE4UtGx30U8utgz+d2hTLwSA==
X-Received: by 10.60.116.169 with SMTP id jx9mr4096061oeb.30.1455763246815;
        Wed, 17 Feb 2016 18:40:46 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:f423:6f06:7df9:a250? ([2001:470:d:73f:f423:6f06:7df9:a250])
        by smtp.googlemail.com with ESMTPSA id j79sm2598462oig.26.2016.02.17.18.40.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 18:40:45 -0800 (PST)
Subject: Re: [PATCH 14/15] MIPS: smp-cps: Add nothreads kernel parameter
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
 <1454469335-14778-15-git-send-email-paul.burton@imgtec.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@axis.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <56C52F2C.8070307@gmail.com>
Date:   Wed, 17 Feb 2016 18:40:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454469335-14778-15-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52112
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

Le 02/02/2016 19:15, Paul Burton a écrit :
> When debugging a new system or core it can be useful to disable the use
> of multithreading. Introduce a "nothreads" kernel command line parameter
> that can be set in order to do so.

This should be documented in Documentation/kernel-parameters.txt as well.
-- 
Florian
