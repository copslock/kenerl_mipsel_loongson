Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 14:15:49 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34774 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992196AbcLSNPlCXvgc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 14:15:41 +0100
Received: by mail-lf0-f66.google.com with SMTP id 30so5948056lfy.1;
        Mon, 19 Dec 2016 05:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e8L6vxfynzXNtl1HOO3JdIX6ISmG01egA4lgMm2dLPU=;
        b=shuXAXlPfYaadESW1ToT7aptFZGMF9cPaqX5vFXCq8MVWbceqmO66PlGbpRACqjlhh
         8YB0AY9wetvgUr9OBqFhIeHYu+CV+k+02NsIlLCdK+PqpsMLdxN1AVyGc4Izv+skdiQj
         e5LE0RfXFBXEBcV6rDHSHwP0IhF1l/qxaWpAxU1EhPVoOpfp0Am3kogtxpbH4vi8TjKq
         QVq8GDtxV96fn0WUNxz5JJ5+/4kopHjHHu3moe5d2sYum4NXv7UbWj7ejs2vD8/Z24Z3
         K3Zu5fNgvOjzkZ4U89LHjoNHWW8d+1ZCQT6HyYK2rXaS6UcBhAbGNo8d+elQohsmrwKo
         TpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e8L6vxfynzXNtl1HOO3JdIX6ISmG01egA4lgMm2dLPU=;
        b=nih+I1ViMYfj9/KGzZChonfnSKJeJizOL4TiMz3YeMtKj6ug9ReJBd8YonSvFpmAZi
         ky4HOvtQpBkei54J2AkFpXifmwtwBkW7esjgF720n5xlWoZuF+qdbCh/Wg0xUBQt5JG5
         R8BZrBM2TMd476BPo6FuUT81Ofe/vSKamOF5Drj4lsxW1BLtRDHupvgC8Iyqp3vYFsPy
         S80d/rFdDMY1VHcnmczl5WwUvM8poVXtIamfpE87abku+PbOe/hL06U581Dd5ait3FoV
         EB1e9Ijc5P/GxHmryxg0tJC5XZqlHY/VJjbYdH0PuXBYYcl5eNjfSShpTyzekoumSPpd
         ylfg==
X-Gm-Message-State: AKaTC03mQGptipUIy3brEQoU0vXQZF+nsIZThXMJ2cTbdzPiibZuny5Nf44Fd7RJU4tzHw==
X-Received: by 10.25.133.11 with SMTP id h11mr5260345lfd.135.1482153335058;
        Mon, 19 Dec 2016 05:15:35 -0800 (PST)
Received: from mobilestation ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id f31sm3763502lfi.43.2016.12.19.05.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Dec 2016 05:15:34 -0800 (PST)
Date:   Mon, 19 Dec 2016 16:15:39 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>, ralf@linux-mips.org,
        paul.burton@imgtec.com, rabinv@axis.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/21] MIPS memblock: Add print out method of kernel
 virtual memory layout
Message-ID: <20161219131539.GA2101@mobilestation>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <1482113266-13207-20-git-send-email-fancer.lancer@gmail.com>
 <db27f41e-4121-bb83-6533-6727c26b9c5b@imgtec.com>
 <20161219130236.GJ27950@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161219130236.GJ27950@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

On Mon, Dec 19, 2016 at 01:02:37PM +0000, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Matt,
> 
> On Mon, Dec 19, 2016 at 12:04:54PM +0000, Matt Redfearn wrote:
> > On 19/12/16 02:07, Serge Semin wrote:
> > > It's useful to have some printed map of the kernel virtual memory,
> > > at least for debugging purpose.
> > >
> > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > ---
> 
> > > @@ -106,6 +107,49 @@ static void __init zone_sizes_init(void)
> > >   }
> > >   
> > >   /*
> > > + * Print out kernel memory layout
> > > + */
> > > +#define MLK(b, t) b, t, ((t) - (b)) >> 10
> > > +#define MLM(b, t) b, t, ((t) - (b)) >> 20
> > > +#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
> > > +static void __init mem_print_kmap_info(void)
> > > +{
> > > +	pr_notice("Virtual kernel memory layout:\n"
> > > +		  "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> > > +		  "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> > > +#ifdef CONFIG_HIGHMEM
> > > +		  "    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> > > +#endif
> > > +		  "    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> > > +		  "      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
> > > +		  "      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
> > > +		  "      .init : 0x%p" " - 0x%p" "   (%4td kB)\n",
> > > +		MLM(PAGE_OFFSET, (unsigned long)high_memory),
> > > +		MLM(VMALLOC_START, VMALLOC_END),
> > > +#ifdef CONFIG_HIGHMEM
> > > +		MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
> > > +#endif
> > > +		MLK(FIXADDR_START, FIXADDR_TOP),
> > > +		MLK_ROUNDUP(_text, _etext),
> > > +		MLK_ROUNDUP(_sdata, _edata),
> > > +		MLK_ROUNDUP(__init_begin, __init_end));
> > 
> > Please drop printing the kernel addresses, or at least only do it if 
> > KASLR is not turned on, otherwise you're removing the advantage of 
> > KASLR, that critical kernel addresses cannot be determined easily from 
> > userspace.
> 
> According to Documentation/printk-formats.txt, this is what %pK is for.
> Better to use that instead?
> 
> Cheers
> James
> 

The function is called from the kernel directly, which is privileged
enough to do the printing. So I suppose Matt is right, to hide this
prints out unless debug is enabled.

Thanks,
-Sergey

> > 
> > It may be better to merge the functionality of show_kernel_relocation
> > http://lxr.free-electrons.com/source/arch/mips/kernel/relocate.c#L354
> > into this function, but only print it under the same conditions as 
> > currently, i.e.
> > #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
> > http://lxr.free-electrons.com/source/arch/mips/kernel/setup.c#L530
> > 
> > Thanks,
> > Matt
