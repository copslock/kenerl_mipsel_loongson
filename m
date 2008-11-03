Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 17:04:25 +0000 (GMT)
Received: from rv-out-0708.google.com ([209.85.198.244]:7115 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S23063806AbYKCREW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Nov 2008 17:04:22 +0000
Received: by rv-out-0708.google.com with SMTP id c5so2819104rvf.24
        for <multiple recipients>; Mon, 03 Nov 2008 09:04:20 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MSCcXcWvwrHMpNgaENe2Q9bCH2d6so48Y9yzUoALQ98=;
        b=IQ9WYc9pVwZXBi3SHgDfMyii0Fj/hKB7AG0OyzJNYKLhhCvvdWLLIGurQg11Mp4Ygn
         XO965XWp+y9gqX6+dTAp/1O/h4UQBaBUYJC7iR+fPm2rJsjw9Jcgd36uFN4S+pxFJz9S
         cDs4g1O3r/45XSQha062bluhviSSoHjgGOg3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Bm2H4U4tEngSPwELwdU474OlKwLf55l7+//9GDXj3FnqvFHhRvFOCDRwpz/0Ig1jxM
         rq8m7pJjYAc9yU6VrTxSHMSwQO6oi3iS2je1XW/du3XrPIBgBYg6xs7/FcDRpiBxrlbL
         cBQgqLmjzoo8+xFb4WS9V0d8LSpJdcniXuCOo=
Received: by 10.143.18.16 with SMTP id v16mr184792wfi.41.1225731860075;
        Mon, 03 Nov 2008 09:04:20 -0800 (PST)
Received: by 10.142.79.18 with HTTP; Mon, 3 Nov 2008 09:04:20 -0800 (PST)
Message-ID: <b647ffbd0811030904k4049cca3jafba532c24a4f5e9@mail.gmail.com>
Date:	Mon, 3 Nov 2008 18:04:20 +0100
From:	"Dmitry Adamushko" <dmitry.adamushko@gmail.com>
To:	linux-mm@kvack.org
Subject: possible dcache aliasing problems after do_swap_page()
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Nitin Gupta" <nitingupta910@gmail.com>,
	linux-mm-cc@lists.laptop.org, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <dmitry.adamushko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.adamushko@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,


the observations below are based on experiments with 'compcache'
(http://code.google.com/p/compcache/) on a MIPS-based system with
2.6.21.5. Although, at first glance 2.6.28-rc2 doesn't seem to make
any diffrence in this respect.


Note, I don't say there is a bug. After all, it likely depends on
whether the use of
(virtual) block-devices as 'swap' is considered sane/supported or not
:-) Other use-cases are unlikely to be affected. OTOH, perhaps having
a dependency on internals of block devices (basically, on how data is
copied from them) in this context is not ok as well.


update_mmu_cache() -> __update_cache() being called at the end of do_swap_page()
does not result in a call of flush_data_cache_page() due to the fact
that a new 'page'
has been anonymously mapped (so page_mapping(page) returns NULL),
notwithstanding
its 'dcache_dirty' bit is present [*]

Now, it all depends on how data has been copied into this new page
from a swap device.
Let's imagine that it's done by a cpu via virtual kernel-space address
(page_address(page)),
so that there can be dcache aliases with a user-space address to which
the 'page' is now mapped.

Obviously, the code doing the actual copying should expect this possibility and
call flush_dcache_page(page). It looks like the correct interface for
this case (?), since the only
info we have got there (passed to a block-device driver via
swap_readpage()) is a 'page' where data has to be written.

The 'problem' is that in this particular case flush_dcache_page(page)
will just call
SetPageDcacheDirty(page) due to the following check being true:

        struct address_space *mapping = page_mapping(page);
        ...
        if (mapping && !mapping_mapped(mapping)) {
                SetPageDcacheDirty(page);
                return;
        }

because 'mapping' is 'swapper_space' and mapping_mapped(&swapper_space) == 0.

To sum it up, the 'dcache_dirty' bit is set but it won't be considered
by __update_cache()
as described above [*].

As a result, for this specific setup 'dcache aliases' are not properly handled
leading to random user-space crashes.

The use of flush_data_cache_page() by (virtual) block-device's driver
fixes it but it's
an overkill (always results in a flush) and moreover it's
arch-specific. The placement of
flush_anon_page() in do_swap_page() (with the version of
flush_anon_page() from .28)
solves the issue as well (sure, there are a few alternative workarounds).

This is a specific setup indeed. One would get a similar problem
enabling a swap on top of
e.g. the "Ram backed block device driver" (drivers/block/brd.c). well,
don't ask me why one would need that :-) The use of 'compcache' is
arguably more useful.

I guess, other cases of anonymous mappings shouldn't be prone to this scenario.
flush_dcache_page() -> page_mapping() -> 'swapper_space' looks like a
'culprit' here.

Any comments?

TIA,

-- 
Best regards,
Dmitry Adamushko
