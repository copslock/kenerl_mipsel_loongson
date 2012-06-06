Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 04:33:14 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:39013 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901351Ab2FFCdL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 04:33:11 +0200
Received: by wgbdr1 with SMTP id dr1so5246522wgb.24
        for <linux-mips@linux-mips.org>; Tue, 05 Jun 2012 19:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mdkszLX0jj4uK5iK73p6QNdRYR4Os8+enC2iyULn2/k=;
        b=oTeqEwHbxnhlg8Hkbh7mWngi264LiJ4g6SXjivYYRckxqY6l2fIKj6tt8CsN1pL7NZ
         8AeJn2fbogkt1tHhC3pWtLIwDs4Y21PbZmCPHgwyPbQQ8nwvKboRN8iGE/QCGN9dSatg
         1DEqWpnndLcWJYNE1o9iWVWFHgtVYBkxYbrW0HUYkz0DGLIvjbobeT9uzZfCh96ORFig
         fiuxmn9fplkaiS4dCPYc8PgVXn8uILQkHQUvqE9z5aAX/cfQrj9vSa4rCFeoMPHxUbyW
         lteJ3rCkOTtMFOqfrfK1gz5fdqojtcuZg+uettdb1gFu9WGj0sxDmhARmOGDHz85bMQo
         BcqQ==
MIME-Version: 1.0
Received: by 10.216.212.157 with SMTP id y29mr15999186weo.146.1338949986083;
 Tue, 05 Jun 2012 19:33:06 -0700 (PDT)
Received: by 10.180.84.136 with HTTP; Tue, 5 Jun 2012 19:33:06 -0700 (PDT)
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B801146957B7@exchdb03.mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
        <1338931179-9611-36-git-send-email-sjhill@mips.com>
        <CACBHAewrmejSTYdx5A95GqHmAt8ovBTzedE2w+LCE9aTf3tQuw@mail.gmail.com>
        <31E06A9FC96CEC488B43B19E2957C1B801146957B7@exchdb03.mips.com>
Date:   Wed, 6 Jun 2012 11:33:06 +0900
X-Google-Sender-Auth: bKczRV8FOpPgO6eBhWvSubEv-NQ
Message-ID: <CACBHAeyaZ6sQ-c09PKteXgSvkePxs_S_sWv2vA4CW-HWtNawvA@mail.gmail.com>
Subject: Re: [PATCH 35/35] MIPS: vr41xx: Cleanup files effected by firmware changes.
From:   Yuasa Yoichi <yuasa@linux-mips.org>
To:     "Hill, Steven" <sjhill@mips.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

Hi,

2012/6/6 Hill, Steven <sjhill@mips.com>:
> Yoichi,
>
> How are those include files required? I built a complete vr41xx kernel and that file did not produce any errors when being compiled with those headers removed. Did you try building a kernel with this patch?
>

It is not only build problem.
We would like to include <linux/init.h> and <linux/ioport.h>
explicitly because of __init and iomem_resource.

Yoichi
