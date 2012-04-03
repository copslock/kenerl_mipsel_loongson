Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2012 14:26:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41698 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903797Ab2DCM0H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2012 14:26:07 +0200
Date:   Tue, 3 Apr 2012 13:26:07 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Matt Turner <mattst88@gmail.com>
cc:     Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
In-Reply-To: <CAEdQ38Ez+8DudAaJY7HZu9jbisk_KMbBO5h=s+P4pjJ0Va-zWw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1204031323300.28968@eddie.linux-mips.org>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com> <20110903103036.161616a5@endymion.delvare> <20111031105354.4b888e44@endymion.delvare> <20120110153834.531664db@endymion.delvare> <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
 <20120331082346.26cc95cb@endymion.delvare> <CAEdQ38Ez+8DudAaJY7HZu9jbisk_KMbBO5h=s+P4pjJ0Va-zWw@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 32859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, 31 Mar 2012, Matt Turner wrote:

> >> It's hard to prioritize volunteer work for hardware you and two other
> >> people have. :)
> >
> > Matt, Maciej, does any of you have an updated patch ready by now? If I
> > don't receive anything by the end of April I'll just drop it.
> 
> I'll do my best to get you an updated patch.
> 
> Thanks for keeping after me.

 And thanks for looking after the patches -- regrettably I still have no 
ETA on updating my Linux sources to a version that would let me work on 
upstream patches, sigh...  I'll do my best to review or provide other 
feedback on these changes if needed though.

  Maciej
