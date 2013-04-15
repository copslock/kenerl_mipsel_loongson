Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 20:14:16 +0200 (CEST)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:35836 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835144Ab3DOSOO3Du14 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 20:14:14 +0200
Received: by mail-pb0-f50.google.com with SMTP id jt11so2661505pbb.37
        for <linux-mips@linux-mips.org>; Mon, 15 Apr 2013 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yMsroIj7GP89V9Be+Sv3KR9zz7z6oO2ES1SimVRJktw=;
        b=fvBFswVg1MFqYprSwfymRRSF8cvGMb2qVZwxY846Iv4siV+UiJTEMf93JToXsU1CzG
         N6H+d4PlWrGr1WBYKHPLZ8HIdFu3TzEt3+q041QCU/MNNC2jZUSqNVW4Xx7vQA63x5ii
         LrHZfR3K3EBNuJdm5A2masdOHRYGYOoTv4/Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=yMsroIj7GP89V9Be+Sv3KR9zz7z6oO2ES1SimVRJktw=;
        b=js2JHDFDx5cmnT6aK7amfdmsHW9YVJuAIr0wX0ks0IacKAJtL5Gc7JBzd2UEfMMMQ+
         0RNpQu+FOy43zSgGV8BJxIEFFOxoRRFvT/X638zoksmlxD1SLYrA3l4/++25gUEvBcTm
         yIwitHDAdI+ojvYILCDrJ67sNFCiJbj8vGrE0cNYL40GWBKguIxAH8v2YLA1v+YfUS/A
         MYy/m0GyJDCk9D8PYd9QBsJ61TXrHdi6XhHzBZ+RKxNmqEqqnh+HyoBc91Lu1chfVb/G
         pvicNx2iXBFTQLlH+AFhy3sTDoQKTMIkt/cT8XwcC+HTZ7Suynj3PHmukW5Qxu5RQFYd
         6l1Q==
X-Received: by 10.68.9.34 with SMTP id w2mr11629208pba.30.1366049647536;
        Mon, 15 Apr 2013 11:14:07 -0700 (PDT)
Received: from localhost ([32.154.78.73])
        by mx.google.com with ESMTPS id j13sm20737903pat.17.2013.04.15.11.14.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 11:14:06 -0700 (PDT)
Date:   Mon, 15 Apr 2013 11:14:02 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: of_serial: allow rt288x-uart to load from OF
Message-ID: <20130415181402.GA25194@kroah.com>
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
 <1365845618-16040-2-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1365845618-16040-2-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQm09M/ZuYwpGFhkimVxvXK5UZr6yBGpEzdaaMQqMGHVCLUujvBWqYbCRk3JFFSrjBL/uxek
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36197
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

On Sat, Apr 13, 2013 at 11:33:36AM +0200, John Crispin wrote:
> In order to make serial_8250 loadable via OF on Ralink WiSoC we need to default
> the iotype to UPIO_RT.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  drivers/tty/serial/of_serial.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index b025d54..42f8550 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -98,7 +98,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  		port->regshift = prop;
>  
>  	port->irq = irq_of_parse_and_map(np, 0);
> -	port->iotype = UPIO_MEM;
> +	if (of_device_is_compatible(np, "ralink,rt2880-uart"))
> +		port->iotype = UPIO_AU;
> +	else
> +		port->iotype = UPIO_MEM;

Why are you putting device-specific things into a generic driver?
Shouldn't this be able to be described in device tree without relying on
an vendor-specific test in this driver?

greg k-h
