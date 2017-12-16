Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Dec 2017 15:58:21 +0100 (CET)
Received: from forward104j.mail.yandex.net ([IPv6:2a02:6b8:0:801:2::107]:49013
        "EHLO forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdLPO6OH7DCS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Dec 2017 15:58:14 +0100
Received: from mxback4g.mail.yandex.net (mxback4g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:165])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 4B0E644602;
        Sat, 16 Dec 2017 17:58:06 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback4g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id IcEZpjkTIU-w5RSEaXg;
        Sat, 16 Dec 2017 17:58:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1513436286;
        bh=4NuJls5Wjnl0GoMaZ2sY6djPCoQMIfExn7Xjme8BeT4=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=DeS2yugC8CebByn9qmp4lu5Gjd7kWzY5AVv1YcgtOswPNxWc1GK2GR5jJhTA72F4Q
         NwcbyQRRO4gG6kVXqN2D2p0ebZ40BiHgpZSe92kXGNPaTxNIzXYBIir8i0eqOxzBsp
         lWmrXlbhLRpPU8R3qaRsC6Aw4qpYsbzYN1w0vxUM=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6waszUSHIG-w1saqsUj;
        Sat, 16 Dec 2017 17:58:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1513436284;
        bh=4NuJls5Wjnl0GoMaZ2sY6djPCoQMIfExn7Xjme8BeT4=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=feqRKNQ6NUQwKw5QtSjgk6fJ4xTPYYV/7jmam73h27Dh1SaKpoRSOe7plTJXqPBsL
         kFFmORxi172H7ULcenxbpp6I1Zn33+oh5iwLhmiSMhv8UqU1LMATeHThwGtFfyV9LF
         CtlfX9EvRTuuFfhHiuFMm+KDyXQohoSccRCzabUA=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Huacai Chan <chenhc@lemote.com>, linux-kernel@vger.kernel.org
Subject: Add YeeLoong support v5 
Date:   Sat, 16 Dec 2017 22:57:46 +0800
Message-Id: <20171216145751.3486-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

Change since v4:
Use SPDX ids copyright header
