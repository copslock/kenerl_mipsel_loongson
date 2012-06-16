Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2012 13:04:25 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:60871 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903459Ab2FPLET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jun 2012 13:04:19 +0200
Received: by obqv19 with SMTP id v19so5783203obq.36
        for <multiple recipients>; Sat, 16 Jun 2012 04:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c9V5PEHp27N9ImXl13ucUyu67wJdPEPmVhaIk9+iPAo=;
        b=HeZNsrpkbSI+PMi3GB5NXkxzQoNaJgzvgXXJd4wFBMjU6FDSLtvfbiCHwQNRqkFyRQ
         fMUpUk4SYY38izpgeHnRVDlguAS1Ol0W8NncJVaMm0tW3jaZL3gh6c3DoEaAjVL2u4KO
         8N819ff4VIS3tLpItqBSWuNb/Ym3bmZ4fNLzX7R+8robQwvUAakOU/v683NoN6321xjK
         HbvBR56uBHQwEjpukE1pZkn0tS54/6LhlBaia5yFQ+cIGtfqIcIkHpDu0Nw17LdMu8hm
         3llg6l7WRyty9LmARUcR5hUfHv3IF1tlJTtmmOvbDTKczOZo8J0ToVj/j3mk6/C4xjyy
         BRaw==
Received: by 10.60.24.165 with SMTP id v5mr9155159oef.67.1339844653116; Sat,
 16 Jun 2012 04:04:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.98.195 with HTTP; Sat, 16 Jun 2012 04:03:52 -0700 (PDT)
In-Reply-To: <20120613153555.GB14657@linux-mips.org>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
 <1339489425-19037-2-git-send-email-jonas.gorski@gmail.com>
 <20120613134801.GA5516@linux-mips.org> <2177534.JpaDVG7JnB@flexo> <20120613153555.GB14657@linux-mips.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 16 Jun 2012 13:03:52 +0200
Message-ID: <CAOiHx=nQphC4TbGqgO9EoCjCTCenL4BqJoVRBMpjP7VTA1mUnA@mail.gmail.com>
Subject: Re: [PATCH 1/8] MIPS: BCM63XX: move flash registration out of board_bcm963xx.c
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33670
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

Hi Ralf,

On 13 June 2012 17:35, Ralf Baechle <ralf@linux-mips.org> wrote:
> I'm running a quick rebuild of all defconfigs before pushing it all out
> to upstream-sfr.

That was faster than expected, thank you very much. Should I send a
replacement patch dropping the __init?

And yes, DT is planned in the long run, but from what I can tell there
are some prerequisites that need to be fixed first (e.g. the clock
code - linux-next currently doesn't even build for bcm63xx because of
that).

Regards,
Jonas
