Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2016 07:32:44 +0200 (CEST)
Received: from e31.co.us.ibm.com ([32.97.110.149]:57754 "EHLO
        e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008648AbcC1FcnyY-Gg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Mar 2016 07:32:43 +0200
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <jejb@linux.vnet.ibm.com>;
        Sun, 27 Mar 2016 23:32:37 -0600
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sun, 27 Mar 2016 23:32:36 -0600
X-IBM-Helo: d03dlp03.boulder.ibm.com
X-IBM-MailFrom: jejb@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 55E4D19D803F
        for <linux-mips@linux-mips.org>; Sun, 27 Mar 2016 23:20:28 -0600 (MDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2S5WYB723199846
        for <linux-mips@linux-mips.org>; Mon, 28 Mar 2016 05:32:34 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
        by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2S5RERC000412
        for <linux-mips@linux-mips.org>; Mon, 28 Mar 2016 01:27:15 -0400
Received: from [153.66.254.194] (sig-9-76-41-46.ibm.com [9.76.41.46])
        by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u2S5QTuL032517
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Mar 2016 01:27:06 -0400
Message-ID: <1459143107.13004.21.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] scsi: remove orphaned modular code from non-modular
 drivers
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
        linux-scsi@vger.kernel.org
Date:   Sun, 27 Mar 2016 22:31:47 -0700
In-Reply-To: <1459098025-26269-1-git-send-email-paul.gortmaker@windriver.com>
References: <1459098025-26269-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.16.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16032805-8236-0000-0000-00001BE32123
Return-Path: <jejb@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jejb@linux.vnet.ibm.com
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

On Sun, 2016-03-27 at 13:00 -0400, Paul Gortmaker wrote:
> In the ongoing audit/cleanup of non-modular code needlessly using 
> modular infrastructure, the SCSI subsystem fortunately only contains 
> two instances that I detected.  Both are for legacy drivers that 
> predate the git epoch, so cleary there is no demand for converting 
> these drivers to be tristate.
> 
> For anyone new to the underlying goal of this cleanup, we are trying 
> to not use module support for code that isn't buildable as a module
> since:
> 
>  (1) it is easy to accidentally write unused module_exit and remove
> code
>  (2) it can be misleading when reading the source, thinking it can be
>      modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in
> turn
>      includes nearly everything else, thus adding to CPP overhead.
>  (4) it gets copied/replicated into other code and spreads like
> weeds.

I don't really buy any of these as being credible issues for the
ancient drivers, so there doesn't appear to be an real benefit to this
conversion; however, besides the danger of touching old stuff, there
are some down sides:

> -MODULE_DESCRIPTION("Sun3x ESP SCSI driver");
> -MODULE_AUTHOR("Thomas Bogendoerfer (tsbogend@alpha.franken.de)");
> -MODULE_LICENSE("GPL");
> -MODULE_VERSION(DRV_VERSION);

These tags are usefully greppable for drivers, regardless of whether
they generate actual kernel side information.

> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.

That's bogus.  I use bind and unbind a lot for testing built in drivers
but the usual user use case is for resetting the devices.

> Build tested for mips (jazz) and m68k (sun3x) on 4.6-rc1 to ensure no
> silly typos crept in.

For trivial changes, build testing is not really sufficient: a
significant fraction of them break something that isn't spotted by the
reviewers.  For the older drivers, this isn't discovered for months to
years and then someone has to go digging back through all the so called
trivial changes to find which one it was.

James
