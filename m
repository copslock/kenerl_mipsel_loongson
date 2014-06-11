Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 23:32:58 +0200 (CEST)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:51967 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859994AbaFKVcyNUxt8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2014 23:32:54 +0200
Received: by mail-ig0-f181.google.com with SMTP id h3so1301897igd.2
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type;
        bh=gEFZB8p7M7RDxv6CMZt7RQ69h0EdE8/UOfTKCq9olU0=;
        b=OWVLsUnkGyxItVeKcEHn10yb84lc2uBqvvi7ePUSogk6avwvjTvDV3ekRVR7TgYbuO
         sCnPffvpITV9h5lT0sYKTAClo1MHLCgsJ2In9tEiZ53ORd124FLtkTuk/c0CM2i9RsMI
         4Sw0y+aRL0KeI1eNfh+uySMehP7MzfdXEa35Nvh2gb627H3Hfdx616fOz9gQ5XOb3u0p
         bPOZYapAX0fPWdlz9E27dSZETzYEC2Td+qXY7fage31FYfcWNnlnqmsrv/Oh8rSroDKX
         yldMsA+Wo+21+k7VvMng/Kk7aK8jeQCl92AFmSf1Qm1TJGMhPXZBVEAE+tr5nUTCQdhC
         UnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=gEFZB8p7M7RDxv6CMZt7RQ69h0EdE8/UOfTKCq9olU0=;
        b=Q37vEvURGjZ7R3BTCRnJVE4TLWJExPQIhz7XMDrzJBYxXGv6QefTOEtX6/GrD87ohw
         KLQzUVEgy9zpdWnDSANOcA1LSmnl/xmN4AOvHli01/ped+pPw8V7qVPqH1f6bX2MQwSz
         3xxWKmkdU5F0PL7i43gKDouPsqhWhRNmLGpw/0A/LJJHz6XuYEfXLyGdd/QVx/B0j4Is
         +/TtMbrH4M9Leku38MW92pAb42lliC+kP+n2hSQEHbEZx66niHvKuDUtYg5TCjY03sxX
         7oX7VriMyYpPAZ+hVPvYWVRdrDJHVaCoPel64GwrRD0p9ySv+pfI5JgCSJr89Ywj2Ub9
         indA==
X-Gm-Message-State: ALoCoQlCv5nEMO6X36ZvYITLt2tdzcRL4exyVU9QQrN+7xaOLdCAh/Xa6v5hJa8ijHXRKfPo5J8K
X-Received: by 10.43.160.137 with SMTP id mc9mr48728929icc.4.1402522367755;
        Wed, 11 Jun 2014 14:32:47 -0700 (PDT)
Received: from [2620:0:1008:1101:be30:5bff:fed8:5e64] ([2620:0:1008:1101:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPSA id u10sm158794igz.21.2014.06.11.14.32.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 14:32:47 -0700 (PDT)
Date:   Wed, 11 Jun 2014 14:32:45 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Eunbong Song <eunb.song@samsung.com>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: mips: math-emu: Fix compilation error ieee754.c
In-Reply-To: <20140611171000.GD26335@linux-mips.org>
Message-ID: <alpine.DEB.2.02.1406111427170.27885@chino.kir.corp.google.com>
References: <2463243.264261402478691777.JavaMail.weblogic@epml26> <20140611171000.GD26335@linux-mips.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rientjes@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, 11 Jun 2014, Ralf Baechle wrote:

> On Wed, Jun 11, 2014 at 09:24:51AM +0000, Eunbong Song wrote:
> 
> > ieee754dp has bitfield member in struct without name. And this
> > cause compilation error. This patch removes struct in ieee754dp
> > declaration. So compilation error is fixed.
> > Signed-off-by: Eunbong Song <eunb.song@samsung.com>
> 
> What gcc version are you using?
> 

make arch/mips/math-emu/ieee754.o for mips defconfig triggers the 
following on linux-next 30 times:

arch/mips/math-emu/ieee754.c:45:2: error: unknown field 'sign' specified in initializer
arch/mips/math-emu/ieee754.c:45:2: warning: missing braces around initializer
arch/mips/math-emu/ieee754.c:45:2: warning: (near initialization for '__ieee754dp_spcvals[0].<anonymous>')
arch/mips/math-emu/ieee754.c:45:2: error: unknown field 'bexp' specified in initializer
arch/mips/math-emu/ieee754.c:45:2: warning: excess elements in union initializer
arch/mips/math-emu/ieee754.c:45:2: warning: (near initialization for '__ieee754dp_spcvals[0]')
arch/mips/math-emu/ieee754.c:45:2: error: unknown field 'mant' specified in initializer
arch/mips/math-emu/ieee754.c:45:2: warning: excess elements in union initializer
arch/mips/math-emu/ieee754.c:45:2: warning: (near initialization for '__ieee754dp_spcvals[0]')

I'm using gcc 4.5.1 for mips.  The patch makes all members part of the 
union so it's probably not what you want to fix it, though.
