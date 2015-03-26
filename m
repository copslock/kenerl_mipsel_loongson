Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 11:48:22 +0100 (CET)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34129 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006155AbbCZKsVU2S0v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 11:48:21 +0100
Received: by wgs2 with SMTP id 2so59607114wgs.1;
        Thu, 26 Mar 2015 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=3UIXYvUzbzS7lfido6OOIatqdHJJDjchPbPmYFcQtiU=;
        b=ONJB1EiBxQyea485oRqsnFnxuZCw3iy2ov9uJl1Whw+hBf0321PJD/AA+p8wdrAnjy
         E8INaTwKkNPrTmURya6JQPvloZJm1W25ZiIALpS6Y0BRwrv8ymhLoQiQV3aut75Ha7FS
         fAtshiDQbIkAgS8ror44jYRKjVTJwZ6HKCkn6o7LEULV4LrfDanmjo5eUFYBFxzFYRaU
         5gbDGpCkMTwsw6J5q8s/96nNYHWITmLTnD6N57bwZEPvYJyZbX9U6CohANfCbv5vqoZw
         tob1Ue2Vp3+N5/EnfKEAAhn1218UCtMntJzOGep+COPu6V+k8N1qasU/wqbZdrjFV9Dy
         gzPw==
X-Received: by 10.180.228.104 with SMTP id sh8mr38106056wic.61.1427366897017;
 Thu, 26 Mar 2015 03:48:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.180.198.145 with HTTP; Thu, 26 Mar 2015 03:47:46 -0700 (PDT)
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Thu, 26 Mar 2015 11:47:46 +0100
Message-ID: <CAD3Xx4LMq1F8cDSR=17c3ViOML2ZYaL4d1ApkEog6bftSwKAPQ@mail.gmail.com>
Subject: MIPS: BMIPS: broken select on RAW_IRQ_ACCESSORS
To:     cernekee@gmail.com
Cc:     ralf@linux-mips.org, jaedon.shin@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Paul Bolle <pebolle@tiscali.nl>,
        Andreas Ruprecht <rupran@einserver.de>,
        hengelein Stefan <stefan.hengelein@fau.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: valentinrothberg@gmail.com
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

Hi Kevin,

your commit dd6d84812b1a ("MIPS: BMIPS: Enable additional peripheral
and CPU support in defconfig") adds a select on the Kconfig symbol
RAW_IRQ_ACCESORS.   However, this symbol is not defined in Kconfig so
that the select turns out to be a NOOP.

Is there a patch scheduled somewhere to add this symbol to Kconfig?

I detected this issue with ./scripts/checkkconfigsymbols.py.  Since
commit b1a3f243485f ("checkkconfigsymbols.py: make it Git aware") the
script can check and diff specified Git commits.  I found
RAW_IRQ_ACCESORS by diffing yesterday's and today's next trees (--diff
commit..commit2).

Kind regards,
 Valentin
