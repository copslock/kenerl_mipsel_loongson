Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 16:18:38 +0100 (CET)
Received: from mail-vw0-f177.google.com ([209.85.212.177]:39285 "EHLO
	mail-vw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492843AbZKUPSd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 21 Nov 2009 16:18:33 +0100
Received: by vws7 with SMTP id 7so1394235vws.22
        for <multiple recipients>; Sat, 21 Nov 2009 07:18:26 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Bj61smTqktMIiy1XqrDVT2z1QcJeWp2rLR3qlWgzeZM=;
        b=t+YyuxfnTXmWMDw5tfs2V2wCJixaNpNcC8Jwzh7VIbTH70nI9XScnhCBULWGmCZLEl
         puluwDCiXubiI7c1pt2ltGv/YVR+3B4WgL+7ccIre/JwtMc4UYxy8nTH+nawx3/EfTcR
         JARl/8eHJr8pqwrSN3cvYoWKcJ8wBzev8PDvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gAyEh5zZcuHNcP9KFs/cHutV4FWXqO8anSrvp+KXSudw2hBkMSpKRxNfqs6/nw0yvJ
         JsrnfhYB3/7Ddmhx0fH/Vp57vFhhC+hXXD7nouAKkmepa1EwMAO1oVGUUM74y9XFkUG4
         jBnkys5vc8j4Vs7Nm/OAFW3GIFKmd0jje033s=
MIME-Version: 1.0
Received: by 10.220.122.90 with SMTP id k26mr3454467vcr.69.1258816706098; Sat, 
	21 Nov 2009 07:18:26 -0800 (PST)
In-Reply-To: <20091118114432.GA17418@linux-mips.org>
References: <c6ed1ac50911171859k24685b32m237afd68f63c626f@mail.gmail.com>
	 <20091118114432.GA17418@linux-mips.org>
Date:	Sat, 21 Nov 2009 09:18:26 -0600
Message-ID: <b2b2f2320911210718j5909c151s3286f715d0ab39db@mail.gmail.com>
Subject: Re: how i can know the linux-mips implememt cache strategy?
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	figo zhang <figo1802@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Nov 18, 2009 at 5:44 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> The kernel will always use cache stategy 3 for non-coherent systems and
> caching strategy 5 for cache coherent systems.  These two select the most
> aggressive caching strategy on all processors and that's what gives the
> best performance.

OK, dumb question -- how is this implemented?  Poking through the code,
it looks to me that the cache strategy used comes from the K0 field of the
coprocessor 0 Config register, which I think is whatever gets set up by
the bootloader, or if that wasn't done, the default value of that
field for the processor.
See function coherency_setup() in arch/mips/mm/c-r4k.c:

        if (cca < 0 || cca > 7)
                cca = read_c0_config() & CONF_CM_CMASK;
        _page_cachable_default = cca << _CACHE_SHIFT;

This can be overridden on the kernel command line with the "cca" parameter,
but as Ralf said in
http://www.linux-mips.org/archives/linux-mips/2008-06/msg00186.html,
"passing a CCA value on the command line is nothing a user should
ever, ever have to do".

I can see how this was implemented in 2.6.25, but commit 3513369
[MIPS] Allow setting of the cache attribute at run time, seems to have changed
from the behaviour Ralf described.

Shane
