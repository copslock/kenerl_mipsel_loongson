Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2011 07:27:37 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:50992 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491138Ab1IOF1a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Sep 2011 07:27:30 +0200
Received: by fxg7 with SMTP id 7so346816fxg.36
        for <multiple recipients>; Wed, 14 Sep 2011 22:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=xr+HCRqu7VO/pXtTfnSxBCjTOnxitBrFT4k7ARQ6rHM=;
        b=lEUER6Wpimy0K+nfRowuaaKqFEm4iiB+L0UeryX2cGkTrmXFFYx9wh3tF7lldt/ob9
         aMW5E38qM0JkcSYw6BAvbXA2yf6dDG1QYlGtYFhqnCpNZHAf5/QByk2Z6y9zH3N4WsCF
         sAE+QhHcPiUafHST1j/d/3uOkR+yTgBDXyIdw=
MIME-Version: 1.0
Received: by 10.223.65.141 with SMTP id j13mr1114249fai.101.1316064445565;
 Wed, 14 Sep 2011 22:27:25 -0700 (PDT)
Received: by 10.223.72.202 with HTTP; Wed, 14 Sep 2011 22:27:25 -0700 (PDT)
Date:   Thu, 15 Sep 2011 13:27:25 +0800
Message-ID: <CAPD9Zd4bLod_hvmub96maRVZuxOep22LVEdytXzcSQDfwtCf0w@mail.gmail.com>
Subject: malloc() and flushcache
From:   liang peng <peter.bssf@gmail.com>
To:     david.daney@cavium.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: multipart/alternative; boundary=0015174a0640c78ca104acf42127
X-archive-position: 31089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter.bssf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7595

--0015174a0640c78ca104acf42127
Content-Type: text/plain; charset=ISO-8859-1

Hi, I want to know how to flushcache to the memory allocated by malloc()?
anybody help?
thanks

--0015174a0640c78ca104acf42127
Content-Type: text/html; charset=ISO-8859-1

Hi, I want to know how to flushcache to the memory allocated by malloc()?<div>anybody help?</div><div>thanks</div>

--0015174a0640c78ca104acf42127--
