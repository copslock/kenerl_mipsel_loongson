Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2017 10:23:43 +0100 (CET)
Received: from forward103p.mail.yandex.net ([IPv6:2a02:6b8:0:1472:2741:0:8b7:106]:40930
        "EHLO forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbdLDJXh0NjOZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Dec 2017 10:23:37 +0100
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 0AC0C21834BD;
        Mon,  4 Dec 2017 12:23:30 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ySyrp3kZDr-NTwGNPrd;
        Mon, 04 Dec 2017 12:23:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512379410;
        bh=O7fN/BUMQtuCG+dD/Rm5vfkpxf/n9jA8cdxm9LsG83U=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=tVgkyqVB+f0rinXDurtJRllt2nthsCLkf8uWrkWtKkKfIFqXaSAduzqa+w4moc8/E
         EHaeIX4P18tGyb2fBjMuoZEw1FESuAcz1YhXXivZSr2yKK1OvhRMWzmK/SH+cLrM3z
         sKgYS+RLv6jeyDtntc0CeK0ofuQt/CzhNfuFnNQ0=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 99BorI3ZLs-NQPeM03q;
        Mon, 04 Dec 2017 12:23:28 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512379408;
        bh=O7fN/BUMQtuCG+dD/Rm5vfkpxf/n9jA8cdxm9LsG83U=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=lGFgtp0siMBhSZLFjTVmNrkYgZas+vQoJWcZHFmqST0JOEWAfNCJREv29KcPL7JQs
         WGgJ7WmR5kKWa8it/aboZIyw3kehriDJD+hWUT+RPvdNq4+pyamt09KzbWemOuzaF2
         2s2viYeDtf3e7rQifbiCSh86kdlcH4AW1EiCMECM=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Add support for lemote-2f YeeLoong laptop (RESEND)
Date:   Mon,  4 Dec 2017 17:23:08 +0800
Message-Id: <20171204092312.11256-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.0
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61282
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

Since Ralf havn't appear for a long time, I resend this patch.
Btw: Why linux-mips wiki and patchwork down for so long time?
