Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2018 16:48:48 +0100 (CET)
Received: from mail-wm0-x22e.google.com ([IPv6:2a00:1450:400c:c09::22e]:35666
        "EHLO mail-wm0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeBVPslq0BVR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Feb 2018 16:48:41 +0100
Received: by mail-wm0-x22e.google.com with SMTP id x21so4516399wmh.0
        for <linux-mips@linux-mips.org>; Thu, 22 Feb 2018 07:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BTO4bBHE37h7vYfbtI5f2EUWkgChnaI9q4d84rF4v6Q=;
        b=sFo3+v53lIZ6RcfqFhR7GQxqFJv97lBEaHEKm+mtbf18yLuPsVWfbER2qi/OCCUua+
         kwNPv9NIX+LxX2UCHP08EQnzQZKP2GqhmRXkxqO0Oj+VRKAFUtlbVNd65mghbz/xkMJD
         2FJEfjjzW4cadnqo3pUx2+++lEGFuJXfRnQfc9sgArF7VCWnFgE5b1AjMmbEBHmVP+8S
         wCgVrS4I3iDArqzG1cpRvy1M+wFdKQPyyMz//bg3aVD3u0ykfZX7dgtlO+QGvV34K3d0
         cTpGUpIQI7Kq9rP78yl1Q0tVWNy9rYh8eG21FuYbfBYYz9gO1XWeBn2P7RgddcNR4Xho
         FgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=BTO4bBHE37h7vYfbtI5f2EUWkgChnaI9q4d84rF4v6Q=;
        b=W50yQKX5mbN1rTauWVzR11pNPW6Hk6XmOrTH0StGNkhQZLpJi7yMy2bFSR7teK2aLY
         +tqhCcU/dc4DxxJIs/QF9ZwFP5K6PbfR0hUHZPLs+caMoGYMDJ40/jASXyZy7Uv+GXeD
         QfZIwP4SLLPAKc0homChSFy37ZHK9LOEfQ6rd6yK6D94odrNWU26BEEPN/rc7cQG0jNK
         vPK5YRFqZ8iKxnckC+IITHGbRbrajosRdY7u9s/JA/hV5p0WBLsPRsR8zdgEETIp4YxK
         uxi7L/yNwBSTq/KDm23gbqccns43PeEw4c1JZcWiS6p4FRcbVOeszja3Isf8kc1qnH2y
         vpCw==
X-Gm-Message-State: APf1xPCCAUYl+4zIzRNkIeSKKKBn/9KQs/fXfV0N8vWMJVZGZZBBJKVF
        4VpJEV4A82+25pJXppqjxio=
X-Google-Smtp-Source: AH8x224NTueYVw7VqcodwySl7haAaknZAqMLK2AwGRMoS1/7wKQ3DZMF2bfQwPyy4rXlOfFSHGvrTw==
X-Received: by 10.28.145.4 with SMTP id t4mr5145778wmd.14.1519314516250;
        Thu, 22 Feb 2018 07:48:36 -0800 (PST)
Received: from localhost (nat.nue.novell.com. [2620:113:80c0:5::2222])
        by smtp.gmail.com with ESMTPSA id e67sm939469wmf.7.2018.02.22.07.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Feb 2018 07:48:34 -0800 (PST)
From:   Johannes Thumshirn <morbidrsa@gmail.com>
X-Google-Original-From: Johannes Thumshirn <jthumshirn@suse.de>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jimmy Vance <jimmy.vance@hpe.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Andreas Werner <andreas.werner@men.de>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zwane Mwaikambo <zwanem@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-mips@linux-mips.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v3] watchdog: add SPDX identifiers for watchdog subsystem
References: <20180221122744.28300-1-marcus.folkesson@gmail.com>
Date:   Thu, 22 Feb 2018 16:48:21 +0100
In-Reply-To: <20180221122744.28300-1-marcus.folkesson@gmail.com> (Marcus
        Folkesson's message of "Wed, 21 Feb 2018 13:27:34 +0100")
Message-ID: <mqdlgflm3ei.fsf@linux-x5ow.site>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <morbidrsa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: morbidrsa@gmail.com
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

Marcus Folkesson <marcus.folkesson@gmail.com> writes:
[...]
>  drivers/watchdog/mena21_wdt.c          |  4 +--

For mena21_wdt:
Acked-by: Johannes Thumshirn <jth@kernel.org>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
