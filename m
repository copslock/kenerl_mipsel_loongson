Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 01:25:04 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:33945
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994630AbdCNAY5VXEnI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 01:24:57 +0100
Received: by mail-wr0-x243.google.com with SMTP id u48so22071797wrc.1;
        Mon, 13 Mar 2017 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WSkCJ05o0IY201LT96wOxOd6Lialtwh6WrJbdxozHt4=;
        b=bu7XsNV9QJXIYA2Mmup/0yfyM3/CmADewgBAjUWw+lPycygZ3tUf8kKhE5lWzQkOEJ
         ol/+zyapz6qMeIk5U6YNPKd17KdXXbtLbsO4Brglc/+0847e6FyyBot9Sy1mnIj1ZoZq
         3ypzMz4GJAaDTsSgZyN0fhNMyq5qrgvZW3+Rw+IKWahVDug04muj+JbRAHOqM3TrfwtI
         OX1W+KFZ+FJPsNiBirLBoHYcq3d+EmuFfMO/+BU60EU1CEqILuI+FIM8Zm/SyA17UKaS
         DdxU9mSMCUPxtwVYYsnrUTTJr6aqc4RqMCV5J0nHdEPxYO9NUfM2P1Fuecv0AJQeY9Ip
         5mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=WSkCJ05o0IY201LT96wOxOd6Lialtwh6WrJbdxozHt4=;
        b=ZnFwbAROSFV9w8TqHOfmsGtTsglGEcPnkpoWAPGNMNuWGj3/8iYw8l3iF0ibm8+NDI
         JAPWDflDjYBEaMZ7fzsVmPHdUAyT0JzhlIbKpTdnTZ9EEHSh2rDdFArYPSXp2Rocm3DG
         AofPBt75fTlC/9xetvxH5EzA9y7EPnPKLPrywLwCEQetEpAq2rYjgHykmvhTnSRFwARB
         QroYM6mL9L1KxHfB0pKZIxuTqA8woJJ4zqpr5LkynfGA69CQVOtbV3d0f8Zc4RDsdo4G
         4FbHTQo5KBR4zpF1ej0e0rN8bt94goWixjwRqU99d+Vxk7zJuJDLsN8Bf0vXbYV6RR+E
         iN/A==
X-Gm-Message-State: AMke39lz+4IamN6nbCJNSU9jBHPitYaqEggjsH2s7epP+shj6pd23jRprO6mIlBHxf5Lhg==
X-Received: by 10.223.174.131 with SMTP id y3mr30198621wrc.40.1489451091887;
        Mon, 13 Mar 2017 17:24:51 -0700 (PDT)
Received: from localhost (login1.zih.tu-dresden.de. [141.76.16.140])
        by smtp.googlemail.com with ESMTPSA id s26sm26986464wra.66.2017.03.13.17.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Mar 2017 17:24:51 -0700 (PDT)
From:   Till Smejkal <till.smejkal@googlemail.com>
X-Google-Original-From: Till Smejkal <till.smejkal@gmail.com>
Date:   Mon, 13 Mar 2017 17:24:48 -0700
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Till Smejkal <till.smejkal@googlemail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH 10/13] mm: Introduce first class virtual address
 spaces
Message-ID: <20170314002448.hwbxlasbbz3shhlv@arch-dev>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Till Smejkal <till.smejkal@googlemail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313235225.GA15359@kroah.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Return-Path: <till.smejkal@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: till.smejkal@googlemail.com
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

Hi Greg,

First of all thanks for your reply.

On Tue, 14 Mar 2017, Greg Kroah-Hartman wrote:
> On Mon, Mar 13, 2017 at 03:14:12PM -0700, Till Smejkal wrote:
> 
> There's no way with that many cc: lists and people that this is really
> making it through very many people's filters and actually on a mailing
> list.  Please trim them down.

I am sorry that the patch's cc-list is too big. This was the list of people that the
get_maintainers.pl script produced. I already recognized that it was a huge number of
people, but I didn't want to remove anyone from the list because I wasn't sure who
would be interested in this patch set. Do you have any suggestion who to remove from
the list? I don't want to annoy anyone with useless emails.

