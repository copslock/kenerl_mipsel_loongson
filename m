Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2014 21:17:40 +0200 (CEST)
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40543 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008597AbaIITRi5Xqfp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Sep 2014 21:17:38 +0200
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by gateway2.nyi.internal (Postfix) with ESMTP id 032DF20FD9
        for <linux-mips@linux-mips.org>; Tue,  9 Sep 2014 15:17:38 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 09 Sep 2014 15:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=05cfxofqeKjMCYRAWJbYN2EcA4c=; b=NBWTbQ+SHk6ucZaVJKU6J3e0ZXRO
        14hWo3aeMCFXD23yI3DIDR7nvtNloeLJn1vf5kVKJKwCMCD12ufdHnge6urd0xwu
        FXcsV2Vmkx1aRpGunD+ZDCOzHZ9hhIcEEJcKeNTNx3y0/fmOUtnBE364hn1yZScr
        w369UAzOdSwOkoQ=
X-Sasl-enc: NGclKyXHEU1+hAiW1j2MTZLTFlaZuovw9EVJc279Y2cR 1410290257
Received: from localhost (unknown [24.22.230.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 999076801C7;
        Tue,  9 Sep 2014 15:17:37 -0400 (EDT)
Date:   Tue, 9 Sep 2014 12:17:36 -0700
From:   Greg KH <greg@kroah.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH linux-next] MIPS: ioctls: Add missing TIOC{S,G}RS485
 definitions
Message-ID: <20140909191736.GA7467@kroah.com>
References: <1410263575-26720-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410263575-26720-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Tue, Sep 09, 2014 at 12:52:55PM +0100, Markos Chandras wrote:
> Commit e676253b19b2d269cccf67fdb1592120a0cd0676
> (serial/8250: Add support for RS485 IOCTLs) added cases for the
> TIOC{S,G}RS485 commands but this broke the build for MIPS:
> 
> drivers/tty/serial/8250/8250_core.c: In function 'serial8250_ioctl':
> drivers/tty/serial/8250/8250_core.c:2874:7: error: 'TIOCSRS485' undeclared
> (first use in this function)
> drivers/tty/serial/8250/8250_core.c:2886:7: error: 'TIOCGRS485' undeclared
> (first use in this function)
> 
> This patch adds these missing definitions
> 
> Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Cc: <linux-next@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Cc: <linux-serial@vger.kernel.org>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/include/uapi/asm/ioctls.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
> index b1e637757fe3..34050cb6b631 100644
> --- a/arch/mips/include/uapi/asm/ioctls.h
> +++ b/arch/mips/include/uapi/asm/ioctls.h
> @@ -76,6 +76,8 @@
>  
>  #define TIOCSBRK	0x5427	/* BSD compatibility */
>  #define TIOCCBRK	0x5428	/* BSD compatibility */
> +#define TIOCGRS485	0x542E
> +#define TIOCSRS485	0x542F

Any reason you aren't using the _IOR() type macros here?

thanks,

greg k-h
