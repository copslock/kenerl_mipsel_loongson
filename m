Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Apr 2010 18:01:23 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:57758 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492501Ab0DVQBS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Apr 2010 18:01:18 +0200
Received: by vws3 with SMTP id 3so1945697vws.36
        for <linux-mips@linux-mips.org>; Thu, 22 Apr 2010 09:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type;
        bh=eD7mGdvVc72lOOdPdhssbBSkj92pV6qXDjegyIz6mVA=;
        b=ALM4cFRkWG9X3UMQHhTubLBkJQPxfAhdZK1D6SXftGn1bXymoPbhfJVSoDDdwdBCq8
         wGVJoQkC5BIw8jzbsapLRwTZIt8olngRwHlcsOu/XHzjnE9bGcpOmt75B71/fV5T9a3x
         jbSlbbC/QvQNXcDYRDAwtZNB5C2ifydCieZ5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=pLV4gxRNiZJYyRwnNEQVju0j460odoBxTSVGUWETzaHBtVPVtT9kItoe28qrZp8ntx
         hSQxxVqf38TlMnSlFa2L+u+XZHDp9WGES2eQiDqcu5eU/pquLcNS7kddPXME9rZuiu8k
         /EMJJIyTte3GoEaW8RDb+erAxKVII88btR9jc=
MIME-Version: 1.0
Received: by 10.220.17.141 with HTTP; Thu, 22 Apr 2010 09:01:09 -0700 (PDT)
In-Reply-To: <j2sdf5e30c51004172251z9fd01867h562b99c1f1044c26@mail.gmail.com>
References: <j2sdf5e30c51004172251z9fd01867h562b99c1f1044c26@mail.gmail.com>
Date:   Fri, 23 Apr 2010 00:01:09 +0800
Received: by 10.220.126.151 with SMTP id c23mr1943335vcs.4.1271952071115; Thu, 
        22 Apr 2010 09:01:11 -0700 (PDT)
Message-ID: <q2odf5e30c51004220901l8bfa979ftc9c6a7b633569460@mail.gmail.com>
Subject: Ask help:why my 64-bit ELF file could not run at the 64-bit mips cpu
From:   Jian Wang <dominicwj@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dominicwj@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26450
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
