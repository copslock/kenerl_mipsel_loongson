Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 13:46:49 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:48949 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1CCMqq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2011 13:46:46 +0100
Received: by fxm16 with SMTP id 16so1130983fxm.36
        for <linux-mips@linux-mips.org>; Thu, 03 Mar 2011 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=TzkMwUH63BrQOIU3zD+H+AbqVBXpDXAgIVVf67NrL8U=;
        b=wKxjgIgLpPkecn84h547qCUI582DLGgxFnRC/gXW0w58zRioSWiI190mFQESHKQDKW
         i0CRnOnjEppqORm3HagrLEcgfv2QQPYMIUeM3d9kKMsg0Ffbv9UcNDkJznYayGpXpaPN
         xQ/idHUQyFASf2UZve7ir5o2TGhYIFxaj+KVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=Cq41dS+oVrQE5uamwlVOnTFNimwZS+g0hKOqxumPLKmtVUZLUAr8e9pzEhVSy0s/Uc
         EN0lr4RBUVnOeep2jA9wf0aixm0jPGNeuYja6FyilVdrrYDMA7Klwl1nfTJM2ruShwFJ
         +79iC4vST8kEsG5fM8O9z2DDb5rDlcDzTkpfc=
Received: by 10.223.70.142 with SMTP id d14mr1400341faj.110.1299156399788;
        Thu, 03 Mar 2011 04:46:39 -0800 (PST)
Received: from [192.168.23.19] ([193.105.30.100])
        by mx.google.com with ESMTPS id 17sm545165far.19.2011.03.03.04.46.37
        (version=SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 04:46:38 -0800 (PST)
Message-ID: <4D6F8DAC.20807@gmail.com>
Date:   Thu, 03 Mar 2011 14:46:36 +0200
From:   Ray Dudu <raydudu@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101220 Lightning/1.0b3pre Thunderbird/3.1.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: uboot for MIPS: need help to skip relocate uboot and start uboot
 from RAM
References: <AANLkTi=9X9Bm9H4FSHm9+W_o-UOa25AEL947aPk4pNRy@mail.gmail.com>
In-Reply-To: <AANLkTi=9X9Bm9H4FSHm9+W_o-UOa25AEL947aPk4pNRy@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <raydudu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raydudu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
I'm not so familira with uboot, however, I done proprietary booter
implementation for my company. Similar functionality was required, for
different purposes actually, but it doesn't change the idea.

So in my booter code I done simple check of code location. In case when
the code detects that it is already in RAM, it skips memory/caches
initialization and self coping. Some useful pieces of code:
Supporting function.

------CUT-HERE--------
LEAF(set_ra)

        jr      ra
        nop

END(set_ra)
------CUT-HERE--------
Actually the check:
------CUT-HERE--------
        bal     set_ra      /* first get the current program counter */
        nop

        move    t0, ra

        li      t1, 0x10000000
        and     t1, t1, t0
        bne     zero, t1, 1f                /* code in ROM/flash */
        nop

        li      s3,0                    /* code in RAM */
        b  	2f
        nop
1:
	/* jump to system initialization and code coping routine here */
2:
	/* continue normal boot */
------CUT-HERE--------

I suppose you can do similar in u-boot and it will be quite generic
solution. Such code can be executed from RAM and FLASH without need to
reconfigure and rebuild.


03.03.11 12:16, Pandurang Kale написав(ла):
> Hello Everyone,
> 
> We have MIPS based development board and I am trying to get the uboot up
> and running on it.
> We have a primary bootloader which check for the valid mod-image stored
> on the flash. This mod-image consist of header, uboot and linux kernel.
> Depending on the recent, active and stable imagethe primary bootloader
> first copies the uboot image. and later on we would copy the kernel
> image from uboot.
> 
> But when primary bootloader copies the uboot image to the RAM and passes
> the control to the uboot, uboot (MIPS version of start.S and
> arch/mips/lib/borad.c) tries to relocate the
> already copied image from RAM (the primary bootloader copied it to start
> of the RAM+1MB address) to top of the RAM (0x87fc0000) region thinking
> that the uboot image is stored in flash.
> 
> All I need to do is skip the uboot relocate code in MIPS version of
> uboot startup as the primary bootloader has already relocated the uboot
> from Flash to RAM and set up the stack pointer and other global data
> appropriately, which it does after relocation.
> I can see there is a switch for ARM processor,
> CONFIG_SKIP_RELOCATE_UBOOT, which skips the relocation of uboot code and
> tries to run the uboot from RAM. I
> cannot see a similar switch implemented for MIPS and didnt find any
> related thread anywhere in mailing list or on net.
> 
> Do we have similar ARM like switch to SKIP the RELOCATION? If not has
> anyone done this before?
> 
> I would really appreciate if you can guide me to overcome this issue to
> run the uboot cleanly skipping the relocation.
> 
> Thanks in advance,
> Pandu

-- 
Best regards,
RD18-UANIC
