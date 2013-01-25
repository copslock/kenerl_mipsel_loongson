Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jan 2013 17:58:20 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60283 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833461Ab3AYQ6PlfqmL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Jan 2013 17:58:15 +0100
Received: by mail-pa0-f52.google.com with SMTP id fb1so363791pad.11
        for <linux-mips@linux-mips.org>; Fri, 25 Jan 2013 08:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=6pe7J2GPhYC4gVIlaUYGYUUIhzlTjBV05/UY/bvtRB0=;
        b=GhO/y4dXKZ0bv9+nELQc7u5bncvPd67YNkAtG19yMHbu/3+UMeuh7Zuz7dhmMp7bsw
         aSftJHWfEnl9F04w8hwdkYVwL0PgDvWJfvw/zwcnsunkuwvmwIzv3eG/9orEjff52bOO
         6MAjmwt3r2SybGSmPiIfsQL9x5D7BDjoyShrANk8mBJEIa/DGGIZ6rZ91vL8kXjV2ikz
         URuaQsDuSzhQlJY7TBTdl46I8B3yAUJ0Nxo8bSvGyxJpjV186kBDFKqnzEFl1Fb8Bt8g
         3ulkx0rCrczK/Onqj6NZq/UwjdlAHxW+Nzw7sMn9QrGq/JGmkQ95neBYdsREPA+1S8wp
         bDZw==
X-Received: by 10.66.89.132 with SMTP id bo4mr14876951pab.62.1359133088204;
        Fri, 25 Jan 2013 08:58:08 -0800 (PST)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id w5sm1168876pax.28.2013.01.25.08.58.06
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 08:58:07 -0800 (PST)
Date:   Fri, 25 Jan 2013 08:58:06 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 1/2] serial: ralink: adds support for the serial core
 found on ralink wisoc
Message-ID: <20130125165806.GA16911@kroah.com>
References: <1359121440-14266-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1359121440-14266-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlCySXMgrw/O+8sKdN95hOFKkivvhLDFLyW0dA+8CmkMG4vX2jst5b5VjlbGTbFNKmnz7oM
X-archive-position: 35560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Fri, Jan 25, 2013 at 02:44:00PM +0100, John Crispin wrote:
> The MIPS based Ralink WiSoC platform has 1 or more 8250 compatible serial cores.
> To make them work we require the same quirks that are used by AU1x00.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
> Changes in V2
> * adds missing "/" in source code comment
> 
>  drivers/tty/serial/8250/8250.c  |    6 +++---
>  drivers/tty/serial/8250/Kconfig |    8 ++++++++
>  include/linux/serial_core.h     |    2 +-
>  3 files changed, 12 insertions(+), 4 deletions(-)

What tree did you make this against?  I can't apply it to my tty-next
one, so I can't take this series.  Care to refresh it and resend it?

thanks,

greg k-h
