Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2011 06:45:28 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:59091 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903542Ab1LGFpV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2011 06:45:21 +0100
Received: by wgbds11 with SMTP id ds11so377438wgb.24
        for <multiple recipients>; Tue, 06 Dec 2011 21:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lG6RBUWgZIEMMkxaH+1H/U0HVmj/YLKeH9mKlPjAykY=;
        b=tEwjoOzl0LBxIsKRk45yW4/XKWhezfvXPS6GoS8jk0Sw2zhQNWPWlnNN2Sj+QQG1O7
         xZ+k1nuZC5c5ak7VIC6uIRPFLDLbRqzubzxFqNunxiSteuY2SDt2Jn4xpmIgPcqYQ5fM
         RP8zwVz4IhI2i36AtfiCeUR5Vz8mm6oDuNscM=
MIME-Version: 1.0
Received: by 10.180.85.4 with SMTP id d4mr21729844wiz.19.1323236716159; Tue,
 06 Dec 2011 21:45:16 -0800 (PST)
Received: by 10.216.180.195 with HTTP; Tue, 6 Dec 2011 21:45:16 -0800 (PST)
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
Date:   Tue, 6 Dec 2011 21:45:16 -0800
Message-ID: <CAN8TOE9kPGr5pvLKEuNykYO_ydp7ZRQvCJuu8BFyHM0-_AvoRw@mail.gmail.com>
Subject: Re: [PATCH 0/7] MTD: MAPS: remove bcm963xx-flash
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5313

On Mon, Dec 5, 2011 at 7:08 AM, Jonas Gorski <jonas.gorski@gmail.com> wrote:
> P.S: This patchset is based on l2-mtd-2.6.git, which seems to be the
> "correct" tree now (the website says mtd-2.6.git, but it doesn't look
> like the correct one, having no commits).

Hi Jonas,

I see that you are nowhere near the first one to have at least a
little bit of trouble with the mtd-2.6.git vs. l2-mtd-2.6.git
question.

Artem or David,

Is it sensible to change the website documentation to reflect the fact
that most MTD development is tracked in Artem's l2 repository
primarily? I can send a patch against mtd-www.git sometime to update
this.

Brian
