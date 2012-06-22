Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2012 13:06:42 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:39152 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903679Ab2FVLGg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jun 2012 13:06:36 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5MB6MS9019669;
        Fri, 22 Jun 2012 12:06:22 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5MB6JEH019668;
        Fri, 22 Jun 2012 12:06:19 +0100
Date:   Fri, 22 Jun 2012 12:06:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnaud Patard <arnaud.patard@rtp-net.org>
Cc:     Huacai Chen <chenhuacai@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH V3 11/16] drm/radeon: Make radeon card usable for
 Loongson.
Message-ID: <20120622110619.GA18249@linux-mips.org>
References: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
 <1340334073-17804-12-git-send-email-chenhc@lemote.com>
 <87txy3sn20.fsf@lebrac.rtp-net.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87txy3sn20.fsf@lebrac.rtp-net.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Jun 22, 2012 at 11:39:19AM +0200, Arnaud Patard wrote:

> > --- a/drivers/gpu/drm/drm_vm.c
> > +++ b/drivers/gpu/drm/drm_vm.c
> > @@ -62,7 +62,7 @@ static pgprot_t drm_io_prot(uint32_t map_type, struct vm_area_struct *vma)
> >  		tmp = pgprot_writecombine(tmp);
> >  	else
> >  		tmp = pgprot_noncached(tmp);
> > -#elif defined(__sparc__) || defined(__arm__)
> > +#elif defined(__sparc__) || defined(__arm__) || defined(__mips__)
> >  	tmp = pgprot_noncached(tmp);
> 
> btw, would it be a good idea to use uncached accelerated instead ?

Not unconditionally.  Only some MIPS cores support uncached accelerated.
Basically you can only assume that cache modes 2 (uncached) (3 cachable
non-coherent) are supported.  On a SMP system use of 2 and 3 may be
unwise (SGI IP27 and IP35 may throw obscure exceptions to indicate their
dislike of these.) and on multi-processor systems there is mode 5, which
is cachable coherent.

The necessary logic is too complex to got into drm_io_prot() which already
is an #ifdef mess anyway so that function should be changed to call some
sort of architecutre specific hook so that function should be changed to
call some sort of architecture specific hook...

  Ralf
