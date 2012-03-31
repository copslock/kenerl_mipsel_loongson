Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2012 14:12:33 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:43558 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903618Ab2CaMMT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Mar 2012 14:12:19 +0200
Received: by iaky10 with SMTP id y10so2606534iak.36
        for <multiple recipients>; Sat, 31 Mar 2012 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IZrfSO8mJIdwVA8KPxbvyR/BEdtotRcOVPIWCazGncs=;
        b=jMihcp11OJ6gR/z46EA7JQxefgujahXslBjnsviA0OKxM5sAkr3B0mUP0Xn0pFNanL
         IjKVqF6yS2SZRF3zgr1H1JWdd42uxJ3fxUDhEVkfMSEjI7yarsVErzw0c8pPh7sPJ/SF
         UQk/OzOy91kp7M+TSGtFSnD6mqCMN1R7omJ4I1Jej837vW3vbF090VYQe+zHL1VXxSLj
         owzMcVW2+CTwG91aREaXr7cLS+xB7mwJ1v7RQ5ELvsxr6IaSGTlNSnT9z7BZR9W4NA8C
         P6Iu8oRbUBviyt4kmzJXS7h945unRVGS/GBbrF+sOEEu9na7re2KBmfGruooNSn64P/7
         wQbg==
Received: by 10.50.207.65 with SMTP id lu1mr1168775igc.32.1333195932839; Sat,
 31 Mar 2012 05:12:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.103.2 with HTTP; Sat, 31 Mar 2012 05:11:52 -0700 (PDT)
In-Reply-To: <20120331082346.26cc95cb@endymion.delvare>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
 <20110903103036.161616a5@endymion.delvare> <20111031105354.4b888e44@endymion.delvare>
 <20120110153834.531664db@endymion.delvare> <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
 <20120331082346.26cc95cb@endymion.delvare>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 31 Mar 2012 08:11:52 -0400
Message-ID: <CAEdQ38Ez+8DudAaJY7HZu9jbisk_KMbBO5h=s+P4pjJ0Va-zWw@mail.gmail.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of interrupts
To:     Jean Delvare <khali@linux-fr.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Mar 31, 2012 at 2:23 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 12 Jan 2012 16:19:49 -0500, Matt Turner wrote:
>> On Tue, Jan 10, 2012 at 9:38 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> > On Mon, 31 Oct 2011 10:53:54 +0100, Jean Delvare wrote:
>> >> On Sat, 3 Sep 2011 10:30:36 +0200, Jean Delvare wrote:
>> >> > Please address my concerns where you agree and send an updated patch.
>> >>
>> >> Matt, care to send an updated patch addressing my concerns? Otherwise
>> >> it will be lost again.
>> >
>> > It's been 3 more months. Matt (or anyone else who cares and has access
>> > to the hardware), please send an updated patch or I'll have to drop it.
>>
>> I'll fix it up and resend the next time I'm working on the related mips stuff.
>>
>> It's hard to prioritize volunteer work for hardware you and two other
>> people have. :)
>
> Matt, Maciej, does any of you have an updated patch ready by now? If I
> don't receive anything by the end of April I'll just drop it.

I'll do my best to get you an updated patch.

Thanks for keeping after me.

Matt
