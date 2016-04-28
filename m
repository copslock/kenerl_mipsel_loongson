Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 19:11:05 +0200 (CEST)
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35409 "EHLO
        mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027719AbcD1RLEJYJo8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Apr 2016 19:11:04 +0200
Received: by mail-qg0-f50.google.com with SMTP id f74so32459792qge.2;
        Thu, 28 Apr 2016 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Fk9LM4LBIBfNYkQkgWTgZE0g39BgDi4WAfmUj9hduZA=;
        b=djdGnM0GYTkCWBNhXPYmGYRnOdgTwy5Lvu7otvdHbFkMVj1NwveNdaag97Z+JLbL6g
         l82rcJITZ3e9YsA3C4a22Me0Exou6NlMaG87V3nVAskd5dyafCbQiW2Syb7mmqZMAR/8
         a2ZZ9gKTeDtlC9/lfv51BpxH4Yp44hmxdEjE1gVNNFIfWW+y+ift4zdLvmWNnF3R/SNH
         uqYTPVKnX5J6Tfp4vIlZSth+lC49etLNr8ZwHS/+ZozCAPoWeEihKsn48131oj/E0nxq
         2phSdVqvgMO/cUujahpMcvbXdpcu3+DLHwhrpduGbk5uR5yO1e7E+MnoVQaP6pJRzAuJ
         yreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Fk9LM4LBIBfNYkQkgWTgZE0g39BgDi4WAfmUj9hduZA=;
        b=VuLnrsMUhp2CFXsNgFTdd/pcxBhQee6xBkJlH2aZ2/KxUl9uuw8zyLuOpfERa0GKzM
         x6QP3a1/oMnL1SLQVCws+dizBRDbfIBn7qFjG9+W7QIuOmHQZNH/Ze83jsYvpsCBueEh
         8q8eKz65ocATZxb+HCrIOkQZhDnBALIsXMoXTyu37P1NX80EjnErd+L7Qb0XzPwMyZ7M
         XqbJ86I93aR0x7YLfaOETX6OXcw8gBwX5yoPh+Jxml1EWO4v3Vj6jgztM+Lp6KswfpYc
         VdSust17viWe/4ILlhpTrwk060w3h8mgb25JxLxbN/6BXeFvbmSukeyNe+1AX2tcECwa
         AwJA==
X-Gm-Message-State: AOPr4FX/lgl41T6Bh/qJfZtYYRRS8gQNU6PIVHQI+xYXNLvFFd3k78YXLQ/14LfQvv6tVw==
X-Received: by 10.140.108.116 with SMTP id i107mr14644949qgf.36.1461863458244;
        Thu, 28 Apr 2016 10:10:58 -0700 (PDT)
Received: from [192.168.1.103] (c-73-180-171-104.hsd1.md.comcast.net. [73.180.171.104])
        by smtp.gmail.com with ESMTPSA id 144sm3095375qhz.14.2016.04.28.10.10.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 10:10:56 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
From:   Josh Juran <jjuran@gmail.com>
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
Date:   Thu, 28 Apr 2016 13:10:52 -0400
Cc:     akpm@linux-foundation.org, linux@horizon.com, peterz@infradead.org,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, nios2-dev@lists.rocketboards.org,
        linux@lists.openrisc.net, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6FAE0D2C-A593-488B-AE26-E462AF372D8E@gmail.com>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
To:     zengzhaoxiu@163.com
X-Mailer: Apple Mail (2.1510)
Return-Path: <jjuran@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jjuran@gmail.com
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

On Apr 28, 2016, at 7:43 AM, zengzhaoxiu@163.com wrote:

> + * This implements the binary GCD algorithm. (Often attributed to Stein,
> + * but as Knuth has noted, appears a first-century Chinese math text.)

Should this be "appears in a"?

Josh
