Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2015 21:08:30 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:41919 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010985AbbAJUIZoQkZf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jan 2015 21:08:25 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 95F621538A; Sat, 10 Jan 2015 20:08:19 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart handler
References: <1420914550-18335-1-git-send-email-lars@metafoo.de>
Date:   Sat, 10 Jan 2015 20:08:19 +0000
In-Reply-To: <1420914550-18335-1-git-send-email-lars@metafoo.de> (Lars-Peter
        Clausen's message of "Sat, 10 Jan 2015 19:29:08 +0100")
Message-ID: <yw1xh9vyflfw.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Lars-Peter Clausen <lars@metafoo.de> writes:

> Use the recently introduced do_kernel_restart() function as the default restart
> handler if the platform did not explicitly provide a restart handler. This
> allows use restart handler that have been registered by device drivers to
> restart the machine.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  arch/mips/kernel/reset.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
> index 07fc524..36cd80c 100644
> --- a/arch/mips/kernel/reset.c
> +++ b/arch/mips/kernel/reset.c
> @@ -19,7 +19,7 @@
>   * So handle all using function pointers to machine specific
>   * functions.
>   */
> -void (*_machine_restart)(char *command);
> +void (*_machine_restart)(char *command) = do_kernel_restart;
>  void (*_machine_halt)(void);
>  void (*pm_power_off)(void);

There is already a similar patch posted by Kevin Cernekee:
http://www.linux-mips.org/archives/linux-mips/2014-12/msg00410.html

-- 
Måns Rullgård
mans@mansr.com
