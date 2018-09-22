Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Sep 2018 23:06:18 +0200 (CEST)
Received: from mail-wm1-x32e.google.com ([IPv6:2a00:1450:4864:20::32e]:34061
        "EHLO mail-wm1-x32e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993060AbeIVVGPHBeMt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Sep 2018 23:06:15 +0200
Received: by mail-wm1-x32e.google.com with SMTP id j25-v6so6851587wmc.1
        for <linux-mips@linux-mips.org>; Sat, 22 Sep 2018 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ByV8VuyzbH3nkcDVM+0R77Y9G0069Sc6g+ThI8moE88=;
        b=S0FISwDeyLxH5FuWgCFiwvRRs1rtPVlyemvHIRnKeRg42g91+0+OSrsuYgSUpmzZyT
         dCs9/vRfod9P+/0AlbthH176z/cgOg5ZXWrlgW+3EAP9d85iO9PvosRBewgLfTj1EHcZ
         pgG7F+o5Qb7rDoHRnab4wR97Uesj/JA5yxdJCaGFR2xvTfRinhkhW7Fv+U5o+eHthGyb
         n/0MMlFe2PexRSiT13UPEbCEE2dyq0WfaNiynlUewtD+anSLBK5+tjnLTlh7WwQSgCKn
         JT3mWSlBMhFSQya9x4iqq4xd38c2mFpT8pVPuYYqxoe9g8399znLr4Ij+nyApMH0noTZ
         sYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ByV8VuyzbH3nkcDVM+0R77Y9G0069Sc6g+ThI8moE88=;
        b=Myuud6Y4FlwhK3RZtxJTzPykD+NQP1zlkMrmApicVZ3YYcT7a72IhaVv49aGyqKvK0
         yPWuJYrcN+jMV3qG6RvER8L/WqoQEWPAXlI/hk2FxTmlzwCfN3iPoaBRWQlSPpS0wYbh
         px3HuZuk6X5PaNWz6nkB5ZVo+610kGd6dvDUacPzfcOAq3W5puKn3lAEmjss9a+m338k
         mNAwdDhAj0am8nKRJQExd9/jgmZi2VdzON8M5DCO0SX4DUwSfWl0ilQNrGkkwE3ZfaFz
         GdIia2fXFdDGVp16707syFNlXSpZbTdBKHiRa5nNkfGJOzVERD6AvAOF8sqPjLyVE3XH
         757A==
X-Gm-Message-State: APzg51ChzPj7uiqipMR+6s9mUlGdZKArGjdVmjM+ypAmUFat4BtuPoXH
        zMkCHT0GlmEFrfn2YUIxTzQ=
X-Google-Smtp-Source: ANB0Vda+m24tHEXwdnNZhIP9RK6qKHcDCKshQNw47a6WSQNGPnbedr6zbO/gy6TlzNWkR7eJeOzCzg==
X-Received: by 2002:a1c:864c:: with SMTP id i73-v6mr2525243wmd.40.1537650369658;
        Sat, 22 Sep 2018 14:06:09 -0700 (PDT)
Received: from kontron.lan (2001-1ae9-0ff1-f191-401f-749d-725f-a2a7.ip6.tmcz.cz. [2001:1ae9:ff1:f191:401f:749d:725f:a2a7])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1617613wrt.0.2018.09.22.14.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 14:06:08 -0700 (PDT)
From:   Petr Cvek <petrcvekcz@gmail.com>
Subject: mt7621/mt7628 PCIe linux driver
To:     ryder.lee@mediatek.com, blogic@openwrt.org,
        sergio.paracuellos@gmail.com
Cc:     linux-mediatek@lists.infradead.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org
Message-ID: <8fd595af-53fa-c100-c369-8c7a30eba8e3@gmail.com>
Date:   Sat, 22 Sep 2018 23:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <petrcvekcz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: petrcvekcz@gmail.com
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

Hello,

I'm trying to play with mt7628 PCIe (and it's old driver mt7620), but
the system keeps freezing. It is probably because of bus master access
of my PCIe cards but I don't see any memory access controls for PCIe <->
RAM in the datasheet. The same problem is with MSI. It seems the root
complex supports MSI (it has an MSI capability field), but there isn't
any mention in the MT7628 datasheet too. As it seems the MT7628 PCIe is
based on MT7621 PCIe, I went for an MT7621 datasheet, but sadly in the
datasheet the PCIe section is missing completely.

Does anybody have a working MT7621/28 bus master setup or a more
completed datasheet? I would like to get some information for fixing the
mt7620 PCIe driver. It is possible the MSI/bus master is controlled by
the undocumented bridge registers (in the pci-mt7621 they controls the
manual oscillator settings, I've found a link quality register at
0x101490c4) or in a PCI config space of the root complex (around 0x700
offset). If you have a working SoC with MSI/bus mastering (= mem access
from card), can you send me the dump of there spaces?

Thanks

best regards,
Petr
