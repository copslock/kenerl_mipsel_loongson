Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 02:41:13 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:45668 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990407AbdJEAlFg-z9r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 02:41:05 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5D8E8102A9620;
        Wed,  4 Oct 2017 17:40:58 -0700 (PDT)
Date:   Wed, 04 Oct 2017 17:40:55 -0700 (PDT)
Message-Id: <20171004.174055.1185097411151057568.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     tglx@linutronix.de, akpm@linux-foundation.org, arnd@arndb.de,
        benh@kernel.crashing.org, cmetcalf@mellanox.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        linux@roeck-us.net, harish.patil@cavium.com,
        heiko.carstens@de.ibm.com, jejb@linux.vnet.ibm.com,
        john.stultz@linaro.org, jwi@linux.vnet.ibm.com,
        kvalo@qca.qualcomm.com, jiangshanlai@gmail.com,
        len.brown@intel.com, manish.chopra@cavium.com,
        mark.gross@intel.com, martin.petersen@oracle.com,
        schwidefsky@de.ibm.com, mpe@ellerman.id.au, mdr@sgi.com,
        netdev@vger.kernel.org, oleg@redhat.com, paulus@samba.org,
        pavel@ucw.cz, pmladek@suse.com, rjw@rjwysocki.net,
        ralf@linux-mips.org, sre@kernel.org, stefanr@s5r6.in-berlin.de,
        sboyd@codeaurora.org, sudipm.mukherjee@gmail.com, tj@kernel.org,
        ubraun@linux.vnet.ibm.com, viresh.kumar@linaro.org, wim@iguana.be,
        linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] timer: Remove expires and data arguments from
 DEFINE_TIMER
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1507159627-127660-11-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
        <1507159627-127660-11-git-send-email-keescook@chromium.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Oct 2017 17:40:59 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Kees Cook <keescook@chromium.org>
Date: Wed,  4 Oct 2017 16:27:04 -0700

> Drop the arguments from the macro and adjust all callers with the
> following script:
> 
>   perl -pi -e 's/DEFINE_TIMER\((.*), 0, 0\);/DEFINE_TIMER($1);/g;' \
>     $(git grep DEFINE_TIMER | cut -d: -f1 | sort -u | grep -v timer.h)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # for m68k parts

For networking:

Acked-by: David S. Miller <davem@davemloft.net>
