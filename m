Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Nov 2012 12:05:34 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:40109 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823020Ab2KRLFdenyiJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Nov 2012 12:05:33 +0100
Received: by mail-wi0-f177.google.com with SMTP id c10so2324770wiw.6
        for <multiple recipients>; Sun, 18 Nov 2012 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Fo2ZmgXEyuVxIitz0ZmedHrOsJQTeb3MWC5YODZOGyQ=;
        b=afWzWZkkl6mHZqUa2RtsLxoY8CZqpc1UhU2MrLpFyPcisbn2Lb1/9LuJVJy9fUkPeh
         sbM3gzBjVVLvrMJlFQ+gX34h1rnB79ypVGX0A5RKG1NcYiUNKPZJF+qwiSIAX5ZzgGOw
         rbxz4k2CbEndUVTVmF1K2pO99/xEwM+o6k3aWvtI6cHXgoMR0YXLX3fzgvS0ib8ajtv2
         iA+rjNVOI1aq4GejvLROzBXBiXokz0jok38yVC+ReYD0HRoV3QUdT8yg3zy5cEEa4tg8
         4dZaRE5ZNBCrnBI+uqkX/xk8r4jBiERjLxuMRj77frxDZlE7J9/SE0h0VlX+CJ6TeeTl
         zZkg==
MIME-Version: 1.0
Received: by 10.216.213.224 with SMTP id a74mr1405388wep.190.1353236728044;
 Sun, 18 Nov 2012 03:05:28 -0800 (PST)
Received: by 10.217.67.72 with HTTP; Sun, 18 Nov 2012 03:05:27 -0800 (PST)
In-Reply-To: <1347376511-20953-1-git-send-email-hauke@hauke-m.de>
References: <1347376511-20953-1-git-send-email-hauke@hauke-m.de>
Date:   Sun, 18 Nov 2012 12:05:27 +0100
Message-ID: <CACna6rw0Qy2=zo6wHcq20JBM8OJb-wnZJGLH3dksaLGFoyp+=w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] MIPS: BCM47xx: use gpiolib
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, john@phrozen.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35032
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

2012/9/11 Hauke Mehrtens <hauke@hauke-m.de>:
> The original code implemented the GPIO interface itself and this caused
> some problems. With this patch gpiolib is used.
>
> This is based on mips/master.
>
> This should go through linux-mips, John W. Linville approved that
> for the bcma and ssb changes normally maintained in wireless-testing.

Ping? Did it go upstream? I can't find that commits in
http://git.kernel.org/?p=linux/kernel/git/ralf/linux.git;a=summary

-- 
Rafał
