Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 17:16:50 +0200 (CEST)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:37163 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860175AbaGaPQoF9J2b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 17:16:44 +0200
Received: by mail-wg0-f47.google.com with SMTP id b13so2863441wgh.6
        for <linux-mips@linux-mips.org>; Thu, 31 Jul 2014 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vs8Ua6Xz+iNK1k/h9c4bYIRkChbZ1Ae9e5pBzFN5Rtk=;
        b=IIFvJwdcozN194s8x/3fesmyFFinQnn1lt6RALZ8Cck+Qcl7oFON+F6ZRc7tOpq/87
         AX3EZ0EXi2R4z+P95sSDRzPI4lYHrEtmzoFpSRMlZ6Het+pML+wKyYfsC0bxWQbmiZn0
         ZJ1zglSNp89EyeeE8qYGUYwMXHjViVfclzCCI7c0zPNVjnUXVoOvoPuP7rrhhbBMhS6n
         scXdCdf02l9ErG72f9A1mkPmS3yoJni/8zITGJ40MJjPwpwOsj4QCt/35CNnBUA3O+Po
         GKnp9tJKEABHVN4vH6a3ZQipuPJ4XN1mBteErUunrg7BI7MUsNWj50+TwR/QBRHfH2pa
         azug==
X-Received: by 10.180.38.51 with SMTP id d19mr16973514wik.10.1406819796408;
        Thu, 31 Jul 2014 08:16:36 -0700 (PDT)
Received: from localhost (8.20.196.77.rev.sfr.net. [77.196.20.8])
        by mx.google.com with ESMTPSA id ed14sm67205074wic.10.2014.07.31.08.16.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2014 08:16:35 -0700 (PDT)
Date:   Thu, 31 Jul 2014 17:16:32 +0200
From:   Frederic Weisbecker <fweisbec@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Oleg Nesterov <oleg@redhat.com>,
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
Message-ID: <20140731151630.GA7842@localhost.localdomain>
References: <cover.1406604806.git.luto@amacapital.net>
 <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net>
 <20140729193232.GA8153@redhat.com>
 <20140730164344.GA27954@localhost.localdomain>
 <CALCETrUVaz3JFiNbyU=r3M-E9muHa1ffn7RX+_-4V_0U-hVaPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUVaz3JFiNbyU=r3M-E9muHa1ffn7RX+_-4V_0U-hVaPw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41841
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

On Wed, Jul 30, 2014 at 10:23:34AM -0700, Andy Lutomirski wrote:
> On Wed, Jul 30, 2014 at 9:43 AM, Frederic Weisbecker <fweisbec@gmail.com> wrote:
> > On Tue, Jul 29, 2014 at 09:32:32PM +0200, Oleg Nesterov wrote:
> >> On 07/28, Andy Lutomirski wrote:
> >> >
> >> > @@ -1449,7 +1449,12 @@ long syscall_trace_enter(struct pt_regs *regs)
> >> >  {
> >> >     long ret = 0;
> >> >
> >> > -   user_exit();
> >> > +   /*
> >> > +    * If TIF_NOHZ is set, we are required to call user_exit() before
> >> > +    * doing anything that could touch RCU.
> >> > +    */
> >> > +   if (test_thread_flag(TIF_NOHZ))
> >> > +           user_exit();
> >>
> >> Personally I still think this change just adds more confusion, but I leave
> >> this to you and Frederic.
> >>
> >> It is not that "If TIF_NOHZ is set, we are required to call user_exit()", we
> >> need to call user_exit() just because we enter the kernel. TIF_NOHZ is just
> >> the implementation detail which triggers this slow path.
> >>
> >> At least it should be correct, unless I am confused even more than I think.
> >
> > Agreed, Perhaps the confusion is on the syscall_trace_enter() name which suggests
> > this is only about tracing? syscall_slowpath_enter() could be an alternative.
> > But that's still tracing in a general sense so...
> 
> At the end of the day, the syscall slowpath code calls a bunch of
> functions depending on what TIF_XYZ flags are set.  As long as it's
> structured like "if (TIF_A) do_a(); if (TIF_B) do_b();" or something
> like that, it's comprehensible.  But once random functions with no
> explicit flag checks or comments start showing up, it gets confusing.

Yeah that's a point. I don't mind much the TIF_NOHZ test if you like.

> 
> If it's indeed all-or-nothing, I could remove the check and add a
> comment.  But please keep in mind that, currently, the slow path is
> *slow*, and my patches only improve the entry case.  So enabling
> context tracking on every task will hurt.

That's what we do anyway. I haven't found a safe way to enabled context tracking
without tracking all CPUs.

> 
> --Andy
