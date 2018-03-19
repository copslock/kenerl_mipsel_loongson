Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 10:29:37 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:39702
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992121AbeCSJ33KVdhq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2018 10:29:29 +0100
Received: by mail-wm0-x244.google.com with SMTP id f125so5809902wme.4;
        Mon, 19 Mar 2018 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t+i6XdxnL1ryXWhtFYfzLguqGb2RKlGvWE2All7i87o=;
        b=hY5UwClop+pSPP8e9H+nDGzJiqCKtYSt8VlSn0P2eIFMNpyz2nPvBOGgHRKPAVLDMA
         iS3mFwAr4uuVYX0wOe48SggEUzdcbB9P+Xem3hcpS1/tbOMVnoH94mQ8bHdnpOx+j37f
         YXE7LwzT8Hqoc+SdBuKoM5yPpu/Mnqy453XTaXNlI05tV4VpOVfTtLnKbQSYprswzbrU
         sRuCUYWjoOEpL0m3pd3Q8TWHs9vtHAbSSOz+Au7aLngm7Twc7kZgPJcghtqqF4YX4+AG
         7r7NpH7kLtoxRp8c5nz7XyoxOUjq4eJBnxmUIlYOC1wbokxuz5yht1Ps/8fvx2mog2rB
         nKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+i6XdxnL1ryXWhtFYfzLguqGb2RKlGvWE2All7i87o=;
        b=PMS2jpcdeJkOt1krj/MUZ8lFMa42zcHKgDiFAtPUNOaeeN9C6JrzVB5jUZjiUKPub/
         woVkllUiasIELYV5q5ZLjvKNMCNEQOJ/vLizIaZ2SKGKe1H3XczV8KbxDIEZIPbGE4Lz
         5hb00+NSp+1PFyNMH0Fjg0cGqG1HFH6nEtixtMML6hejAz/ZjJbsABKWEnSXcsJJNPlN
         59GT9uPFAFN/LYo78H1T433ws49vkxFGNkLAAInPMY0OxQDMkBiI5+vMVyZsvei5vpBt
         Sez9KG4E4BNGREHgrzM2l06NOvRVQCLKLbkZr2PlBxEOmZY+x+ff2TPBmIiv0Gmh9i77
         h/bQ==
X-Gm-Message-State: AElRT7F5UqfbuCmZG2vrI2dZR0v1i2i4pE0m9+nUGcxhT2mh4jnmqQHB
        f0ghlvcPvv300Qg+L+3UZms=
X-Google-Smtp-Source: AG47ELtNk7cWNKhLC6LpnjxknEnpnzqLvnxuWSQVKugJCiclQydizWG1y99x6mindANRbzn7Z71UOQ==
X-Received: by 10.28.64.193 with SMTP id n184mr7300484wma.4.1521451763649;
        Mon, 19 Mar 2018 02:29:23 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m200sm183418wmb.34.2018.03.19.02.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 02:29:22 -0700 (PDT)
Date:   Mon, 19 Mar 2018 10:29:20 +0100
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
Message-ID: <20180319092920.tbh2xwkruegshzqe@gmail.com>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319042300.GW30522@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63045
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

> On Sun, Mar 18, 2018 at 06:18:48PM +0000, Al Viro wrote:
> 
> > I'd done some digging in that area, will find the notes and post.
> 
> OK, found:

Very nice writeup - IMHO this should go into Documentation/!

