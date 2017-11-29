Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:38:33 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40865 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbdK2Qi1c307a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:38:27 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id B6F7920709; Wed, 29 Nov 2017 17:38:19 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 9092E2036E;
        Wed, 29 Nov 2017 17:38:19 +0100 (CET)
Date:   Wed, 29 Nov 2017 17:38:19 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] MIPS: mscc: Add initial support for Microsemi MIPS
 SoCs
Message-ID: <20171129163819.GN21126@piout.net>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-10-alexandre.belloni@free-electrons.com>
 <20171128160137.GF27409@jhogan-linux.mipstec.com>
 <20171128165359.GJ21126@piout.net>
 <20171128173151.GD5027@jhogan-linux.mipstec.com>
 <20171128195002.dcq7i2wqmstkn3rr@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128195002.dcq7i2wqmstkn3rr@pburton-laptop>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61192
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

Hi Paul,

On 28/11/2017 at 11:50:02 -0800, Paul Burton wrote:
> On Tue, Nov 28, 2017 at 05:31:51PM +0000, James Hogan wrote:
> > On Tue, Nov 28, 2017 at 05:53:59PM +0100, Alexandre Belloni wrote:
> > > On 28/11/2017 at 16:01:38 +0000, James Hogan wrote:
> > > > On Tue, Nov 28, 2017 at 04:26:39PM +0100, Alexandre Belloni wrote:
> > > > > Introduce support for the MIPS based Microsemi Ocelot SoCs.
> > > > > As the plan is to have all SoCs supported only using device tree, the
> > > > > mach directory is simply called mscc.
> > > > 
> > > > Nice. Have you considered adding this to the existing multiplatform
> > > > "generic" platform? See for example commit b35565bb16a5 ("MIPS: generic:
> > > > Add support for MIPSfpga") for the latest platform to be converted.
> > > > 
> > > 
> > > I didn't because we are currently booting using an old redboot with its
> > > own boot protocol and at boot, the register read by the sead3 code is
> > > completely random (it actually matched once).
> > > 
> > > Do you consider that mandatory to get the platform upstream?
> > 
> > No, however if it is practical to do so I think it might be the best way
> > forward (even if generic+YAMON support is mutually exclusive of
> > generic+redboot, though hopefully there is some way to avoid that).
> > 
> > Paul on Cc, he may have thoughts on this one.
> 
> We could certainly look at tightening the checks in the SEAD-3 code to
> avoid the false positive.
> 
> Could you share any details of the boot protocol you're using with
> redboot? One option might be for the SEAD-3 code to check that the
> arguments the bootloader provided look "YAMON-like", so long as the 2
> protocols differ sufficiently.
> 

I didn't look closely at the redboot code yet but it ends up with
something like:
 - argc == fw_arg0
 - argv == fw_arg1
    - not sure yet what is in argv[0]
    - kernel commande line in argv[1]
 - fw_arg2 is a pointer to a structure like:
        struct parmblock {
            t_env_var memsize;
        };
    with:
        typedef struct
        {
            char *name;
            char *val;
        } t_env_var;
   this is the size of the RAM but I'm not using it because it is in the
   device tree.

Does that help?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
