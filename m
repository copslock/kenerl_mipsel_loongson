Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2017 07:50:40 +0100 (CET)
Received: from forward103p.mail.yandex.net ([77.88.28.106]:59497 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990393AbdLIGudMuXzO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2017 07:50:33 +0100
Received: from mxback9o.mail.yandex.net (mxback9o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::23])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id D5B9D2183A04;
        Sat,  9 Dec 2017 09:50:22 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback9o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id xR0AUrhLNe-oMPWNlse;
        Sat, 09 Dec 2017 09:50:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512802222;
        bh=FH8tmMX4Mih5w65ePE6M5b1VOfe1aEsqpX5JcEmsMDg=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=dGtaMMbHY1a8+2W1l4lLwErfMBLb3fUSTqKqk7aX1a+zd2Q0D3ntKQ1gXm91KNeLT
         7CgT3V830B6Hqo+nwboKRNOHO4hF45xzjBd9zchDythB0J6nolbwlZl/Lu+47MA8Di
         GnJLxnV3D8hXHN5DziyyjjN3xQomNbFski7wFSjQ=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jBC3v0GG1J-oIpqbrEC;
        Sat, 09 Dec 2017 09:50:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512802221;
        bh=FH8tmMX4Mih5w65ePE6M5b1VOfe1aEsqpX5JcEmsMDg=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=UllFuzoIV0llNvVfMQGaiN/9qrzpPMFDuPEJx5vwGbZe6jce7uG9bCpEx/rf4u6j0
         2udGff2iPGwJPp8OxZ43+j2sNihPcUPDNBki70vfWS6N3IYundaQ2POP3uRsfnQDTK
         vXdwyiKYdFl2Jmizbh7Mg/IN3y94tFaFsETdwU0M=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] add Lemote YeeLoong Laptop support 
Date:   Sat,  9 Dec 2017 14:49:48 +0800
Message-Id: <20171209064953.8984-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.0
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61384
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

Change since v3:
Fix build error in platform.c
