Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 15:54:04 +0200 (CEST)
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35263 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007232AbbEZNyCJ54GP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 15:54:02 +0200
Received: by qkdn188 with SMTP id n188so89226674qkd.2
        for <linux-mips@linux-mips.org>; Tue, 26 May 2015 06:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nlL1lJXWOx9lvDbpfmYdwyvPUMbR8TnxdZBv2SEb9eY=;
        b=lth/Xap669j4wiOiXNFz+he40epRYuudod3U1/8PwObmffOwKHxaIWSVu7vb8sa3X0
         yaWFgbHPYUjFYHuZ9Q+RBxfNUA+tg4Gkis3EIUZgYW86rFWBn3kqpA7XUMjKVQllKdfU
         fYgb8HXucpksUo+CUQk6eY3hA/6ri78hLrSXQdQY116vOH5AZKuRLd7p6Jxfis97WJzu
         kNbtnjSQKiAKn8yMjs0xlFqcL26shWf7KpgiUoeM0VSC2yFop0uUa5oJ58iKcsxS8SZO
         vd4MoipB4591gLKFj35BCuYFrvqAenps6ypgVxADrTWVjZUFK0HiziAonkT4+WdOomlA
         pKAg==
X-Gm-Message-State: ALoCoQnBaVRb6jdoFt3/+vZLZlbu3csWHUEWD/prVQZr2Obuj0+5vAFkZQu2cBfvHgGE//sLFUno
X-Received: by 10.55.20.12 with SMTP id e12mr22259299qkh.56.1432648438952;
        Tue, 26 May 2015 06:53:58 -0700 (PDT)
Received: from [192.168.1.139] (h69-21-74-195.cntcnh.broadband.dynamic.tds.net. [69.21.74.195])
        by mx.google.com with ESMTPSA id j44sm8727188qgd.28.2015.05.26.06.53.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2015 06:53:58 -0700 (PDT)
Message-ID: <55647AF3.1000508@hurleysoftware.com>
Date:   Tue, 26 May 2015 09:53:55 -0400
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>
CC:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 08/15] of_serial: support for UARTs on I/O ports
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com> <1432309875-9712-9-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1432309875-9712-9-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

[ + Arnd who has been reviewing/acking of_serial.c changes ]

On 05/22/2015 11:51 AM, Paul Burton wrote:
> If the address provided for the UART is of an I/O port rather than
> a regular memory address, then set the port iotype appropriately and
> write the address to iobase rather than mapbase.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  drivers/tty/serial/of_serial.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index 137381e..ccff9ba 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -110,7 +110,12 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  
>  	port->irq = irq_of_parse_and_map(np, 0);
>  	port->iotype = UPIO_MEM;
> -	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> +
> +	if (resource.flags & IORESOURCE_IO) {
> +		port->iotype = UPIO_PORT;
> +		port->iobase = port->mapbase;
> +		port->mapbase = 0;
> +	} else if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
>  		switch (prop) {
>  		case 1:
>  			port->iotype = UPIO_MEM;
> 
