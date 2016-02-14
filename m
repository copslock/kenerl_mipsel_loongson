Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Feb 2016 17:36:26 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35754 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011437AbcBNQgZUSf0R convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 14 Feb 2016 17:36:25 +0100
Received: by mail-lf0-f65.google.com with SMTP id j99so6327952lfi.2;
        Sun, 14 Feb 2016 08:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lmL8r+hSfnyu5bER+f4ypWf+3a2KFr6WjhXp3OuAee0=;
        b=X3Qa9vP/cmPaRaWARI1RTtrPnNXepbpgeiyPhHkCPFZN/+vDl0tf/HmPvB29E2shv/
         V79tegzTLG44nLRI+Kb5M+ZP/u4bVtzAbfCJ4tqQxDn/nJ3PWG2xLE5gMOnaIUXaNQod
         pycfB9+gCFIUV9l+PFU/eCQLE7w5kqMWmkSl4ZBBpaHcXLzUOCtZi6vrZhVM38UofaBu
         Dqd2tPxbvGse/VF4TYV6YpqryGWK7MaFZY7H6KmPI7Bdk1i9rQ+0c2NqiSexdSyEYZAQ
         KIOWERQOWmuNFJn9ruI1QSn9AL/bONZB6xzccUzZE0NABv5k5ds0Tt3nwdCv1Og4fSBc
         GS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=lmL8r+hSfnyu5bER+f4ypWf+3a2KFr6WjhXp3OuAee0=;
        b=lXcrP6gxl34W5g07ZZCeIKJNKF2Srw70OmFz4WbHX9CKNYH0OtroHSj8/7JPCEVM/7
         MMoHmVw9sWmTYSQzTuH49T+NXSoXAT0LavH2+blyXJQ7Sk6L6TmWCR86nW1lesG23OU+
         xBDgPCo5merivJT2XjeNg+XWmCOUwU0jpS9IjuwYu8aIcB38qXWImJNfggPbnCrxMY1c
         ropLWzlQyJrN/hTIM3gwEzfGTU6Vau0CVgm9/FWj8S92Y5XfWM/veUczUquB/1BBmmtm
         rylhDkigydu38gQ7a7RgS55fCRcXNLj4ay4GSg95HU+wJ4qWxgmV73OT0WMkVbvSMqct
         LA0w==
X-Gm-Message-State: AG10YOR3TaGBWlsXMlmiteas2N/YZI5sYVo0nCwLZZcHSbA0kIF9q34zbFYCyZfj/RAWyQ==
X-Received: by 10.25.218.148 with SMTP id r142mr4810906lfg.154.1455467779588;
        Sun, 14 Feb 2016 08:36:19 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id zk9sm3096241lbb.3.2016.02.14.08.36.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Feb 2016 08:36:18 -0800 (PST)
Date:   Sun, 14 Feb 2016 20:02:00 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>
Subject: Re: [PATCH 03/10] MIPS: ath79: Fix the ar724x clock calculation
Message-Id: <20160214200200.fcacde54a5f26f6cbc122b7c@gmail.com>
In-Reply-To: <56C084C4.8000509@denx.de>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
        <1455400697-29898-4-git-send-email-antonynpavlov@gmail.com>
        <56C084C4.8000509@denx.de>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Sun, 14 Feb 2016 14:44:36 +0100
Marek Vasut <marex@denx.de> wrote:

> On 02/13/2016 10:58 PM, Antony Pavlov wrote:
> > From: Weijie Gao <hackpascal@gmail.com>
> > 
> > According to the AR7242 datasheet section 2.8, AR724X CPUs use a 40MHz
> > input clock as the REF_CLK instead of 5MHz.
> 
> Can't the AR71xx also use 25MHz clock source ?


I have just googled AR7242 datasheet.
I states that only 40 MHz reference clock is used.

> > The correct CPU PLL calculation procedure is as follows:
> > CPU_PLL = (FB * REF_CLK) / REF_DIV / 2.
> 
> [...]


-- 
-- 
Best regards,
  Antony Pavlov
