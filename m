Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:04:08 +0100 (CET)
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33708 "EHLO
        mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013493AbaKLJEGRR7Qi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:04:06 +0100
Received: by mail-wg0-f44.google.com with SMTP id x12so13577274wgg.17
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 01:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rDkuW6PdX2bEd8p5ATb68ssVP8b9JcF4f+XmZ6h1hGg=;
        b=PZN6kKxN07hkjr/Zg5xyzKjDoBP3Hr4grxYdlezfzYXNv2W6UtW87RAieejh1GZx18
         K2J5xcdHq5vo6sFYWmXHge/gkZC+L0z+fu9gqGkOHBop8+UDK3CDgFMBr2eDbk/0pEnj
         Kzixl8PBFAKp/0YbkXjjobfGxfeUsdaB8yiZBDiJyREZljqXi8Jpknd4WfG0zTzGOf1Y
         DOa7Gt6II2IK9JdbGvHEARUJd4o7efwHbvVW8xhlsP/cdLyKcWI7FfRtm7BRs3xtRFyH
         56jY1kzlO9vvxRtvJLUQ+B3vsa8NHZckOayT5yh6pqYX2QmTHPBIkpQtEZKazwYqrIH+
         izlw==
X-Received: by 10.180.73.45 with SMTP id i13mr48310912wiv.32.1415783040990;
        Wed, 12 Nov 2014 01:04:00 -0800 (PST)
Received: from ?IPv6:2a01:4240:53f0:43fb::cbb? ([2a01:4240:53f0:43fb::cbb])
        by mx.google.com with ESMTPSA id ht9sm20764776wib.8.2014.11.12.01.03.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2014 01:04:00 -0800 (PST)
Message-ID: <5463227E.9050304@suse.cz>
Date:   Wed, 12 Nov 2014 10:03:58 +0100
From:   Jiri Slaby <jslaby@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        robh@kernel.org
CC:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH/RFC 4/8] serial: pxa: Add fifo-size and {big,native}-endian
 properties
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-5-git-send-email-cernekee@gmail.com>
In-Reply-To: <1415781993-7755-5-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 11/12/2014, 09:46 AM, Kevin Cernekee wrote:
> With a few tweaks, the PXA serial driver can handle other 16550A clones.
> Add a fifo-size DT property to override the FIFO depth (BCM7xxx uses 32),
> and {native,big}-endian properties similar to regmap to support SoCs that
> have BE or "automagic endian" registers.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/tty/serial/pxa.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 21b7d8b..78ed7ee 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -60,13 +60,19 @@ struct uart_pxa_port {
>  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
>  {
>  	offset <<= 2;
> -	return readl(up->port.membase + offset);
> +	if (!up->port.big_endian)
> +		return readl(up->port.membase + offset);
> +	else
> +		return ioread32be(up->port.membase + offset);

This needn't fly IMO, unless you map the space using iomap (not ioremap).

-- 
js
suse labs
