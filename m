Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2011 17:27:49 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58567 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491180Ab1CBQ1q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2011 17:27:46 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p22GRWSx030766;
        Wed, 2 Mar 2011 17:27:32 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p22GRUWc030761;
        Wed, 2 Mar 2011 17:27:30 +0100
Date:   Wed, 2 Mar 2011 17:27:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110302162730.GA23666@linux-mips.org>
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
 <1298996006-15960-6-git-send-email-blogic@openwrt.org>
 <4D6E286D.9050100@mvista.com>
 <20110302142933.GA18221@linux-mips.org>
 <4D6E5CA9.5090201@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6E5CA9.5090201@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 02, 2011 at 04:05:13PM +0100, John Crispin wrote:

> Hi Ralf,
> > While nitpicking - there should be one space between include and < in
> > #include <blah.h>.
> >
> >   
> where did you see that ?

> +#include<linux/module.h>
> +#include<linux/fs.h>
> +#include<linux/miscdevice.h>
> +#include<linux/watchdog.h>
> +#include<linux/platform_device.h>
> +#include<linux/uaccess.h>
> +#include<linux/clk.h>
> +#include<linux/io.h>
> +
> +#include<lantiq.h>

But that only seems to have happened to the code quoted in Sergei's mail.

  Ralf
