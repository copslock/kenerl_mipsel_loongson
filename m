Received:  by oss.sgi.com id <S553821AbRALTjU>;
	Fri, 12 Jan 2001 11:39:20 -0800
Received: from mx.mips.com ([206.31.31.226]:59291 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553671AbRALTi7>;
	Fri, 12 Jan 2001 11:38:59 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA08367;
	Fri, 12 Jan 2001 11:38:52 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id LAA03817;
	Fri, 12 Jan 2001 11:38:50 -0800 (PST)
Message-ID: <020a01c07ccf$cf11d220$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jun Sun" <jsun@mvista.com>
Cc:     <linux-mips@oss.sgi.com>
References: <3A5E7FFB.79925DF9@mvista.com> <001e01c07c68$96155f80$0deca8c0@Ulysses> <3A5F53CB.F8EC3947@mvista.com>
Subject: Re: broken RM7000 in CVS ...
Date:   Fri, 12 Jan 2001 20:42:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> "Kevin D. Kissell" wrote:
> >
> > Yes, arguably the mips_cpu structure could also contain
> > a descriptor of the MMU routines to bind, and it probably
> > would have if it would have been a simple matter of an
> > address/length of a vector to copy.  But heck, it could
> > be a function pointer as well, I suppose.
> >
>
> I think that is a good idea.  I suggest we have two more pointers in the
> mips_cpu strcuture : one to mips_mmu_ops structure, and the other to
> setup_exception_vectors() function.
>
> BTW, I have a question about MIPS32 (or 4KC).  Do all MIPS32 CPUs have the
> same PRID?

No.

> Or all "incarnations" of 4KC have the same PRID?

The same upper 24 bits, anyway.

> I suppose MIPS32 CPUs have a more complete config register where you can
> probe for all the options.  For others we can use a table-like structure
to fill in
> the options.

And thereby hangs a tale.  MIPS tweaked the Config register, and has
added additional registers "behind" the Config register (a previously
reserved zero field in the mtc0/mfc0 instructions now serves as a
sort of bank select, and most current gnu assemblers recognize
"mfc0 $2, 16, 1", etc.) in MIPS32 to allow MMU and cache configuration,
presence of FPU, etc, to be read at run-time.  This is important for
synthesizable cores like the 4K and 5K families, since the same
basic core (and hence same PrID) can be instantiated with different
cache geometries, etc.  So one of the first things we did was write
code that reads those registers and populates the mips_cpu structure
accordingly.  Unfortunately, we were ahead of our time!  At the time
we needed to ship our Linux kernel tweaks to people outside MIPS,
those parts of the MIPS32 spec were still confidential, so we had
to take them out and make the 4K and 5K revert to using the same
table as everyone else!   I believe we got the all-clear to put the code
back in some time ago, but Carsten and I have been too busy with
other stuff.  Sorry!

> Along this line, it probably makes sense to have another pointer to
> mips_cpu_config() function, where for MIPS32 it is the standard MIPS32
config
> probing function and for most others it is NULL.

It probably wouldn't be NULL.   One would still want a routine
that probes for the size of the caches if the table indicates that
it could be variable for that device.  Etc.
>
> Now the mips_cpu_table looks like :
>
> struct mips_cpu mips_cpu_table[]={
> { PRID_IMP_4KC, mips32_cpu_config},
> { PRID_IMP_RM7K, null, 0xaaa, {...}}
> .....
> };
>
> The cpu_probe() routine will now look like:
> {
>    read prid register
>    find mips_cpu_table[i] with matching PRID.
>    mips_cpu = &mips_cpu_table[i];
>    if (mips_cpu->mips_cpu_config) mips_cpu->mips_cpu_config();

Dispatching through the table to the config routine would
be possible, but unless you want to write a seperate routine
for every possible set of CPU parameters and options, it would
be preferrable (IMHO) to keep the parameters in the table
and to pass the table entry address to the function being
invoked.  That way some smaller number of common functions
could be used.

> }
>
> To me this is beautiful. Am I dreaming? :-)

Not unless you are asleep.  If you're awake, we
call that hallucinating.  ;-)

            Regards,

            Kevin K.
