Received:  by oss.sgi.com id <S553825AbRALTQa>;
	Fri, 12 Jan 2001 11:16:30 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:34576 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553726AbRALTQ2>;
	Fri, 12 Jan 2001 11:16:28 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id 00E07205FA
	for <linux-mips@oss.sgi.com>; Fri, 12 Jan 2001 11:16:22 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Fri, 12 Jan 2001 11:10:56 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id 56C0F15961
	for <linux-mips@oss.sgi.com>; Fri, 12 Jan 2001 11:16:22 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id BCE0C686D; Fri, 12 Jan 2001 11:16:20 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS ...
Date:   Fri, 12 Jan 2001 11:06:56 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
References: <3A5E7FFB.79925DF9@mvista.com> <001e01c07c68$96155f80$0deca8c0@Ulysses> <3A5F53CB.F8EC3947@mvista.com>
In-Reply-To: <3A5F53CB.F8EC3947@mvista.com>
MIME-Version: 1.0
Message-Id: <0101121116201G.07691@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 12 Jan 2001, you wrote:
> I think that is a good idea.  I suggest we have two more pointers in the
> mips_cpu strcuture : one to mips_mmu_ops structure, and the other to
> setup_exception_vectors() function.
> 
> BTW, I have a question about MIPS32 (or 4KC).  Do all MIPS32 CPUs have the
> same PRID?  Or all "incarnations" of 4KC have the same PRID?  

No.  Mips32 defines PRID into 4 partitions: a company id, processor id,
revision id, and company options field.  

>I suppose MIPS32
> CPUs have a more complete config register where you can probe for all the
> options.  For others we can use a table-like structure to fill in the options.

This is sort of true.  Mips32 does do a pretty good job of defining how to
probe for L1 caches and the like, but other things, such as L2 caches, are not
going to be so easily probed.  I think the mmu_ops routines should continue
to be specialized on a per-processor basis, just because they are both quite
performance sensitive and relatively easy to write/maintain. 

> 
> Along this line, it probably makes sense to have another pointer to
> mips_cpu_config() function, where for MIPS32 it is the standard MIPS32 config
> probing function and for most others it is NULL.
> 
> Now the mips_cpu_table looks like :
> 
> struct mips_cpu mips_cpu_table[]={
> 	{ PRID_IMP_4KC, mips32_cpu_config},
> 	{ PRID_IMP_RM7K, null, 0xaaa, {...}}
> 	.....
> };

If I'm understanding your idea correctly, this table would require you to
always compile in all the mmu routines for all processors, just to fill in the
table entries.  Doesn't seem like a particularly good idea to me, even if we
could use generic mips32 routines for most parts.  

> The cpu_probe() routine will now look like:
> {
>    read prid register
>    find mips_cpu_table[i] with matching PRID.
>    mips_cpu = &mips_cpu_table[i];
>    if (mips_cpu->mips_cpu_config) mips_cpu->mips_cpu_config();
> }
> 
> To me this is beautiful. Am I dreaming? :-)

See objections above.

I did submit a patch to Ralf a couple weeks ago to fix cpu_probe so it 
checks PRID according to the mips32 spec, but never heard back, and haven't
seen it show up in CVS.  WIll try again sometime soon, methinks.

-Justin
