Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jan 2013 10:24:49 +0100 (CET)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63627 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823099Ab3AIJYoy7lZW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Jan 2013 10:24:44 +0100
Received: by mail-wi0-f178.google.com with SMTP id hn3so394558wib.17
        for <linux-mips@linux-mips.org>; Wed, 09 Jan 2013 01:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=AuOu3Rs+GcmOEXrwyB9kI/y+GVwAUAq/uq9XlOouwY8=;
        b=upFmVkks80AJwAeLDzkJtc3YeOJA5ZtyZR+TabIGM14RWE/Nt5NrkXs+xSEZbfQD1+
         cHhb4ZW17GCA2Jl4MNNzOTFnDQCti5Fllzt367LHDmDzKchls9hwcyt3wnoMevSCtk8K
         JhEQ2A7UWJvFK/KZI+MOi8qFlAu67481LVVnw5QiJk8VKsL1uPRdAwV5Ld5CnDxfOOUc
         2MabiyHfYQp0Zaq5XCtVpDgagpUSV9fi2P5cpgxDMq1wd//QUA4J9vSv8uMG90wD0SPP
         iA3wVK0kF95eEumFw4Q1hgYKAJAmJZvMJXisgboi7DlgJOkklboXtpcYVymS3E0Hhaxn
         Mydw==
MIME-Version: 1.0
X-Received: by 10.180.84.193 with SMTP id b1mr1996450wiz.26.1357723477041;
 Wed, 09 Jan 2013 01:24:37 -0800 (PST)
Received: by 10.216.21.8 with HTTP; Wed, 9 Jan 2013 01:24:36 -0800 (PST)
In-Reply-To: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
References: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
Date:   Wed, 9 Jan 2013 10:24:36 +0100
Message-ID: <CACna6rzcYReMs1ZxKuMDjAte+3bX_rjvd3Jd7265tgkMF2E-oA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] watchdog/bcm47xx/bcma/ssb: add support for SoCs
 with PMU
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linville@tuxdriver.com, wim@iguana.be,
        linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35397
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

2012/12/5 Hauke Mehrtens <hauke@hauke-m.de>:
> This patch series improves the functions for setting the watchdog
> driver in ssb amd bcma. It also makes ssb and bcma register a platform
> device which could be used by a watchdog driver to better set the times
> where the system should restart. The patches for the watchdog driver
> will be send later and were removed in v3.
>
> This code is currently based on the wireless-testing/master tree by
> John Linville.
>
> v3:
>  * Remove changes done to the watchdog driver so John could pull this
>    into wireless-testing, this sill works with the old watchdog driver.
>    The patches changing the watchdog driver will be send later.
>    This was done to get this into 3.8 because Wim Van Sebroeck is
>    neither giving an Ack or a Nack on these patches and we want to do
>    more changes to bcma/ssb on top of these.

Your changes are already in Linus's tree, do you plan to re-send
watchdog patches dropped in V3 through linux-watchdog? Can you take
care of this?

-- 
Rafał
