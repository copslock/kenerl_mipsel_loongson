Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2015 06:01:30 +0200 (CEST)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33625 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006506AbbE2EB3KupBG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2015 06:01:29 +0200
Received: by obbnx5 with SMTP id nx5so48522858obb.0
        for <linux-mips@linux-mips.org>; Thu, 28 May 2015 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nr2B+QPQ4v2o0jRI+iNAFicbxR7Im+ETP7RssgHt9fs=;
        b=W58KI7IaHmKMFq+94OGTdNT56OXcuGBh2xR8Eej4ZJvtaqNG4Q8/+aLNYmF7Se3gIe
         qfK8S4h71aKcShb4MSBtA8yEjcix+Mwhqsb4bxK1+FWpSTDe4w1RwCWXhaPTYeOMQ45r
         Wq4qKMP3B1TsVg2DZM4rnZe9HEnKSU1Uz3bVQWXmSJ3k5zl6GlKKTo1H7DoVAZoVDTDz
         jF1Cz9QQ1XW3iw+385MjlYlnoF2Avy5I2SR32f7I0iQy4aWz18O6AsMT/JPDrq7nwnfv
         28Qt9sj9qcZqHtS+KbfkwRIyRdeRQIeviXVqNONf9+6hq4RgIjwvlkIyJKBeOifhODJQ
         CKfg==
X-Received: by 10.202.169.214 with SMTP id s205mr5042578oie.71.1432872085859;
        Thu, 28 May 2015 21:01:25 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:d4fe:27c9:9624:cea8? ([2001:470:d:73f:d4fe:27c9:9624:cea8])
        by mx.google.com with ESMTPSA id d74sm2353076oic.9.2015.05.28.21.01.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 21:01:25 -0700 (PDT)
Message-ID: <5567E493.80800@gmail.com>
Date:   Thu, 28 May 2015 21:01:23 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, sre@kernel.org,
        dbaryshkov@gmail.com, dwmw2@infradead.org, arnd@arndb.de,
        linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org
CC:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 8/9] bus: brcmstb_gisb: Honor the "big-endian" and "native-endian"
 DT properties
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com> <1416962994-27095-9-git-send-email-cernekee@gmail.com>
In-Reply-To: <1416962994-27095-9-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47720
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

Le 11/25/14 16:49, Kevin Cernekee a écrit :
> On chips strapped for BE, we'll need to use ioread32be/iowrite32be instead of
> ioread32/iowrite32.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Applied to soc/next, thanks!
-- 
Florian
