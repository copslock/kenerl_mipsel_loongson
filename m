Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 15:36:26 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64921 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022423AbXCWPgZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 15:36:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2NFaMjJ019876;
	Fri, 23 Mar 2007 15:36:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2NFaLYV019875;
	Fri, 23 Mar 2007 15:36:21 GMT
Date:	Fri, 23 Mar 2007 15:36:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Miklos Szeredi <miklos@szeredi.hu>, linux-mips@linux-mips.org,
	Ravi.Pratap@hillcrestlabs.com
Subject: Re: flush_anon_page for MIPS
Message-ID: <20070323153621.GB19477@linux-mips.org>
References: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu> <20070323141939.GB17311@linux-mips.org> <cda58cb80703230801v5ce4baacr9b40119ff3342ac8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80703230801v5ce4baacr9b40119ff3342ac8@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 23, 2007 at 04:01:04PM +0100, Franck Bui-Huu wrote:
> Date:	Fri, 23 Mar 2007 16:01:04 +0100
> From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
> To:	"Ralf Baechle" <ralf@linux-mips.org>
> Subject: Re: flush_anon_page for MIPS
> Cc:	"Miklos Szeredi" <miklos@szeredi.hu>, linux-mips@linux-mips.org,
> 	Ravi.Pratap@hillcrestlabs.com
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> On 3/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> >+#define ARCH_HAS_FLUSH_ANON_PAGE
> >+static inline void flush_anon_page(struct vm_area_struct *vma,
> >+       struct page *page, unsigned long vmaddr)
> >+{
> >+       extern void __flush_anon_page(struct vm_area_struct *vma,
> >+                                     struct page *, unsigned long);
> >+       if (PageAnon(page))
> >+               __flush_anon_page(vma, page, vmaddr);
> >+}
> >+
> 
> Shouldn't you add a test against cpu_has_dc_aliases here and thus
> avoid an useless call to __flush_anon_page() ?

Yes, that's one of the things left to do.  On alias-free processors where
cpu_has_dc_aliases was defined to 0 in cpu-feature-overrides.h this will
result in the entire function call to be eleminated by the compiler.  Of
course that will still leave the unused body of __flush_anon_page around,
how sad ;)

  Ralf
