Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2012 08:24:04 +0200 (CEST)
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:9776 "EHLO
        services.gcu-squad.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903616Ab2CaGX7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Mar 2012 08:23:59 +0200
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
        by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1SDrj6-000275-Bf
        (TLSv1:AES128-SHA:128)
        (envelope-from <khali@linux-fr.org>)
        ; Sat, 31 Mar 2012 08:23:52 +0200
Date:   Sat, 31 Mar 2012 08:23:46 +0200
From:   Jean Delvare <khali@linux-fr.org>
To:     Matt Turner <mattst88@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Message-ID: <20120331082346.26cc95cb@endymion.delvare>
In-Reply-To: <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
        <20110903103036.161616a5@endymion.delvare>
        <20111031105354.4b888e44@endymion.delvare>
        <20120110153834.531664db@endymion.delvare>
        <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.7; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 32834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 12 Jan 2012 16:19:49 -0500, Matt Turner wrote:
> On Tue, Jan 10, 2012 at 9:38 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Mon, 31 Oct 2011 10:53:54 +0100, Jean Delvare wrote:
> >> On Sat, 3 Sep 2011 10:30:36 +0200, Jean Delvare wrote:
> >> > Please address my concerns where you agree and send an updated patch.
> >>
> >> Matt, care to send an updated patch addressing my concerns? Otherwise
> >> it will be lost again.
> >
> > It's been 3 more months. Matt (or anyone else who cares and has access
> > to the hardware), please send an updated patch or I'll have to drop it.
> 
> I'll fix it up and resend the next time I'm working on the related mips stuff.
> 
> It's hard to prioritize volunteer work for hardware you and two other
> people have. :)

Matt, Maciej, does any of you have an updated patch ready by now? If I
don't receive anything by the end of April I'll just drop it.

-- 
Jean Delvare
