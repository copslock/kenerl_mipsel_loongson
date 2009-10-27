Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2009 22:20:52 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:49384 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493196AbZJ0VUq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2009 22:20:46 +0100
Received: by ewy12 with SMTP id 12so169602ewy.0
        for <multiple recipients>; Tue, 27 Oct 2009 14:20:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:to:mail-followup-to:cc
         :subject:references:from:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=veKP7df0u1D8wMsaZ7ZvNhfFW+2F4qhQ8J1snKccx1Y=;
        b=m2rXMOiF1ngDOIx6wX5QMb1RNRlNEQ9Rbx2BTKre6ZOfTNA/rqo0q6NkaBEQFkiIOr
         HkP5f/zhUr0FCd5eenr4atnmD4589L87YFQ9upa9xuYeWIZOmci7nMH7ALDbYdeB97/u
         lLOgDKk3kE8HMgH7NCz+PY/JoK45T3INgcjME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=to:mail-followup-to:cc:subject:references:from:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=waKaCU2OidJ4FaUP9u955VUwaF8RSfXl6CQWUlWYOO8CwKM33xs54m3zTk3UEL6azI
         vAadc++kd3Iw6clKMXVRwGBWPXxrKKo5Vq6y4sPb/aQcV1YyO58rSloJ6bQ0hi0QqRC7
         8mjKhEtvK/P/DnuBTYDSVOTX0JRQrA6C+8v9s=
Received: by 10.211.144.7 with SMTP id w7mr3728703ebn.90.1256678440721;
        Tue, 27 Oct 2009 14:20:40 -0700 (PDT)
Received: from localhost (rsandifo.gotadsl.co.uk [82.133.89.107])
        by mx.google.com with ESMTPS id 28sm67875eye.23.2009.10.27.14.20.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 14:20:39 -0700 (PDT)
To:	David Daney <ddaney@caviumnetworks.com>
Mail-Followup-To: David Daney <ddaney@caviumnetworks.com>,GCC Patches <gcc-patches@gcc.gnu.org>,  linux-mips@linux-mips.org, wuzhangjin@gmail.com,  Adam Nemet <anemet@caviumnetworks.com>, rostedt@goodmis.org,  Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Nicholas Mc Guire <der.herr@hofr.at>, rdsandiford@googlemail.com
Cc:	GCC Patches <gcc-patches@gcc.gnu.org>, linux-mips@linux-mips.org,
	wuzhangjin@gmail.com, Adam Nemet <anemet@caviumnetworks.com>,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] MIPS: Add option to pass return address location to _mcount.
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	<2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	<3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	<ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	<1256138686.18347.3039.camel@gandalf.stny.rr.com>
	<1256233679.23653.7.camel@falcon>
	<4AE0A5BE.8000601@caviumnetworks.com> <87y6n36plp.fsf@firetop.home>
	<4AE232AD.4050308@caviumnetworks.com> <87my3htau1.fsf@firetop.home>
	<4AE5F392.5020405@caviumnetworks.com>
From:	Richard Sandiford <rdsandiford@googlemail.com>
Date:	Tue, 27 Oct 2009 21:20:34 +0000
In-Reply-To: <4AE5F392.5020405@caviumnetworks.com> (David Daney's message of "Mon\, 26 Oct 2009 12\:08\:02 -0700")
Message-ID: <87ljiwr0t9.fsf@firetop.home>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

David Daney <ddaney@caviumnetworks.com> writes:
>> Looks good otherwise, but I'd be interested in other suggestions for
>> the option name.  I kept misreading "raloc" as a typo for "reloc".
>
> Well how about raaddr?  (Return-Address Address)

Taking Wu Zhangjin's suggestion of an extra dash, how about
-mmcount-ra-address?

> +@option{-mmcount-raaddr} can be used in conjunction with @option{-pg}
> +and a specially coded @code{_mcount} function to record function exit

Doc conventions require "specially-coded", I think.  We should
mention the $12 register too, and the treatment of leaf functions.
How about:

--------------------------
Allow (do not allow) @code{_mcount} to modify the calling function's
return address.  When enabled, this option extends the usual @code{_mcount}
interface with a new @var{ra-address} parameter, which has type
@code{intptr_t *} and is passed in register @code{$12}.  @code{_mcount}
can then modify the return address by doing both of the following:
@itemize
@item
Returning the new address in register @code{$31}.
@item
Storing the new address in @code{*@var{ra-address}},
if @var{ra-address} is nonnull.
@end @itemize

The default is @option{-mno-mcount-ra-address}.
--------------------------

> +/* { dg-do compile } */
> +/* { dg-options "-O2 -pg -mmcount-raaddr -march=mips64 -mabi=64 -mno-abicalls -msym32" } */

This is a general feature, so I'd rather test with as few special options
as possible.  Just "-O2 -pg" if we can.  Same with the other tests.

Sorry to ask, but while you're here, would you mind fixing a couple
of pre-existing formatting problems too?  Namely:

> +      /*  For TARGET_LONG_CALLS use $3 for the address of _mcount.  */

Only one space for "For" and

> +  if (!TARGET_NEWABI)
> +    {
> +      fprintf (file,
> +	       "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n",
> +	       TARGET_64BIT ? "dsubu" : "subu",
> +	       reg_names[STACK_POINTER_REGNUM],
> +	       reg_names[STACK_POINTER_REGNUM],
> +	       Pmode == DImode ? 16 : 8);
> +    }

No braces here.

As far as the new bits are concerned:

> +      /* If TARGET_MCOUNT_RAADDR load $12 with the address of the ra save
> +	 location.  */
> +      if (cfun->machine->frame.ra_fp_offset == 0)
> +	/* ra not saved, pass zero.  */
> +	fprintf (file, "\tmove\t%s,%s\t\t# address of ra\n",
> +		 reg_names[12], reg_names[0]);

Let's drop the "# address of ra" comment.  We don't add comments to
the other bits.

Everything in the following block:

> +      else if (SMALL_OPERAND (cfun->machine->frame.ra_fp_offset))
> +	fprintf (file,
> +		 "\t%s\t%s,%s," HOST_WIDE_INT_PRINT_DEC "\t\t# address of ra\n",
> +		 Pmode == DImode ? "daddiu" : "addiu",
> +		 reg_names[12], reg_names[STACK_POINTER_REGNUM],
> +		 cfun->machine->frame.ra_fp_offset);
> +      else
> +	{
> +	  fprintf (file,
> +		   "\t%s\t%s," HOST_WIDE_INT_PRINT_DEC "\n",
> +		   Pmode == DImode ? "dli" : "li",
> +		   reg_names[12],
> +		   cfun->machine->frame.ra_fp_offset);
> +	  fprintf (file, "\t%s\t%s,%s,%s\t\t# address of ra\n",
> +		   Pmode == DImode ? "daddu" : "addu",
> +		   reg_names[12], reg_names[12],
> +		   reg_names[STACK_POINTER_REGNUM]);
> +	}

reduces to:

      else
	fprintf (file, "\t%s\t%s," HOST_WIDE_INT_PRINT_DEC "(%s)",
		 Pmode == DImode ? "dla" : "la", reg_names[12],
		 cfun->machine->frame.ra_fp_offset,
		 reg_names[STACK_POINTER_REGNUM]);

OK with those changes, thanks, if it passing testing, and if
Ralf is happy with the linux side.

Richard
