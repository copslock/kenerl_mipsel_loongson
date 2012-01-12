Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2012 22:20:21 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:54268 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901167Ab2ALVUR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jan 2012 22:20:17 +0100
Received: by dajx4 with SMTP id x4so2033140daj.36
        for <multiple recipients>; Thu, 12 Jan 2012 13:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GXQs5YpTFA3aVL2tTdzWSX5RlE2K2d1GMcP6xb/EqGw=;
        b=Q7wThLpFDGNp3ZeOB/cCT1tYYN9UxK7rXSNyW3+OWxya4uAs9d4Aa6M3tavoLnMPZG
         7qlr5vQXN7JcdB8ydJfkgUzKcKJMLKn/G4RAYGaFre7YElAIX/XnBVvdLSzqGoYAOGIJ
         3Sis/Jb+ZhI4jEMkIgsNML/zMdPLsmOqVklQc=
Received: by 10.68.115.195 with SMTP id jq3mr11568276pbb.34.1326403210267;
 Thu, 12 Jan 2012 13:20:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.48.8 with HTTP; Thu, 12 Jan 2012 13:19:49 -0800 (PST)
In-Reply-To: <20120110153834.531664db@endymion.delvare>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
 <20110903103036.161616a5@endymion.delvare> <20111031105354.4b888e44@endymion.delvare>
 <20120110153834.531664db@endymion.delvare>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 12 Jan 2012 16:19:49 -0500
Message-ID: <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of interrupts
To:     Jean Delvare <khali@linux-fr.org>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jan 10, 2012 at 9:38 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 31 Oct 2011 10:53:54 +0100, Jean Delvare wrote:
>> On Sat, 3 Sep 2011 10:30:36 +0200, Jean Delvare wrote:
>> > Please address my concerns where you agree and send an updated patch.
>>
>> Matt, care to send an updated patch addressing my concerns? Otherwise
>> it will be lost again.
>
> It's been 3 more months. Matt (or anyone else who cares and has access
> to the hardware), please send an updated patch or I'll have to drop it.
>
> --
> Jean Delvare

I'll fix it up and resend the next time I'm working on the related mips stuff.

It's hard to prioritize volunteer work for hardware you and two other
people have. :)

Matt
