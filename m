Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 13:29:06 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:39000
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdL0M25Wfgk6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 13:28:57 +0100
Received: by mail-wr0-x244.google.com with SMTP id o101so7983464wrb.6;
        Wed, 27 Dec 2017 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+K1+XBWntUwsjVXIZ1LqEj5lJ5dI+d+61ao4icYsd30=;
        b=Gr4G7bGk4RFEP3MFIHnL6bQqIdJVXlBaESvV4CMGsCJgrJSDkEIoXLCGXUAY8Q0K07
         tSsONPyoTDrpVChMdYL725wdJbW5HDEZrwLrOlxkoFNhvykipTMQkDkyMCC1YnSKPLPG
         Rs6I1z4Ak5+eHDCxk7dHCduJr7n8Tzx6klPVW9ah03iYoBVAvlcB3rlXfbhQKARhHddU
         MXpgGnGtsDXBu22xThIR4YUYD4M+Z6qyXsPxi1K8Qi9QxYuaCQ3a0x3gfOjvhaWoa2Ab
         6pyRLebPKf6lPaWA1a7+tG65WfeaLXTZ4EjB+nTt937gFZHjh/vmyQ0C3Sb6tfIAEMYD
         7wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=+K1+XBWntUwsjVXIZ1LqEj5lJ5dI+d+61ao4icYsd30=;
        b=pmpVw4cjQ++rZOpgUZmgKjyt9oplq8KX7PYey4R/dIIAKl+7e5sE63Nmmd1fIJnl7E
         v6Mq4xCtGwUMQoR/7LTp2qPbMx1eEk8rciDuTidZYKgDLZuOzyKLcV4D+n/HsC4ee7jh
         W/6mW0b6rjfDguG6QVIZ5hWQ9tHyONtrs3CMJM33RQiN+dD0869DqRh/USpoTbNgpXn0
         vb/4ue0gzIYxUAQ/FAdt3+AzkeJcvIwv8XTdwkG8IyqL3hG78CiOe8/jdU+f9X43bv5p
         RoIRNP8ZVg8OMgpBRzFRZ7uoXHOB3XdKKfPREBm9yeyF6Jx3r1s+6LeNEj3M/iMu8auh
         xiHA==
X-Gm-Message-State: AKGB3mJg8JO0tNF60OWkheNObC9lgx0wyYtj0SnTygSOl0y62PubwTjD
        Tl3qX7qhveUpnT3hH1J1N4A=
X-Google-Smtp-Source: ACJfBovQIzi7A34KK2xhtwVnGv46W3B4YWhLut8JxgGpwOe9e8NAt7eTbjC9rQ44p7NgFI5rwoplhg==
X-Received: by 10.223.177.217 with SMTP id r25mr27856612wra.191.1514377730402;
        Wed, 27 Dec 2017 04:28:50 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id t61sm41285340wrc.21.2017.12.27.04.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 04:28:49 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id D27AF10C322F; Wed, 27 Dec 2017 13:28:48 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Zubair.Kakakhel@imgtec.com
Cc:     Mathieu Malaterre <malat@debian.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2/2] dts: Probe efuse for CI20
Date:   Wed, 27 Dec 2017 13:27:02 +0100
Message-Id: <20171227122722.5219-3-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171227122722.5219-1-malat@debian.org>
References: <20171227122722.5219-1-malat@debian.org>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/configs/ci20_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index b5f4ad8f2c45..62c63617e97a 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -171,3 +171,5 @@ CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon console=ttyS4,115200 clk_ignore_unused"
+CONFIG_NVMEM=y
+CONFIG_JZ4780_EFUSE=y
-- 
2.11.0
