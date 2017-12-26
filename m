Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 14:24:11 +0100 (CET)
Received: from forward106p.mail.yandex.net ([77.88.28.109]:32926 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLZNYDCLPro (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 14:24:03 +0100
Received: from mxback1g.mail.yandex.net (mxback1g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:162])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 696F92D8426D;
        Tue, 26 Dec 2017 16:23:56 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id pYTELRc19r-NsMStE9n;
        Tue, 26 Dec 2017 16:23:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294636;
        bh=03vtqMahdAkTaKIW+vAfUjDA2vMHFHGaXoN1JQvHiiQ=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=l8d37LB7R61+at1U9r40RQrvfmWCpoTxSj+phrqmPlstmD5KtWVhUfoAUcVpKn87b
         8/kUkP+9GNR+K273yX/xTjQagLbwW9JshUFaE/CWAtTCUA/f395xSLZ2MnasLrzCus
         FkoObW+MyjAgkmLQ0/CwyN5fltUpVcg77/x6yF8A=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ful6zNDKwE-NpkiBrM2;
        Tue, 26 Dec 2017 16:23:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294634;
        bh=03vtqMahdAkTaKIW+vAfUjDA2vMHFHGaXoN1JQvHiiQ=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=XsPldycaWUW5nPcaqi+975rLkn10z9JZt432stWDsZ1ad3aAZQGJczshr+2gKrI1y
         7N1Q6hzBF2roHSSYqsNxIZhrguGrbyVmzuIzAkr20TNK6G6foXtC0AWf22TdsiVqDE
         IKWx9ObDS/5z99ztweyF5TX4wZjGn3I0C2JHI/fU=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Cleanup loongson64 mach to use SPDX copyright format 
Date:   Tue, 26 Dec 2017 21:23:32 +0800
Message-Id: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61598
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
