Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2010 15:42:34 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:65026 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491015Ab0HTNm2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Aug 2010 15:42:28 +0200
Received: by yxf34 with SMTP id 34so1429471yxf.36
        for <linux-mips@linux-mips.org>; Fri, 20 Aug 2010 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Oo82OnZOex9sdFJkowtN9hlCzrYAZYI04vwWsrxCwoI=;
        b=fFguhvN1r5deQ89W6YjaUt6dC2RMbkkdFND1FPaoNgEScq7CijSXDJGYNv0byndp/5
         sEbXE/VlX2z8kC5euIy4cJ+mEhMoLRjKObMdHWgH/GF8hrRcCm14+Vi8Xt5D44lX+zKm
         ES08w3vzMrSF6fJSm6u6AFzgEIp7wa70f0dso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=XvS0wKvzYnKVO0RGJKOJOIcQ0nDzcSvqiXJCxWQQ9GEbAskx5YKR79Jnj02lehLO4f
         3EeDOYsrnijA0C4KMEty50sv4nBqtbst4YiINwezwwp9hfo9/+E+hO3v/M/oyUOi9tJ2
         M6Lh/uBYamxrNlr6Sj2D1GfK7d1LDXqTjrYaw=
MIME-Version: 1.0
Received: by 10.90.63.18 with SMTP id l18mr1098334aga.140.1282311739798; Fri,
 20 Aug 2010 06:42:19 -0700 (PDT)
Received: by 10.231.116.148 with HTTP; Fri, 20 Aug 2010 06:42:19 -0700 (PDT)
Date:   Fri, 20 Aug 2010 21:42:19 +0800
Message-ID: <AANLkTikR=Gzq-93_LVPsmkzf7XtmUPSz_8dF3JJ6YiNL@mail.gmail.com>
Subject: Some questions about exceptions?
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Dear all:
When I read mips spec there is an exception called MCheck and my questions are:
1. Does this exception only happen on write?
2. The spec says this exception happens when following conditions matched:
    a. Existing Page Valid Bit = 1
    b. Written Page Valid Bit = 1
    what is the correct definition of "Existing Page" and "Written Page"?
    I guess the definition of "Written Page" is teh PFN we get from TLB.
    But what is "Existing Page"?
3. I google a paragraph which discuss about this exception,
http://www.spinics.net/lists/mips/msg19804.html
   But I cannot find the reason why it happened from the log.
   The entries in TLB seems fine.

BTW, where I can find kernel
1. first time fill Page blobal directory
2. handle
  a. tlb refill, invalid and modified?

appreciate your help,
miloody
