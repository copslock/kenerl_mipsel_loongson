Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 19:28:41 +0200 (CEST)
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33220 "EHLO
        mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026702AbcDOR2iXuzjI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 19:28:38 +0200
Received: by mail-ig0-f193.google.com with SMTP id g8so3753913igr.0;
        Fri, 15 Apr 2016 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=YRukMw4wO3TIPPnBIAWHIJfQafPX3BSr92XjiQh0ZHM=;
        b=JfyEtH5Y82O6JfjxtsO8ZandiTupURFbyZgENLQ9A+VqUnYFDuQsXF66ezGnHq/8RX
         E4f7srp6rnLiwfsBLDQoO3s5bp4oiE+JnZr3muKnMRkDYgb22x7xdINdItWfdDkepJjC
         512k9pE+hb5Gf2TtkstpkMAon+KkVWbLavaH6n+srmLh1wGfOVys0Ns8VlqsI3YJze1t
         0DZBLM43MSNvr49+Ni8VUMMCvL3AqdikKklr/cGkn91qWJ7a/P6MfU6cHuXiPRW4QTBm
         lt37bd2Ol095KTEH3HEo6bXIzdyS/b8Lx3P1XXp231AdGUioxmU1nV8i767gTjJGdcGn
         UZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YRukMw4wO3TIPPnBIAWHIJfQafPX3BSr92XjiQh0ZHM=;
        b=M0p38y33F8ylTgz3agzzSxYMTdgQsPbjUmi6TRQ6RNHAjno1gYe6PTuLSthjb7DHhr
         TZai5hLeruOANwwLNotesIzK9uCr4YD6c6AhmWQ8CPBBnOwebRdYn/iSmmkmoMMlUxHn
         SAIh/PIIj1Mov4IpRFpOElLxHTTClFM1Q8I51wfb1//asx8Tbv8VYPEbIu7zdXo0tdVw
         VsrVyyTO4YLUlGk3c9dZVwHq8P6+/iMz8XpSA99t+dn1TCN2awDLEsJdlPPj3hWWVrCM
         oPSzwqTKGk3umibPpy1/emz6Ryl+SyLHd8BphmRDIezrufy0Rpyf4bGu0FKbTmNCeUw4
         E+kw==
X-Gm-Message-State: AOPr4FUrqDMzqLBNN+iH1iug7o3M1DWyE/gQcE6zGWcyZh43oqdQ7c+zDp9/qVaWQjxhkZ67VIuPGWAm7gb8Hw==
MIME-Version: 1.0
X-Received: by 10.50.108.13 with SMTP id hg13mr6245168igb.29.1460741312574;
 Fri, 15 Apr 2016 10:28:32 -0700 (PDT)
Received: by 10.107.32.21 with HTTP; Fri, 15 Apr 2016 10:28:32 -0700 (PDT)
In-Reply-To: <1452734299-460-11-git-send-email-joshua.henderson@microchip.com>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
        <1452734299-460-11-git-send-email-joshua.henderson@microchip.com>
Date:   Fri, 15 Apr 2016 18:28:32 +0100
X-Google-Sender-Auth: u3goi8x6lA-u_SgSHdHkgpujNJs
Message-ID: <CAPKp9uYOnhJhNq8YDVRMpLSmGa7yWsktYnhVsMdWLtH1Jru3bw@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] serial: pic32_uart: Add PIC32 UART driver
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-api@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <sudeepholla.maillist@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudeep.holla@arm.com
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

Hi Greg,

I just noticed this now. I am having similar issue with MPS2 UART driver
posted @[1], hence I am asking here to get some clarification myself.
Sorry for replying on very old thread.

On Thu, Jan 14, 2016 at 1:15 AM, Joshua Henderson
<joshua.henderson@microchip.com> wrote:
> From: Andrei Pistirica <andrei.pistirica@microchip.com>
>
> This adds UART and a serial console driver for Microchip PIC32 class
> devices.
>
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>

[...]

> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 93ba148..9df0a98 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -261,4 +261,7 @@
>  /* STM32 USART */
>  #define PORT_STM32     113
>
> +/* Microchip PIC32 UART */
> +#define PORT_PIC32     114

This was posted before v4.6-rc1 similar to MPS2 UART and has taken
port# 114 for it. However MVEBU UART obtained 114 with v4.6-rc1
And MPS2 UART was assigned 115 when it got revised/reposted.

I also see this patch in linux-next with 114 itself as its port number.
So the allocation of port number needs to be resolved before it gets
merged or it's OK to wait for v4.7-rc1 ?

If it's former, can PORT_PIC32 take 116 as the latest post of MPS2 assigned
it 115 and I have pulled the same to take it via arm-soc.

I am fine with any solution, just want to be notified if I need to
take any action.

Regards,
Sudeep

[1] http://www.spinics.net/lists/devicetree/msg120727.html
