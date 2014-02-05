Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2014 07:42:01 +0100 (CET)
Received: from mail-ea0-f170.google.com ([209.85.215.170]:33638 "EHLO
        mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815749AbaBEGl7IsBwd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Feb 2014 07:41:59 +0100
Received: by mail-ea0-f170.google.com with SMTP id k10so4829658eaj.15
        for <linux-mips@linux-mips.org>; Tue, 04 Feb 2014 22:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lJEy8BB61JSx/GNSdlqGCWYe4lF3vBDf7sis+B9vj40=;
        b=pqHwsGJH+PpArlXJdOBWzXMOmhL76W6zT4UvhRrbvILEdjdv8Lek5Y88cCnb/MjhfM
         jG5NFCLm938pEsiIzi8bn4zP8qyNRJk+SBb5TmpEpqbepJEd1j/iGxQJODG3w9GHgRau
         GSt5Ovc/GmMAXHPfCiZTvSFqm+xXMtKpGz2ZB3e5BpbhFsujn941mu2IIUhMi1yJ8F1c
         xZbmT4cyiHR7LJA8aAAVArco+MHipoj91tjuBSSGXnYB4wAJ8RmZ5ROQN9o6dsbwIhxh
         Wodr1lxa+4J7L9EFvWfnoT1QpzDTSSADpNPViNLAPBZHUNrZXh6ACTBsPwYiqZjMfOEy
         KBxg==
X-Received: by 10.15.73.134 with SMTP id h6mr55589178eey.15.1391582513384;
        Tue, 04 Feb 2014 22:41:53 -0800 (PST)
Received: from gmail.com (54033002.catv.pool.telekom.hu. [84.3.48.2])
        by mx.google.com with ESMTPSA id g1sm97714380eet.6.2014.02.04.22.41.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2014 22:41:52 -0800 (PST)
Date:   Wed, 5 Feb 2014 07:41:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rusty@rustcorp.com.au, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
Message-ID: <20140205064150.GA31568@gmail.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
 <20140205060633.GE30094@gmail.com>
 <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ingo,
> 
> On Wed, 5 Feb 2014 07:06:33 +0100 Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > So, if you meant Linus to pull it, you probably want to cite a real 
> > Git URI along the lines of:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> 
> Paul provided the proper git url further down in the mail along with the
> usual pull request message (I guess he should have put that bit at the
> top).

Yeah, indeed, and it even comes with a signed tag, which is an extra 
nice touch:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git tags/init-cleanup

(I guess the https was mentioned first to lower expectations.)

Thanks,

	Ingo
