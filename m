Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 09:59:47 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:55214
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992615AbeCTI7ka5L1s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2018 09:59:40 +0100
Received: by mail-wm0-x242.google.com with SMTP id h76so1799105wme.4;
        Tue, 20 Mar 2018 01:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dfawECWtk1hdp40aEX5Sp7Cd/Au50B++H/6qwEyRzrM=;
        b=T58ebr48J/FRV004s6+aro78J4goGbk87R85ZgRm0EdGzjk8pGkH0j8THcLW0mIpHz
         Ue4u1my/kf5AiMMx62m1YCEl6DVfxdHBilOyZsr/gju6DarTdXELnPTZKofN0XCcJwvD
         2KIzfFiFNUEBsaHZkBol5tdBTwHAC1vzV9mh9DIAiBn8osEcwSaykf+ANvJN/uw0XJm9
         1QDEZITUDiJFXtPnhw4cHiH23deqgCkgcuYTnJySbifovpOZgDUosbFnuPl7GQnLDHgS
         JUGoqii+e2IGWR9mhq8bdNcKN20cq/enHHNlULUlKZxwRC3XEoj8agDicze/DWUzIXIB
         FulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dfawECWtk1hdp40aEX5Sp7Cd/Au50B++H/6qwEyRzrM=;
        b=h5J0T3txC63Vj3AvH5PANaDvFXoVE3Rl+F7zfRBbNANGm47GbXzlWSy//Bn9/szBrA
         vlPsYmPsePH6is4/7QtXptZCMs5+4WYSWrXDziUSxy7UINkZqxhrp9y5Fq6M7UJCRFdX
         aX1h0/SY8pkOhHbPvGEI1UzE1KNuyA8CI63r0QdouFcIrB+NO6LtMmDHunpFLdtk1zbF
         i5FYOefowC7su+KofDqfP4Mu3flGVoHOZu+5ACu3lu99FfU8DC52ODvHVhL4HRPHINA+
         87cX3Khz5+eDjFH83lMt/EdeWWK59LoMl1FJWnFQH+pqsLp3lRqLwdkYZO/r/p/iXrnx
         vVTw==
X-Gm-Message-State: AElRT7FpGwZswGOAjpqFfo78nPCuaHMFP2iOHuWv1Ehn00crHgBcFfjJ
        D+j+HlrORWYu7TN9RFrtQcCvWw==
X-Google-Smtp-Source: AG47ELsE6E5rjoC1NJNFoLWiDfJtmAEHsCTtcc8Prg17gHalCTQ1Ozu5qaAZ9JRcIVePxVBXsUohPA==
X-Received: by 10.28.172.196 with SMTP id v187mr1475511wme.69.1521536375149;
        Tue, 20 Mar 2018 01:59:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b8sm922278wrf.29.2018.03.20.01.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Mar 2018 01:59:34 -0700 (PDT)
Date:   Tue, 20 Mar 2018 09:59:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jslaby@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Message-ID: <20180320085932.xnwkpiz5gpegnw5d@gmail.com>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com>
 <20180319232342.GX30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319232342.GX30522@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Al Viro <viro@ZenIV.linux.org.uk> wrote:

> > For example this attempt at creating a new system call:
> > 
> >   SYSCALL_DEFINE3(moron, int, fd, loff_t, offset, size_t, count)
> > 
> > ... would translate into something like:
> > 
> > 	.name = "moron", .pattern = "WWW", .type = "int",    .size = 4,
> > 	.name = NULL,                      .type = "loff_t", .size = 8,
> > 	.name = NULL,                      .type = "size_t", .size = 4,
> > 	.name = NULL,                      .type = NULL,     .size = 0,     /* end of parameter list */
> > 
> > i.e. "WDW". The build-time constraint checker could then warn about:
> > 
> >   # error: System call "moron" uses invalid 'WWW' argument mapping for a 'WDW' sequence
> >   #        please avoid long-long arguments or use 'SYSCALL_DEFINE3_WDW()' instead
> 
> ... if you do 32bit build.

Yeah - but the checking tool could do a 32-bit sizing of the types and thus the 
checks would work on all arches and on all bitness settings.

I don't think doing part of this in CPP is a good idea:

 - It won't be able to do the full range of checks

 - Wrappers should IMHO be trivial and open coded as much as possible - not hidden
   inside several layers of macros.

 - There should be a penalty for newly introduced, badly designed system call
   ABIs, while most CPP variants I can think of will just make bad but solvable 
   decisions palatable, AFAICS.

I.e. I think the way out of this would be two steps:

 1) for new system calls: hard-enforce the highest quality at the development
    stage and hard-reject crap. No new 6-parameter system calls or badly ordered
    arguments. The tool would also check new extensions to existing system calls, 
    i.e. no more "add a crappy 4th argument to an existing system call that works 
    on x86 but hurts MIPS".

 2) for old legacies: cleanly open code all our existing legacies and weird
    wrappers. No new muck will be added to it so the line count does not matter.

... is there anything I'm missing?

Thanks,

	Ingo
