Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Aug 2010 09:16:15 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:49641 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490968Ab0H1HQI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Aug 2010 09:16:08 +0200
Received: by pwj3 with SMTP id 3so1720401pwj.36
        for <linux-mips@linux-mips.org>; Sat, 28 Aug 2010 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:reply-to:mime-version:content-type:content-disposition
         :user-agent;
        bh=HUEcTfyw3bvjrQ3QMMAHjnFpmU2CvBYdVlhoUfyucS8=;
        b=bXaMftd7AMfTzrV30ccVt/PutwDhlXQ+GfBs+gqTFAweNkDiH5uUPnMLvSM+pkjDd4
         GsrQSRamWPEkSD/aBybUABj1g7Z0k+FZcu8K3ydvWIBlBcP4Eo8WI3NEaWSGew9B0Haz
         ffpimHLiK2wT3uxCWOsafOQ82jvZYb34iS4O0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:reply-to:mime-version:content-type
         :content-disposition:user-agent;
        b=q8kpKRmtx6+cK8hXbekAztm89dKXHb5PT8Y4T1FrIh79OlvDX8IoDD/M/5ZaTo9KhW
         OW44sRKXMg5O2X2Zuqr4uad8IkxjriAPiE7fR3lac2pA2P0XwxNaXy7Vpeam3QDNouNi
         6juO9HkfcO6e4J+cIgK7DI7SCZ4FH1Ol2/xW8=
Received: by 10.114.132.17 with SMTP id f17mr1701335wad.223.1282979760513;
        Sat, 28 Aug 2010 00:16:00 -0700 (PDT)
Received: from localhost (KD118154228076.ppp-bb.dion.ne.jp [118.154.228.76])
        by mx.google.com with ESMTPS id q6sm8338449waj.10.2010.08.28.00.15.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 00:15:59 -0700 (PDT)
Date:   Sat, 28 Aug 2010 16:18:42 +0900
From:   Adam Jiang <jiang.adam@gmail.com>
To:     linux-mips@linux-mips.org
Subject: How is interrupt handling on MIPS SMP?
Message-ID: <20100828071842.GB6957@capricorn-x61>
Reply-To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

How dose interrupt be handled on SMP build on MIPS architecture? Does
mips-linux support SMP?
