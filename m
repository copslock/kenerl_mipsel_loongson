Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 17:41:48 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.184]:46211 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22924855AbYKARlk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Nov 2008 17:41:40 +0000
Received: by nf-out-0910.google.com with SMTP id h3so153715nfh.14
        for <linux-mips@linux-mips.org>; Sat, 01 Nov 2008 10:41:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=7ukXR8OVOckUiENM3ccYv+2tSTaUC+BTCGjwUT9tAbM=;
        b=PqbWDGhaNNqbEKrHTOyOGnqWItaeFvMWltdq8G5x9o5OPs/ujMbkxJAa5Ypm+kYNQi
         qSCh2C7n/sXpGT/8ABYCbxq0uF1bDHNvUUFj2ReYh/nRxtjln+tEuNBCSB8IDNYImvxB
         Xdbgv9qvgSTqaSDNA4rhhaB+sD5BSN4U3Fvnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=VIjIGPOKxXHRReenwH77Fj9fA7slyW/IOzBGeIlgLIIlvvly/OLvqV6uwQD4fRU1go
         MMU7JC7+H4PmZeq//YbY4IkV0EDE/Boz+Uhi2T8nZL8QuhgXYPR13VyuznLEyiBoN7FJ
         1STWjWYfCfV/s4mOtmkWU5kUz1ovSZZCa6lS0=
Received: by 10.210.22.8 with SMTP id 8mr15266089ebv.46.1225561297467;
        Sat, 01 Nov 2008 10:41:37 -0700 (PDT)
Received: from localhost (79-67-45-8.dynamic.dsl.as9105.com [79.67.45.8])
        by mx.google.com with ESMTPS id z37sm4202649ikz.4.2008.11.01.10.41.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Nov 2008 10:41:36 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	Kumba <kumba@gentoo.org>
Mail-Followup-To: Kumba <kumba@gentoo.org>,gcc-patches@gcc.gnu.org,  Linux MIPS List <linux-mips@linux-mips.org>, rdsandiford@googlemail.com
Cc:	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>
Date:	Sat, 01 Nov 2008 17:41:30 +0000
In-Reply-To: <490C05A9.9070707@gentoo.org> (kumba@gentoo.org's message of
	"Sat\, 01 Nov 2008 03\:30\:49 -0400")
Message-ID: <87abcjibsl.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Kumba <kumba@gentoo.org> writes:
> Kumba wrote:
>> The attached patch adds a workaround to have gcc emit branch likely 
>> instructions (beqzl) in atomic operations for R10000 CPUs.  This is 
>> because revisions of this CPU before 3.0 misbehave, while revisions 2.6 
>> and earlier will deadlock.  This issue has been noted on SGI IP28 
>> (Indigo2 Impact R10000) systems and SGI IP27 Origin systems.
>> 
>> After creating a patch to glibc based off of Debian Bug #462112 
>> (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=462112), it was 
>> suggested by David Daney that a similar patch be created for GCC.
>> 
>> Feedback would be welcome on any suggestions for improving this patch 
>> (please CC, as I'm not subscribed to the ML).
>> 
>> Thanks!
>
> Oops, typo in my first patch.  Stray parenthesis around the macro
> check.  Fixed patch is included.
>
> I'm wondering whether this should be limited to _MIPS_ARCH_R10000,
> though.  Maybe _MIPS_ARCH_MIPS4 instead, because the R10000 is at
> minimum, a MIPS-IV CPU, and there might be cases where a userland
> compiled with -march=mips4 could get used instead of one optimized for
> -march=r10000?
>
> Or would MIPS-II be better, which is when the branch likely
> instruction was added?

As Maciej said, this should really be controlled by an -mfix-r10000
command-line option, not by the _MIPS_ARCH_* macro.  (In this context,
_MIPS_ARCH_* is a property of the compiler that you're using to build
gcc itself.)

There are two ways we could handle this:

  - Make -mfix-r10000 require -mbranch-likely.  (It mustn't _imply_
    -mbranch-likely.  It should simply check that -mbranch-likely is
    already in effect.)

  - Make -mfix-r10000 insert nops when -mbranch-likely is not in effect.

Richard
