Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 19:17:31 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:59594 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860187AbaGaRRYgqT-p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 19:17:24 +0200
Received: by mail-wi0-f182.google.com with SMTP id d1so4416810wiv.9
        for <linux-mips@linux-mips.org>; Thu, 31 Jul 2014 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lj7zHEUsYv15Q1Gcg6WyusSvi0Q1lrUp3sf2UXG9Bns=;
        b=Gm9kj2cAZt5vqQx2ebksI4RUr2Sr8SGFE9NNdnUlQSgDU1D/E+fhFOAo6z4U2BGq+p
         RSKrDpFcRk1ZptYU6DIEFa971QDMgCplGxgp3UiA+ZcEfzYpttqu8YVVsPjuZ+a1kxa2
         zwWW2R8gCsPVDh7oc0LaZ6Aop6Ull3PdEEUfkYvaZpavJUoBgC+AYVnr/BG3L0gkx5JB
         fysDwH4reCjV/JAeQ6g717WfrbXPrevDCV372YbX6EiyX9voXBmXCeWFxMAPzLqnhNsO
         IZK8tnj2qNXEdfl5SCtSeMZOM8OhEMKjXoNAyd/xBp2Zt7jABt1okRbxPhxAl9pifQM8
         3XzA==
X-Received: by 10.180.36.238 with SMTP id t14mr18432193wij.38.1406827038252;
        Thu, 31 Jul 2014 10:17:18 -0700 (PDT)
Received: from localhost (8.20.196.77.rev.sfr.net. [77.196.20.8])
        by mx.google.com with ESMTPSA id pj6sm14699921wjb.21.2014.07.31.10.17.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2014 10:17:17 -0700 (PDT)
Date:   Thu, 31 Jul 2014 19:17:14 +0200
From:   Frederic Weisbecker <fweisbec@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 2/5] x86,entry: Only call user_exit if TIF_NOHZ
Message-ID: <20140731171713.GE7842@localhost.localdomain>
References: <cover.1406604806.git.luto@amacapital.net>
 <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net>
 <20140729193232.GA8153@redhat.com>
 <20140730164344.GA27954@localhost.localdomain>
 <CALCETrUVaz3JFiNbyU=r3M-E9muHa1ffn7RX+_-4V_0U-hVaPw@mail.gmail.com>
 <20140731151630.GA7842@localhost.localdomain>
 <20140731164246.GA15974@redhat.com>
 <20140731164918.GC7842@localhost.localdomain>
 <20140731165423.GA16800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140731165423.GA16800@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
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

On Thu, Jul 31, 2014 at 06:54:23PM +0200, Oleg Nesterov wrote:
> On 07/31, Frederic Weisbecker wrote:
> >
> > On Thu, Jul 31, 2014 at 06:42:46PM +0200, Oleg Nesterov wrote:
> > > On 07/31, Frederic Weisbecker wrote:
> > > >
> > > > On Wed, Jul 30, 2014 at 10:23:34AM -0700, Andy Lutomirski wrote:
> > > > >
> > > > > At the end of the day, the syscall slowpath code calls a bunch of
> > > > > functions depending on what TIF_XYZ flags are set.  As long as it's
> > > > > structured like "if (TIF_A) do_a(); if (TIF_B) do_b();" or something
> > > > > like that, it's comprehensible.  But once random functions with no
> > > > > explicit flag checks or comments start showing up, it gets confusing.
> > > >
> > > > Yeah that's a point. I don't mind much the TIF_NOHZ test if you like.
> > >
> > > And in my opinion
> > >
> > > 	if (work & TIF_XYZ)
> > > 		user_exit();
> > >
> > > looks even more confusing. Because, once again, TIF_XYZ is not the
> > > reason to call user_exit().
> > >
> > > Not to mention this adds a minor performance penalty.
> >
> > That's a point too! You guys both convinced me! ;-)
> 
> Very nice, now I know that you can agree with 2 opposite opinions at
> the same time ;)

That's what an Acked-by from Schroedinger would look like!

> 
> > > > > If it's indeed all-or-nothing, I could remove the check and add a
> > > > > comment.  But please keep in mind that, currently, the slow path is
> > > > > *slow*, and my patches only improve the entry case.  So enabling
> > > > > context tracking on every task will hurt.
> > > >
> > > > That's what we do anyway. I haven't found a safe way to enabled context tracking
> > > > without tracking all CPUs.
> > >
> > > And if we change this, then the code above becomes racy. The state of
> > > TIF_XYZ can be changed right after the check. OK, it is racy anyway ;)
> > > but still this adds more confusion.
> >
> > No because all running tasks have this flag set when context tracking is
> > enabled. And context tracking can't be disabled on runtime.
> 
> Yes, yes, please note that I said "if we change this".

Yeah but the NO_HZ test wouldn't change much the situation I think.
