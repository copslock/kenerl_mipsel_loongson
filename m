Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2008 11:34:52 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:17395 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22973866AbYKBLem (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 2 Nov 2008 11:34:42 +0000
Received: by nf-out-0910.google.com with SMTP id h3so219565nfh.14
        for <multiple recipients>; Sun, 02 Nov 2008 03:34:41 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=uOlD5APufZsmfpTO9+Zk6rH/M+o+oYYVJh53PN1rl9w=;
        b=NGfYfu0D2iEubRQkk77jafV2wNMoizoQGPphtl6AX76av1YTVjmBZ7zA7GWmpztBEK
         Sc9XE3mb7cD2FwOLkRFZrMAN93t8yODgIfvl/8XZY8flLq5OAOJDDnqdED/FFuoBGD9A
         9q5ee8XQs1qRrJWsiiK4woqvct+Zyq3QgT61I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=T3G+/wqJMavvC9jcnr7xJ6oVROAAGSgA2vUbcjpnmUAJsEh/JzQowsWtRppg0iBOoF
         Rbl4GzCgpz1gnUlCH6bLIepNLmnSIhOo48HOppSuFpE+hDRs17Sl9t97uO9+7Zd1zNYA
         FYsDqVMH5RVaDeyPRxz+IxWz9GafO0+dwNcz4=
Received: by 10.210.105.20 with SMTP id d20mr2625774ebc.84.1225625681200;
        Sun, 02 Nov 2008 03:34:41 -0800 (PST)
Received: from localhost (79-67-45-8.dynamic.dsl.as9105.com [79.67.45.8])
        by mx.google.com with ESMTPS id y37sm2972965iky.8.2008.11.02.03.34.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 03:34:40 -0800 (PST)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,Kumba <kumba@gentoo.org>,  gcc-patches@gcc.gnu.org,  Linux MIPS List <linux-mips@linux-mips.org>, rdsandiford@googlemail.com
Cc:	Kumba <kumba@gentoo.org>, gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>
	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>
	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>
	<alpine.LFD.1.10.0811021036330.20461@ftp.linux-mips.org>
Date:	Sun, 02 Nov 2008 11:34:37 +0000
In-Reply-To: <alpine.LFD.1.10.0811021036330.20461@ftp.linux-mips.org> (Maciej
	W. Rozycki's message of "Sun\, 2 Nov 2008 10\:49\:45 +0000 \(GMT\)")
Message-ID: <87ljw2gy42.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
> On Sat, 1 Nov 2008, Kumba wrote:
>> The branch-likely stuff is only going to work for MIPS-II or higher targets.
>> In the odd (but possible) cases where MIPS-I might be used with -mfix-r10000,
>> I assume we'll still have to emit 28 nops prior to a beq/beqz instruction.  Is
>> this already taken care of someplace?
>
>  MIPS I does not support LL/SC, so that case is not to be concerned.  
> These instructions are emulated on such processors and as such can appear 
> in assembly snippets, but GCC is expected not to emit them itself (I hope 
> it hasn't changed; if it has, then we are in trouble -- I suppose a 
> compiler error is justified for such an odd case).

Not quite true.  Use of LL and SC is controlled by a separate option,
-mllsc.  As you'd expect, this option is on by default if the architecture
provides LL and SC.  It's therefore on by default for generic MIPS II
and above, and for -march=<cpu> if <cpu> provides the instructions.

However, the default for other architectures depends on the configuration.
If the configured target is known to emulate the LL and SC instructions
(as Linux targets are), the default is -mllsc.  It is -mno-llsc otherwise.

>> Hmm, okay.  Might this work to enable -mbranch-likely if -mfix-r10000?  (Kind
>> of guessing by looking at other segments of code).
>> 
>>   if ((target_flags_explicit & MASK_BRANCHLIKELY) == 0)
>>     {
>>       if (ISA_HAS_BRANCHLIKELY
>>           && (optimize_size
>>               || (!(target_flags_explicit & MASK_FIX_R10000) == 0)
>>               || (mips_tune_info->tune_flags & PTF_AVOID_BRANCHLIKELY) == 0))
>>         target_flags |= MASK_BRANCHLIKELY;
>>       else
>>         target_flags &= ~MASK_BRANCHLIKELY;
>>     }
>> 
>> 
>> 
>> My understanding so far for -mfix-r10000:
>> - Gets enabled if -march=r10000 is passed (done)
>> - Enable -mbranch-likely if not already enabled on >= MIPS-II (working on)
>> - Emits beqzl in the asm templates if enabled and >= MIPS-II (unsure)
>> - Emits 28 nops prior to beq/beqz if enabled and == MIPS-I (unsure)
>> - Ditto for asm templates (unsure)
>> - Documentation (not done)
>
>  I think the best option is to leave -mbranch-likely intact and bail out 
> if -mfix-r10000 and -mno-branch-likely are passed at the same time.  
> Anything else is likely to cause confusion.  Then -march=r10000 should 
> enable both -mfix-r10000 and -mbranch-likely.
>
>  I believe (but have not checked) that all CPUs/ISAs that are within the 
> MIPS II - MIPS IV range enable -mbranch-likely by default, so there is no 
> problem here unless somebody requests -mno-branch-likely in which case 
> they get what they asked for (i.e. a compiler error).  I believe all MIPS 
> architecture CPUs/ISAs disable -mbranch-likely by default, but such code 
> cannot run on the R10k anyway.
>
>  I think it covers all cases.  Comments?

For avoidance of doubt, this is exactly option #1 in my messages.
As you say, -march=r10000 already implies -mbranch-likely unless
explicitly overridden.

Richard
