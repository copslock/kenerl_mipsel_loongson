Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 20:37:23 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:45323 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903659Ab2EKShT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 20:37:19 +0200
Received: by laap9 with SMTP id p9so2631423laa.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 11:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=vSmak8Nea6B7mNsl0HqmWJv//XwTXx4JqLdG3XzWG1k=;
        b=mTZF7p8xalbJ+iISHtJDDooxjidxrA5maVaHRCssd4kLIEi8LapQ9Qy2Oxp8bX6lMC
         x9opKLCKIjGdX0OaIoJY5AWZJ5y8Ro4tRohEZyM2H75tk6dEBmBDFKKwKLT+Cl1RoMg7
         W2lrtoMYCh6Jf0NIPiamaAA1H6UjZ8nd8tmqASZiQg/8Wcv4yWkwnMO/7kcnvp25jIYG
         tr8Qm44HG0lhnBJ0ShBLCTbpBe+ntJexus7xlxLCIjUvwGVHGOxz9dyNhy/4liLqh3jM
         hitsqfehvgwIrw2CCTMk76FboI9EdMsFd0ENyCbzc5+jiuuwyWs7Uav2mhpxFGwCHDqv
         DeLQ==
Received: by 10.112.30.102 with SMTP id r6mr4149511lbh.0.1336761433413;
        Fri, 11 May 2012 11:37:13 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id k3sm12710030lbz.4.2012.05.11.11.37.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 11:37:11 -0700 (PDT)
Message-ID: <4FAD5C10.7050604@mvista.com>
Date:   Fri, 11 May 2012 22:36:00 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Hill, Steven" <sjhill@mips.com>
CC:     "Yegoshin, Leonid" <yegoshin@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] Add MIPS64R2 core support.
References: <1336717784-853-1-git-send-email-sjhill@mips.com>,<4FAD4B9E.70803@mvista.com> <ajcsenx2bmwqyi5629d3ywgh.1336757525517@email.android.com>,<4FAD4E5C.9040607@mvista.com> <j9ltxtmuep0qhf4mgqhj4du5.1336758301121@email.android.com>,<4FAD54E9.6030102@mvista.com> <31E06A9FC96CEC488B43B19E2957C1B80114693470@exchdb03.mips.com>
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B80114693470@exchdb03.mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmUF9EgkmYYs+FXFxesEGW0j3sVujKB12x/jEoL8n6zn++nQ+e0CJmwyT8FtNewfKnUGziI
X-archive-position: 33270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 05/11/2012 10:23 PM, Hill, Steven wrote:

> Sergei,

> Stop copying Ralf. Copying the mailing list is sufficient.

    I just replied to all, as usual.

> Leonid,

> Could you please write a couple of sentences describing the 6 lines that you added in 'arch/mips/Kconfig' ? We can then add that with the sentence "Add support for MIPS64R2 on the Malta platform." That will be sufficient and prevents having to split this patch up. Just email it to me internally and I will repost the patch.

    Yeah, that would be a good start. Although I'd still insist on splitting it up.

> -Steve

WBR, Sergei