> Minor sysfs questions/issues:
> 
> > +struct vas {
> > +	struct kobject kobj;		/* < the internal kobject that we use *
> > +					 *   for reference counting and sysfs *
> > +					 *   handling.                        */
> > +
> > +	int id;				/* < ID                               */
> > +	char name[VAS_MAX_NAME_LENGTH];	/* < name                             */
> 
> The kobject has a name, why not use that?

The reason why I don't use the kobject's name is that I don't restrict the names that
are used for VAS/VAS segments. Accordingly, it would be allowed to use a name like
"foo/bar/xyz" as VAS name. However, I am not sure what would happen in the sysfs if I
would use such a name for the kobject. Especially, since one could think of another
VAS with the name "foo/bar" whose name would conflict with the first one although it
not necessarily has any connection with it.

> > +
> > +	struct mutex mtx;		/* < lock for parallel access.        */
> > +
> > +	struct mm_struct *mm;		/* < a partial memory map containing  *
> > +					 *   all mappings of this VAS.        */
> > +
> > +	struct list_head link;		/* < the link in the global VAS list. */
> > +	struct rcu_head rcu;		/* < the RCU helper used for          *
> > +					 *   asynchronous VAS deletion.       */
> > +
> > +	u16 refcount;			/* < how often is the VAS attached.   */
> 
> The kobject has a refcount, use that?  Don't have 2 refcounts in the
> same structure, that way lies madness.  And bugs, lots of bugs...
> 
> And if this really is a refcount (hint, I don't think it is), you should
> use the refcount_t type.

I actually use both the internal kobject refcount to keep track of how often a
VAS/VAS segment is referenced and this 'refcount' variable to keep track how often
the VAS is actually attached to a task. They not necessarily must be related to each
other. I can rename this variable to attach_count. Or if preferred I can
alternatively only use the kobject reference counter and remove this variable
completely though I would loose information about how often the VAS is attached to a
task because the kobject reference counter is also used to keep track of other
variables referencing the VAS.

> > +/**
> > + * The sysfs structure we need to handle attributes of a VAS.
> > + **/
> > +struct vas_sysfs_attr {
> > +	struct attribute attr;
> > +	ssize_t (*show)(struct vas *vas, struct vas_sysfs_attr *vsattr,
> > +			char *buf);
> > +	ssize_t (*store)(struct vas *vas, struct vas_sysfs_attr *vsattr,
> > +			 const char *buf, size_t count);
> > +};
> > +
> > +#define VAS_SYSFS_ATTR(NAME, MODE, SHOW, STORE)				\
> > +static struct vas_sysfs_attr vas_sysfs_attr_##NAME =			\
> > +	__ATTR(NAME, MODE, SHOW, STORE)
> 
> __ATTR_RO and __ATTR_RW should work better for you.  If you really need
> this.

Thank you. I will have a look at these functions.

> Oh, and where is the Documentation/ABI/ updates to try to describe the
> sysfs structure and files?  Did I miss that in the series?

Oh sorry, I forgot to add this file. I will add the ABI descriptions for future
submissions.

> > +static ssize_t __show_vas_name(struct vas *vas, struct vas_sysfs_attr *vsattr,
> > +			       char *buf)
> > +{
> > +	return scnprintf(buf, PAGE_SIZE, "%s", vas->name);
> 
> It's a page size, just use sprintf() and be done with it.  No need to
> ever check, you "know" it will be correct.

OK. I was following the sysfs example in the documentation that used scnprintf, but
if sprintf is preferred, I can change this.

> Also, what about a trailing '\n' for these attributes?

I will change this.

> Oh wait, why have a name when the kobject name is already there in the
> directory itself?  Do you really need this?

See above.

> > +/**
> > + * The ktype data structure representing a VAS.
> > + **/
> > +static struct kobj_type vas_ktype = {
> > +	.sysfs_ops = &vas_sysfs_ops,
> > +	.release = __vas_release,
> 
> Why the odd __vas* naming?  What's wrong with vas_release?

I was using the __* naming scheme for functions that have no other meaning outside of
my source file. But I can change this if people don't like it. I have no strong
feelings about the names of the functions.

> > +	.default_attrs = vas_default_attr,
> > +};
> > +
> > +
> > +/***
> > + * Internally visible functions
> > + ***/
> > +
> > +/**
> > + * Working with the global VAS list.
> > + **/
> > +static inline void vas_remove(struct vas *vas)
> 
> <snip>
> 
> You have a ton of inline functions, for no good reason.  Make them all
> "real" functions please.  Unless you can measure the size/speed
> differences?  If so, please say so.

There was no specific reason why I declared the functions as inline except my hope to
reduce the function call for some of my very small functions. I can look more closely
at this and check whether there is some real benefit in inlining them and if not
remove it.

Thank you very much.

Till
