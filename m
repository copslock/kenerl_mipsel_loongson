Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 13:42:03 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:38759 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012227AbbLKMmB0oKwS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 13:42:01 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 555D2AC08;
        Fri, 11 Dec 2015 12:42:00 +0000 (UTC)
Date:   Fri, 11 Dec 2015 13:41:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Cris <linux-cris-kernel@axis.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
Message-ID: <20151211124159.GB3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50544
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

On Fri 2015-12-11 12:10:02, Geert Uytterhoeven wrote:
> On Wed, Dec 9, 2015 at 2:21 PM, Petr Mladek <pmladek@suse.com> wrote:
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
> >                      13 =>   8 KB for each CPU
> >                      12 =>   4 KB for each CPU
> >
> > +config NMI_LOG_BUF_SHIFT
> > +       int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
> > +       range 10 21
> > +       default 13
> > +       depends on PRINTK && HAVE_NMI
> 
> Symbol NMI_LOG_BUF_SHIFT does not exist if its dependencies are not met.

Åh, the NMI buffer is enabled on arm via NEED_PRINTK_NMI.

The buffer is compiled when CONFIG_PRINTK_NMI is defined. I am going
to fix it the following way:


diff --git a/init/Kconfig b/init/Kconfig
index efcff25a112d..61cfd96a3c96 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -870,7 +870,7 @@ config NMI_LOG_BUF_SHIFT
 	int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
 	range 10 21
 	default 13
-	depends on PRINTK && HAVE_NMI
+	depends on PRINTK_NMI
 	help
 	  Select the size of a per-CPU buffer where NMI messages are temporary
 	  stored. They are copied to the main log buffer in a safe context


Thanks a lot for report,
Petr
