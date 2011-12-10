Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Dec 2011 01:39:46 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:40373 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903738Ab1LJAjm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Dec 2011 01:39:42 +0100
Received: by ghrr19 with SMTP id r19so3196997ghr.36
        for <linux-mips@linux-mips.org>; Fri, 09 Dec 2011 16:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jWAfHx/dRsRHMMteNCfF82lDJM0BcfUbyIStnJ714LE=;
        b=LOmz/R4/lYxd525l/nYDvBOSjXzK0rUh95kdd6Dmjw2gvgF06sGIGL+J5qq1i9Rxm/
         Q7bX0tjfB78C8uN2ndo7u0rs9Z+9uWwJg1D7NNC/3DFShZHJx0DlMRlHAN7uoe64pGTH
         CY3lVwLCeYcaQbiGHTFm+ivKZDzTNOIJB4JWo=
Received: by 10.236.75.230 with SMTP id z66mr15146399yhd.66.1323477576472;
        Fri, 09 Dec 2011 16:39:36 -0800 (PST)
Received: from bubble.grove.modra.org ([115.187.252.19])
        by mx.google.com with ESMTPS id 37sm3344101anu.21.2011.12.09.16.39.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 16:39:35 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
        id C8D5D170C2BF; Sat, 10 Dec 2011 11:09:28 +1030 (CST)
Date:   Sat, 10 Dec 2011 11:09:28 +1030
From:   Alan Modra <amodra@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     binutils <binutils@sourceware.org>,
        Richard Sandiford <rdsandiford@googlemail.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [Patch v2]: Fix ld pr11138 FAILures on mips*.
Message-ID: <20111210003928.GC2461@bubble.grove.modra.org>
Mail-Followup-To: David Daney <david.daney@cavium.com>,
        binutils <binutils@sourceware.org>,
        Richard Sandiford <rdsandiford@googlemail.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>,
        linux-mips <linux-mips@linux-mips.org>
References: <4EE27012.5030508@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EE27012.5030508@cavium.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 32080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amodra@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8200

On Fri, Dec 09, 2011 at 12:31:14PM -0800, David Daney wrote:
> 	* /elfxx-mips.c (mips_elf_link_hash_table.rld_value): Remove.
> 	(mips_elf_link_hash_table.rld_symbol): New field;
> 	(MIPS_ELF_RLD_MAP_SIZE): New macro.
> 	(_bfd_mips_elf_add_symbol_hook): Remember __rld_obj_head symbol
> 	in rld_symbol.
> 	(_bfd_mips_elf_create_dynamic_sections): Remember __rld_map symbol
> 	in rld_symbol.
> 	(_bfd_mips_elf_size_dynamic_sections): Set correct size for .rld_map.
> 	(_bfd_mips_elf_finish_dynamic_symbol): Remove .rld_map handling.
> 	(_bfd_mips_elf_finish_dynamic_sections): Use rld_symbol to
> 	calculate DT_MIPS_RLD_MAP value.
> 	(_bfd_mips_elf_link_hash_table_create): Initialize rld_symbol,
> 	quit initializing rld_value.

OK.  Remove stray / in ChangeLog entry

> +	  s->size += MIPS_ELF_RLD_MAP_SIZE(output_bfd);

Fix formatting here.

> +		dyn.d_un.d_ptr = s->output_section->vma + s->output_offset
> +				 + h->root.u.def.value;

And it's nice to write code that emacs auto-indent won't change, so
add parentheses

		dyn.d_un.d_ptr = (s->output_section->vma + s->output_offset
				  + h->root.u.def.value);

-- 
Alan Modra
Australia Development Lab, IBM
