Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2015 11:18:34 +0100 (CET)
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:51873 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011440AbbKLKScZLRua (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2015 11:18:32 +0100
Received: from boeck4.rrze.uni-erlangen.de (boeck4.rrze.uni-erlangen.de [131.188.11.34])
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 3nxJmS1B33zKSDv;
        Thu, 12 Nov 2015 11:18:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fau.de; s=fau-2013;
        t=1447323512; bh=uk+La8diml3P6uzNhYZcIOmjcm6XtUBu6KzYR5PinQM=;
        h=To:Cc:From:Subject:Date:From;
        b=Qaidbpp35O3FJPSNQy0IasqcEtIMefwHsmEeVtRhFckCs1PHK3bWBt6TZ+cg9Hs9q
         G2UgoQxtGEhpX07cvy2ATTHxw5sq321Hw3HoVJbhJswgUITTBN82j9Z2c2ldgY88RG
         rMIepVSDFSdkr7sP2AxqqcxqkUNtZbcK20VbaRwYftE+oI9IHjcrtQEq7gADRWYzDU
         nB6hUZ8yv0r3pueoXkdjR/KONTiLMcMhZxJOSzukJU8g7SO2APsNKos8FagJV8lPy+
         WWGUc6tjdtyaF1Z3HxXnf/M4cBwFzLd4as+XmO6AbIDtKyYHPldK53Z6gDJ8F9du7Y
         GvlmEOmtpFvyQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20])
        by boeck4.rrze.uni-erlangen.de (boeck4.rrze.uni-erlangen.de [131.188.11.34]) (amavisd-new, port 10026)
        with LMTP id YQmO0oTr5ysm; Thu, 12 Nov 2015 11:18:31 +0100 (CET)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 3nxJmR17JkzKRHv;
        Thu, 12 Nov 2015 11:18:31 +0100 (CET)
X-RRZE-Submit-IP: 2001:638:a000:4142::ff0f:d304
Received: from [IPv6:2001:638:a000:4142::ff0f:d304] (unknown [IPv6:2001:638:a000:4142::ff0f:d304])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX195mujutZ9IKQnDcwIsydvewo6WkOHOGRI=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 3nxJmR0c5BzHngr;
        Thu, 12 Nov 2015 11:18:31 +0100 (CET)
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Paul Bolle <pebolle@tiscali.nl>
From:   Andreas Ziegler <andreas.ziegler@fau.de>
X-Enigmail-Draft-Status: N1110
Subject: Re: MIPS: BMIPS: Enable GZIP ramdisk and timed printks
Message-ID: <56446776.5020406@fau.de>
Date:   Thu, 12 Nov 2015 11:18:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <andreas.ziegler@fau.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.ziegler@fau.de
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

Hi Florian,

your patch "MIPS: BMIPS: Enable GZIP ramdisk and timed printks"
showed up as commit fb9e5642aa9e in linux-next today (that is,
next-20151112). I noticed it because we (a research group from
Erlangen[0]) are running daily checks on linux-next.

Your commit adds two entries to arch/mips/configs/bmips_stb_defconfig,
but one of them has a typo (line 37):

CONFIG_PRINK_TIME=y

which should instead say (notice the missing 'T'):

CONFIG_PRINTK_TIME=y

Not sure how this got two Reviewed-by's, as this simple mistake could
have been easily spotted by running scripts/checkkconfigsymbols.py on
the patch.

Regards,

Andreas

[0] https://cados.cs.fau.de
Original patchwork: https://patchwork.linux-mips.org/patch/11307/
