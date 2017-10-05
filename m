Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 08:55:03 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:55024 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990511AbdJEGyuJLjaa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 08:54:50 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8AF4B60719; Thu,  5 Oct 2017 06:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1507186486;
        bh=xJYhV6oqcPoHvx8ohN/ikovIfIM5MGorVc75zaxRmbo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZkKrefgWmU+pRusg7wTONxYsW13VFxrgvHiIztVb0rJGM71Xb6OnW0Pgzh4ezHoPc
         EjyKWDyCKoysYr2fzkaisjtbE54W7nLghExAYAmkxTEt7a/OeXwTSOUuwINQWo7EK3
         /hnPZNZgyXhF82FVyJrAmyHKqBZL8gIU5RyDLgX4=
Received: from x230.qca.qualcomm.com (a88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3510A6025D;
        Thu,  5 Oct 2017 06:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1507186485;
        bh=xJYhV6oqcPoHvx8ohN/ikovIfIM5MGorVc75zaxRmbo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=J0V05Snnf0qaUNrquL+d53cPUMB1Zqjzn5/w+mco8HOC3e+27dPsY8LHrJ+BxoHQI
         mLFCmxaXf1TF4/OLZHszqUxUTNWvyRFRVEr3e7/8kxuE+YWDI2ZzlMac001PoXrDXi
         pqWOP8zvzRp0XrWkwYPiTE3/Ds4YmIX0ls+Mq2wU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3510A6025D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,  Andrew Morton <akpm@linux-foundation.org>,  Arnd Bergmann <arnd@arndb.de>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>,  Chris Metcalf <cmetcalf@mellanox.com>,  Geert Uytterhoeven <geert@linux-m68k.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Guenter Roeck <linux@roeck-us.net>,  Harish Patil <harish.patil@cavium.com>,  Heiko Carstens <heiko.carstens@de.ibm.com>,  "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,  John Stultz <john.stultz@linaro.org>,  Julian Wiedmann <jwi@linux.vnet.ibm.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,  Len Brown <len.brown@intel.com>,  Manish Chopra <manish.chopra@cavium.com>,  Mark Gross <mark.gross@intel.com>,  "Martin K. Petersen" <martin.petersen@oracle.com>,  Martin Schwidefsky <schwidefsky@de.ibm.com>,  Michael Ellerman <mpe@ellerman.id.au>,  Michael Reed <mdr@sgi.com>,  netdev@vger.kernel.org,  Oleg Nesterov <oleg@redhat.com>,  Paul Mackerras <paulus@samba.org>,  Pavel Machek <pavel@u
 cw.cz>,  Petr Mladek <pmladek@suse.com>,  "Rafael J. Wysocki" <rjw@rjwysocki.net>,  Ralf Baechle <ralf@linux-mips.org>,  Sebastian Reichel <sre@kernel.org>,  Stefan Richter <stefanr@s5r6.in-berlin.de>,  Stephen Boyd <sboyd@codeaurora.org>,  Sudip Mukherjee <sudipm.mukherjee@gmail.com>,  Tejun Heo <tj@kernel.org>,  Ursula Braun <ubraun@linux.vnet.ibm.com>,  Viresh Kumar <viresh.kumar@linaro.org>,  Wim Van Sebroeck <wim@iguana.be>,  linux1394-devel@lists.sourceforge.net,  linux-mips@linux-mips.org,  linux-pm@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,  linux-s390@vger.kernel.org,  linux-scsi@vger.kernel.org,  linux-watchdog@vger.kernel.org,  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] timer: Remove expires and data arguments from DEFINE_TIMER
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
        <1507159627-127660-11-git-send-email-keescook@chromium.org>
Date:   Thu, 05 Oct 2017 09:54:33 +0300
In-Reply-To: <1507159627-127660-11-git-send-email-keescook@chromium.org> (Kees
        Cook's message of "Wed, 4 Oct 2017 16:27:04 -0700")
Message-ID: <87d1625bkm.fsf@qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Kees Cook <keescook@chromium.org> writes:

> Drop the arguments from the macro and adjust all callers with the
> following script:
>
>   perl -pi -e 's/DEFINE_TIMER\((.*), 0, 0\);/DEFINE_TIMER($1);/g;' \
>     $(git grep DEFINE_TIMER | cut -d: -f1 | sort -u | grep -v timer.h)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # for m68k parts

[...]

>  drivers/net/wireless/atmel/at76c50x-usb.c | 2 +-

For wireless:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
