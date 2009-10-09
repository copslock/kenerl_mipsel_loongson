Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 18:02:27 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.159]:32954 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492754AbZJIQCU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2009 18:02:20 +0200
Received: by fg-out-1718.google.com with SMTP id d23so2004603fga.6
        for <multiple recipients>; Fri, 09 Oct 2009 09:02:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=uf0kxsPJgOKKsE97vQ8uJepftu//Kg9daZLMdsJ/fmU=;
        b=erfAavkQdARPFsujiDR7zceo9bVfewtznnCp2Ul5XdbnmzvNVLFtUqcBJFQCE1AKOL
         mWv9sT4wq3GyzT6LgGrcPJwQYzvZQ5r+cNI93Z6gNXjPlZUoNk0SV3rRIbAlymybt7mv
         QcLLj6W/kQnX8UcpgibtVLrH4toB2wr4RPSC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wLoD1U1CDoUMPc6lFjRS5gcXQxQivZNgyoMkCdAVl2EJxGgyCRlv/jws4S+WB3YA6c
         NB6EW48mHubaXOAUCz68ALMAhuUifNgy0zNT8Oj7sK9g18oyhESUlTa+ZAs07liPJW7c
         CG+rOXQ55anyRCsRNXjDHCKZkiqA6ryF+FNyY=
Received: by 10.86.220.9 with SMTP id s9mr2564948fgg.40.1255104140244;
        Fri, 09 Oct 2009 09:02:20 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id l12sm266695fgb.11.2009.10.09.09.02.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 09:02:18 -0700 (PDT)
Subject: Re: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-mips@linux-mips.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1255054108.5810.74.camel@falcon>
References: <1255001548-30567-1-git-send-email-wuzhangjin@gmail.com>
	 <200910082221.12649.rjw@sisk.pl>  <20091008204447.GA14560@linux-mips.org>
	 <1255054108.5810.74.camel@falcon>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 10 Oct 2009 00:02:10 +0800
Message-Id: <1255104130.3658.122.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-10-09 at 10:08 +0800, Wu Zhangjin wrote:
> On Thu, 2009-10-08 at 22:44 +0200, Ralf Baechle wrote:
> > On Thu, Oct 08, 2009 at 10:21:12PM +0200, Rafael J. Wysocki wrote:
> > 
> > > > Here, we fix it via checking pfn is in the "System RAM" or not. and
> > > > Seems pfn_valid() is not called in assembly code, we move it to
> > > > "!__ASSEMBLY__" to ensure we can simply declare it via "extern int
> > > > pfn_valid(unsigned long)" without Compiling Error.
> > > > 
> > > > (This -v1 version incorporates feedback from Pavel Machek <pavel@ucw.cz>
> > > >  and Sergei Shtylyov <sshtylyov@ru.mvista.com>)
> > > 
> > > Hmm.  What exactly would be wrong with using register_nosave_region() or
> > > register_nosave_region_late() like x86 does?
> 
> Have tried to use register_nosave_region(), it works, but seems there is
> something else wrong there.
> 
> > 
> > That seems to be more the fix than pfn_valid / PageReserved fiddlery we were
> > discussing in the other thread.  Thanks!
> 
> Just checked the arch/mips/loongson/common/mem.c, Seems it did not
> register any reserved pages, in reality, two sections of memory are
> reserved.
> 
> here should be the patch, tested it, works.
> 
> diff --git a/arch/mips/loongson/common/mem.c
> b/arch/mips/loongson/common/mem.c
> index 7c92f79..069d20b 100644
> --- a/arch/mips/loongson/common/mem.c
> +++ b/arch/mips/loongson/common/mem.c
> @@ -15,11 +15,17 @@
>  
>  void __init prom_init_memory(void)
>  {
> -    add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
> +    add_memory_region(0x0, memsize << 20, BOOT_MEM_RAM);
> +
> +    add_memory_region(memsize << 20, LOONGSON_PCI_MEM_START - (memsize
> <<
> +                           20), BOOT_MEM_RESERVED);
>  #ifdef CONFIG_64BIT
>      if (highmemsize > 0)
>         add_memory_region(LOONGSON_HIGHMEM_START,
>                 highmemsize << 20, BOOT_MEM_RAM);
> +
> +    add_memory_region(LOONGSON_PCI_MEM_END + 1, LOONGSON_HIGHMEM_START
> -
> +                   LOONGSON_PCI_MEM_END - 1, BOOT_MEM_RESERVED);
>  #endif /* CONFIG_64BIT */
>  }

The above patch can not fix the problem when enabled FLATMEM in
linux-2.6.32-rc3, the real problem should be that we need register the
"pci memory space" as nosave pages, and also, the above "reserved"(not
memory) pages should be registered as nosave pages. but the simpler
solution should be the pfn_valid() I sent out in this E-mail thread, we
just need to check whether they are "valid", if they are "System
RAM"(BOOT_MEM_RAM or BOOT_MEM_ROM_DATA), they should be valid.

and what's more? should be register "pci memory space" as nosave pages
for all architecture?

Regards,
	Wu Zhangjin