> OTOH, consider arm.  There we have
> 	* r0, r1, r2, r3, [sp,#8], [sp,#12], [sp,#16]... is the sequence
> of objects used to pass arguments
> 	* 32bit and less - pick the next available slot
> 	* 64bit - skip a slot if we'd already taken an odd number, then use
> the next two slots for lower and upper 32 bits of the argument.
> 
> So our classes take
> simple n-argument:	0 to 6 slots
> WD			4 slots
> DWW			4 slots
> WDW			5 slots
> WWDD			6 slots
> WDWW			5 slots
> WWWD			6 slots
> WWDWW			6 slots
> WDDW			7 slots (!)  Also ****, !!!!, !@#!@#!@#!# and other nice
> and well-deserved comments from arch maintainers, some of them even printable:
> /* It would be nice if people remember that not all the world's an i386
>    when they introduce new system calls */
> SYSCALL_DEFINE4(sync_file_range2, int, fd, unsigned int, flags,
>                                  loff_t, offset, loff_t, nbytes)

Such idiosyncratic platform quirks that have an impact on generic code should be 
as self-maintaining as possible: i.e. there should be a build time warning even on 
x86 if someone introduces a new, suboptimally packed system call.

Otherwise we'll have such incidents again and again as new system calls get added.

> [snip the preprocessor horrors - the sketches I've got there are downright obscene]

I still think we should consider creating a generic facility and a tool: which 
would immediately and automatically add new system calls to *every* architecture - 
or which would initially at least check these syscall ABI constraints.

I.e. this would start with a new generic kernel facility that warns about 
suboptimal new system call argument layouts on every architecture, not just on the 
affected ones.

That's a significant undertaking but should be possible to do.

Once such a facility is in place all the existing old mess is still a PITA, but 
should be manageable eventually - as no new mess is added to it.

IMHO that's the only thing that could break the somewhat deadly current dynamic of 
system call mappings mess. Complaining about people not knowing about quirks won't 
help.

One way to implement this would be to put the argument chain types (string) and 
sizes (int) into a special debug section which isn't included in the final kernel 
image but which can be checked at link time.

For example this attempt at creating a new system call:

  SYSCALL_DEFINE3(moron, int, fd, loff_t, offset, size_t, count)

... would translate into something like:

	.name = "moron", .pattern = "WWW", .type = "int",    .size = 4,
	.name = NULL,                      .type = "loff_t", .size = 8,
	.name = NULL,                      .type = "size_t", .size = 4,
	.name = NULL,                      .type = NULL,     .size = 0,     /* end of parameter list */

i.e. "WDW". The build-time constraint checker could then warn about:

  # error: System call "moron" uses invalid 'WWW' argument mapping for a 'WDW' sequence
  #        please avoid long-long arguments or use 'SYSCALL_DEFINE3_WDW()' instead

Each architecture can provide its own syscall parameter checking logic. Both 
'stack boundary' and parameter packing rules would be straightforward to express 
if we had such a data structure.

Also note that this tool could also check for optimum packing, i.e. if the new 
system call is defined as:

  SYSCALL_DEFINE3_WDW(moron, int, fd, loff_t, offset, size_t, count)

... would translate to something like:

	.name = "moron", .pattern = "WDW", .type = "int",    .size = 4,
	.name = NULL,                      .type = "loff_t", .size = 8,
	.name = NULL,                      .type = "size_t", .size = 4,
	.name = NULL,                      .type = NULL,     .size = 0,     /* end of parameter list */

where the tool would print out this error:

  # error: System call "moron" uses suboptimal 'WDW' argument mapping instead of 'WWD'

there would be a whitelist of existing system calls that are already using an 
suboptimal argument order - but the warnings/errors would trigger for all new 
system calls.

But adding non-straight-mapped system calls would be the exception in any case.

Such tooling could also do other things, such as limit the C types used for system 
call defines to a well-chosen set of ABI-safe types, such as:

      3  key_t
      3  uint32_t
      4  aio_context_t
      4  mqd_t
      4  timer_t
     10  clockid_t
     10  gid_t
     10  loff_t
     10  long
     10  old_gid_t
     10  old_uid_t
     10  umode_t
     11  uid_t
     31  pid_t
     34  size_t
     69  unsigned int
    130  unsigned long
    226  int

This would also allow us some cleanups as well, such as dropping the pointless 
'const' from arithmetic types in syscall definitions for example.

etc.

Basically this tool would be a secondary parser of the syscall arguments, with 
most of the parsing and type sizing difficulties solved by the C parser already.

I think this problem could be much more sanely solved via annotations and a bit of 
tooling, than trying to trick CPP into doing this for us (which won't really work 
in any case).

Thanks,

	Ingo
