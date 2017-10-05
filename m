Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 07:28:37 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990499AbdJEF23RLSUd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 07:28:29 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26B276C;
        Thu,  5 Oct 2017 05:28:20 +0000 (UTC)
Date:   Thu, 5 Oct 2017 07:28:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [PATCH 10/13] timer: Remove expires and data arguments from
 DEFINE_TIMER
Message-ID: <20171005052828.GA14470@kroah.com>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
 <1507159627-127660-11-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507159627-127660-11-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Wed, Oct 04, 2017 at 04:27:04PM -0700, Kees Cook wrote:
> Drop the arguments from the macro and adjust all callers with the
> following script:
> 
>   perl -pi -e 's/DEFINE_TIMER\((.*), 0, 0\);/DEFINE_TIMER($1);/g;' \
>     $(git grep DEFINE_TIMER | cut -d: -f1 | sort -u | grep -v timer.h)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # for m68k parts
> ---
>  arch/arm/mach-ixp4xx/dsmg600-setup.c      | 2 +-
>  arch/arm/mach-ixp4xx/nas100d-setup.c      | 2 +-
>  arch/m68k/amiga/amisound.c                | 2 +-
>  arch/m68k/mac/macboing.c                  | 2 +-
>  arch/mips/mti-malta/malta-display.c       | 2 +-
>  arch/parisc/kernel/pdc_cons.c             | 2 +-
>  arch/s390/mm/cmm.c                        | 2 +-
>  drivers/atm/idt77105.c                    | 4 ++--
>  drivers/atm/iphase.c                      | 2 +-
>  drivers/block/ataflop.c                   | 8 ++++----
>  drivers/char/dtlk.c                       | 2 +-
>  drivers/char/hangcheck-timer.c            | 2 +-
>  drivers/char/nwbutton.c                   | 2 +-
>  drivers/char/rtc.c                        | 2 +-
>  drivers/input/touchscreen/s3c2410_ts.c    | 2 +-
>  drivers/net/cris/eth_v10.c                | 6 +++---
>  drivers/net/hamradio/yam.c                | 2 +-
>  drivers/net/wireless/atmel/at76c50x-usb.c | 2 +-
>  drivers/staging/speakup/main.c            | 2 +-
>  drivers/staging/speakup/synth.c           | 2 +-
>  drivers/tty/cyclades.c                    | 2 +-
>  drivers/tty/isicom.c                      | 2 +-
>  drivers/tty/moxa.c                        | 2 +-
>  drivers/tty/rocket.c                      | 2 +-
>  drivers/tty/vt/keyboard.c                 | 2 +-
>  drivers/tty/vt/vt.c                       | 2 +-
>  drivers/watchdog/alim7101_wdt.c           | 2 +-
>  drivers/watchdog/machzwd.c                | 2 +-
>  drivers/watchdog/mixcomwd.c               | 2 +-
>  drivers/watchdog/sbc60xxwdt.c             | 2 +-
>  drivers/watchdog/sc520_wdt.c              | 2 +-
>  drivers/watchdog/via_wdt.c                | 2 +-
>  drivers/watchdog/w83877f_wdt.c            | 2 +-
>  drivers/xen/grant-table.c                 | 2 +-
>  fs/pstore/platform.c                      | 2 +-
>  include/linux/timer.h                     | 4 ++--
>  kernel/irq/spurious.c                     | 2 +-
>  lib/random32.c                            | 2 +-
>  net/atm/mpc.c                             | 2 +-
>  net/decnet/dn_route.c                     | 2 +-
>  net/ipv6/ip6_flowlabel.c                  | 2 +-
>  net/netrom/nr_loopback.c                  | 2 +-
>  security/keys/gc.c                        | 2 +-
>  sound/oss/midibuf.c                       | 2 +-
>  sound/oss/soundcard.c                     | 2 +-
>  sound/oss/sys_timer.c                     | 2 +-
>  sound/oss/uart6850.c                      | 2 +-
>  47 files changed, 54 insertions(+), 54 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
