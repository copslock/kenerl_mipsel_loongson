Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 16:45:18 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40129 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdK1PpIbEXvY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 16:45:08 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id AD06B2081A; Tue, 28 Nov 2017 16:45:02 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 89F282074B;
        Tue, 28 Nov 2017 16:44:52 +0100 (CET)
Date:   Tue, 28 Nov 2017 16:44:50 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Joe Perches <joe@perches.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] MAINTAINERS: Add entry for Microsemi MIPS SoCs
Message-ID: <20171128154450.GF21126@piout.net>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-14-alexandre.belloni@free-electrons.com>
 <1511883290.19952.20.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511883290.19952.20.camel@perches.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

On 28/11/2017 at 07:34:50 -0800, Joe Perches wrote:
> On Tue, 2017-11-28 at 16:26 +0100, Alexandre Belloni wrote:
> > Add myself as a maintainer for the Microsemi MIPS SoCs.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -9062,6 +9062,13 @@ S:	Maintained
> >  F:	drivers/usb/misc/usb251xb.c
> >  F:	Documentation/devicetree/bindings/usb/usb251xb.txt
> >  
> > +MICROSEMI MIPS SOCS
> > +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > +L:	linux-mips@linux-mips.org
> > +S:	Maintained
> > +F:	arch/mips/mscc/*
> > +F:	arch/mips/boot/dts/mscc/*
> 
> Do any of these directories also contain subdirectories?
> 
> This use of * means only the top level directory files
> are matched by this pattern.
> 
> Using just a trailing / instead makes any file in any
> subdirectory also match.
> 
> Perhaps:
> 
> F:	arch/mips/mscc/
> F:	arch/mips/boot/dts/mscc/

Yes but I'll change it in v2 because I need to resend as I messed up the
cc list on some patches.

Thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
