Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 13:46:30 +0200 (CEST)
Received: from mail-yh0-f53.google.com ([209.85.213.53]:34924 "EHLO
        mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821654AbaFRLq3J1uRi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 13:46:29 +0200
Received: by mail-yh0-f53.google.com with SMTP id b6so476489yha.40
        for <linux-mips@linux-mips.org>; Wed, 18 Jun 2014 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3GiUb1ND1eJymUp9NUiL2nMieoiwZ4Hb5rJAkGxBZKE=;
        b=s/qbqBM+UQlviFS+jnr+rWW68aGxRvJPeBxVn52TJ5+4S1Fpb4pPUQcHKJ/BAPTgcI
         wGcEVwDQb4/Y9seeJykzRE0ujatVhFjidLpBAnghT/1rqnxC+PwqufX/SFBOI6bf6RYa
         FaYUX6PUtacZCbJNvdHVdiIQDP+pqUWcGivJ4fPQyR7Bs/+/EmMK779Ns2n6Idvb9mQ0
         VICqCdTdnw13sroDzldIyHD9uED5eCpoAeGpi1AEGXQ+ZQOYdcjMPdDO8dlGqJsGtplf
         /6/siXgxt3rW3QUL0DLsJ7W6Fu78wr7qJCIN8lofEBhkE4FMbrLwDGlhnTQw6+HWdRbC
         IHuQ==
X-Received: by 10.236.61.45 with SMTP id v33mr54725636yhc.20.1403091982786;
 Wed, 18 Jun 2014 04:46:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.168.136 with HTTP; Wed, 18 Jun 2014 04:46:01 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 18 Jun 2014 15:46:01 +0400
Message-ID: <CAHNKnsSMvc+VeKumoDY5doR4YDhZ+3ezgY903uHnFH7BGQ+XRQ@mail.gmail.com>
Subject: Introducing Atheros AR231x/AR531x WiSoC support
To:     Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Hello,

I plan to send several patches for upstream merging, that introduce
support for Atheros AR231x/AR531x WiSoCs. This code developed and
extensively tested in OpenWRT project. And I need some help.

I need to know what is the preferred way to split code on to separate
patches suitable for review and merging? Some kind of howto or article
would be great. Could you recomend something? Should I send a series
as RFC first?

-- 
BR,
Sergey
