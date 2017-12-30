Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 19:28:57 +0100 (CET)
Received: from forward105o.mail.yandex.net ([37.140.190.183]:51091 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbdL3S2uXTYkc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 19:28:50 +0100
Received: from mxback17j.mail.yandex.net (mxback17j.mail.yandex.net [IPv6:2a02:6b8:0:1619::93])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id C2844444300F;
        Sat, 30 Dec 2017 21:28:43 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback17j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id LYmtmQUoIJ-Sh7ipgPe;
        Sat, 30 Dec 2017 21:28:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658523;
        bh=04vfkb63LbswQl3XB6IvAu8pE+TyHyD6g1zWQIcjISQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=uhdCHKiuJMnsJ/WMMnXrxCpgvVfgjSX5Bk2gjOP3tO0Y2yIl4OEzCj77Owv8UgaJN
         POA9qLOa0wmtlq/P8Fel3pwMonKHRPUyopoAEHPYLQIW2mif/xzalziWvoFOb7Ypfj
         YDC3lIDW7fWofR18ptjfXS6l9wbLLvimItIUDj50=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6PdmBEypOo-SeTGSUns;
        Sat, 30 Dec 2017 21:28:42 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658522;
        bh=04vfkb63LbswQl3XB6IvAu8pE+TyHyD6g1zWQIcjISQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=DEMbAvDMk8x/FFThHd2uljhBTRsexlVlaqYqMpMaiGAurZAxNgn2HFHi1UjPiSBjL
         keq81iAfoP+l3WGn8TCCSCnACS19zQMW+YyrvUJxqYC4us/adN6YStbvVtjnwcvn9o
         FV3QCmGiBgiR+zR//0j0MNO4ZY1EDG6bf4FSnUg8=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Cleanup loongson64 mach to use SPDX copyright format v2 
Date:   Sun, 31 Dec 2017 02:28:23 +0800
Message-Id: <20171230182830.6496-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61790
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

This patchset should based on "Add YeeLoong support v6"

v1 -> v2
Fix the issue raised by Philippe to use the corret style
