Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 17:20:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51688 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825760Ab3IRPUuNMS9I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Sep 2013 17:20:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8IFKm6T000319;
        Wed, 18 Sep 2013 17:20:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8IFKlxI000316;
        Wed, 18 Sep 2013 17:20:47 +0200
Date:   Wed, 18 Sep 2013 17:20:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Fix VGA_MAP_MEM macro.
Message-ID: <20130918152047.GR22468@linux-mips.org>
References: <1378859764-17544-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1378859764-17544-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Sep 10, 2013 at 07:36:04PM -0500, Steven J. Hill wrote:

> diff --git a/arch/mips/include/asm/vga.h b/arch/mips/include/asm/vga.h
> index f4cff7e..4795206 100644
> --- a/arch/mips/include/asm/vga.h
> +++ b/arch/mips/include/asm/vga.h
> @@ -13,7 +13,7 @@
>   *	access the videoram directly without any black magic.
>   */
>  
> -#define VGA_MAP_MEM(x, s)	(0xb0000000L + (unsigned long)(x))
> +#define VGA_MAP_MEM(x, s)	CKSEG1ADDR(0x10000000L + (unsigned long)(x))

If using an addrspace.h macro better include that header file!  I've
fixed that.

Applied.  Thanks!

  Ralf
