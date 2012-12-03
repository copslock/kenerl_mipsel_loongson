Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2012 09:45:35 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:51858 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823123Ab2LCIpcaAKnH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Dec 2012 09:45:32 +0100
Received: by mail-wg0-f45.google.com with SMTP id dq12so1306760wgb.24
        for <linux-mips@linux-mips.org>; Mon, 03 Dec 2012 00:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6+HwqQTBn/Uvd4qypeIUAkUpx2j80DMFAxt/8R9466c=;
        b=pa70If8B+oWSrTJITQ6f5kaEd418wCMCXoVn/G9DOaRxSZPFkfNwVvbhxmpE4C8FJe
         amSIIkvNoja2nYtJs7Ov1xnSeHj6YKe7qsglUf8IBnQMetXE9D8IiVA6jJOU8mySj6Hm
         FsAwPOiwLxdw0FMNIAGLDBChEhGgrBOK+KE7FbMvEamwcEXJdD6vhkccwoa7ZfAbricA
         XkPeHlU7/XZLR3OWPBjsFfNPlxLwutjVUO+tTGl9Zli2W+8/LbA6NjnGg5lMaHacNNcV
         fyqj8nuz3/36N5OXiPImXXVuS1n/hQQ7s53r+I3ImlAytjMIU6hU7QZhe7sbJoUokMcW
         cr7w==
MIME-Version: 1.0
Received: by 10.180.99.5 with SMTP id em5mr8057679wib.8.1354524326775; Mon, 03
 Dec 2012 00:45:26 -0800 (PST)
Received: by 10.216.21.8 with HTTP; Mon, 3 Dec 2012 00:45:26 -0800 (PST)
In-Reply-To: <1353975925-32056-1-git-send-email-hauke@hauke-m.de>
References: <1353975925-32056-1-git-send-email-hauke@hauke-m.de>
Date:   Mon, 3 Dec 2012 09:45:26 +0100
Message-ID: <CACna6rwmfpNFAFZpvbt8GHzofC6UoyBC4oKF5rL=9xN5_=gYXw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] watchdog/bcm47xx/bcma/ssb: add support for SoCs
 with PMU
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linville@tuxdriver.com, wim@iguana.be,
        linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2012/11/27 Hauke Mehrtens <hauke@hauke-m.de>:
> This patch series improves the watchdog driver used on the Broadcom
> bcm47xx SoCs.
> The watchdog driver does not access the functions directly any more,
> but it registers as a platform device driver and ssb and bcma are
> registering a device for this watchdog driver.
> This also adds support for SoCs with a power management unit (PMU),
> which have different clock rates.
>
> This code is currently based on the wireless-testing/master tree by
> John Linville, because there are some changes in ssb and bcma in that
> tree queued for 3.8 which will conflict with these changes, if this
> would be based on an other tree. I have no problem with rebasing this
> onto any other tree.
>
> @Wim Could you give me an ACK on the "watchdog: bcm47xx_wdt.c:" patches
>      so that John could take them trough the wireless-testing tree, or
>      provide me with some feedback on what I should change.

Hi Wim,

Have you got a chance to look at that patches?

I've some additional bcma changes I wish to submit on top of this :)

-- 
Rafał
