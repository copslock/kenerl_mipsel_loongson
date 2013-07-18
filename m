Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 21:35:18 +0200 (CEST)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46033 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819547Ab3GRTfOh0gT0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 21:35:14 +0200
Received: by mail-wi0-f170.google.com with SMTP id ey16so1248166wid.5
        for <linux-mips@linux-mips.org>; Thu, 18 Jul 2013 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4apXvw27zL8Csn+hhjJkHiN88KmR0S1uVL40W3saB2A=;
        b=CBkSxKxHZzwF112Dwp0NpKPVdaOMosigVJTamEWXQkcwj812mF4QKeXLQ4nyc363Fv
         G941S/xaDn962J+QPm7xMW+A15J8MzD0/oQPWtkNR5ec4xhlQ+DIIzsDDVkaFydxC/LP
         dwFvf23dGKXER0x0CPjEIG2e+bLSMTunyIMpHgSeEZ3kGfxk4yrvsPwL0gNxP431c35P
         jliTvSmOSVpughaaPFFFwRK+1q7DdfaZP1m5Kwtp9mfIaffWciZh5QB+NCNwTEB0ckkm
         URa5qV63RLG0wcqfCco9EtX6xG4nwckAVJuqMzrsngHtPSLjaMlL+oREDTuJKJ1GZcFM
         SwOQ==
X-Received: by 10.194.179.233 with SMTP id dj9mr9652758wjc.46.1374176109128;
 Thu, 18 Jul 2013 12:35:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.245.2 with HTTP; Thu, 18 Jul 2013 12:34:28 -0700 (PDT)
In-Reply-To: <20130718180339.GH14385@blackmetal.musicnaut.iki.fi>
References: <20130718122556.GA19040@tty.gr> <51E817C6.3030706@gmail.com> <20130718180339.GH14385@blackmetal.musicnaut.iki.fi>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 18 Jul 2013 21:34:28 +0200
Message-ID: <CAOLZvyE-KppwVkb4J8V5k3FHuHKUiQycQiXft5AijPxtSdcL-A@mail.gmail.com>
Subject: Re: octeon: oops/panic with CONFIG_SERIO_I8042=y
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Faidon Liambotis <paravoid@debian.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Thu, Jul 18, 2013 at 8:03 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Thu, Jul 18, 2013 at 09:28:54AM -0700, David Daney wrote:
>> On 07/18/2013 05:25 AM, Faidon Liambotis wrote:
>> >My goal is to run a standard Debian kernel and its octeon variant[1] on
>> >the Ubiquity EdgeRouter Lite. The ERLite needs a couple of patches
>> >to boot and work (octeon-ethernet patch, octeon-usb driver) but these
>> >are already merged 3.11 and I'll file Debian bugs to enable those
>> >settings appropriately.
>> >
>> >1: e.g. http://packages.debian.org/sid/linux-image-3.10-1-octeon
>> >
>> >However, when trying to boot a standard Debian kernel in the ERLite I
>> >get a 7s delay followed by an oops for a Data bus error on i8042_flush()
>> >and ending up with a panic. It looks like the kernel is built with
>> >CONFIG_SERIO_I8042=y.  The Octeon machine Debian owns prints "i8042: No
>> >controller found" but works nevertheless.  This isn't the case with the
>> >ERLite; I tried 3.2 & 3.10 and got the same oops which went away as soon
>> >as I disabled CONFIG_SERIO_I8042.
>> >
>> >Are there even any octeon machines with i8042 anyway? Should I request
>> >for the setting to be disabled irrespective of this bug?
>>
>> Yes.  There is a rare board called NAC38 that was produced by ASUS
>> in a 1U chassis.  I don't think it is important to support this, so
>> the best thing seems to be not to enable SERIO_I8042
>
> I think the real bug here is that IO space does not get properly
> initialized on Octeon when there is no PCI? So any drivers trying to
> probe IO space will produce some interesting results.

This is not specific to Octeon, I've seen it on Alchemy as well.  A lot of
drivers, coming from x86, simply assume that x86-Port-IO space is
always available without having to map it first.  I'd say it's a bug in
the various drivers.

Manuel
