Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 22:14:36 +0100 (CET)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33869 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010087AbcAUVOeBrgiX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 22:14:34 +0100
Received: by mail-lf0-f47.google.com with SMTP id 17so35047831lfz.1
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 13:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BPHav1xHdJ3RouTdWgIPLyyBU5xhaXVRaAdoMcS0taM=;
        b=y0xLN8fQ+U5CYReT//rE/qVhk5G0CokwKACWRgEWoL2SZavYTZ6uL3CEU7VIHUsoHT
         p6YqvCh7Y1wsU0QEa44QvJymPWGEEtVhGqZYR0CROt1gqjooO07ngo2jJRWNext6X/oD
         8T72cmmKiQ/7bwRMfYQmjfNpcmnxifaFFlBBNKiMIPqBrYfiPWBkBzM9HHLSeCXt7Qx0
         nr1WGRsJZRGAII4TbpZk/uVlnmZtPTZjOpJkPvq4+Z38gKybFryAZYvB0Jyj/W09NjEC
         LzuDA6Q/V0o0zV2mvmVTTzf79PakOb3m2KSjIaU5xBsEI6D2nRMzDSaCjCJVdHWa3S5D
         gUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=BPHav1xHdJ3RouTdWgIPLyyBU5xhaXVRaAdoMcS0taM=;
        b=lzbPgjQShdad7sZvtZ7/8a5aMQTGcsfB0RoaAlhsmQRoRLO+S4ZMFuIrYJbPExc950
         25sRh841X2hlULM80n+wEYoTRyZT20G26DGgfJre4GVUHdVP+dcJ0k6O8EoE5nYpvMP/
         vgYwy+Xzmt9+DR1cx4/J/wnEL42InTtoNO3wl2kgz3nT0/tuBIME7OSCJYrZhQhn5tQq
         vf+dErq7rhGxG9Ju8Hwjp1NcpOlMcDxqrmGMuIMBlDvvLEM2+HvwEvVtPOnk8P7kdv1g
         6KmseWUVI3Ic9l6WypIwL4oNY7MhEzwaku9CE0wodCdXdYfDWX1fXlf3cXjTh0Az9kx/
         j2aA==
X-Gm-Message-State: ALoCoQmO6M0DMIGgb7UMzLh35ejkQWpShMHe2QkrmMjaXGNG4MBN/N6YVMziCPVbinQbvFUiIS266LskY0p4CUBU5YwD1EXs1g==
X-Received: by 10.25.19.80 with SMTP id j77mr16629979lfi.84.1453410868345;
        Thu, 21 Jan 2016 13:14:28 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id h72sm451678lfe.33.2016.01.21.13.14.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jan 2016 13:14:27 -0800 (PST)
Date:   Fri, 22 Jan 2016 00:39:38 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS: ath79: TP-LINK WR1043ND: uart clk issue
Message-Id: <20160122003938.2e689f07cbe360be15381277@gmail.com>
In-Reply-To: <20160121123647.5b08e7360103768755488433@gmail.com>
References: <20160121123647.5b08e7360103768755488433@gmail.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Thu, 21 Jan 2016 12:36:47 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:



A thousand apologies!

It looks like there is no uart clk issue at all.

I have to use "console=ttyS0,115200" instead of just "console=ttyS0" in kernel cmdline
to make console works.



> Hi!
> 
> I have tried to run linux on TP-LINK WR1043ND v1.8.
> 
> I use branch master from git://git.linux-mips.org/pub/scm/ralf/linux
> 
> I see a problem with UART speed setup. There is no UART output after
> serial port initialization. Here is the last correct linux output:
> 
>   Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>   console [ttyS0] disabled
>   18020000.uart: ttyS0 at MMIO 0x18020000 (irq = 11, base_baud = 12500000) is a 8250
> 
> 
> I can disable UART speed setup in 8250 driver:
> 
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2208,6 +2208,8 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
>  {
>         struct uart_8250_port *up = up_to_u8250p(port);
>  
> +       return;
> +
>         /* Workaround to enable 115200 baud on OMAP1510 internal ports */
>         if (is_omap1510_8250(up)) {
>                 if (baud == 115200) {
> 
> With this very very dirty hack linux works fine.
> 
> I suppose there is a problem in arch/mips/ath79/clock.c
> 
> I have tryed to cherry-pick your 'MIPS: ath79: Fix the ar913x reference clock rate'
> and 'MIPS: ath79: Fix the ar724x clock calculation' commits from
> your github ath79 branch at https://github.com/AlbanBedel/linux/tree/ath79
> but these patches don't help me.
> 
> Could you please try to reproduce the problem?
> 
> -- 
> Best regards,
>   Antony Pavlov


-- 
-- 
Best regards,
  Antony Pavlov
