Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 03:31:33 +0100 (CET)
Received: from forward103p.mail.yandex.net ([77.88.28.106]:45264 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdL0Cb0aOdSZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 03:31:26 +0100
Received: from mxback14j.mail.yandex.net (mxback14j.mail.yandex.net [IPv6:2a02:6b8:0:1619::90])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 5D2682183C94;
        Wed, 27 Dec 2017 05:31:20 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback14j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Y7CaEtSKln-VJXONs7h;
        Wed, 27 Dec 2017 05:31:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514341880;
        bh=70zefyLFoRqyXjWZY61CWyTv591E4XtFTpAHeW4tL0k=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=fiMHlroutYMYH/sueNPXXTBipZobX22jKX8Cp9FMHPBTkZ2AmUfWHd4zl6ZFkG077
         r6FcXZoIfXdAPdBKSPoz8l4fthQ9QTHluAhOgIHLNEntWB0tLSEFD7afVzyFxwWTLU
         rw8Y0/X3QOYrSsS1XQOY5AiHoRJolDdFyk//assU=
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 8At41EhZ1X-VFf8ivTA;
        Wed, 27 Dec 2017 05:31:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514341878;
        bh=70zefyLFoRqyXjWZY61CWyTv591E4XtFTpAHeW4tL0k=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=aEu1tnk9RWZGMOszwhWg0jFkc5gZ8eo72CaqoGs6cimXWiYTVogufA4ZLp6ECUuuk
         WzoRQRgrXpxT7RWa/P1PfhZYke70/H4KBub92ikETnrKPjbIGBmtU91GOJYzkJlNVK
         cXBJd4RiNU71m9n18MoIbeYVXX+S1B8nl/+ZZ5EQ=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: rename arcs_cmdline to mips_cmdline 
Date:   Wed, 27 Dec 2017 10:31:02 +0800
Message-Id: <20171227023103.12870-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61612
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

This patch should based on "Add YeeLoong support v6"
