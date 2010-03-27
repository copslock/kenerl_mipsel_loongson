Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Mar 2010 19:20:25 +0100 (CET)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:43012 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492064Ab0C0SUW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Mar 2010 19:20:22 +0100
Received: by wwb18 with SMTP id 18so3547102wwb.36
        for <linux-mips@linux-mips.org>; Sat, 27 Mar 2010 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=x15+odJjUHy1wZqSdtf9fc6XSRtRj7O6YQpIMKkrbgY=;
        b=kV6sG89zrlOY82Im0hT3BABJ0p/RDMuSsXx4G+c58owRc9rnM+jwdBd00F0iq3da2+
         U4ldk2rLD5ac80fRBH8nfqTOKC0H01CorYrIb9uf4ZyfJ7AlMxmjqSlEQKPQw/TaFgKx
         znz82GdZo5bY2ROf+lbfP3bZDxp3lCAjmbVTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=kDwWHR0CQ8J0Fygm+QmTmQ5rGlPilJKWAYlaYYp1ieRyRKfO9TrhKGP3zkKMJKhkpU
         VbWnbHkZJ4aEXjzQ9LP3wFsjYmuFezv+QUQ2eD4yRTM88F2jno+MOltsK/nRi/1aaf9N
         4LN3mrsmN0EykScxRnu2d1IdvFXvvEDV95bvs=
Received: by 10.216.168.203 with SMTP id k53mr1515386wel.120.1269714016905;
        Sat, 27 Mar 2010 11:20:16 -0700 (PDT)
Received: from debian.localnet (chello087206211117.chello.pl [87.206.211.117])
        by mx.google.com with ESMTPS id i35sm9327247gve.26.2010.03.27.11.20.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 11:20:16 -0700 (PDT)
From:   Adrian Byszuk <adebex@gmail.com>
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix kexec call on MIPS platform
Date:   Sat, 27 Mar 2010 18:19:02 +0000
User-Agent: KMail/1.12.4 (Linux/2.6.33.1-custom; KDE/4.3.4; i686; ; )
References: <201003211706.47373.adebex@gmail.com>
In-Reply-To: <201003211706.47373.adebex@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201003271819.02876.adebex@gmail.com>
Return-Path: <adebex@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adebex@gmail.com
Precedence: bulk
X-list: linux-mips

Dnia niedziela 21 marca 2010 o 17:06:47 Adrian Byszuk napisał(a):
> Dear developers,
> 
> This kernel patch fixes problems with kexec call on some devices.
> I tested it on Asus WL-500gP v2. I suppose it would behave well on all MIPS
> machines.
> Applicable to 2.6.32 and 2.6.33
> 
Hi everyone!

I'd like to know if somebody at least had a look on this patch?
If it won't get upstream, then I'll try to make it openWRT specific at least.
Simple answer like no/not yet/yes, applied  will be enough.

Kind regards
Adrian
