Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Mar 2015 13:02:49 +0100 (CET)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35903 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008920AbbC1MCsTGn79 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Mar 2015 13:02:48 +0100
Received: by wibg7 with SMTP id g7so53500760wib.1
        for <linux-mips@linux-mips.org>; Sat, 28 Mar 2015 05:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=gIPjKWiWWN8Cr1sv4w/IBA4Lgo6cCnjZb/v4E79V7oc=;
        b=U3In5AX+gwcQJodoSY0PblLrBOY8JHyts8XLw9Zz40uGyRMPUghAX6zO+gMyXstkoC
         kTwVp8dFk95UWNva/1Qc0rePqB89p/JBd19nBsRaKt/sQ9ex52oOOIloYvcFY2LthiS2
         mExAe/OZYMflhRAoJmPf7vHjhYwSSqIgeK8RNOSwQIPIdfM6bKK4J7cgSZUhxhv4TkeI
         MvMK8RzgCG/uP2eCtLv4PfTmByRy59uqy/iAY4L8SpIvWAVC0u4iul6w+ac0qB2fGzfI
         A6aZ7CwHzgXW2J0Ncahu6QzZ2TsojLtUVjyHhn/NtuACxLtREQn9m2adTHVFtbCW243Q
         5lKA==
X-Gm-Message-State: ALoCoQlPIflVuI5zcg5tnZeOfwKgA/Jl2UXZCEY1ICVpBsqZ6LGSAzIdWKtO2CUsLmJuQmjirpsQ
X-Received: by 10.180.81.7 with SMTP id v7mr5730343wix.27.1427544163615;
        Sat, 28 Mar 2015 05:02:43 -0700 (PDT)
Received: from trevor.secretlab.ca ([37.205.61.206])
        by mx.google.com with ESMTPSA id u10sm7530196wib.1.2015.03.28.05.02.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2015 05:02:42 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 488A0C4091F; Sat, 28 Mar 2015 01:36:04 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on
 =?iso-8859-1?Q?DT=0D?= properties
To:     Peter Hurley <peter@hurleysoftware.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <54F3914F.3080905@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
        <1416872182-6440-6-git-send-email-cernekee@gmail.com>
        <54F3914F.3080905@hurleysoftware.com>
Date:   Fri, 27 Mar 2015 18:36:04 -0700
Message-Id: <20150328013604.488A0C4091F@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Sun, 01 Mar 2015 17:23:11 -0500
, Peter Hurley <peter@hurleysoftware.com>
 wrote:
> Hi Kevin,
> 
> On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
> > If an earlycon (stdout-path) node is being used, check for "big-endian"
> > or "native-endian" properties and pass the appropriate iotype to the
> > driver.
> > 
> > Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
> > big-endian property only really makes sense in the context of 32-bit
> > registers, since 8-bit accesses never require data swapping.
> > 
> > At some point, the of_earlycon code may want to pass in the reg-io-width,
> > reg-offset, and reg-shift parameters too.
> > 
> > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> > ---
> >  drivers/of/fdt.c              | 7 ++++++-
> >  drivers/tty/serial/earlycon.c | 4 ++--
> >  include/linux/serial_core.h   | 2 +-
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 658656f..9d21472 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -794,6 +794,8 @@ int __init early_init_dt_scan_chosen_serial(void)
> >  
> >  	while (match->compatible[0]) {
> >  		unsigned long addr;
> > +		unsigned char iotype = UPIO_MEM;
> > +
> >  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
> >  			match++;
> >  			continue;
> > @@ -803,7 +805,10 @@ int __init early_init_dt_scan_chosen_serial(void)
> >  		if (!addr)
> >  			return -ENXIO;
> >  
> > -		of_setup_earlycon(addr, match->data);
> > +		if (of_fdt_is_big_endian(fdt, offset))
> > +			iotype = UPIO_MEM32BE;
> > +
> > +		of_setup_earlycon(addr, iotype, match->data);
> 
> I know these got ACKs already but as you point out in the commit log,
> earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
> distinction between early_init_dt_scan_chosen_serial() and
> of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
> taught to properly decode of_serial driver bindings instead of a
> stack of parameters to of_setup_earlycon().
> 
> In fact, this patch allows a mis-defined devicetree to bring up a
> functioning earlycon because the 'big-endian' property is directly
> associated with UPIO_MEM32BE, which will create incompatibility problems
> when DT earlycon is fixed to decode the of_serial DT bindings.

That's a good point. This hasn't been merged yet, so there isn't any
impact on addressing this. I would propose that for consistency, the
earlycon code should always default to 8-bit access. if big-endian
accesses are required, then reg-io-width + big-endian must be specified.

Something like the following would do it and would be future-proof. We
can add support for 16 or 64bit big or little endian access if it ever
became necessary.

static int of_flat_dt_get_iotype(unsigned long node)
{
	int size, width = 1;
	__be32 *prop;
	bool bigendian = false;

	if (of_get_flat_dt_prop(node, "big-endian", NULL));
		bigendian = true;

	prop = of_get_flat_dt_prop(node, "reg-io-width", &size);
	if (prop) {
		if (size != sizeof(u32))
			return -EINVAL;
		width = fdt32_to_cpu(*prop);
	}

	switch (width) {
	case 1:
		return UPIO_MEM; /* big-endian flag has no effect */
	case 4:
		return bigendian ? UPIO_MEM32BE : UPIO_MEM32;
	default:
		return -EINVAL;
	}
}

...

	iotype = of_fdt_get_iotype(fdt, offset);
	if (iotype == UPIO_INVAL)
		/*fail*/

g.
