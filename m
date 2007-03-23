Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 15:02:07 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.168]:30239 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022407AbXCWPCF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 15:02:05 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1149199uga
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2007 08:01:05 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IYsDgLeOl7CARUzMrIMWPb459IiAIdI1keQNU9oEyZkYw7cseQqhEJDrQOuEpUDC2esMip8nea9PoUkelYf5DZ9tlQpD67mieAmY5zPmPFrw5cvD5q/TeDgsAtldedwp8WCJXrIhZdALIjA5mFtXsaB87t0qecLMO9BGbEkr2uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q7qjNgM6FAyG0kxOfyzTYwA6nWdNKyukgGiV9Y09i/xI+HV8Ob6oeG5D6aUeh00m/9ewUnxf7VbbLw2LwyeMZqwgcfK1GHsJJhFk0syZ76oEtInZNPkMb+tZZiwC1avGf5LIfNydnqystv6P7gbU6gDrlmB2qv/2LQeUhs0zihQ=
Received: by 10.114.95.1 with SMTP id s1mr1223086wab.1174662064599;
        Fri, 23 Mar 2007 08:01:04 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Fri, 23 Mar 2007 08:01:04 -0700 (PDT)
Message-ID: <cda58cb80703230801v5ce4baacr9b40119ff3342ac8@mail.gmail.com>
Date:	Fri, 23 Mar 2007 16:01:04 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: flush_anon_page for MIPS
Cc:	"Miklos Szeredi" <miklos@szeredi.hu>, linux-mips@linux-mips.org,
	Ravi.Pratap@hillcrestlabs.com
In-Reply-To: <20070323141939.GB17311@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu>
	 <20070323141939.GB17311@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> +#define ARCH_HAS_FLUSH_ANON_PAGE
> +static inline void flush_anon_page(struct vm_area_struct *vma,
> +       struct page *page, unsigned long vmaddr)
> +{
> +       extern void __flush_anon_page(struct vm_area_struct *vma,
> +                                     struct page *, unsigned long);
> +       if (PageAnon(page))
> +               __flush_anon_page(vma, page, vmaddr);
> +}
> +

Shouldn't you add a test against cpu_has_dc_aliases here and thus
avoid an useless call to __flush_anon_page() ?

-- 
               Franck
