Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 22:11:25 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:60274 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492234Ab0BOVLW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 22:11:22 +0100
Received: by bwz7 with SMTP id 7so4319799bwz.26
        for <multiple recipients>; Mon, 15 Feb 2010 13:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=Xq6Xyg+3Idj776ASAQiLwS8t/hOE18xj9DvxZkaePpk=;
        b=Fi6Vg6BL99KT8UyszhhugTNyjAeCg8t0KTIXpporu3pK35vI81dyh4+CZVmGIBxEwP
         zGBSg56m//Lut4HQtR09kG35bLmYVW4phApVBqYWA6sH00V419NKcTG3tPXeEL/sytHv
         domIChspIoTKUnPTnzQ0MgSx559Eay+K+7Z8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=R2vBYePmaC61YWJLDdqwCccokQt911TYPcyQpAB8bn5TslEoLgJBA//LdGwyRazV3D
         lulv7EZu54J4wb8OvEjDn+dzq/3+2zoY+xehxkkuVNUFKt+WnpPWLg+M0DSAJH2IxB8Y
         vTmmCGd/kV4mubg3zmBIVW2l53gOI+2DWdYUQ=
Received: by 10.204.39.211 with SMTP id h19mr1297771bke.164.1266268275147;
        Mon, 15 Feb 2010 13:11:15 -0800 (PST)
Received: from ?127.0.0.1? (gw1.cosmosbay.com [212.99.114.194])
        by mx.google.com with ESMTPS id 13sm2840106bwz.14.2010.02.15.13.11.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 13:11:13 -0800 (PST)
Subject: Re: [PATCH 4/4] Staging: Octeon:  Free transmit SKBs in a timely
 manner.
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
In-Reply-To: <4B79B15F.7030506@caviumnetworks.com>
References: <4B79AAA6.60005@caviumnetworks.com>
         <1266264799-3510-4-git-send-email-ddaney@caviumnetworks.com>
         <1266265673.2859.5.camel@edumazet-laptop>
         <4B79B15F.7030506@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 15 Feb 2010 22:11:11 +0100
Message-ID: <1266268271.2859.22.camel@edumazet-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 8bit
Return-Path: <eric.dumazet@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.dumazet@gmail.com
Precedence: bulk
X-list: linux-mips

Le lundi 15 février 2010 à 12:41 -0800, David Daney a écrit :
> On 02/15/2010 12:27 PM, Eric Dumazet wrote:
> > Le lundi 15 février 2010 à 12:13 -0800, David Daney a écrit :
> >> If we wait for the once-per-second cleanup to free transmit SKBs,
> >> sockets with small transmit buffer sizes might spend most of their
> >> time blocked waiting for the cleanup.
> >>
> >> Normally we do a cleanup for each transmitted packet.  We add a
> >> watchdog type timer so that we also schedule a timeout for 150uS after
> >> a packet is transmitted.  The watchdog is reset for each transmitted
> >> packet, so for high packet rates, it never expires.  At these high
> >> rates, the cleanups are done for each packet so the extra watchdog
> >> initiated cleanups are not needed.
> >
> > s/needed/fired/
> >
> 
> or perhaps s/are not needed/are neither needed nor fired/
> 
> > Hmm, but re-arming a timer for each transmited packet must have a cost ?
> >
> 
> The cost is fairly low (less than 10 processor clock cycles).  We didn't 
> add this for amusement, people actually do things like only send UDP 
> packets from userspace.  Since we can fill the transmit queue faster 
> than it is emptied, the socket transmit buffer is quickly consumed.  If 
> we don't free the SKBs in short order, the transmitting process get to 
> take a long sleep (until our previous once per second clean up task was 
> run).

I understand this, but traditionaly, NIC drivers dont use a timer, but a
'TX complete' interrupt, that usually fires a few us after packet
submission on Gigabit speed.

A fast program could try to send X small udp packets in less than 150
us, X being greater than the size of your TX ring.

So your patch makes the window smaller, but it still is there (at
physical layer, we'll see a burst of packets, a ~100us delay, then a
second burst)
