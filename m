Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2014 09:22:07 +0200 (CEST)
Received: from mail-qg0-f54.google.com ([209.85.192.54]:46271 "EHLO
        mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859949AbaHEHWAlARKf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2014 09:22:00 +0200
Received: by mail-qg0-f54.google.com with SMTP id z60so553092qgd.41
        for <multiple recipients>; Tue, 05 Aug 2014 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=RtvRjIZGY90xbvCh7J0CgW1/sXi1OppsqpMJ7kx0CRY=;
        b=RG/VTVKED3IPhJLmCWBkfdsto6N37SJTzQx36WTTllzcWCiZTYUIyT/6Q7HBTix8qk
         ytVr+IXOZiIbVpgpmblcQ5HYCy9XCFbSfr8JRhIoibDirDt08bn6S+uWNewIPrH74k57
         MjsMDIQjOMP+aCuBQmt95tPh3Ap1cjZL7Gyw+79VTRlqkMYEKZkFpNJrsaImP7P3WxRe
         Pv36SiTRWwk56M4jM2YHGudc4s5nvsL6TdGwIheD8Q5rUEQuMGvUpdTtgZ9RqAkODYvH
         TmKdJ7K5DNLT8/OUvm2nhxesNRsPH6g9HUw4WCDL6Hv/rYUTA/jkwRtjbl5giXS5OdXw
         jtog==
MIME-Version: 1.0
X-Received: by 10.229.182.1 with SMTP id ca1mr2628185qcb.28.1407223314496;
 Tue, 05 Aug 2014 00:21:54 -0700 (PDT)
Received: by 10.140.105.119 with HTTP; Tue, 5 Aug 2014 00:21:54 -0700 (PDT)
Date:   Tue, 5 Aug 2014 15:21:54 +0800
X-Google-Sender-Auth: 9ROH7G6YKjeR_ETcCugHsADMrRA
Message-ID: <CAAhV-H5o_vDqCmRJ8qne7-dOzg3Ai6bnSkqZ6dLc=hN1fjr7XQ@mail.gmail.com>
Subject: Please update two patches
From:   Huacai Chen <chenhc@lemote.com>
To:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Ralf,

Could you please update these two patches to V4 (V3 has already merged
into upstream-linus.git but they are not perfect)? Or I must send new
patches on top of the old ones to fix them?
http://patchwork.linux-mips.org/patch/7502/
http://patchwork.linux-mips.org/patch/7498/

Huacai
