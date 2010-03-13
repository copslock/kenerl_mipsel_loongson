Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Mar 2010 09:34:15 +0100 (CET)
Received: from mail-yw0-f201.google.com ([209.85.211.201]:43202 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492094Ab0CMIeM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Mar 2010 09:34:12 +0100
Received: by ywh39 with SMTP id 39so807261ywh.21
        for <multiple recipients>; Sat, 13 Mar 2010 00:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LbmcyLF83DealLGlmAywXxDmnjq2Fy1VO+w8AFn5ECU=;
        b=BW2crtG9BCIJoIIh/AoR4tfS89wrhCM8OKzgztBxKK2iIhTaTZ0b3j9M3C55hg8Cnp
         H37PZ1Lw0OvbfEnB6YwXqFiWtmvd0aO9d8P/roQ7pkQOsmrKQYBDfOS2xKzO89PGpxCe
         S+ZLKEAGT1IVdbrtGJtdXWwmVy8CvdQcJ0IUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B8eGl0B/reUWxzOdxwT2w5uTFpEQqz/uL7jYw7CUAp8+WVvkOmnQmLdNUzx91+RI/g
         TeVvFxWnYckVqJtCKyD1qwMRy73OeA6O/XNrznlopZrtnxilb2f3Qxsdw0MypB/3dVws
         4hS0n1aMh1+Jdr54jZe4F4wgEMv9KdZLz4NZ4=
Received: by 10.101.210.15 with SMTP id m15mr1337941anq.111.1268469243505;
        Sat, 13 Mar 2010 00:34:03 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-24-6-153-206.hsd1.ca.comcast.net [24.6.153.206])
        by mx.google.com with ESMTPS id 22sm747206ywh.1.2010.03.13.00.34.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Mar 2010 00:34:02 -0800 (PST)
Date:   Sat, 13 Mar 2010 00:33:59 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Wolfram Sang <w.sang@pengutronix.de>
Cc:     kernel-janitors@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arch/mips/txx9/generic: init dynamic bin_attribute
 structures
Message-ID: <20100313083359.GB22494@core.coreip.homeip.net>
References: <1268377431-11671-1-git-send-email-w.sang@pengutronix.de>
 <1268377431-11671-2-git-send-email-w.sang@pengutronix.de>
 <20100312183450.GC8736@core.coreip.homeip.net>
 <20100313022855.GD4034@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100313022855.GD4034@pengutronix.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Mar 13, 2010 at 03:28:55AM +0100, Wolfram Sang wrote:
> On Fri, Mar 12, 2010 at 10:34:51AM -0800, Dmitry Torokhov wrote:
> > On Fri, Mar 12, 2010 at 08:03:49AM +0100, Wolfram Sang wrote:
> > > Commit 6992f5334995af474c2b58d010d08bc597f0f2fe introduced this requirement.
> > > Found with coccinelle, but fixed manually. Compile tested on X86 where
> > > possible.
> > > 
> > 
> > Regarding all 3 - it looks like these dynamically alocated attributes
> > could be converted to statically allocated ones. I'd recommend doing
> > that instead (in fact, I posted patch for the firmware_class couple days
> > ago).
> 
> I agree for the firmware-patch. Regarding the MIPS one, 'size' might differ and
> 'private' will differ per instance. Regarding the RTC driver, 'size' might also
> differ. I don't know if somebody really wants two RTCs or the SRAM for MIPS can
> be instantiated more than once. Unless somebody with actual hardware jumps in,
> I'd say better safe than sorry.
> 

Ah, right, size... I forgot about it. You are right, making the other 2
static is not an option.

-- 
Dmitry
