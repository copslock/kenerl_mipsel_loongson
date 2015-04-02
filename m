Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 17:01:19 +0200 (CEST)
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34554 "EHLO
        mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009724AbbDBPBRhDu7H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2015 17:01:17 +0200
Received: by wgbdm7 with SMTP id dm7so88313877wgb.1
        for <linux-mips@linux-mips.org>; Thu, 02 Apr 2015 08:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=eZtF8F+cqu+qJAVDCuI5LegJrrXa318dS4SckR6eb28=;
        b=DrD6qF4rkNn1kqcuJ5wO4MxBPlJUCUicyB8DIcHPUKgjaVL+FqqQciA8loe59iqL23
         2CMTH1tawaXKhr6VVe/64cLYmx/Mz82EGXRpv2l7dzN1Z4eLOBj8RTG6moZVLACwByVr
         7XJ9+V1E5fHj5f17biKADQRvJ+1ggyOt+QpwkwT59Ucui+A++IUuRnJkVWlAFK7RBleA
         oCaG43xgX6mKSmRNS2wvPRBrIvv1UVh8jx3ZtjIaekifREpwMTpzlAwrNBVIPVwGf2tG
         EV9AOSVgA/ry/qOCfuA2LG2IoPGq7kMBT6QxQVI6ObfGk05JLS/a0kpypztb0ZOkPWOZ
         3hCA==
X-Gm-Message-State: ALoCoQkHUFYk7pW5lSVOQRcJEMbWXSW4UWHxc3MHyFpb3QXbJggRMQokr8zHdWx20+edpDZziZAT
X-Received: by 10.180.74.144 with SMTP id t16mr6662863wiv.33.1427986873305;
        Thu, 02 Apr 2015 08:01:13 -0700 (PDT)
Received: from trevor.secretlab.ca (host81-159-189-91.range81-159.btcentralplus.com. [81.159.189.91])
        by mx.google.com with ESMTPSA id vq9sm7619930wjc.6.2015.04.02.08.01.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2015 08:01:11 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 740C1C408D6; Thu,  2 Apr 2015 06:32:50 -0700 (PDT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on
 =?iso-8859-1?Q?DT=0D?= properties
To:     Peter Hurley <peter@hurleysoftware.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <5516DE64.6000104@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
        <1416872182-6440-6-git-send-email-cernekee@gmail.com>
        <54F3914F.3080905@hurleysoftware.com>
        <20150328013604.488A0C4091F@trevor.secretlab.ca>
        <5516DE64.6000104@hurleysoftware.com>
Date:   Thu, 02 Apr 2015 06:32:50 -0700
Message-Id: <20150402133250.740C1C408D6@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46705
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

On Sat, 28 Mar 2015 13:01:24 -0400
, Peter Hurley <peter@hurleysoftware.com>
 wrote:
> Hi Grant,
> 
> On 03/27/2015 09:36 PM, Grant Likely wrote:
> > On Sun, 01 Mar 2015 17:23:11 -0500
> > , Peter Hurley <peter@hurleysoftware.com>
> >  wrote:
> >> Hi Kevin,
> >>
> >> On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
> >>> If an earlycon (stdout-path) node is being used, check for "big-endian"
> >>> or "native-endian" properties and pass the appropriate iotype to the
> >>> driver.
> >>>
> >>> Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
> >>> big-endian property only really makes sense in the context of 32-bit
> >>> registers, since 8-bit accesses never require data swapping.
> >>>
> >>> At some point, the of_earlycon code may want to pass in the reg-io-width,
> >>> reg-offset, and reg-shift parameters too.
> >>>
> >>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> >>> ---
> >>>  drivers/of/fdt.c              | 7 ++++++-
> >>>  drivers/tty/serial/earlycon.c | 4 ++--
> >>>  include/linux/serial_core.h   | 2 +-
> >>>  3 files changed, 9 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> >>> index 658656f..9d21472 100644
> >>> --- a/drivers/of/fdt.c
> >>> +++ b/drivers/of/fdt.c
> >>> @@ -794,6 +794,8 @@ int __init early_init_dt_scan_chosen_serial(void)
> >>>  
> >>>  	while (match->compatible[0]) {
> >>>  		unsigned long addr;
> >>> +		unsigned char iotype = UPIO_MEM;
> >>> +
> >>>  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
> >>>  			match++;
> >>>  			continue;
> >>> @@ -803,7 +805,10 @@ int __init early_init_dt_scan_chosen_serial(void)
> >>>  		if (!addr)
> >>>  			return -ENXIO;
> >>>  
> >>> -		of_setup_earlycon(addr, match->data);
> >>> +		if (of_fdt_is_big_endian(fdt, offset))
> >>> +			iotype = UPIO_MEM32BE;
> >>> +
> >>> +		of_setup_earlycon(addr, iotype, match->data);
> >>
> >> I know these got ACKs already but as you point out in the commit log,
> >> earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
> >> distinction between early_init_dt_scan_chosen_serial() and
> >> of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
> >> taught to properly decode of_serial driver bindings instead of a
> >> stack of parameters to of_setup_earlycon().
> >>
> >> In fact, this patch allows a mis-defined devicetree to bring up a
> >> functioning earlycon because the 'big-endian' property is directly
> >> associated with UPIO_MEM32BE, which will create incompatibility problems
> >> when DT earlycon is fixed to decode the of_serial DT bindings.
> > 
> > That's a good point. This hasn't been merged yet, so there isn't any
> > impact on addressing this. I would propose that for consistency, the
> > earlycon code should always default to 8-bit access. if big-endian
> > accesses are required, then reg-io-width + big-endian must be specified.
> > 
> > Something like the following would do it and would be future-proof. We
> > can add support for 16 or 64bit big or little endian access if it ever
> > became necessary.
> 
> I was planning on adding MEM32BE support to OF earlycon on top of my
> patch series 'OF earlycon cleanup', which adds full support for the
> of_serial driver DT properties (among other things).
> 
> Unfortunately, that series is waiting on two things:
> 1. libfdt upstream patch, which I submitted but was referred back to me
> to add test cases. That was 3 weeks ago and I simply haven't had a free
> day to burn to figure out how their test matrix is organized. I don't
> think that's going to change anytime soon; I might just abandon that patch
> and do the string manipulation on the stack.
> 
> ATM, earlycon is still broken if stdout-path options have been set.

I don't seem to have that patch. Can you send it to me please?

I do have a thought though. Would it be better to teach
fdt_path_offset() to recognize the ':' delimiter?  It's never a valid
character for a path.

The unittests are easy. "make check" builds and runs them. Adding a test
is as simple as editing tests/parent_offset.c. main() calls check_path()
several times to test calls to fdt_path_offset(). The tests can be added
directly to that file.

g.
