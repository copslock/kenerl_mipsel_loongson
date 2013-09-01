Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Sep 2013 21:07:14 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:52468 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823977Ab3IATHLsXm1p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Sep 2013 21:07:11 +0200
Received: by mail-pd0-f174.google.com with SMTP id y13so3873945pdi.5
        for <multiple recipients>; Sun, 01 Sep 2013 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FV1rghNRul52RgRT8MXvI9GBT98U6QWPhijkQvXPYPM=;
        b=p5l8UJ5uy99WP8Xw6aILCxlWE90qMVWwDGCQ4ppMWDmo85fXwIbbzJwAybETrgq/k8
         d/oV3XfBcXkkGF5Sb4Lw9nEk5yr9lc5xQTqVAC3svrVY6TM4TtQHVJmKKQxiqZw8S35Z
         ZrzwvrHiVczSc6X6lsvsd5sR+LrntZXDQLbJTj8enT4HKDCcNghu9HWQGGRZXT4JpFW3
         C/IA3WCHDd1cGLYhJGgspMJ4bHAZ+midVb7ZheY2J3AqPiT1oV6oFI7Ler9R28DqjMoR
         pNDuV8uLOo+rVApVWuoo85omQ3y98trsQhobKvvtDx2KL1vNpuuiBjsh9Mhe05nYcYXd
         R7BA==
X-Received: by 10.68.219.104 with SMTP id pn8mr21685215pbc.81.1378062425046;
 Sun, 01 Sep 2013 12:07:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.38.99 with HTTP; Sun, 1 Sep 2013 12:06:24 -0700 (PDT)
In-Reply-To: <1377877362-15650-1-git-send-email-james.hogan@imgtec.com>
References: <1377877362-15650-1-git-send-email-james.hogan@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun, 1 Sep 2013 20:06:24 +0100
Message-ID: <CAGVrzca5i2CgXYOSobOz+9=gLg7syZueq0X-zqg_bQD=vpyDjw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] MIPS: add uImage build target
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/8/30 James Hogan <james.hogan@imgtec.com>:
> This adds a uImage build target for MIPS. The first two patches clean up
> the Makefiles slightly to allow the load and entry address to be passed
> nicely to arch/mips/boot/Makefile, and the final patch adds the uImage
> targets.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: linux-mips@linux-mips.org
>
> Changes in v2:
>  - Split into several patches to add refactoring which avoids duplicated
>    load/entry address calculations (Florian).
>  - Disable uImage targets when load address < 0xffffffff80000000 (e.g.
>    SGI IP27).
>
> James Hogan (3):
>   MIPS: refactor boot and boot/compressed rules
>   MIPS: refactor load/entry address calculations
>   MIPS: add uImage build target

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Looks good, thanks James!
-- 
Florian
