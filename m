Received:  by oss.sgi.com id <S42245AbQIHBpP>;
	Thu, 7 Sep 2000 18:45:15 -0700
Received: from u-93.karlsruhe.ipdial.viaginterkom.de ([62.180.21.93]:2310 "EHLO
        u-93.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S42236AbQIHBo4>; Thu, 7 Sep 2000 18:44:56 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868997AbQIGJUN>;
        Thu, 7 Sep 2000 11:20:13 +0200
Date:   Thu, 7 Sep 2000 11:20:13 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-fbdev@vuser.vu.union.edu, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: mmap() frame buffer causes bus error on MIPS ...
Message-ID: <20000907112013.A6259@bacchus.dhis.org>
References: <39B5BD14.A8D2F467@mvista.com> <39B5DABB.7FB85B09@mvista.com> <39B6B75D.2501654E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39B6B75D.2501654E@mvista.com>; from jsun@mvista.com on Wed, Sep 06, 2000 at 02:30:05PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Sep 06, 2000 at 02:30:05PM -0700, Jun Sun wrote:

> In MIPS, mk_pte_phys() is defined as follows :
> 
> extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
> {
> 	return __pte(((physpage & PAGE_MASK) - PAGE_OFFSET) |
> pgprot_val(pgprot));
> }
> 
> The problematic part is " - PAGE_OFFSET" (where PAGE_OFFSET is
> 0x80000000).  If "physpage" is a physical address, it should not be
> substracted by PAGE_OFFSET.  This is a bug.
> 
> On the other hand, I wonder why this bug is there without being caught
> before (it is so fundamental).  If this is not a bug in MIPS kernel,
> then the fix is in the fb_mmap(), where under __mips__ case, we should
> add PAGE_OFFSET to the start of buffer address.

The definition should be:

extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
{
	return __pte(physpage) | pgprot_val(pgprot);
}

Masking with PAGE_MASK also seemed to be useless.

It's really surprising why it never has been caught.  Probably people
feed it with the addresses that are tweaked such that sich just work.

I'll cook up a patch for this bug.

  Ralf
