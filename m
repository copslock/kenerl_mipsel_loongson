Received:  by oss.sgi.com id <S553673AbRALS6j>;
	Fri, 12 Jan 2001 10:58:39 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:19958 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553652AbRALS6S>;
	Fri, 12 Jan 2001 10:58:18 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0CItcC30970;
	Fri, 12 Jan 2001 10:55:38 -0800
Message-ID: <3A5F53CB.F8EC3947@mvista.com>
Date:   Fri, 12 Jan 2001 10:58:19 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS ...
References: <3A5E7FFB.79925DF9@mvista.com> <001e01c07c68$96155f80$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:
> 
> Yes, arguably the mips_cpu structure could also contain
> a descriptor of the MMU routines to bind, and it probably
> would have if it would have been a simple matter of an
> address/length of a vector to copy.  But heck, it could
> be a function pointer as well, I suppose.
> 

I think that is a good idea.  I suggest we have two more pointers in the
mips_cpu strcuture : one to mips_mmu_ops structure, and the other to
setup_exception_vectors() function.

BTW, I have a question about MIPS32 (or 4KC).  Do all MIPS32 CPUs have the
same PRID?  Or all "incarnations" of 4KC have the same PRID?  I suppose MIPS32
CPUs have a more complete config register where you can probe for all the
options.  For others we can use a table-like structure to fill in the options.

Along this line, it probably makes sense to have another pointer to
mips_cpu_config() function, where for MIPS32 it is the standard MIPS32 config
probing function and for most others it is NULL.

Now the mips_cpu_table looks like :

struct mips_cpu mips_cpu_table[]={
	{ PRID_IMP_4KC, mips32_cpu_config},
	{ PRID_IMP_RM7K, null, 0xaaa, {...}}
	.....
};

The cpu_probe() routine will now look like:
{
   read prid register
   find mips_cpu_table[i] with matching PRID.
   mips_cpu = &mips_cpu_table[i];
   if (mips_cpu->mips_cpu_config) mips_cpu->mips_cpu_config();
}

To me this is beautiful. Am I dreaming? :-)

Jun
