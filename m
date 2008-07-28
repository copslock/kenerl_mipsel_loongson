Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 20:44:03 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:48055 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023977AbYG1Tn4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Jul 2008 20:43:56 +0100
Received: by nf-out-0910.google.com with SMTP id h3so1359430nfh.14
        for <linux-mips@linux-mips.org>; Mon, 28 Jul 2008 12:43:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=kwVIL25OJMSQYz+KLDmk/F25k1dFKiS7O76KNbPW10E=;
        b=PM+tQ9g5Tn8tCFm2c2neNOAHM61aU28ZMM45ItrFLdExJ1qzD6OZhR4SwqNE9H56sI
         6TSiKsLZ31aQH6oofVKJLoZag6Aui/E+JUuN3uHfzaRl/ksvKK5iJxUN3GqGvoSxSpy4
         1CkuSsIOuolehC8JcNQBTfAPLHDQ8yQOEA9KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=PytMWicl91capWlwNDcC72GbyaYpx2Px0k2H+pifCj0ucb4s66xnfhSVQEIJB1Puic
         YQs2RF40FudHNS5Bj5Ru29mwZOtVJKi6vrPjHi9njp1EGBYEdKXavezy0pXS8aHAn9ts
         qG54Hzvn4PBr4MzuUGjI2jsHasFxgAMCqto68=
Received: by 10.210.39.20 with SMTP id m20mr6409701ebm.126.1217274235828;
        Mon, 28 Jul 2008 12:43:55 -0700 (PDT)
Received: from localhost ( [79.67.114.192])
        by mx.google.com with ESMTPS id g9sm706009gvc.0.2008.07.28.12.43.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jul 2008 12:43:54 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	Mark Mitchell <mark@codesourcery.com>
Mail-Followup-To: Mark Mitchell <mark@codesourcery.com>,binutils@sourceware.org,  gcc@gcc.gnu.org,  linux-mips@linux-mips.org, rdsandiford@googlemail.com
Cc:	binutils@sourceware.org, gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home>
	<20080724161619.GA18842@caradoc.them.org>
	<87y73nelq8.fsf@firetop.home> <488CEA74.4060505@codesourcery.com>
Date:	Mon, 28 Jul 2008 20:43:49 +0100
In-Reply-To: <488CEA74.4060505@codesourcery.com> (Mark Mitchell's message of
	"Sun\, 27 Jul 2008 14\:36\:52 -0700")
Message-ID: <87bq0h23re.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Mark Mitchell <mark@codesourcery.com> writes:
> Richard Sandiford wrote:
>> Daniel Jacobowitz <dan@debian.org> writes:
>>> All comments welcome - Richard, especially from you.  How would you
>>> like to proceed?  I think the first step should be to get your other
>>> binutils/gcc patches merged, including MIPS16 PIC; I used those as a
>>> base.  But see a few of the notes for potential problems with those
>>> patches.
>> 
>> Yeah, Nick's approved most of the remaining binutils changes (thanks).
>> I haven't applied them yet because of the doubt over whether st_size
>> should be even or odd for ISA-encoded MIPS16 symbols.  I don't really
>> have an opinion, so I'll accept a maintainerly decision...
>
> [I'm not sure if this is a helpful suggestion or not, so feel free to 
> ignore it if it's not.]
>
> I would suggest that st_size be the actual size of the function, as it 
> lives in memory.  A test of it's start/end location is "could I stick a 
> random data byte there and have it affect the function".  For example, 
> for a Thumb function whose ISA address is "0x00000001", I would consider 
> for size purposes that it starts at "0x00000000", since altering that 
> byte at run-time would change the meaning of the function.

For the record, my reasoning when picking the odd st_size was similar,
but with the opposite outcome.  The point of using an ISA-encoded
st_value is that that's what most users want.  Most of them won't
even have code to say "is this a MIPS16 symbol?".

So if users are going to get into the habit of using MIPS st_values
without checking the "ISA bit", I thought it was more conservative to
base the end address on the unmodified st_value rather than the modified
one.  In other words, I thought it was more conservative to have
"st_value + st_size" be the end point of the function, rather than
"(st_value & ~1) + st_size".  This ensures that "st_value" and
"st_value + st_size - 1" are bytes in the function, rather than making
"st_value + st_size" be two bytes past the end of the function (and thus
making "st_value + st_size - 1" refer to something outside the function).

But like I say, I can see there are pros and cons both ways, so I don't
really have an opinion.  I'm happy to (and do) accpet Dan's decision.
And I guess the ARM experience shows that my concern isn't really an
issue in practice anyway.

Richard
