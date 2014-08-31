Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2014 20:54:12 +0200 (CEST)
Received: from mail-vc0-f171.google.com ([209.85.220.171]:33880 "EHLO
        mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007718AbaHaSyKhAgav (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Aug 2014 20:54:10 +0200
Received: by mail-vc0-f171.google.com with SMTP id id10so4585439vcb.2
        for <linux-mips@linux-mips.org>; Sun, 31 Aug 2014 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=abDdsFAh9vf0KXAF+C1n5rbH3YHC/VxTKi3XfhIPyX4=;
        b=pih++V6bwmW0YRgQQ3oAKFzHvN0f63TE2fs7itdJnmiDKlqmkqa4LoYT3kgMYm2gEx
         MeMiOAoj3HWFcBzY6+mkdourOMMtYSgWx0WIsyFEzfEvMccC++NE/uFUW38fFdv9CpeQ
         JVjYyvxD1TAh7muwDATwTW4lFqXA1vwpgNBOpuEdld05jIUb4hRgEV/NaUjA4uo/ENCS
         ey6DRxu5WYjTObmaJtMYKt7kqtSmwmvYC5E/pRzQxe56kRNM+dRWodRJ2p7soyWnSQj5
         YfXWZ0TSWuCkrh1VTiIHa4CUdcFYD4f4lv0lOH6Zhc07EmFmxbRzGKGir9plI8wI+qVV
         zwlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=abDdsFAh9vf0KXAF+C1n5rbH3YHC/VxTKi3XfhIPyX4=;
        b=jXStN3RHVyR69lYuCfB2I/rXOzX0j1bPZ0AMhhzXcl1WeJLcCuj0MQb2t1jYirk9e+
         CnrplXhT3Cq68za+xgfQZLiImue3lGrWxd1xGzOiaeT+UUwqdrsqmvSw3EEZZhsDTO8O
         93zKZk/5WctpQ5OzI4Jb92MRCmm0BY/RpEAuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=abDdsFAh9vf0KXAF+C1n5rbH3YHC/VxTKi3XfhIPyX4=;
        b=OGvSw4NzDI9k1rwxqsM966sBtNmXt2I70IhhxIa/xujcSTUmayDgJpiN5QysJls+GD
         ZYNlVJYdD1Q7o9ItQbFMlPg6E+iNknAfFw1ph1TM1Tm5eYsJ1wCpjJT1RHUs1IrcJ/2x
         Ljxugl8CmW8I3XED4/JyVU2mDasmRkFaXgaAnIWwKduNPhdEqn30lur6SNVv2IMWLyDY
         0T3q6FmrpZdyjkWcsSzPn54ftSBje8vpQTy7B3l5r6EFQQVpdj9/6YIbY33aHAM2eZBx
         JPi4w3IbKzEAUrXgZiQD8+5lWOra0GwXNJCJZRT7a/olx6M597wg/KilueDvJo3c5zCN
         Fzqg==
X-Gm-Message-State: ALoCoQmaVzMh2I/45AnjFzV9QGDaefyl/0Fvt6vRAIBLJ0QjfZueJfGBrXnN46LBLhwLqklBEEs0
MIME-Version: 1.0
X-Received: by 10.221.29.5 with SMTP id rw5mr1730001vcb.49.1409511244694; Sun,
 31 Aug 2014 11:54:04 -0700 (PDT)
Received: by 10.53.5.133 with HTTP; Sun, 31 Aug 2014 11:54:04 -0700 (PDT)
In-Reply-To: <6179185.bNbDBEC6tl@wuerfel>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
        <1409350479-19108-5-git-send-email-abrestic@chromium.org>
        <6179185.bNbDBEC6tl@wuerfel>
Date:   Sun, 31 Aug 2014 11:54:04 -0700
X-Google-Sender-Auth: VHWRbFTWf--u6jwK2nwvGsRy3uk
Message-ID: <CAL1qeaEEo6-LZz3Kex7oPUfz=Z56nvKoDnqu051rGhhi3ZFTDQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] MIPS: GIC: Move MIPS_GIC_IRQ_BASE into platform irq.h
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42352
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

On Sat, Aug 30, 2014 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 29 August 2014 15:14:31 Andrew Bresticker wrote:
>> Define a generic MIPS_GIC_IRQ_BASE which is suitable for Malta and
>> the upcoming Danube board in <mach-generic/irq.h>.  Since Sead-3 is
>> different and uses a MIPS_GIC_IRQ_BASE equal to the CPU IRQ base (0),
>> define its MIPS_GIC_IRQ_BASE in <mach-sead3/irq.h>.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>
>
> Why do you actually have to hardwire an IRQ base? Can't you move
> to the linear irqdomain code for DT based MIPS systems yet?

Neither Malta nor SEAD-3 use device-tree for interrupts yet, so they
still require a hard-coded IRQ base.  For boards using device-tree, I
stuck with a legacy IRQ domain as it allows most of the existing GIC
irqchip code to be reused.
