Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2012 13:08:37 +0100 (CET)
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:6834 "EHLO
        services.gcu-squad.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824761Ab2LRMIcUqxMw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Dec 2012 13:08:32 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
        by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1TkvyG-0006jc-Pw
        (TLSv1:AES128-SHA:128)
        (envelope-from <khali@linux-fr.org>)
        ; Tue, 18 Dec 2012 13:08:28 +0100
Date:   Tue, 18 Dec 2012 13:08:23 +0100
From:   Jean Delvare <khali@linux-fr.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of 
 interrupts
Message-ID: <20121218130823.183a0322@endymion.delvare>
In-Reply-To: <alpine.LFD.2.00.1207160208570.12288@eddie.linux-mips.org>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
        <20110903103036.161616a5@endymion.delvare>
        <20111031105354.4b888e44@endymion.delvare>
        <20120110153834.531664db@endymion.delvare>
        <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
        <20120331082346.26cc95cb@endymion.delvare>
        <CAEdQ38Ez+8DudAaJY7HZu9jbisk_KMbBO5h=s+P4pjJ0Va-zWw@mail.gmail.com>
        <CAEdQ38EDKndUcdBu1tZ_dOuhweVRW6aA=YKb6kUE3gUQJiwWoQ@mail.gmail.com>
        <alpine.LFD.2.00.1207160208570.12288@eddie.linux-mips.org>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.7; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 35306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 19 Jul 2012 22:01:08 +0100 (BST), Maciej W. Rozycki wrote:
> On Sat, 30 Jun 2012, Matt Turner wrote:
> 
> > I'm not going to have time to do this. :(
> > 
> > I had another look at the code, and I'm not sure I really understand
> > it well enough to address your concerns.
> 
>  I'll try then, as soon as I can.

I'm giving up on this one, sorry. I've been waiting for an update for
over a year, this is simply too much. I just don't get why this patch
was ever submitted if there was no intent to actually get it included.
This has been a waste of many people's time :(

-- 
Jean Delvare
