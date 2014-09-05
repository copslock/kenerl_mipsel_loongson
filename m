Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 23:02:46 +0200 (CEST)
Received: from mail-vc0-f170.google.com ([209.85.220.170]:35741 "EHLO
        mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008229AbaIEVCoVkVE1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 23:02:44 +0200
Received: by mail-vc0-f170.google.com with SMTP id la4so13142608vcb.29
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QQZ2wtO91yHY+tMQIZpjVUDTQLysvJRylKwjhUE+esg=;
        b=ZPB7LO9vsD6/biJxNkeG0cjeJBV7KH+REzS90rUsa5uW4sNLAepg8t2z09Ad7k9Kjs
         POEwUL1F8DiHEKmwf+8TZelUf8QWSIMXvomlEwrGmtg9FyVD+jxTK4GhBKDCJvfQVVvE
         EXmFClTCNl2PKZPoGyDxKcMVme42hMwjrR8Y4lxnSWIwetHVXbJZAnYEcu3x3EjiKfzM
         VLKNumSeWvJNxMC3TlLEovzMcb1GUiYGIU+VVd6zJrm4zwrYEwZwJUqIs5GsUiqZlocF
         9eu+llx6K1+tpHWVdUgvmo3Gx+Xm9v+yGWve3euGn80iSkgFKp4No+F50bkSfnATRcEU
         138Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QQZ2wtO91yHY+tMQIZpjVUDTQLysvJRylKwjhUE+esg=;
        b=bf9bzBbNBnr/BvO1AxJz5HVHF0uHzIuH8hUTwFpddF9WtClmgpw3NASsXNekLUPO+2
         glMFROSNw6c2g8mrdvd8gHT8Cc50RVTI0teH7LjKz85HJbgQZD8Al6KADEqhDYCvj8uU
         7SziFkcTaNxNdneaBdKFs4LdT6OTV/sorKDpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QQZ2wtO91yHY+tMQIZpjVUDTQLysvJRylKwjhUE+esg=;
        b=iDSi60C7ERUOXDxHTKxPEpmphDpdqJZ2vIJPuGnbJ6+ySVG76j0YOdlcH53J3nXio7
         5PNqPKR6MGFOC6aRUng0EWl2YceXLbs/euYu/ifFCc5c2ThHNzvEZQdBs5duqtDDE2OP
         rdK+CqoXOEQqCZD1Zc0SZBkKQ/fr0Z7BZrGDlXOTOce1va+mf6EtHFrUcOE0OyY67//e
         0p3DFRx8G+g1aVnP2qPsLAbm2RS0EdSmKr/ZxsZm3CyiUOljbifGVVWyXwzm3Zs8+uMK
         IJbZRB5a5bIYdtaaAdHvHJjMmTfPC6AZhREWCqLJ63U13Tq9hRTVFHr45zkuh4Sm7Q8v
         0oDQ==
X-Gm-Message-State: ALoCoQkU/AZkF1GpeUvFCBDR+z8BUVxpe3Z6rugaRB3bje6h+zgnm9qtmKN3PQmAMSxsaSWSWPuo
MIME-Version: 1.0
X-Received: by 10.52.69.195 with SMTP id g3mr2658668vdu.45.1409950958184; Fri,
 05 Sep 2014 14:02:38 -0700 (PDT)
Received: by 10.52.51.194 with HTTP; Fri, 5 Sep 2014 14:02:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1409052051240.5472@nanos>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
        <1409938218-9026-2-git-send-email-abrestic@chromium.org>
        <alpine.DEB.2.10.1409052051240.5472@nanos>
Date:   Fri, 5 Sep 2014 14:02:38 -0700
X-Google-Sender-Auth: 67k7QKQ6EBz33I-QO04y6ucKRcc
Message-ID: <CAL1qeaFDBU6bB-OmSW8DqMWGtpNDL9H-WB6F0ZBg7hEz6c1vBQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] MIPS: Provide a generic plat_irq_dispatch
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Fri, Sep 5, 2014 at 11:51 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 5 Sep 2014, Andrew Bresticker wrote:
>> For platforms which boot with device-tree and use the MIPS CPU interrupt
>> controller binding, a generic plat_irq_dispatch() can be used since all
>> CPU interrupts should be mapped through the CPU IRQ domain.  Implement a
>> plat_irq_dispatch() which simply handles the highest pending interrupt.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Tested-by: Jonas Gorski <jogo@openwrt.org>
>> ---
>> No changes from v1.
>> ---
>>  arch/mips/kernel/irq_cpu.c | 28 +++++++++++++++++++++++-----
>>  1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
>> index e498f2b..9cf8459 100644
>> --- a/arch/mips/kernel/irq_cpu.c
>> +++ b/arch/mips/kernel/irq_cpu.c
>> @@ -116,6 +116,24 @@ void __init mips_cpu_irq_init(void)
>>  }
>>
>>  #ifdef CONFIG_IRQ_DOMAIN
>> +static struct irq_domain *mips_intc_domain;
>> +
>> +asmlinkage void __weak plat_irq_dispatch(void)
>> +{
>> +     unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
>> +     unsigned int hw;
>> +     int irq;
>> +
>> +     if (!pending) {
>> +             spurious_interrupt();
>> +             return;
>> +     }
>> +
>> +     hw = fls(pending) - CAUSEB_IP - 1;
>> +     irq = irq_linear_revmap(mips_intc_domain, hw);
>> +     do_IRQ(irq);
>
> Why are you not handling all pending interrupts in a loop?

Nearly all of the existing plat_irq_dispatch()es handle only a single
pending interrupt.  I suppose it doesn't hurt to handle all pending
interrupts though.
