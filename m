Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2014 07:06:45 +0100 (CET)
Received: from mail-ee0-f44.google.com ([74.125.83.44]:35942 "EHLO
        mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816856AbaBEGGlw0tur (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Feb 2014 07:06:41 +0100
Received: by mail-ee0-f44.google.com with SMTP id c13so4690852eek.17
        for <linux-mips@linux-mips.org>; Tue, 04 Feb 2014 22:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TFBFVdOsk93c/ilJnYiqirZ95SDSxmnCR5coqv+LwDw=;
        b=BVQM0CGt6nDrfNLfQvVYTT4YraYmu6x4zrpp6Dutl7clYw/nnwmOOPzyPfypN7LevZ
         o23wLiA3gvLYYFnGhjU6SH7P3y6bgBJZeBpuxlKUvxwBWcEqdVG/TcHJitrRDJX1LFYK
         1H4VuKq1MH/i8YqkLS86Wwkv4ylg48KxzD5XI07upxUmP/sbmNSFDobSZrVclDuqYGX3
         Ozmz48MqHjUn32O46pZsYpurMSU8+Mld6TAdRWiUnGD9NrVVC7zVMttXSHrc2inbXMeh
         xEX7KE+RnxDpvxbJDQHo+1DZPf4yeY7zsQ8AZ10bULrf5DbmM8e0+aRPsnIh5IJX6ykS
         ES9A==
X-Received: by 10.15.102.78 with SMTP id bq54mr741329eeb.94.1391580395929;
        Tue, 04 Feb 2014 22:06:35 -0800 (PST)
Received: from gmail.com (54033002.catv.pool.telekom.hu. [84.3.48.2])
        by mx.google.com with ESMTPSA id x6sm21257179eew.20.2014.02.04.22.06.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2014 22:06:35 -0800 (PST)
Date:   Wed, 5 Feb 2014 07:06:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        gregkh@linuxfoundation.org, rusty@rustcorp.com.au,
        linux-arch@vger.kernel.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
Message-ID: <20140205060633.GE30094@gmail.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39216
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


* Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> On Feb 4, 2014 3:52 PM, "Paul Gortmaker" <paul.gortmaker@windriver.com>
> wrote:
> >
> > We've had this in linux-next for 2+ weeks (thanks Stephen!) as a
> > linux-stable like queue of patches, and as can be seen here:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> 
> Argh, above link is meant for cloning, not viewing.
> 
> This should be better...
> 
> https://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/

So, if you meant Linus to pull it, you probably want to cite a real 
Git URI along the lines of:

   git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git

( Otherwise your pull request might be ignored or worse, you might get
  an honest reply, due to the https transport being considered evil
  that no free man outside of corporate firewalls should ever consider
  and all that. )

Nice cleanups btw.

Thanks,

	Ingo
