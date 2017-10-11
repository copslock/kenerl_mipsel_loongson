Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 12:15:31 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990432AbdJKKPXvtq4S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Oct 2017 12:15:23 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4C3ACABB4;
        Wed, 11 Oct 2017 10:15:20 +0000 (UTC)
Date:   Wed, 11 Oct 2017 12:15:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] timer: Remove expires argument from
 __TIMER_INITIALIZER()
Message-ID: <20171011101514.GA2882@pathway.suse.cz>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
 <1507159627-127660-12-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507159627-127660-12-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

On Wed 2017-10-04 16:27:05, Kees Cook wrote:
> The expires field is normally initialized during the first mod_timer()
> call. It was unused by all callers, so remove it from the macro.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/kthread.h   | 2 +-
>  include/linux/timer.h     | 5 ++---
>  include/linux/workqueue.h | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)

I was primary interested into the change in kthread.h. But the entire
patch is simple and looks fine:

Reviewed-by: Petr Mladek <pmladek@suse.cz>

Best Regards,
Petr
