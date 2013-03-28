Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Mar 2013 15:13:20 +0100 (CET)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60737 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822839Ab3C1ONSqm93P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Mar 2013 15:13:18 +0100
Received: from ptx.hi.pengutronix.de ([2001:6f8:1178:2:5054:ff:fec0:8e10] ident=Debian-exim)
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <mgr@pengutronix.de>)
        id 1ULDZe-000052-9a; Thu, 28 Mar 2013 15:13:02 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.72)
        (envelope-from <mgr@pengutronix.de>)
        id 1ULDZV-000224-UF; Thu, 28 Mar 2013 15:12:53 +0100
Date:   Thu, 28 Mar 2013 15:12:53 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Svetoslav Neykov <svetoslav@neykov.name>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: chipidea: big-endian support
Message-ID: <20130328141253.GA5079@pengutronix.de>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name>
 <1362176257-2328-2-git-send-email-svetoslav@neykov.name>
 <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:10:12 up 18 days, 23:50, 17 users,  load average: 0.19, 0.27,
 0.28
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:5054:ff:fec0:8e10
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
X-archive-position: 35987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mgr@pengutronix.de
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

On Thu, Mar 28, 2013 at 11:28:32AM +0200, Alexander Shishkin wrote:
> Svetoslav Neykov <svetoslav@neykov.name> writes:
> 
> > Convert between big-endian and little-endian format when accessing the usb controller structures which are little-endian by specification.
> > Fix cases where the little-endian memory layout is taken for granted.
> > The patch doesn't have any effect on the already supported
> > little-endian architectures.
> 
> Applied to my branch of things that are aiming at v3.10. Next time
> please make sure that it applies cleanly.

I am currently rebasing my fix/cleanup/feature patches against your
ci-for-greg and realised that this patch missed to fix debug.c with
cpu_le_32 action. Is someone volunteering to cook a patch?

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
