Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2011 22:16:38 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:59710 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903545Ab1LFVQe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Dec 2011 22:16:34 +0100
Received: by wgbds11 with SMTP id ds11so5919547wgb.24
        for <linux-mips@linux-mips.org>; Tue, 06 Dec 2011 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=NKs5iUFpFJXPWx53fHX+Mb3r8bxuop+yKg/bBWdsiPw=;
        b=SXQZsitBCSkhLlfcb1i2AOPvAP2Z9wp0p3U/n8H+atKXCiGJC7LAfZRQ6QeEk3Kq6f
         9WNcqfwenV5EVH0oF1BHgbN4gvJ5i1BTfWFa6zRkBVVYqPy64SxJGtQrac5EiWPHOc/t
         XkZu0BHdyK5dqvqKhLhYHl+dIgPwZRUfiG2qo=
Received: by 10.227.198.19 with SMTP id em19mr4008861wbb.14.1323206189431;
        Tue, 06 Dec 2011 13:16:29 -0800 (PST)
Received: from localhost (rsandifo.gotadsl.co.uk. [82.133.89.107])
        by mx.google.com with ESMTPS id u5sm29117323wbm.2.2011.12.06.13.16.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 13:16:27 -0800 (PST)
From:   Richard Sandiford <rdsandiford@googlemail.com>
To:     David Daney <david.daney@cavium.com>
Mail-Followup-To: David Daney <david.daney@cavium.com>,binutils <binutils@sourceware.org>,      linux-mips <linux-mips@linux-mips.org>,         Manuel Lauss <manuel.lauss@googlemail.com>,     Debian MIPS <debian-mips@lists.debian.org>, rdsandiford@googlemail.com
Cc:     binutils <binutils@sourceware.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>
Subject: Re: [Patch]: Fix ld pr11138 FAILures on mips*.
References: <4EDD669F.30207@cavium.com>
        <20111206054018.GB21034@bubble.grove.modra.org>
Date:   Tue, 06 Dec 2011 21:16:22 +0000
In-Reply-To: <20111206054018.GB21034@bubble.grove.modra.org> (Alan Modra's
        message of "Tue, 6 Dec 2011 16:10:19 +1030")
Message-ID: <8762ht2yft.fsf@firetop.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 32047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5003

Alan Modra <amodra@gmail.com> writes:
> On Mon, Dec 05, 2011 at 04:49:35PM -0800, David Daney wrote:
>> The root cause of this is that the mips linker synthesizes a special
>> symbol "__RLD_MAP", and then sets MIPS_RLD_MAP to point to it.  When
>> a version script is present, this symbol gets versioned along with
>> all the rest, and when it is time to take its address, the symbol
>> can no longer be found as it has had version information appended to
>> its name.
>
> Why not just change
>
> 	  && (strcmp (name, "__rld_map") == 0
> 	      || strcmp (name, "__RLD_MAP") == 0))
>
> to
>
> 	  && (strncmp (name, "__rld_map", 9) == 0
> 	      || strncmp (name, "__RLD_MAP", 9) == 0))
>
> in _bfd_mips_elf_finish_dynamic_symbol?  Perhaps the same for other
> syms there too?

Showing my ignorance here, but is that the usual behaviour for this kind
of thing?  I wouldn't have expected versions to apply to internally-created
symbols.

There again, is this symbol (as opposed to the DT_MIPS_RLD_MAP tag)
actually part of the ABI?  I can't find any reference to it in the
original psABI, the SGI ELF64 spec, gdb or glibc.  If it's just an
internal thing, maybe we could get rid of it altogether, or at least
make it bind locally rather than globally.

Richard
