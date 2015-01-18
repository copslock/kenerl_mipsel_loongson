Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 11:36:18 +0100 (CET)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:45071 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010654AbbARKgR0Ye-0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 11:36:17 +0100
Received: by mail-wi0-f175.google.com with SMTP id fb4so3514701wid.2;
        Sun, 18 Jan 2015 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TlGWcz029PJosLHMLHsayNBuFru2xhHjZyWNV6OzicM=;
        b=Xudp8LJj7YwFagX4KuEr1CxJA07J3h2xIQ8DQAY/iGhPbV6I6c6Zhudda48j4eWeBW
         3yQyBeSSMIuO95oYw3MnGLO7REJ3U0O5JMbfy4Y3PELKueLTDb3ZbcYLuGvAaVmoGXAj
         heOp+JHTahs6NuLBmLMmjJuI4tK5jNHqC09cn/xj4dY69yDSSi2ux6DDrhWiUT9uoM4r
         1gx1U5sTx9L21PJUprzA6JxULSHmdh2gReqZqDehml0j+StXgJnEHKvkfcGehTI556Cg
         7MZ1d0MtDcahI+PVf48Rskq0C+vw7xwLhQd+k7pm8XKYBZwG1mI9ARRuZ92aNWwH7xm8
         oEsg==
X-Received: by 10.180.20.177 with SMTP id o17mr23974051wie.64.1421577372242;
 Sun, 18 Jan 2015 02:36:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.105.144 with HTTP; Sun, 18 Jan 2015 02:35:31 -0800 (PST)
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FAA1B6@LEMAIL01.le.imgtec.org>
References: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com>
 <CAOLZvyGBOqCARmLx+rQ1CEgFw2TZBYYauGOiD9tF31MFsB-peQ@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FA97DF@LEMAIL01.le.imgtec.org>
 <CAOLZvyGUGr3ubbzNjoFLCEDk29Fbn4qjoT6xmT=F1OZ4L-YhMA@mail.gmail.com>
 <CAOLZvyE7nk4r+gcYTkdbfeDWh6c75RRhijuh-XY=AK98LF81LA@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FA9A04@LEMAIL01.le.imgtec.org>
 <20150117163832.GA12420@fuloong-minipc.musicnaut.iki.fi> <6D39441BF12EF246A7ABCE6654B0235320FAA1B6@LEMAIL01.le.imgtec.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Sun, 18 Jan 2015 11:35:31 +0100
Message-ID: <CAOLZvyEvXuTYhCgO6=XZCUv5_apqVaz44WswPesSSS3fvoALaw@mail.gmail.com>
Subject: Re: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45247
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

On Sat, Jan 17, 2015 at 8:00 PM, Matthew Fortune
<Matthew.Fortune@imgtec.com> wrote:
> Aaro Koskinen <aaro.koskinen@iki.fi> writes:
>> On Fri, Jan 16, 2015 at 08:36:12PM +0000, Matthew Fortune wrote:
>> > You are right that it is the .MIPS.abiflags patch that is causing your
>> > trouble. For a long time I had to put a restriction in the ABI plan
>> > that soft-float binaries without an ABIFLAGS pheader could not be
>> > linked against soft-float binaries with an ABIFLAGS pheader. We have
>> > since found a way to relax that restriction without reducing the
>> > effectiveness of the new compatibility checks. I would need to check
>> > the code in the kernel but I suspect that is the issue. Markos has
>> > done a significant update to this piece of code which he posted
>> > earlier today. That updated version should allow the combination of
>> > soft-float without ABIFLAGS and soft-float with ABIFLAGS.
>>
>> Are you referring to the series with 70 patches? I think a fix that
>> passes stable kernel rules is needed.
>
> Yes it was just one patch though for this issue:
> [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI and FPU
> mode checks
>
> I wasn't trying to suggest how to fix the existing code just explaining
> how it came to be and what has been done about it for next release.
> (I'm not a kernel developer I'm just interested as I did most of the
> design work for the new ABI extensions.)
>
> I guess there are three options:
> a) revert the patch - That would remove the new ABI safety measures from
>    3.19 which is a shame given it has MSA support in it (I think anyway).
>    equally given that the new prctl FPU mode options did not make 3.19
>    then I suppose it doesn't lose too much either as the two features
>    go hand in hand to some extent.

I favor this one.  I don't know how many systems with MSA are in the wild,
and if there are any, I'm sure they're using some mti/imgtec-supplied kernel
anyway.  Another thing I noticed last time is that companies shipping MIPS
products rarely upgrade their toolchains, so I'm sure the ABI safety measures
can wait for another release, but then function with all configurations
in the wild.


Manuel
