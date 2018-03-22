Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 15:31:12 +0100 (CET)
Received: from forward106p.mail.yandex.net ([77.88.28.109]:38266 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbeCVObGYEWOp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Mar 2018 15:31:06 +0100
Received: from mxback2o.mail.yandex.net (mxback2o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1c])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id F1AA82D83419;
        Thu, 22 Mar 2018 17:31:00 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback2o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Z8pXDBl5Z0-V0nWBbRP;
        Thu, 22 Mar 2018 17:31:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521729060;
        bh=JrUsvbIRFc1Kpq3vDeerh4BQ3xzwjPxzgygeMV/UxKI=;
        h=Message-ID:Subject:From:To:Cc:Date;
        b=aqnvGevoKKv5ZaZ9+eOM/jNz29mw4GpHvQlD5CUbn9Bb0+CJ/vqhudsvceQNrd2bm
         hYtBaE8FsoJL5NCHZAUkaZhsisgXypk4uV65giqkowAV7w6JeKym7D/aR/emKNuidy
         +NHa8EvJ/BUQNNfGve61+FkrV97UmFxGE8BGrY5o=
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id KPsQfOpYOn-UrZC26iV;
        Thu, 22 Mar 2018 17:30:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521729060;
        bh=JrUsvbIRFc1Kpq3vDeerh4BQ3xzwjPxzgygeMV/UxKI=;
        h=Message-ID:Subject:From:To:Cc:Date;
        b=aqnvGevoKKv5ZaZ9+eOM/jNz29mw4GpHvQlD5CUbn9Bb0+CJ/vqhudsvceQNrd2bm
         hYtBaE8FsoJL5NCHZAUkaZhsisgXypk4uV65giqkowAV7w6JeKym7D/aR/emKNuidy
         +NHa8EvJ/BUQNNfGve61+FkrV97UmFxGE8BGrY5o=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1521729033.6120.6.camel@flygoat.com>
Subject: SSL certificate of linux-mips.org have been expired
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@linux-mips.org
Cc:     jhogan@kernel.org, ralf@linux-mips.org
Date:   Thu, 22 Mar 2018 22:30:33 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63151
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

Hi MIPS maintainers:

SSL certficete of linux-mips.org have been expired. Either wiki or
patchwork can't be reached for now. Please renew the certificate,
thanks.

Btw: Is Ralf still maintaining these servers? I havn't seen him for a
long time.

-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>
