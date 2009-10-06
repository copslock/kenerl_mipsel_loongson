Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2009 14:11:27 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:34849 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492906AbZJFMLV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Oct 2009 14:11:21 +0200
Received: by bwz4 with SMTP id 4so3257464bwz.0
        for <multiple recipients>; Tue, 06 Oct 2009 05:11:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Yrhe/Myo01RwUorHQly4Zk1MMU8RM5WTB9LrtMSlllY=;
        b=KDQlxJfc+Sce+j6M9sSrrQApIvrV7BDo2UXv3u8c9lPMftxBgOzl9ntr1lXvfvAhh9
         ltSJo7y+ZUe2XKL/sJ0cDQogScKhH0AMajbnMxDATECxWFI6QoPQkVWTsz2xvXUJQKuF
         zzCecmssBMi1GVnkixcX2jahBF0GYu7dRlRCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SGYVb0oP8MFwz3uIGE3BrEuATTjTUBz7h/sQF78QeQkHJcHDFM5gX93GIz4isCH8BM
         QtGm8X/CWC0AgbrUnCjtO1rDy94qDwBjMOXA0mNvL51xDDYFVvME9NFzRSkpwYTgA0Aa
         bfmhmvMsvOvY6qwliefG7mU+2nq/tPqZWdFPM=
MIME-Version: 1.0
Received: by 10.103.87.27 with SMTP id p27mr647648mul.125.1254831075574; Tue, 
	06 Oct 2009 05:11:15 -0700 (PDT)
In-Reply-To: <20091006115220.GC25263@linux-mips.org>
References: <f861ec6f0910030748l396b45bck858f15460354e58e@mail.gmail.com>
	 <20091006115220.GC25263@linux-mips.org>
Date:	Tue, 6 Oct 2009 14:11:15 +0200
Message-ID: <f861ec6f0910060511t3e95a089h63dc33e628349c11@mail.gmail.com>
Subject: Re: Reason for PIO_MASK?
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, Oct 6, 2009 at 1:52 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Oct 03, 2009 at 04:48:12PM +0200, Manuel Lauss wrote:
>
>> In arch/mips/lib/iomap.c  there's this "#define PIO_MASK 0x0ffff"
>> which limits the ability to successfully call ioport_map() to the
>> first 64kB.  This causes pata_pcmcia to error out on CF card
>> probe because devm_ioport_map() is called with the remapped
>> PCMCIA IO area, which is somewhere in MAP_BASE space.
>
> Remapped, so that then actually be a physical address?  That'd be wrong.

I meant the result of ioremap() of the 36bit address of PCMCIA IO space:
so the ioport base is somewhere at 0xc0000000, which pata_pcmcia
tries to devm_iomap(), and this is rejected by the above mentioned file.

The old ide-cs.c driver takes the given IO base as-is (without trying to
do funky things to it) and just works. (i.e. there are 2 entries in the
0xc0000000-range per cf-card in /proc/ioports)


>> I've temporarily removed the PIO_MASK check and pata_pcmcia
>> works as expected. Is there any way around this, other than
>> creating an Alchemy-specific ioport_map() function?
>
> The provocative question - why would you want to have more than 64k I/O port
> space?

*I* don't want more; I want a smarter pata_pcmcia driver ;-)  I'll go bug other
people about this.  I brought this up here because one of my SH boards has
similar needs (need to do an ioremap() with special TLB flags to get access to
pcmcia IO space) but pata_pcmcia does work there (because SH kernel
either asks the board to translate an x86-IO port to memory address or
simply returns the port plus an offset).

Thanks!
        Manuel Lauss
