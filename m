Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 17:15:20 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994619AbeHFPPNrQqpz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Aug 2018 17:15:13 +0200
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E61E721A58;
        Mon,  6 Aug 2018 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568507;
        bh=ESQjGEI5PGW7PE4gaTHvUdHk0/agU9lq0+5RsgFmsZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jJnQ6StKTz74D3T0Z4UyHTMg/cyFlWGMHwwpXCW4hSbbQBeuhmjoyMAdjc88eK3nI
         sZaSkVoas7B63XhuwdCjfi4jFexaEi7J9tbky90RANv73e1FXJB8V7Lgm+mKch1eAK
         1r39QWSIl4weeQzzRKf/tdepgW/ZkBo8+SHMapSQ=
Received: by mail-qt0-f174.google.com with SMTP id t5-v6so14192434qtn.3;
        Mon, 06 Aug 2018 08:15:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlEyPc0Jfjft0Gz7UbIAO+StaJnkQ5bm6ax1Z5ppZ1gi8sw0628k
        vR2xOT0Dj2hHbVz5ioEacopYBivjmcbe+9SXsQ==
X-Google-Smtp-Source: AAOMgpe//wKERl/pGMnDQnhURHagtn6KPVZjvY8uIMPwFDXXnfQ54AJVwQbnBMWSnXr+jTlVdLJQqLF6qS6iCvkeo+w=
X-Received: by 2002:ac8:2c72:: with SMTP id e47-v6mr15441740qta.60.1533568506083;
 Mon, 06 Aug 2018 08:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-7-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-7-songjun.wu@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Aug 2018 09:14:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyuFsfXsG7g10D5g1uLXrFHJ9rdHc97AP9G+pj88v+xg@mail.gmail.com>
Message-ID: <CAL_JsqLyuFsfXsG7g10D5g1uLXrFHJ9rdHc97AP9G+pj88v+xg@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] MIPS: dts: Change upper case to lower case
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin zhu <yixin.zhu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>
> All the upper case in unit-address and hex constants are
> changed to lower case according to the Linux conventions.

It is DT conventions, not Linux.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
> Changes in v2: None
>
>  arch/mips/boot/dts/lantiq/danube.dtsi   | 42 ++++++++++++++++-----------------
>  arch/mips/boot/dts/lantiq/easy50712.dts | 14 +++++------
>  2 files changed, 28 insertions(+), 28 deletions(-)
