Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 19:42:46 +0100 (CET)
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:32730 "EHLO
        mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6826024Ab2KFSmqE0Fft (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2012 19:42:46 +0100
Received: from c-98-234-237-12.hsd1.ca.comcast.net ([98.234.237.12] helo=localhost.localdomain)
        by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)
        (envelope-from <tony@atomide.com>)
        id 1TVo6b-000Inf-8v; Tue, 06 Nov 2012 18:42:33 +0000
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 98.234.237.12
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/Bwc9rtEcSeSoe2vom2srp
Date:   Tue, 6 Nov 2012 10:42:27 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Felipe Balbi <balbi@ti.com>
Cc:     Michal Nazarewicz <mpn@google.com>, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Michal Nazarewicz <mina86@mina86.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mike Frysinger <vapier@gentoo.org>,
        uclinux-dist-devel@blackfin.uclinux.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Subject: Re: [PATCHv2 1/6] arch: Change defconfigs to point to
 g_mass_storage.
Message-ID: <20121106184227.GK6801@atomide.com>
References: <cover.1351715302.v2.git.mina86@mina86.com>
 <46dde680f525562e9fd19567deb5247f0bf26842.1351715302.v2.git.mina86@mina86.com>
 <20121106113157.GE11931@arwen.pp.htv.fi>
 <20121106184117.GJ6801@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121106184117.GJ6801@atomide.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 34903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony@atomide.com
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

* Tony Lindgren <tony@atomide.com> [121106 10:41]:
> * Felipe Balbi <balbi@ti.com> [121106 03:40]:
> > Hi,
> > 
> > On Fri, Nov 02, 2012 at 02:31:50PM +0100, Michal Nazarewicz wrote:
> > > From: Michal Nazarewicz <mina86@mina86.com>
> > > 
> > > The File-backed Storage Gadget (g_file_storage) is being removed, since
> > > it has been replaced by Mass Storage Gadget (g_mass_storage).  This commit
> > > changes defconfigs point to the new gadget.
> > > 
> > > Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> > 
> > I need more Acks here. Only got one from Nicolas. Anyone else ?
> 
> For omaps:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Heh I guess no omap changes there, so probably not
worth adding then.

Tony
