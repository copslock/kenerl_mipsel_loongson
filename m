Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 23:32:43 +0100 (CET)
Received: from perches-mx.perches.com ([206.117.179.246]:47859 "EHLO
        labridge.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6824760Ab2KMWclCZvNl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 23:32:41 +0100
Received: from [173.51.221.202] (account joe@perches.com HELO [192.168.1.167])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 19837653; Tue, 13 Nov 2012 14:32:38 -0800
Message-ID: <1352845961.17444.13.camel@joe-AO722>
Subject: Re: [PATCH V2] wanrouter: Remove it and the drivers that depend on
 it
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>
Cc:     rob@landley.net, harryxiyou@gmail.com, jdike@addtoit.com,
        richard@nod.at, linux@arm.linux.org.uk, ralf@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org, chris@zankel.net,
        jcmvbkbc@gmail.com, isdn@linux-pingi.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        xiyoulinuxkernelgroup@googlegroups.com, linux-kernel@zh-kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org
Date:   Tue, 13 Nov 2012 14:32:41 -0800
In-Reply-To: <20121113.171736.561094209116852795.davem@davemloft.net>
References: <67fe0c5701a8c7cfe06b178cf04b1c5c06592714.1352548454.git.joe@perches.com>
         <20121113.144406.1610017702502358739.davem@davemloft.net>
         <1352837845.12850.3.camel@joe-AO722>
         <20121113.171736.561094209116852795.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.6.0-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-archive-position: 34992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Tue, 2012-11-13 at 17:17 -0500, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Tue, 13 Nov 2012 12:17:25 -0800
> 
> > That seems an odd workflow as it leaves dangling CONFIG_<foo>
> > options set, but I guess it doesn't hurt so here it is.
> 
> As you said it's harmless, and more importantly it avoids
> unnecessary conflicts.
> 
> > I just removed the modified arch/.../<foo>defconfig files.
> 
> Something is not right here:

> [davem@drr net-next]$ git am --signoff V2-wanrouter-Remove-it-and-the-drivers-that-depend-on-it.patch 
> Applying: wanrouter: Remove it and the drivers that depend on it
> error: removal patch leaves file contents
> error: net/wanrouter/Kconfig: patch does not apply
> error: removal patch leaves file contents
> error: net/wanrouter/Makefile: patch does not apply
> error: removal patch leaves file contents
> error: net/wanrouter/patchlevel: patch does not apply
> error: removal patch leaves file contents
> error: net/wanrouter/wanmain.c: patch does not apply
> error: removal patch leaves file contents
> error: net/wanrouter/wanproc.c: patch does not apply
> error: removal patch leaves file contents
> error: drivers/net/wan/cycx_drv.c: patch does not apply
> error: removal patch leaves file contents
> error: drivers/net/wan/cycx_main.c: patch does not apply
> error: removal patch leaves file contents
> error: drivers/net/wan/cycx_x25.c: patch does not apply
> error: removal patch leaves file contents
> error: include/linux/cyclomx.h: patch does not apply
> error: removal patch leaves file contents
> error: include/linux/cycx_drv.h: patch does not apply
> error: removal patch leaves file contents
> error: include/linux/wanrouter.h: patch does not apply
> error: removal patch leaves file contents
> error: include/uapi/linux/wanrouter.h: patch does not apply

Right, that is unexpected/odd/interesting.

I was trying to save mailing list bandwidth by reducing
the patch size.

I generated this with
	$ git format-patch -M -D
but it doesn't apply here either. :(

Using
	$ git format-patch -M
does apply correctly.

It's quite a bit larger though. (120KB vs 14)
I'll send the large patch just to netdev.

Joe
