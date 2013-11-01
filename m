Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Nov 2013 06:26:33 +0100 (CET)
Received: from mail-ee0-f45.google.com ([74.125.83.45]:48697 "EHLO
        mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816233Ab3KAF02uInpu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Nov 2013 06:26:28 +0100
Received: by mail-ee0-f45.google.com with SMTP id e50so1783391eek.4
        for <multiple recipients>; Thu, 31 Oct 2013 22:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-type:content-disposition
         :in-reply-to;
        bh=zEGf/7tlCtafASPnSljo8GScWTFC+OxFqKvguUF0kTM=;
        b=zg1xTevbWa9BmXmM/pqHKmX29Lz1SlZXSzMe7FvEH8aNt1oL44IgpQle1rHIT+6isI
         zEAyZiI70MTY+G6Lpv6R44Z6d+NDETu5plAYgxNgrPkBntA80MkFeYTqyY/ZX6kQR22s
         4BsNsav7CwzTRuN/GmElnRvpZRAB56OeqR0BXTk7pNedfsrm4s0W3hiDpQErMRf/h3Jx
         5V06MVltOMhskP/ef8kFyImvYt59SzFLSEzwAh2sk8WPJmLp2SmMT96mC+CEqHiGrufi
         0YPO0qNBUA09nn+9uajnO1XRTpbY72rrtJBsRHnU+nfEp0hgsNLJkZamWM7D7cd1a4Bd
         LrHQ==
X-Received: by 10.14.198.66 with SMTP id u42mr1068087een.80.1383283583543;
        Thu, 31 Oct 2013 22:26:23 -0700 (PDT)
Received: from glitch (j115181.upc-j.chello.nl. [24.132.115.181])
        by mx.google.com with ESMTPSA id u46sm3036511eep.17.2013.10.31.22.26.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 22:26:22 -0700 (PDT)
Received: by glitch (Postfix, from userid 1000)
        id 316CA3C01F5; Fri,  1 Nov 2013 06:26:14 +0100 (CET)
Date:   Fri, 1 Nov 2013 06:26:14 +0100
From:   Domenico Andreoli <cavokz@gmail.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/11] MIPS: use the common machine reset handling
Message-ID: <20131101052614.GB28233@glitch>
Mail-Followup-To: Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
References: <20131031062708.520968323@linux.com>
 <20131031062959.169063871@linux.com>
 <5273381A.9020103@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5273381A.9020103@synopsys.com>
Return-Path: <cavokz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cavokz@gmail.com
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

On Fri, Nov 01, 2013 at 10:41:54AM +0530, Vineet Gupta wrote:
> On 10/31/2013 11:57 AM, Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > Proof of concept: MIPS as a consumer of the machine reset hooks.
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mips@vger.kernel.org
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > ---
> >  arch/mips/kernel/reset.c |    7 +++++++
> >  kernel/power/Kconfig     |    2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > Index: b/arch/mips/kernel/reset.c
> > ===================================================================
> > --- a/arch/mips/kernel/reset.c
> > +++ b/arch/mips/kernel/reset.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/types.h>
> >  #include <linux/reboot.h>
> > +#include <linux/machine_reset.h>
> >  
> >  #include <asm/reboot.h>
> >  
> > @@ -29,16 +30,22 @@ void machine_restart(char *command)
> >  {
> >  	if (_machine_restart)
> >  		_machine_restart(command);
> > +	else
> > +		default_restart(reboot_mode, command);
> >  }
> >  
> >  void machine_halt(void)
> >  {
> >  	if (_machine_halt)
> >  		_machine_halt();
> > +	else
> > +		default_halt();
> >  }
> >  
> >  void machine_power_off(void)
> >  {
> >  	if (pm_power_off)
> >  		pm_power_off();
> > +	else
> > +		default_power_off();
> >  }
> > Index: b/kernel/power/Kconfig
> > ===================================================================
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -297,4 +297,4 @@ config CPU_PM
> >  config MACHINE_RESET
> >  	bool
> >  	default n
> > -	depends on ARM || ARM64
> > +	depends on ARM || ARM64 || MIPS
> 
> This particular idiom is frowned upon for new code. As new arches get added this
> list keeps getting bigger and then those who don't need the feature need to add
> the anti dependency. Also in this particular case the dependency is trivial so you
> can just "select" it in arch/*/Kconfig

this dependency guarantees only that the option is available only on the
supported arches.

anyway I've not a strong opinion, I only picked the least invasive solution
I was able to think.

thanks,
Domenico
