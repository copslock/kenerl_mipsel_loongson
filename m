Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 20:48:33 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36998 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903426Ab2FZSs1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 20:48:27 +0200
Received: by obbta17 with SMTP id ta17so266700obb.36
        for <linux-mips@linux-mips.org>; Tue, 26 Jun 2012 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UuJsBj0dssfJY0NAHf8+AlAHpslt6Y3XNl5TvFHjdXA=;
        b=vsbejDv0KKSghxdE6MtoKv9sV0njlq8khDkTWbiFlFJ5KmLDtynYC5kC65Oy4O4hPk
         ITld8QC6cnq28LnRYbwNUMpLY0xqgJvGrmje/k3rwKbkRE/zb6n4KyAmnPulfKA5Qh53
         a2vjVpA6GaZeDJa1S/sIMhLwr3eRyt/wvqKQHoRNqESgHKYQilTsubIhGGZeDnSak1FJ
         Z0NREakdFnNJvWk3tWtMMB97b3sRbjUyXKKoENfjsV409Q7R4KXltlCyWdPYA3H2NppM
         N37pjTawzBvx3JiVdivmYBbKYiwF7i/IqLYs0Kdbbj+kjqG1mKM4LFKaf121YH+qB7Yf
         qe2w==
Received: by 10.60.1.202 with SMTP id 10mr17445057oeo.15.1340736501128; Tue,
 26 Jun 2012 11:48:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.98.195 with HTTP; Tue, 26 Jun 2012 11:47:59 -0700 (PDT)
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B8011469833E@exchdb03.mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
 <CAOiHx=kKxZZzJZkRe+SRjFj0JD7yq4=3CmRFbqc6hW_Dhnbz3g@mail.gmail.com> <31E06A9FC96CEC488B43B19E2957C1B8011469833E@exchdb03.mips.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 26 Jun 2012 20:47:59 +0200
Message-ID: <CAOiHx==e0ZsJy+=KAkaCzNYvjbsnY+mmjNX8oHhHPstA_WZCKQ@mail.gmail.com>
Subject: Re: [PATCH 00/33] Cleanup firmware support across multiple platforms.
To:     "Hill, Steven" <sjhill@mips.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 26 June 2012 20:34, Hill, Steven <sjhill@mips.com> wrote:
> Did you read the COPYING file of the kernel source tree? I'm pretty sure it states "or later" in the text. Therefore, I believe that my changes to the headers are alright.

To quote the top-level COPYING:

> Also note that the only valid version of the GPL as far as the kernel
> is concerned is _this_ particular version of the license (ie v2, not
> v2.2 or v3.x or whatever), unless explicitly otherwise stated.
...
>                   GNU GENERAL PUBLIC LICENSE
>                      Version 2, June 1991

So no "or later" here.

Jonas
