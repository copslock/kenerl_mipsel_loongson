Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 04:49:14 +0200 (CEST)
Received: from forward105o.mail.yandex.net ([IPv6:2a02:6b8:0:1a2d::608]:43787
        "EHLO forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990947AbeFYCtG7SqJ9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2018 04:49:06 +0200
Received: from mxback1g.mail.yandex.net (mxback1g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:162])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 2761A44427BD;
        Mon, 25 Jun 2018 05:48:59 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id xzdvB3YfmR-mwVavELv;
        Mon, 25 Jun 2018 05:48:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1529894938;
        bh=vSPn18e/fNkTKhonsgVCcJdjFL5iBLHyzn99bjYyXrc=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=xHEiPngPvFGtD7zfx0szLItx75lcVoXPMvx6DJXzeS6+ctStPXQrx33WE9fbBIJPx
         TLo/q+9Bg1pXkQ3ABvYYPGOPEkBRGsb0A9jVc6MuTuD5jGTkv9a06RXf5ayZ3YuXK4
         1SL6S/FGtf+a1E1nb68+MCBxRfzZUE1eLwwcms0w=
Authentication-Results: mxback1g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by web11o.yandex.ru with HTTP;
        Mon, 25 Jun 2018 05:48:58 +0300
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Envelope-From: yjx@flygoat.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: The SSL certification of  linux-mips.org has expired
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 25 Jun 2018 10:48:58 +0800
Message-Id: <5812041529894938@web11o.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64426
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

Hi Ralf

It seemed like Let's Encrypt certification auto renew script on linux-mips.org server is not
working properly. Please check it manualy.

Thanks

--
Jiaxun Yang  
