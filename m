Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Apr 2010 17:31:51 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:43610 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492338Ab0DVPbo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Apr 2010 17:31:44 +0200
Received: by vws3 with SMTP id 3so1913486vws.36
        for <linux-mips@linux-mips.org>; Thu, 22 Apr 2010 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type;
        bh=eD7mGdvVc72lOOdPdhssbBSkj92pV6qXDjegyIz6mVA=;
        b=WyA58wRn1z7ZC3DrqRbn/cb+39kPzwehWORTiT72SgOZUpB3fPnoJqnxX2DH7xGE/E
         eprMzjxZagUnY0TPbiH0BRJtFgck+aW9r3zrYoxD9DPQ4ZiXhd+EqePFpr/PF2Q/MOkQ
         GCz82kBILW2C8zXYNc4Qy/b4cCarJcOFxpbbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=JbMQygmfIUDHJzR32WW52QSCGOf7kSGnf9B1yZjFYdO0Yi/7jrqfxzcGdLu/p463bT
         wy4Cwu/LAmFxS2JB1HYSNRomoinnZxSNp195AdgEHw3DvwB0BBKatapzLNhW1ZzDFw9R
         ztTKn907fzClbBoJtVTTGvK/92Ab6LcO1xjaU=
MIME-Version: 1.0
Received: by 10.220.17.141 with HTTP; Thu, 22 Apr 2010 08:31:34 -0700 (PDT)
In-Reply-To: <j2sdf5e30c51004172251z9fd01867h562b99c1f1044c26@mail.gmail.com>
References: <j2sdf5e30c51004172251z9fd01867h562b99c1f1044c26@mail.gmail.com>
Date:   Thu, 22 Apr 2010 23:31:34 +0800
Received: by 10.220.123.74 with SMTP id o10mr6940117vcr.44.1271950296318; Thu, 
        22 Apr 2010 08:31:36 -0700 (PDT)
Message-ID: <m2qdf5e30c51004220831n66ff859fxd71f6bd14a5af56f@mail.gmail.com>
Subject: Re: Ask help:why my 64-bit ELF file could not run at the 64-bit mips 
        cpu
From:   Jian Wang <dominicwj@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dominicwj@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dominicwj@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

 I have a 64-bit mips cpu, and compiled a 64-bit application, but this
 application could not run. (the target is running Linux)
 The details is:
 1)if I compile the application with -mabi=n64, this program could not
 run, when I run it in the shell, it prompts "command not found"
 2)but if I compile the application with -mabi=n32, it runs well and
 gives the correct result.

 I am wondering why with "-mabi=n64", this program could not run? I
 checked the CP0(status register), Bit px=0b0, KX=0b1, SX=0b1, UX=0b1,
 it seems that in User Mode, it accepts 64-bit operation.

 Anybody could give me some help? Any comments is much appreciated!!

 BR/Dominic
