Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 12:58:20 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:35728
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990477AbeC3K6MHoRAc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2018 12:58:12 +0200
Received: by mail-wr0-x243.google.com with SMTP id 80so7767748wrb.2;
        Fri, 30 Mar 2018 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L6JOxp19XShDg4QwZ2D0LBToAZHdJMOHiTKXCztA0xQ=;
        b=kKPHqoIth1k+xRngcLlqtdh1P6XuuYEcNbIeBjs5ELocS3KIgIbT9P2clIlH4oJXAI
         wb5OhcDrKYC0v6PPW6F50DSQKGf8bTYKtAE5cvjwt6BjqKiAwK0NX8ZPY/MQ6FLIoZiM
         OGvtsHdvQBBxao/QxJ6L4HIuxsZPypiVGa06z5eqoePpIsJcdL2eB1DQa444xLHd2H7x
         feiINABWMOTiCFZoDJ/yqunZJvHve7gwBnvf/TPHHED+0l6VM3akqbkZp7C/SuXf3L7j
         FbjnKd0vYwsewY6QF9SZrKOjK2/iezGk5erueY3mCoGs6zHV+4JQsLV3bEaP/X2o8hX3
         TA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L6JOxp19XShDg4QwZ2D0LBToAZHdJMOHiTKXCztA0xQ=;
        b=WqRHVNun7BWUiJFbe1mB2D0+PdBLlkWo0tmN72DDSdmEY8w085abQHpacA/MET1ePr
         7KRBkn/nbTH+KiaEeTNb8iIM/0rfMEaP2Woq8iAcfHXXkpzxmz7fDshp99zNbPX7WZdE
         Dej3YxE8pQWhQYY5fTbMmBOv9mAlZkOKdNvLPZq6ut+mCexVxWL3Qu7rTk7Liib3Uo1T
         23EZ+YVOn0PSHdBWw4c4bh+dY39q94S99DIpA3T8Djvcv6rABlEV79k0O3+r//eugx6x
         qE20bvMus1xre8RY8AbpCXztQA5AHy/ga9glKXN01Cddi/j7Jo/77iKs85L4PbOpiRyz
         luAg==
X-Gm-Message-State: AElRT7Hw2SjyrdP72sKvrmrBIrB2GX5rckXG83i4miSY9I+CIqycuITA
        hzBrjSH63VFbMX3YBuOG464=
X-Google-Smtp-Source: AIpwx4/ogyv0XGGZ0pkX93daLA6TvsNE9P+Vl/DIPe0sydsJzA4606GxHhiH8V4av79CHfkPbfCgHA==
X-Received: by 10.223.150.56 with SMTP id b53mr9838943wra.79.1522407486072;
        Fri, 30 Mar 2018 03:58:06 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w82sm7565wmd.0.2018.03.30.03.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 03:58:05 -0700 (PDT)
Date:   Fri, 30 Mar 2018 12:58:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
Message-ID: <20180330105802.7df5pacjfqsqwa6l@gmail.com>
References: <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk>
 <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk>
 <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
 <428751c8-6920-096b-8694-a3f1b8990bdf@physik.fu-berlin.de>
 <CA+55aFwp-T-WFN95j7u5nn2BExxviJCx1-RgD3Mnu1AN_GYD3w@mail.gmail.com>
 <8a8ee344-fb19-3ed9-f7dc-db63f703e6d3@physik.fu-berlin.de>
 <CA+55aFzHL1L_SEt_xqmJBfRRngTm4qbQGwxFvqSXw-MD2BiAOQ@mail.gmail.com>
 <7753539f-c72d-9e5a-eb2d-939e5514404b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7753539f-c72d-9e5a-eb2d-939e5514404b@physik.fu-berlin.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63361
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


* John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> On 03/27/2018 12:40 PM, Linus Torvalds wrote:
> > On Mon, Mar 26, 2018 at 4:37 PM, John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >>
> >> What about a tarball with a minimal Debian x32 chroot? Then you can
> >> install interesting packages you would like to test yourself.
> > 
> > That probably works fine.
> 
> I just created a fresh Debian x32 unstable chroot using this command:
> 
> $ debootstrap --no-check-gpg --variant=minbase --arch=x32 unstable debian-x32-unstable http://ftp.ports.debian.org/debian-ports
> 
> It can be downloaded from my Debian webspace along checksum files for
> verification:
> 
> > https://people.debian.org/~glaubitz/chroots/
> 
> Let me know if you run into any issues.

Here's the direct download link:

  $ wget https://people.debian.org/~glaubitz/chroots/debian-x32-unstable.tar.gz

Checksum should be:

  $ sha256sum debian-x32-unstable.tar.gz
  010844bcc76bd1a3b7a20fe47f7067ed8e429a84fa60030a2868626e8fa7ec3b  debian-x32-unstable.tar.gz

Seems to work fine here (on a distro kernel) even if I extract all the files as a 
non-root user and do:

  ~/s/debian-x32-unstable> fakechroot /usr/sbin/chroot . /usr/bin/dpkg -l  | tail -2

  ERROR: ld.so: object 'libfakechroot.so' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.
  ii  util-linux:x32         2.31.1-0.5           x32          miscellaneous system utilities
  ii  zlib1g:x32             1:1.2.8.dfsg-5       x32          compression library - runtime

So that 'dpkg' instance appears to be running inside the chroot environment and is 
listing x32 installed packages.

Although I did get this warning:

  ERROR: ld.so: object 'libfakechroot.so' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.

Even with that warning, is still still a sufficiently complex test of x32 syscall 
code paths?

BTW., "fakechroot /usr/sbin/chroot ." crashes instead of giving me a bash shell.

Thanks,

	Ingo
