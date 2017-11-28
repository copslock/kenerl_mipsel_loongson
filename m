Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 17:23:10 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:41608 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990596AbdK1QXA4ooRY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 17:23:00 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 14FDE203B5; Tue, 28 Nov 2017 17:22:55 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id E173320374;
        Tue, 28 Nov 2017 17:22:44 +0100 (CET)
Date:   Tue, 28 Nov 2017 17:22:45 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/13] dt-bindings: Add vendor prefix for Microsemi
 Corporation
Message-ID: <20171128162245.GH21126@piout.net>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-2-alexandre.belloni@free-electrons.com>
 <20171128161014.GG27409@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128161014.GG27409@jhogan-linux.mipstec.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61157
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

On 28/11/2017 at 16:10:14 +0000, James Hogan wrote:
> On Tue, Nov 28, 2017 at 04:26:31PM +0100, Alexandre Belloni wrote:
> > Microsemi Corporation provides semiconductor and system solutions for
> > aerospace & defense, communications, data center and industrial markets.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> 
> Nit: Usually the Cc list goes before the --- line so that it is included
> in the git history (i.e. these people had the opportunity to comment).
> 

Ok, it depends on the maintainer, some people prefer leaving that out of commit log.
I'm fine with adding those back in.

> Cheers
> James
> 
> > 
> > 
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 0994bdd82cd3..7b880084fd37 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -219,6 +219,7 @@ motorola	Motorola, Inc.
> >  moxa	Moxa Inc.
> >  mpl	MPL AG
> >  mqmaker	mqmaker Inc.
> > +mscc	Microsemi Corporation
> >  msi	Micro-Star International Co. Ltd.
> >  mti	Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
> >  multi-inno	Multi-Inno Technology Co.,Ltd
> > -- 
> > 2.15.0
> > 
> > 



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
