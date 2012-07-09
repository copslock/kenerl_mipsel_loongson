Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2012 04:58:11 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:33736 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903445Ab2GIC6I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jul 2012 04:58:08 +0200
Received: by eekd17 with SMTP id d17so4090096eek.36
        for <multiple recipients>; Sun, 08 Jul 2012 19:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lJ3JjJCQmZlCk8KRCTEeobL+XGb0gdxJbufjR0Q0Xg0=;
        b=EfyF4Quhsuy0laHS2Mp0drMjQwfqtG9a15uDCaSmp+TxnjstlVXlxJLKQ3rscveoch
         u4KCLr0Li4/ZZIGqaOHznR5NddFtie+ozvNm6/W9g9v4j7IjqJ0zFlYCM220k7y91CbJ
         atXkkGo9zA9jtkPVuipwrZxOBIpmE60GD6mDOoJ04NIR+BXdSj9tGoHt8Zajyym2dXOb
         Axygo7wrltjq1Jdp8i5uBRe3Wcvo2EOoxENosgdj+sRCESkauvTwQgDuv896KP5pgXQ7
         vxKIaAU5tVTQq250RyYEVs52C9edih3rC662W+kz8KQfA9G9GNnUCezeqYYejO6H0a8O
         RyxA==
MIME-Version: 1.0
Received: by 10.14.100.144 with SMTP id z16mr9084480eef.50.1341802682542; Sun,
 08 Jul 2012 19:58:02 -0700 (PDT)
Received: by 10.14.173.194 with HTTP; Sun, 8 Jul 2012 19:58:02 -0700 (PDT)
In-Reply-To: <0f67eabbb0d5c59add27e42a08b94944@localhost>
References: <0f67eabbb0d5c59add27e42a08b94944@localhost>
Date:   Sun, 8 Jul 2012 19:58:02 -0700
Message-ID: <CAJiQ=7Dxp8StP6Wj-EFAgWpLHxRrs616089BpKRSbPq4kWszag@mail.gmail.com>
Subject: Re: [PATCH 0/7] Prerequisites for BCM63XX UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     ffainelli@freebox.fr, mbizon@freebox.fr, jonas.gorski@gmail.com,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Fri, Jun 22, 2012 at 10:14 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> These patches are intended to lay the groundwork for a new USB Device
> Controller (gadget UDC) driver.

I have posted "V2" for 4 of the 7 patches.  New bundle is here:

http://patchwork.linux-mips.org/bundle/cernekee/bcm63xx-udc-prereq-v2/
