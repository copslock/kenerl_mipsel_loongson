Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2010 22:46:37 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:63231 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492123Ab0GHUq3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jul 2010 22:46:29 +0200
Received: by gwj21 with SMTP id 21so269618gwj.36
        for <linux-mips@linux-mips.org>; Thu, 08 Jul 2010 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=8VkSdYJQjkFfwQFJtFzbCnxxxZZHe0LlRV9FAEZc+IM=;
        b=iowxsxdhV7gA0C/77py6eKkBR6R1XBjvMVlVRRj8SNnUn7cmdBpoHsPUMikULHYCts
         8P+ssQbu0yhAcIRv28fU4vZ/BzhUJ2Jl0mKFeZ/qgPWBq/Abl60LXv1TQcXC+bUb3wDQ
         rT1SPiVMDm/y7s6Dw1TpXfyYapk7UhHFS0270=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bNs3wmRTPOe8E3HfXIXoO0mIvP92iP34YAQSainfONX2wswW0oWRl5KEV9gpBIQlpg
         XJTCAdnBhuiGaYiy5s/K9dNykgB0yc4FS73C3/7Ti5C8CXEVcVm0bfOBSyVMESp9xniO
         nD5j99hWCAhWTphWRNeatxMrEPSFSLfuR75Go=
MIME-Version: 1.0
Received: by 10.224.112.209 with SMTP id x17mr4946900qap.304.1278621981184; 
        Thu, 08 Jul 2010 13:46:21 -0700 (PDT)
Received: by 10.229.37.77 with HTTP; Thu, 8 Jul 2010 13:46:21 -0700 (PDT)
Date:   Thu, 8 Jul 2010 16:46:21 -0400
Message-ID: <AANLkTilwCgYls4BesQLZJnZieezRU0WlW0sZ9f9gt08J@mail.gmail.com>
Subject: Questions about BCM91250A
From:   Matt Turner <mattst88@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
I'm trying to figure out how to access a Compact Flash card via a
PCMCIA->CF adapter on my BCM91250A.

I've added
--- PCCard (PCMCIA/CardBus) support
<*>   16-bit PCMCIA support
 [*]     Load CIS updates from userspace (EXPERIMENTAL)
[*]   32-bit CardBus support
       *** PC-card bridges ***
<*>   CardBus yenta-compatible bridge support
[*]     Special initialization for O2Micro bridges
[*]     Special initialization for Ricoh bridges
[*]     Special initialization for TI and EnE bridges
[*]       Auto-tune EnE bridges for CB cards
[*]     Special initialization for Toshiba ToPIC bridges
<*>   Cirrus PD6729 compatible bridge support
<*>   i82092 compatible bridge support

and

--- Serial ATA and Parallel ATA drivers
<*>     PCMCIA PATA support
<*>     Generic platform device PATA support

But I see nothing in dmesg about this.

Also, I can't get access to the rtc. I've tried a lot of different
drivers. Any clues which is the right one?

Thanks!
Matt
