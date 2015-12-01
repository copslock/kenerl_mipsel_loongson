Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 01:48:18 +0100 (CET)
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35371 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007015AbbLAAsQhzCCf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2015 01:48:16 +0100
Received: by wmuu63 with SMTP id u63so152732548wmu.0
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ukGYz30xt8ye9tQrGxN3YkQ5dg5cMejwPYbEhwCnsi4=;
        b=DfEp+dy7sF4YpXUQTFFugfKR8OBP5+GXim6s+JCY1txsZQSiMRJAWY6s7y576QHH+7
         Uy2dUWkAQaMS6QzzyHpYkGlUh8WULpJtMdaOKXlmLK+ZgErpcESHQWoM30BwP8lFWFGK
         yDXQAdKbF4Xa7H16Zk91QlP4aNmgezbFbzgmKP6Qm7jCCTbzI7MeZi6b76XTk3ha/joH
         erfoh1GFnY7m0SV1tEvZLwfJv1cxRmvKixyr5wcKonMCfq/CTQV5l5Hzx8HkqbkdxOQv
         a0c6Zbgi8mY94A8ZSE40ArZnK3B8jv4BJZeadbeheDsNvha2N3/yrl9TztOtBpJN5dNi
         s1DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ukGYz30xt8ye9tQrGxN3YkQ5dg5cMejwPYbEhwCnsi4=;
        b=oi69u0cU/gAU364VelpILAdPAiZa0Qg5cApWA3TQK5+tkhIvAm/Q4blru/sLvF4F+b
         NFsn1nrAsWUXdvPZSPCvJ0ancUFkZq78DejYS0Va8pLg3yOHD7yz2VNvtD08hF2huD9a
         7TH/xwBqQCsLt09gs+GNvqGqFVQyeMH3pbL1TotPgY7uk8nOmk017+hv9BB1qhJqFvvg
         SNdutO91QhrRvHg+C05NvXGfNJo9M0F3gy/Lb3m7j2kEyK84fpqwG6mvWRKa9zqK4/5R
         ILxmF+OE/Edfjmm9fxd4w6i9hlW+ODkO1o36mgMJxe4RuDNwkHHqsDDWAQGftBWgTVbe
         7rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=ukGYz30xt8ye9tQrGxN3YkQ5dg5cMejwPYbEhwCnsi4=;
        b=jEo6rn8Q9XKgSoiIs9MjJZgrPPgvGMF+YcTtj8pP9qfWjf/y+QXc8UczAGXg5WZWZs
         AUah6QZTJLpwdUABcRkXWr9QO/NI8W62cDSOWCDUthC1pMEkYWic5/603h4lKi7pBhH0
         tiQb6itro9oo+/GrvMiTEDnxOypgcKAL+YLEb8600XksIoRGFtiKN2W4iV1YEjELwv/T
         vz8/WQBA5IUp1qoD7bMVCBxhr5xy07IIApZNWieIM3pGD6duxIa0kATS7Bt4b8P2/ned
         NRbjs3Dwvb7MP/hYJuDN9pROCnvjOFrt06oqAWxysbjPWfhJYqF4xU+sQHXXM8A37GoV
         lNww==
X-Gm-Message-State: ALoCoQnXWgDIusEjryoNvToGxUbY4zcft5njmfwOpOf1cS0hgIcHts3zDVr/izzsdbmYAQs8p+0E
X-Received: by 10.194.243.6 with SMTP id wu6mr74803466wjc.14.1448930891290;
 Mon, 30 Nov 2015 16:48:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.31.135 with HTTP; Mon, 30 Nov 2015 16:47:51 -0800 (PST)
In-Reply-To: <201512010847.SVw9zucX%fengguang.wu@intel.com>
References: <1448921155-24764-4-git-send-email-ddecotig@gmail.com> <201512010847.SVw9zucX%fengguang.wu@intel.com>
From:   David Decotigny <ddecotig@gmail.com>
Date:   Mon, 30 Nov 2015 16:47:51 -0800
X-Google-Sender-Auth: x9e0R1lyz7sRaeiaCC4RjmtJUkU
Message-ID: <CAG88wWa43THeBVyUyS6DirjQM-q1MxGgnZxAGZnU-pKNh1_NsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/17] net: ethtool: add new
 ETHTOOL_GSETTINGS/SSETTINGS API
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        Amir Vadai <amirv@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org,
        Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@emulex.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <decot@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

On Mon, Nov 30, 2015 at 4:04 PM, kbuild test robot <lkp@intel.com> wrote:
>>> include/linux/ethtool.h:129:3: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]

prepared a fix for that, will be part of next patch update after feedback.
