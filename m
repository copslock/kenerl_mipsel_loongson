Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 20:15:41 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:54379 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835048Ab3DOSPj6m0wH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 20:15:39 +0200
Received: by mail-pa0-f53.google.com with SMTP id bh4so2680144pad.40
        for <linux-mips@linux-mips.org>; Mon, 15 Apr 2013 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=89atUdrTX1lrJH7y5MCw4lLTlOFyMZvb/Z2nMBXjX4U=;
        b=HkWVggT9eUCYJz47PrWsXbE6DfuVc4nXZsCeI0rtF7HG7RAskdM0vNh59ZsafZu/EP
         ZSIBt008SyP5br8RTu3PEvyqpRPO+nMnjS27a4XbONA45rAQXoVp2hJ5nNGpJoyMsfxp
         vu84f/FbWqmOBRt+nLSRKPyrzpwZDener4fzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=89atUdrTX1lrJH7y5MCw4lLTlOFyMZvb/Z2nMBXjX4U=;
        b=gtjTzn9BmNKXSqO+eEnCm6y5HKvHXdpJugN0ayB5lrHmDnjqtY66KkxbsnOE3aaG9h
         BJrraNRdZmsJjQQ8MLeerHFi/jUGzFsowpU6KA4qwkebvCMaN1ccwUQs/UP6Z1izNGxB
         IBy5g2aChVZ5Etb5DEltmrfUPS1xFTCR/kDr9ZqHe9R56J3qBjBKWEYtfgwSd6wOH6gQ
         SWL7qO0mHp78pcumNKrKm9k8yKOssfFVpQ4XagUt1DVVzZBJ22YZgblBL8aHH7HWiB7z
         hVXPmBbLwd7acKTBZyojlUu8pjg+lYbSaDBuNefBXANUR9cFC0u3XaqHTl6IQzqlYIH0
         tlFw==
X-Received: by 10.66.163.229 with SMTP id yl5mr30966689pab.104.1366049733407;
        Mon, 15 Apr 2013 11:15:33 -0700 (PDT)
Received: from localhost ([32.154.78.73])
        by mx.google.com with ESMTPS id pa2sm22949393pac.9.2013.04.15.11.15.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 11:15:32 -0700 (PDT)
Date:   Mon, 15 Apr 2013 11:15:27 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: ralink: fix SERIAL_8250_RT288X
 dependency
Message-ID: <20130415181527.GA25341@kroah.com>
References: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQk9FLteQLWpqEpXIYF0Tm2VdQmTU3ptgDe6UHWKMACDk/I7YSGQ2Fj7VFB73SBXzA7XyGin
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36198
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

On Sat, Apr 13, 2013 at 11:39:32AM +0200, John Crispin wrote:
> With every Ralink SoC that we add, we would need to extend the dependency. In
> order to make life easier we make the symbol depend on MIPS & RALINK and then
> select it from within arch/mips/ralink/.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
> 
> These 2 patches in this series should be merged via the mips tree. Patch 1/2
> requires an Ack from the tty maintainer.
> 
>  drivers/tty/serial/8250/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 80fe91e..24ea3c8 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -295,8 +295,8 @@ config SERIAL_8250_EM
>  	  If unsure, say N.
>  
>  config SERIAL_8250_RT288X
> -	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
> -	depends on SERIAL_8250 && (SOC_RT288X || SOC_RT305X || SOC_RT3883)
> +	bool
> +	depends on SERIAL_8250 && MIPS && RALINK


This patch doesn't create a select anywhere, so how can a user know what
to do here?

greg k-h
