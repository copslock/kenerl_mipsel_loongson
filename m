Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2015 22:33:28 +0200 (CEST)
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34487 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010626AbbDRUd1Zz-pB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Apr 2015 22:33:27 +0200
Received: by oiko83 with SMTP id o83so98571474oik.1;
        Sat, 18 Apr 2015 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IP4mxTs4/IzoRdKjuV2/ORXJTj3dUObLy2pUGtvEOFw=;
        b=RWbHXayJa74oOTqNZs/feTtY/3AFuuxro/nSOBXGE87EszJRVE380Ak0RHaLo3LGsF
         NoDVkCfxiRBZSUia6SiVXRO5VidZ2rT5HLfLrwWEZ6W7UvWNOSYbl8ijxcsM0eYOQ5U+
         OCx8QNstgpRNYgK9XM1wOuXsVxcGj4bCviGKIx/ozhIAw8e078Sw7OVgEZQDu1CgtxTk
         ibfb7NbTL7liNx4iOsP5lDfJTeZ4TozNzJvGXLJv6HF143PkB+H6OBDFZDTp0BYEyigL
         IkWZ8H1bs9nsg+S3QypKRZSVa3LdzRlDhPrBKg2UKX+uIYWYbmZwCRr9dw0WT8TG7GgZ
         VfZg==
X-Received: by 10.202.98.193 with SMTP id w184mr7751912oib.96.1429389202977;
        Sat, 18 Apr 2015 13:33:22 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:6158:2ccb:302b:ed9a? ([2001:470:d:73f:6158:2ccb:302b:ed9a])
        by mx.google.com with ESMTPSA id n1sm8994845obz.21.2015.04.18.13.33.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2015 13:33:22 -0700 (PDT)
Message-ID: <5532BF90.2040907@gmail.com>
Date:   Sat, 18 Apr 2015 13:33:20 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATH] MIPS: ath79: Add OF support and DTS for TL-WR1043ND
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
In-Reply-To: <1429280669-2986-1-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46912
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

Le 17/04/2015 07:24, Alban Bedel a écrit :
> This series add OF bindings and code support for the interrupt
> controllers, clocks and GPIOs. However it was only tested on a
> TL-WR1043ND with an AR9132, others SoCs are untested, and a few are
> not supported at all.
> 
> Most code changes base on the previous bug fix series:
> [PATH] MIPS: ath79: Various small fix to prepare OF support

Any reasons why Gabor Juhos is not CC'd on these patches?
--
Florian
