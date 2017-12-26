Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 04:26:30 +0100 (CET)
Received: from forward105p.mail.yandex.net ([77.88.28.108]:46704 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbdLZD0XBN1s1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 04:26:23 +0100
Received: from mxback14j.mail.yandex.net (mxback14j.mail.yandex.net [IPv6:2a02:6b8:0:1619::90])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 925434081DFE;
        Tue, 26 Dec 2017 06:26:15 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback14j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id wmo26f9iIX-QF4qgptY;
        Tue, 26 Dec 2017 06:26:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514258775;
        bh=3C478mEA3ohCo82TTp3JbBC0eMmylajOdLeYm9UaWrk=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=CE36YjbWKMfEvBKMHmxxRT3FOBTksozs+Kl4tdC5fXU98mE3PFiAJzBoVNbDD1HFM
         ewX5EgSkcNNpQPJGwrp+i/WEFxS/9zIcoKggDBXjZ1PCPYoFgvornjPvHQ0E8x5ZEL
         YnwlXhcB0xDn4m8hyTEsUlWDjVonZP2TcpK1pkMQ=
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id NFRULz4HAX-QBxOpEum;
        Tue, 26 Dec 2017 06:26:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514258774;
        bh=3C478mEA3ohCo82TTp3JbBC0eMmylajOdLeYm9UaWrk=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=UlrtwvCyyF211L+zmnkwfmFXm1qq9BDKYdjTHh1SlXjDk7d68Lx2SJwr6bxsDJywY
         iq0VL8rQwiqdIYNAZuVXVEOvvYcOY/twwUVcNtPCtPEZYh3mH8fya4R4/wHDmn25jP
         XcoLXIXfZnSoVheAbHY8AKw4oup9Hiz6YgO1gffE=
Authentication-Results: smtp4j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Add YeeLoong support v6
Date:   Tue, 26 Dec 2017 11:25:58 +0800
Message-Id: <20171226032602.11417-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61582
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

Change since v5:
Use arcs_cmdline instead of loongson_cmdline
Fix GPL copyright issues


Change since v4:
Use SPDX ids copyright header
