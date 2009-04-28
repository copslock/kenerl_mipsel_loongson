Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 08:16:34 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:43571 "EHLO
	mail-ew0-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025240AbZD1HQ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 08:16:27 +0100
Received: by ewy22 with SMTP id 22so379772ewy.0
        for <multiple recipients>; Tue, 28 Apr 2009 00:16:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=aqS0ER/4iuZ0JbF19Wrkg3QJ78ZbxNXrDCF6lvTv//U=;
        b=dizhe4juihne08lzCoVBtLsgD+ZyvEv5SGlWILJiW+hmF8GkvM1GPoWWynk7vb9GVO
         n+2obi4myve59IBar2K2QppUw9a1BTf3TpgwpYn/GSQQZUMVN3/incADWuG9+q6CQKuH
         p7ajgZxf/4XSHjGuMtuozbXgkVOAO+xBOZQQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=RxWD97L5zpfk97x0orskbxLN0s9kaOO3kQ66phsXIt+Cc1xMtDMWBauQKJqeRscID0
         5RuN5ZY1ItA0m/Uqatp2oGtUqG+iHE92kymcIU2Scbkp8xp3UV2xiIQ4IcWRth4qKIwc
         SWDK7btlWH1x6551vpsdkznXzYduUvhUu8AvQ=
MIME-Version: 1.0
Received: by 10.210.13.17 with SMTP id 17mr5855829ebm.43.1240902982115; Tue, 
	28 Apr 2009 00:16:22 -0700 (PDT)
In-Reply-To: <b2b2f2320904272321l4cf30181rcde6b1d42a5b5547@mail.gmail.com>
References: <E1LyQQX-00047N-6E@localhost>
	 <20090427130952.GA30817@linux-mips.org>
	 <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com>
	 <b2b2f2320904272321l4cf30181rcde6b1d42a5b5547@mail.gmail.com>
Date:	Tue, 28 Apr 2009 09:16:22 +0200
X-Google-Sender-Auth: 852d0091d904e38e
Message-ID: <10f740e80904280016r7a99e325l6646d787f7cc4ebc@mail.gmail.com>
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 28, 2009 at 08:21, Shane McDonald <mcdonald.shane@gmail.com> wrote:
> On Mon, Apr 27, 2009 at 7:22 AM, Geert Uytterhoeven <geert@linux-m68k.org>

>> On Mon, Apr 27, 2009 at 15:09, Ralf Baechle <ralf@linux-mips.org> wrote:
>> > On Mon, Apr 27, 2009 at 06:59:17AM -0600, Shane McDonald wrote:
>> >
>> >> There have been a number of compile problems with the msp71xx
>> >> configuration ever since it was included in the linux-mips.org
>> >> repository.  This patch resolves these problems:
>> >>  - proper files are included when using a squashfs rootfs
>> >>  - resetting the board no longer uses non-existent GPIO routines
>> >>  - create the required plat_timer_setup function
>> >>
>> >> This patch has been compile-tested against the current HEAD.
>> >>
>> >> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
>> >> ---
>> >>  arch/mips/pmc-sierra/msp71xx/msp_prom.c  |    3 ++-
>> >>  arch/mips/pmc-sierra/msp71xx/msp_setup.c |    8 ++------
>> >>  arch/mips/pmc-sierra/msp71xx/msp_time.c  |    7 ++-----
>> >>  3 files changed, 6 insertions(+), 12 deletions(-)
>> >>
>> >> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
>> >> b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
>> >> index e5bd548..1e2d984 100644
>> >> --- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
>> >> +++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
>> >> @@ -44,7 +44,8 @@
>> >>  #include <linux/cramfs_fs.h>
>> >>  #endif
>> >>  #ifdef CONFIG_SQUASHFS
>> >> -#include <linux/squashfs_fs.h>
>> >> +#include <linux/magic.h>
>> >> +#include "../../../../fs/squashfs/squashfs_fs.h"
>> >
>> > No way.  You're reaching deep into the internals of squashfs for no good
>> > reason.  The only use of anything from squashfs_fs.h is a cast and
>> > casting
>> > to void * would work just as well.
>>
>> He needs the definition of struct squashfs_super_block to access the
>> .bytes_used
>> field. Alternatively, the offset of that field must be hardcoded.
>>
>> BTW, the magic is __le32, and bytes_used is __le64, so there are some
>> le{32,64}_to_cpu()
>> missing.
>
> I am not sure how to proceed here.  My main purpose in providing this patch
> was to get the msp71xx platform compiling again, but I stumbled into some
> pre-existing code ugliness, which I must confess I was ultimately
> responsible for.
>
> As Geert said, I need to reach deep into the squashfs internals to access
> the bytes_used field of struct squashfs_super_block; the code just previous
> to this line works similar for the cramfs filesystem, where it accesses the
> size field of the struct cramfs_super field.  The cramfs code doesn't look
> as bad, because its superblock structure is defined in an easier-to-access
> file (linux/cramfs_fs.h).
>
> I can see a number of possible paths here:
>
> 1. Fix up the existing patch with le{32,64}_to_cpu() as Geert suggested, and
> leave everything else as-is.
> 2. Approach the squashfs maintainers to move the squashfs_fs.h file to a
> more public location, and still do 1.
> 3. Pull the squashfs code entirely.
> 4. Remove the entire get_ramroot() code, both squashfs and cramfs, as
> Christoph has suggested.  I am hesitant to do this as it also affects code
> in the MTD subsystem (file maps/pmcmsp-ramroot.c), and it also loses some
> functionality on the PMC boards (putting the rootfs in RAM immediately
> following the kernel).  Perhaps there's a better way to handle this?
>
> I am open to suggestions on how to proceed.

The only reason you need to know about the file system internals is to
find out the
size of the appended file system, right?

The way other platforms solve this is by e.g. letting the bootloader
pass the location
and size of the ramdisk to the kernel. This is file system agnostic.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
