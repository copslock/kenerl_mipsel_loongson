Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Apr 2014 16:36:12 +0200 (CEST)
Received: from forward20.mail.yandex.net ([95.108.253.145]:46454 "EHLO
        forward20.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816288AbaDEOgKRApO4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Apr 2014 16:36:10 +0200
Received: from web6j.yandex.ru (web6j.yandex.ru [5.45.198.47])
        by forward20.mail.yandex.net (Yandex) with ESMTP id 4ADCC1043AEB
        for <linux-mips@linux-mips.org>; Sat,  5 Apr 2014 18:36:04 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        by web6j.yandex.ru (Yandex) with ESMTP id 03F93370004D;
        Sat,  5 Apr 2014 18:36:03 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1396708564; bh=lpgngFkOzocZO3YE6/vlVle/cYUVSJR3De8KNHNIUFk=;
        h=From:To:In-Reply-To:References:Subject:Date;
        b=XL/owM2QhZ715hMxRV9WMt6tnVZPr6sbqFCZ+TcIkH6SbZejyAPvZmLNFUQh59Dhr
         28apmZislSy3y2Q1dPre8teZrUl2nj7FbMemdj3mE4jyseRf6Qii+o063Cr3menTKY
         +5FRh+hu3KFZcWhYjpOaJYl72ppDNUoiPd+V8guo=
Received: from ppp83-237-37-145.pppoe.mtu-net.ru (ppp83-237-37-145.pppoe.mtu-net.ru [83.237.37.145]) by web6j.yandex.ru with HTTP;
        Sat, 05 Apr 2014 18:36:03 +0400
From:   kr kr <kr-jiffy@yandex.ru>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <6183191396702064@web14j.yandex.ru>
References: <6183191396702064@web14j.yandex.ru>
Subject: Re: [MIPS Malta 5kc] Re-flashing using BDI 2000 problem.
MIME-Version: 1.0
Message-Id: <2042591396708563@web6j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 05 Apr 2014 18:36:03 +0400
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Return-Path: <kr-jiffy@yandex.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kr-jiffy@yandex.ru
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

I think, I've got it...

05.04.2014, 16:48, "kr kr" <kr-jiffy@yandex.ru>:
> Hello,
>
> I've been trying to re-flash mips malta 5kc board (the real board,  not quemu) with a yamon image, using Abatron bdi 2000. No success yet.
> JP1 jumper (MFWR) on the board is closed, S5 switch is set to: 1 - "open", 2 - "closed" (BE mode),  3 - "open", 4 - "open". On board display shows "Power on".
>
> From the user manual for Malta board:
> "Note: Address 1FC0.0010 is “special”, in the sense that when the software read this address it is overridden and does NOT decode to an address in Flash, but rather to register address REVISION. This is 
> done to ensure future compatibility - all MIPS Technologies boards will be able to identify their hardware environment and configure themselves accordingly. Reads from address 1E00.0010 will decode to an 
> address in Flash."

have just had a closer look to yamon's __reset_vector function.
