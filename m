Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 18:43:58 +0200 (CEST)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:44221 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860092AbaG3Qnz4hdPN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 18:43:55 +0200
Received: by mail-wi0-f173.google.com with SMTP id f8so7889035wiw.6
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2014 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=r+08Jlp4ivkiAlM9zRnvwtNpTXAySKAlJ8WCD1pYorE=;
        b=BykbbyN09eyrvOKxDTYBxPvwgGPgPRxRnZhdvrsU2W1OapwnpMhz2WPHsQFtQInZkx
         g5DAYVPV/Ru8UocrRTvsks762zFUVBoGkxCod76Y7VlD4Mhnu2+bcFEQTCRNG6piB7uz
         yT65Y06PsAUOoV76b1pVNPyOBpXGyqBxqS8N33Dic/SB4jfkv/hf3un0HO/T4uZkqvBI
         rFV1fs2dcQabr9RAQPupo4zbwtl/MCyXOmCzusDC2q3k098fFnww7kbgW9FLwVh5GGfT
         y+5GzOfG/LQcLbvtK2VR41omsmeqwK5S8qX6n/o5PLVU5w3nMhE+GOVPOG+rsBkBhJrt
         HQrA==
X-Received: by 10.194.191.131 with SMTP id gy3mr8172412wjc.108.1406738630605;
        Wed, 30 Jul 2014 09:43:50 -0700 (PDT)
Received: from localhost (8.20.196.77.rev.sfr.net. [77.196.20.8])
        by mx.google.com with ESMTPSA id es9sm6740558wjd.1.2014.07.30.09.43.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jul 2014 09:43:49 -0700 (PDT)
Date:   Wed, 30 Jul 2014 18:43:46 +0200
From:   Frederic Weisbecker <fweisbec@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com
Subject: Re: [PATCH v4 2/5] x86,entry: Only call user_exit if TIF_NOHZ
Message-ID: <20140730164344.GA27954@localhost.localdomain>
References: <cover.1406604806.git.luto@amacapital.net>
 <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net>
 <20140729193232.GA8153@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140729193232.GA8153@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41811
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

On Tue, Jul 29, 2014 at 09:32:32PM +0200, Oleg Nesterov wrote:
> On 07/28, Andy Lutomirski wrote:
> >
> > @@ -1449,7 +1449,12 @@ long syscall_trace_enter(struct pt_regs *regs)
> >  {
> >  	long ret = 0;
> >  
> > -	user_exit();
> > +	/*
> > +	 * If TIF_NOHZ is set, we are required to call user_exit() before
> > +	 * doing anything that could touch RCU.
> > +	 */
> > +	if (test_thread_flag(TIF_NOHZ))
> > +		user_exit();
> 
> Personally I still think this change just adds more confusion, but I leave
> this to you and Frederic.
> 
> It is not that "If TIF_NOHZ is set, we are required to call user_exit()", we
> need to call user_exit() just because we enter the kernel. TIF_NOHZ is just
> the implementation detail which triggers this slow path.
> 
> At least it should be correct, unless I am confused even more than I think.

Agreed, Perhaps the confusion is on the syscall_trace_enter() name which suggests
this is only about tracing? syscall_slowpath_enter() could be an alternative.
But that's still tracing in a general sense so...
