Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 13:47:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62408 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20022188AbYFEMrB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jun 2008 13:47:01 +0100
Received: by rv-out-0708.google.com with SMTP id c5so564259rvf.24
        for <linux-mips@linux-mips.org>; Thu, 05 Jun 2008 05:46:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=lQNYOKFaiqU3+K73qp+i02KEGERjGYqERt3abZ9aXdQ=;
        b=r28VmdN49d2uyfxhc5cyj8+u1yd5dhfkEFke+/ZRKEm1m/t7jpj+yU00sqNUO5QAMM
         ljdAmRNdRhc4BqpR1obsQFcrXtcDmft3cNeDmyUq+Wsqa/iUfLAwvMsl3LMiSlXusY0S
         JDKP74bgVehwAZg3/TTkOVAeUYBjiP3NYQDUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=kfe5n4do21UwnuGQl8I3ddXxkCfA1S/AjFSzQ3zGEUao7LsXGBixVbTe8VGK3bws7Z
         3WVKs1Z4MAnpkRKHKN6OCp0sqZLoZO/OBYE7fS10OQqjZsziBXaULHvu14M3fTzFO0PP
         im9+Ope5/zl5kEtrlpJkLdbBLjtyTTW5aZ7jI=
Received: by 10.141.175.5 with SMTP id c5mr823116rvp.54.1212670001034;
        Thu, 05 Jun 2008 05:46:41 -0700 (PDT)
Received: by 10.141.197.19 with HTTP; Thu, 5 Jun 2008 05:46:40 -0700 (PDT)
Message-ID: <a537dd660806050546s5b015183ra7b3a8259e13574e@mail.gmail.com>
Date:	Thu, 5 Jun 2008 14:46:40 +0200
From:	"Brian Foster" <brian.foster@innova-card.com>
To:	linux-mips@linux-mips.org
Subject: [Q] Pre-built cross-compilers for little-endian MIPS-Linux kernel (SDE-Lite vs? mipsel-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 86461a57dfdfe4e1
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

 I'm confused about pre-built cross-compiling tool-chains
 for building the MIPS-Linux kernel.  (Please note my
 question is confined to building the kernel, cross.)

 My Host is x86 running Linux.  My Target is an embedded
 SoC using the 4KSd core, and is little-endian.

 Linux (of the 2.6.20 vintage) has been ported to the SoC,
 using  mipsel-sdelinux-V6.04.00-4  to compile the kernel.
 The development system also includes  5.03 SDE-Lite,
 albeit I'm not too clear what that's used for:  I know
 the debugger, sde-gdb, is used with the FS2 EJTAG Probe,
 but am uncertain if anything else is actually used ....

 Anyways, that's all getting a bit old.  Hence, in time,
 the kernel will be up-reved (to at least 2.6.24).
 I also want to use later toolchain(s?), and I am currently
 trying to work out what's what, with the goal (if possible)
 of using them to built the current (2.6.20-ish kernel).
 The  http://www.linux-mips.org/wiki/MIPS_SDE_Installation
 page is rather confusing, talking first about SDE 6.x,
 and then jumping into a discussion of cross tool-chains.

 Whilst I assume I can use the most recent  mipsel-linux
 (mipsel-sdelinux-v6.05.00-4) to built the kernel, is it
 possible to use the most recent SDE-Lite (v6.06.01) to
 build the Linux kernel?   If so, what do I need to tweak
 so `sde-gcc' (with appropriate magic) is used instead of
 `mipsel-linux-gcc' (with whatever magic it's using)?

cheers!
	-blf-

-- 
"How many surrealists does it take to | Brian Foster
 change a lightbulb? Three. One calms | somewhere in south of France
 the warthog, and two fill the bathtub | Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools." | http://www.stopesso.com
