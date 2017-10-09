Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 15:23:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55688 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992636AbdJINXRGYZN0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Oct 2017 15:23:17 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v99DN88o013095;
        Mon, 9 Oct 2017 15:23:08 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v99DN5gg013092;
        Mon, 9 Oct 2017 15:23:05 +0200
Date:   Mon, 9 Oct 2017 15:23:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harish Patil <harish.patil@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Reichel <sre@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux1394-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] timer: Remove users of expire and data arguments
 to DEFINE_TIMER
Message-ID: <20171009132305.GH20977@linux-mips.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
 <1507159627-127660-10-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507159627-127660-10-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.9.0 (2017-09-02)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Oct 04, 2017 at 04:27:03PM -0700, Kees Cook wrote:

> Subject: [PATCH 09/13] timer: Remove users of expire and data arguments to
>  DEFINE_TIMER
> 
> The expire and data arguments of DEFINE_TIMER are only used in two places
> and are ignored by the code (malta-display.c only uses mod_timer(),
> never add_timer(), so the preset expires value is ignored). Set both
> sets of arguments to zero.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/mips/mti-malta/malta-display.c | 6 +++---
>  drivers/watchdog/alim7101_wdt.c     | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

For malta-display:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
