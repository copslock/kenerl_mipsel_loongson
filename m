Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 11:16:35 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:62942 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1CCKQc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2011 11:16:32 +0100
Received: by iyf40 with SMTP id 40so854134iyf.36
        for <linux-mips@linux-mips.org>; Thu, 03 Mar 2011 02:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=qBcb6W07W/jq8EOIJXpNQnVOnfjQtzWBg1X+FsUt1ic=;
        b=tgCTz4Uw8medgoLPR5iORi9arzhhpwyliYpZpiDWNCANX1W5buI0Bije4d/Ier31+1
         dCD8fAitjvDpm7bevWYqshYI31s2a7ctAyeVlXPOUd5jGgeyCXba+TTkdHC9zRDu5Uqr
         S65T0xta/lhTyUrxuVWwfI75oOkaShhJOHw84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=glgMOVzCbrj99aIAIfwoON+uXfcua9ISsYmQIdnVsSfT1UkhwLZGTNOm8q2pqsxjxN
         s+HQDGhp78eOB91d0fHZpMfDZ/ZK9Yrl5pw0BOqAnYcXPQPWF14S9HYVYR8rluwpY8CD
         velhoUIpFjiaVa0tnm4TQNnCc0FWLgipq2VRw=
MIME-Version: 1.0
Received: by 10.231.20.13 with SMTP id d13mr830365ibb.57.1299147385917; Thu,
 03 Mar 2011 02:16:25 -0800 (PST)
Received: by 10.231.183.20 with HTTP; Thu, 3 Mar 2011 02:16:25 -0800 (PST)
Date:   Thu, 3 Mar 2011 10:16:25 +0000
Message-ID: <AANLkTi=9X9Bm9H4FSHm9+W_o-UOa25AEL947aPk4pNRy@mail.gmail.com>
Subject: uboot for MIPS: need help to skip relocate uboot and start uboot from RAM
From:   Pandurang Kale <kale.pandurang@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00221532cb7872d53d049d91523c
Return-Path: <kale.pandurang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kale.pandurang@gmail.com
Precedence: bulk
X-list: linux-mips

--00221532cb7872d53d049d91523c
Content-Type: text/plain; charset=ISO-8859-1

Hello Everyone,

We have MIPS based development board and I am trying to get the uboot up and
running on it.
We have a primary bootloader which check for the valid mod-image stored on
the flash. This mod-image consist of header, uboot and linux kernel.
Depending on the recent, active and stable imagethe primary bootloader first
copies the uboot image. and later on we would copy the kernel image from
uboot.

But when primary bootloader copies the uboot image to the RAM and passes the
control to the uboot, uboot (MIPS version of start.S and
arch/mips/lib/borad.c) tries to relocate the
already copied image from RAM (the primary bootloader copied it to start of
the RAM+1MB address) to top of the RAM (0x87fc0000) region thinking that the
uboot image is stored in flash.

All I need to do is skip the uboot relocate code in MIPS version of uboot
startup as the primary bootloader has already relocated the uboot from Flash
to RAM and set up the stack pointer and other global data appropriately,
which it does after relocation.
I can see there is a switch for ARM processor, CONFIG_SKIP_RELOCATE_UBOOT,
which skips the relocation of uboot code and tries to run the uboot from
RAM. I
cannot see a similar switch implemented for MIPS and didnt find any related
thread anywhere in mailing list or on net.

Do we have similar ARM like switch to SKIP the RELOCATION? If not has anyone
done this before?

I would really appreciate if you can guide me to overcome this issue to run
the uboot cleanly skipping the relocation.

Thanks in advance,
Pandu

--00221532cb7872d53d049d91523c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Everyone,<br><br>We have MIPS based development board and I am trying=
 to get the uboot up and running on it.<br>We have a primary bootloader whi=
ch check for the valid mod-image stored on the flash. This mod-image consis=
t of header, uboot and linux kernel.<br>
Depending on the recent, active and stable imagethe primary bootloader firs=
t copies the uboot image. and later on we would copy the kernel image from =
uboot.<br><br>But when primary bootloader copies the uboot image to the RAM=
 and passes the control to the uboot, uboot (MIPS version of start.S and ar=
ch/mips/lib/borad.c) tries to relocate the<br>
already copied image from RAM (the primary bootloader copied it to start of=
 the RAM+1MB address) to top of the RAM (0x87fc0000) region thinking that t=
he uboot image is stored in flash.<br><br>All I need to do is skip the uboo=
t relocate code in MIPS version of uboot startup as the primary bootloader =
has already relocated the uboot from Flash to RAM and set up the stack poin=
ter and other global data appropriately, which it does after relocation.<br=
>
I can see there is a switch for ARM processor, CONFIG_SKIP_RELOCATE_UBOOT, =
which skips the relocation of uboot code and tries to run the uboot from RA=
M. I<br>cannot see a similar switch implemented for MIPS and didnt find any=
 related thread anywhere in mailing list or on net.<br>
<br>Do we have similar ARM like switch to SKIP the RELOCATION? If not has a=
nyone done this before?<br><br>I would really appreciate if you can guide m=
e to overcome this issue to run the uboot cleanly skipping the relocation.<=
br>
<br>Thanks in advance,<br>Pandu<br>

--00221532cb7872d53d049d91523c--
