Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 22:46:43 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:59314 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491801Ab0FAUND convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Jun 2010 22:13:03 +0200
Received: by iwn34 with SMTP id 34so282010iwn.36
        for <linux-mips@linux-mips.org>; Tue, 01 Jun 2010 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eYV3NXYD+5orpMQLFMghf7iW9I0IOQ4vgnq+vt09KV0=;
        b=asXoPi1hrUNTnt0Jci3GUsmaNhRilJfkoZ4vqHRRhQnCYO2Qt7qYYPgqPG3eSetgNj
         FgiddksbQr9FySoNY7kBI6Y8s3pvLLHHiX3yJ8cigSGxTA6X3o3DqQYQLfT3sy7FT5ws
         Y9UK4pJTpdjT3d7CyPLFaz0wPTmOriggM4ekk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=spanyDJpu0f77ooI/YdqrhOQNOdwgHP5FI+2n2lR/3Ua7fjTmyOyjtdAFvn5P/hswN
         9dBo44FdQp0KcifrUMyoLAXYYLAtrCasVvedpkvv+p5S7DXDVUiOZCkAwVn4lfSu8sIu
         ToXE714MVSnhOvfvMVEThENeqvZuI2/NA0XI0=
MIME-Version: 1.0
Received: by 10.231.150.2 with SMTP id w2mr8442083ibv.37.1275423179775; Tue, 
        01 Jun 2010 13:12:59 -0700 (PDT)
Received: by 10.231.183.74 with HTTP; Tue, 1 Jun 2010 13:12:59 -0700 (PDT)
In-Reply-To: <20100601200200.GA5438@merkur.ravnborg.org>
References: <1275405795-9009-1-git-send-email-manuel.lauss@googlemail.com>
        <20100601163528.GA5216@merkur.ravnborg.org>
        <AANLkTikIiKmqjhuZKnguhyNeuCXnPeBLHSSeolCTf3d0@mail.gmail.com>
        <20100601200200.GA5438@merkur.ravnborg.org>
Date:   Tue, 1 Jun 2010 22:12:59 +0200
Message-ID: <AANLkTimJXcCxazHZXLOA2tfVuc326LyQty9uAfW7V11i@mail.gmail.com>
Subject: Re: [PATCH -queue v2] MIPS: Move Alchemy Makefile parts to their own 
        Platform file.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 26977
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 724

On Tue, Jun 1, 2010 at 10:02 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Jun 01, 2010 at 06:47:59PM +0200, Manuel Lauss wrote:
>> On Tue, Jun 1, 2010 at 6:35 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> > On Tue, Jun 01, 2010 at 05:23:15PM +0200, Manuel Lauss wrote:
>> >> Cc: Sam Ravnborg <sam@ravnborg.org>
>> >> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> >> ---
>> >> On top of latest mips-queue.  The changes to the mtx1/xx1500 Makefiles were
>> >> necessary to work around vmlinux link failures.
>> >
>> > Was this something the platform patches introduced or
>> > is it needed to fix the build?
>>
>> Maybe.  Link failures with the "lib-y" parts do crop up occasionally.
>> Usually, the lib-y parts are built as the last files (along with other
>> arch/mips/lib code); with your changes they're built with the other
>> files in a directory:
>>  CC      arch/mips/alchemy/mtx-1/platform.o
>>   LD      arch/mips/alchemy/mtx-1/built-in.o
>>   CC      arch/mips/alchemy/mtx-1/board_setup.o
>>   CC      arch/mips/alchemy/mtx-1/init.o
>>   AR      arch/mips/alchemy/mtx-1/lib.a
>>
>> That lib.a is apparently not picked up by the linker:
>>   LD      .tmp_vmlinux1
>
> ...
>
>> > ...
>> >> +#
>> >> +# 4G-Systems eval board
>> >> +#
>> >> +platform-$(CONFIG_MIPS_MTX1) += alchemy/mtx-1/
>> >> +load-$(CONFIG_MIPS_MTX1)     += 0xffffffff80100000
>> >
>> >> diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
>> >> index 4a53815..4d1367e 100644
>> >> --- a/arch/mips/alchemy/mtx-1/Makefile
>> >> +++ b/arch/mips/alchemy/mtx-1/Makefile
>> >> @@ -6,7 +6,6 @@
>> >>  # Makefile for 4G Systems MTX-1 board.
>> >>  #
>> >>
>> >> -lib-y := init.o board_setup.o
>> >> -obj-y := platform.o
>> >> +obj-y := init.o board_setup.o platform.o
>> >>
>> >>  EXTRA_CFLAGS += -Werror
>> >
>
> So the original ocde looked like this:
>
> arch/mips/Makefile:
> libs-$(CONFIG_MIPS_MTX1)        += arch/mips/alchemy/mtx-1/
>
> The above is used to tell that it shall look for a lib.a
> in the directory: arch/mips/alchemy/mtx-1/
> It also tell kbuild to build any built-in or modules in the same dir.
>
> In your conversion this became:
> platform-$(CONFIG_MIPS_MTX1) += alchemy/mtx-1/
>
> The above tells kbuild to build objects as built-in or modules
> in the directory. It does not say anything about libs.
>
> So we loose the information about the lib.a in the directory.
> I know that kbuild will build it - but it happens
> to forget all about it when done.
>
> The right fixs seems to keep the libs-$(...) assignments in
> the Platform files and let kbuild pick them up due to
> the include in arch/mips/Makefile.

That doesn't work, I get errors for instance when doing "make clean":

linux-2.6.git/scripts/Makefile.clean:17:
linux-2.6.git/alchemy/mtx-1/Makefile: No such file or directory


> Getting rid of the libs like you did is also an option.

I'll send new patches doing exactly that and pile this one on
top of it.


> Does the lib files contain stuff that is only used in some
> confgurations or does the content end up being linked
> in always anyway?

Nope, just usual board initialization and platform data.


> Also are there any linker order constrains to tke care of?

None that I'm aware of, at least for the affected boards.


        Manuel
