Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2016 19:25:06 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33159 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032729AbcEZRZEr6hr1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 May 2016 19:25:04 +0200
Received: by mail-pf0-f193.google.com with SMTP id b124so9547922pfb.0
        for <linux-mips@linux-mips.org>; Thu, 26 May 2016 10:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poysibdLGyTYJuIrELs+DndAAFfg671MfqzzCgfhWjo=;
        b=wAOmpyiRFuv2YlBzomqsQPvj0avzlESod1GREdrVodBWLmy0Z/hpDfF9SjlLXUNSqd
         wy8dDLM4BVg0vN1UzxMHwIqh41I5w9GFYOeGvEqLcr7EvWLVw63+ie9LrTcvxGQe2+w4
         hbLjVN2aWQqvjUfV4Imco/Q43WAUbUV5pUr0cuIZVnpvmN+of0zrxGfxTfo+Q7YuGT0k
         9yj+6vmOprh/hrjMhLypjl7HKk8bjbBoW7VJe4trskh7VKGf7+s+5RAnL7fRD6i0u0V1
         SUDP+Ir9NtEj1afspIx3K4vb4tFr57J3vCe1/0maibNSIncIocnm+Afng685atyRt99H
         UkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poysibdLGyTYJuIrELs+DndAAFfg671MfqzzCgfhWjo=;
        b=Vnklu7XnTYEbBHUKHs0sSqdGdq8tCwVUAGiku8Qp5DoNlLJE59pfUhhEKTxD9fc92n
         fL/C4AnzaKf0UwyrId6cwLMXP23mTtIW4J1A/m6q4Rb5eMlIvD1HBgWwDlhvG+E6JgJX
         nJA091cDkGCiA4HRvP0hJynDKf1ug93aFQEBrM1jlg4XP9gVfLv09CfVyngayHIAEVy2
         Yk0zYHjob0lqMxvb9ZwxIyuFRbdLMP/2DwNnct3ODyosPCPnU/53cKk4gQ8FZefLukSj
         dfQlpDp1vAoclDDFXqgNi2EAeZSa/xpwLyAIL8R821DEAlOEWFr8fgJIF+D7vAflhHTa
         8Pvw==
X-Gm-Message-State: ALyK8tIV8tmo8hkcqZVD011A+ErOr2YGHt48uS+qEM9civv0KNbw7RdnMziq5Gfy02vmhA==
X-Received: by 10.98.1.6 with SMTP id 6mr15908981pfb.155.1464283498512;
        Thu, 26 May 2016 10:24:58 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:2447:a10d:9051:be13? ([2601:645:c200:33:2447:a10d:9051:be13])
        by smtp.gmail.com with ESMTPSA id 17sm7441740pfj.96.2016.05.26.10.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2016 10:24:57 -0700 (PDT)
Message-ID: <1464283495.5020.16.camel@chimera>
Subject: Re: [RFC PATCH] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Date:   Thu, 26 May 2016 10:24:55 -0700
In-Reply-To: <57472386.8030605@hauke-m.de>
References: <574372CD.1060201@hauke-m.de> <5743777F.9060801@hauke-m.de>
         <1464041521.5475.18.camel@chimera> <1464067930.27173.7.camel@chimera>
         <57472386.8030605@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Thu, 2016-05-26 at 18:25 +0200, Hauke Mehrtens wrote:
> I like it in the ARM arch code that the SoC specific code does not
> have
> to take care of this stuff. The normal arch code provides the device
> tree and so on.

Well, MIPS bootloaders are strikingly more diverse than on ARM…

> Can we at least add a function to mips which will read the device tree
> and the kernel cmd, so I do not have to open code it for each SoC, but
> only call this function.

That would take a serious arch overhaul not unlike the migration to DT,
and I suspect multiple targets would break. So far, this argc == -2
stuff has been used on only two targets that I could see, so I don't
believe it belongs in head.S even with such an overhaul. That said, if
_real_ UHI spec compliance gets in, the SoC-specific stuff could just be
dropped. In the meantime, I propose this patch with the changes
previously suggested.
