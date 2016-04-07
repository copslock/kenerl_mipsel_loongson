Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 08:41:03 +0200 (CEST)
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38767 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025659AbcDGGlCTTQNC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2016 08:41:02 +0200
Received: by mail-wm0-f41.google.com with SMTP id u206so73121288wme.1;
        Wed, 06 Apr 2016 23:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XzIgRvW33wwp1kS7W+k1G8Cr4zKe++NzJGSU8WkQIPk=;
        b=ptbgTL4NqHVooZFa+L3UKyK7uTaT2eGMCU4oA/DNdaSzVEXioOqIPljolresgeLijM
         LxM2paAyEh1z60jRlQv+Mwkifpr3IRQY3EX9MCK6jODjA/Oz1Lv7akJQYG3Tcbl8joHU
         nHCICKi/5G6qc8UY8LV7phgV2Y3q/hXcVAqzGAYky8EBS+z+BagwKrsCr9+M79QVVCej
         2XW9E3qa7H2HXDFJiyTlkGgbgGH/JAzIttbbkJBnK9y3KrgdfN7gCXs0dNN8+mh0o4z+
         Cznog49iZlvAkF4qgNI20gBgWVbRApQt7uK4PpnFIQ/LXLhJ8GuqrQ4nR23UYYaESbEN
         0Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XzIgRvW33wwp1kS7W+k1G8Cr4zKe++NzJGSU8WkQIPk=;
        b=gK0g9zOrbVx5ol5ZCBrghXQUnk8QaXFgt64aOzA0uPuorpQhQZBXV0XKtj9nko3X5S
         FxHUiDSbclwknXCAPjs64/IAkH17zDH0qVmldSbUJiMB6wU4O0o8mmI1eFiil1m6Zdai
         9CqbReSVfLXPGMSvnYghVwD98qmnFKGVZ5Y3BJIa1kCjQj7sXDJmFgP9R7WZ+IQtcX9M
         4bHsO4+ZHhowLvQ5ULeSoNK9IHvBX//flTy2JZZjEM0aHIH1BzAWIGBK4v/EYqrFo2nG
         Wlds0SROmpvhDR4mCtmH+vabFsGPZvxpZ7yqlSs9o6yI/gjRZ7q6aYeLCxvKZ+6P9JLR
         rvtQ==
X-Gm-Message-State: AD7BkJKXG66gLnyLIVOBYLRuPLTUzfldSOajC8oQpkRAfQAwkdvu7a5e7EK18uCMz671BIg8O7eZ72H0aXLdKA==
X-Received: by 10.194.83.134 with SMTP id q6mr1432554wjy.131.1460011257057;
 Wed, 06 Apr 2016 23:40:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.129.14 with HTTP; Wed, 6 Apr 2016 23:40:17 -0700 (PDT)
In-Reply-To: <20160407000658.GA11065@NP-P-BURTON>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
 <20160407000658.GA11065@NP-P-BURTON>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 7 Apr 2016 08:40:17 +0200
Message-ID: <CAOLZvyErcw4kyLsLPoqCCBcxoK3L4OPykQLFaWRs6bLrPXK5zg@mail.gmail.com>
Subject: Re: 4.1: XPA breaks Alchemy
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Thu, Apr 7, 2016 at 2:06 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> git://git.linux-mips.org/pub/scm/paul/linux.git -b v4.6-tlb


Hi Paul,

This branch does indeed boot again, and PCI/PCMCIA work as well.

Thank you for looking at this!
      Manuel
