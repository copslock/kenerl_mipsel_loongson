Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBG2S7M30914
	for linux-mips-outgoing; Sat, 15 Dec 2001 18:28:07 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBG2S2o30902
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 18:28:02 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBG1RvW01972;
	Sat, 15 Dec 2001 23:27:57 -0200
Date: Sat, 15 Dec 2001 23:27:57 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: patches for SGI O2
Message-ID: <20011215232757.A1863@dea.linux-mips.net>
References: <Pine.LNX.4.21.0112152332470.11851-400000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112152332470.11851-400000@melkor>; from vivien.chappelier@enst-bretagne.fr on Sat, Dec 15, 2001 at 11:52:58PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Dec 15, 2001 at 11:52:58PM +0100, Vivien Chappelier wrote:

> The first one (O2-asid) concerns the TLB initialization the IP32. The
> asid_cache is not initialized, which leads to MMU context = 0 being
> considered valid! Thus when switching task, in switch_mm, a new context is
> not created.

Correct finding.  It's just that you shouldn't have to apply this patch
to the IP32 code and that shows that mips64 needs quite a cleanup there.
Applied anyway.

> Finaly, with my configuration (SGI O2 R5000 @ 180Mhz) I've to change
> PAGE_OFFSET in page.h to the one used for IP22 rather than the one used
> for IP32.. here is a third patch (O2-page) to change this, but I'm not
> sure about other configurations (R10000?)

> -#if defined(CONFIG_SGI_IP27) || defined(CONFIG_SGI_IP32)
> +#if defined(CONFIG_SGI_IP27)
>  #define PAGE_OFFSET	0xa800000000000000UL
>  #endif

0xa8 is caching mode 5 which is not defined for the R5000, thus undefined
behaviour.  You can be almost certain that the CPU use that as an
excuse in order to do really funny things.

As the O2 is a non-cachecoherent machine this should also be correct for
the R10000 / R12000.

  Ralf
