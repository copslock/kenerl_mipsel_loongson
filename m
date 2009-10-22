Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2009 00:17:15 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.148]:47097 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493847AbZJVWRJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2009 00:17:09 +0200
Received: by ey-out-1920.google.com with SMTP id 26so200322eyw.52
        for <multiple recipients>; Thu, 22 Oct 2009 15:17:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:to:mail-followup-to:cc
         :subject:references:from:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=cFPxboufPRtIsCl/LNZLnLa/WBw+xek7Ygqblc8SESA=;
        b=EUlCWFlGNxySPNaoLprVtShX+t36IgRGb1vWldvLO1op92onjTv5hFuisuQuxFkfjh
         cRKiDNKvtKdlH7Kqt5XiVffrnL7SpgNU9bM+BfBywg1kvqBudSb5A7HVkumtjX0m9acb
         A0f4yCcp+wpUo+Ut6Xdg0tEM7VpgSIAOo720Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=to:mail-followup-to:cc:subject:references:from:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=h61SyMrOGBC4rTshUSUUg73Z5CaKDUI9pmZdhCsxUhGhcZlVK91mGAoAypivYKvTWQ
         E5O0bYUhY6GzTari4FtcMA6k9woANPHo/hdAbX66jHTdkPORIZwpu+SQB39Qo8KlR03w
         uK5jTzXJquP12ZFlZum4K8Ppf+fw+oJjUpjRo=
Received: by 10.211.147.2 with SMTP id z2mr5229586ebn.17.1256249828674;
        Thu, 22 Oct 2009 15:17:08 -0700 (PDT)
Received: from localhost (rsandifo.gotadsl.co.uk [82.133.89.107])
        by mx.google.com with ESMTPS id 10sm4619726eyz.35.2009.10.22.15.17.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 15:17:08 -0700 (PDT)
To:	David Daney <ddaney@caviumnetworks.com>
Mail-Followup-To: David Daney <ddaney@caviumnetworks.com>,wuzhangjin@gmail.com,  Adam Nemet <anemet@caviumnetworks.com>, rostedt@goodmis.org,  linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,  Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Nicholas Mc Guire <der.herr@hofr.at>, rdsandiford@googlemail.com
Cc:	wuzhangjin@gmail.com, Adam Nemet <anemet@caviumnetworks.com>,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH -v4 4/9] tracing: add static function tracer support for MIPS
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	<2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	<3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	<ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	<1256138686.18347.3039.camel@gandalf.stny.rr.com>
	<1256233679.23653.7.camel@falcon>
	<4AE0A5BE.8000601@caviumnetworks.com>
From:	Richard Sandiford <rdsandiford@googlemail.com>
Date:	Thu, 22 Oct 2009 23:17:06 +0100
In-Reply-To: <4AE0A5BE.8000601@caviumnetworks.com> (David Daney's message of "Thu\, 22 Oct 2009 11\:34\:38 -0700")
Message-ID: <87y6n36plp.fsf@firetop.home>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

David Daney <ddaney@caviumnetworks.com> writes:
> Wu Zhangjin wrote:
>> On Wed, 2009-10-21 at 11:24 -0400, Steven Rostedt wrote:
> [...]
>>>> +
>>>> +NESTED(_mcount, PT_SIZE, ra)
>>>> +	RESTORE_SP_FOR_32BIT
>>>> +	PTR_LA	t0, ftrace_stub
>>>> +	PTR_L	t1, ftrace_trace_function /* please don't use t1 later, safe? */
>>> Is t0 and t1 safe for mcount to use? Remember, mcount does not follow
>>> the dynamics of C function ABI.
>> 
>> So, perhaps we can use the saved registers(a0,a1...) instead.
>> 
>
> a0..a7 may not always be saved.
>
> You can use at, v0, v1 and all the temporary registers.  Note that for 
> the 64-bit ABIs sometimes the names t0-t4 shadow a4-a7.  So for a 64-bit 
> kernel, you can use: $1, $2, $3, $12, $13, $14, $15, $24, $25, noting 
> that at == $1 and contains the callers ra.  For a 32-bit kernel you can 
> add $8, $9, $10, and $11
>
> This whole thing seems a little fragile.
>
> I think it might be a good idea to get input from Richard Sandiford, 
> and/or Adam Nemet about this approach (so I add them to the CC).
>
> This e-mail thread starts here:
>
> http://www.linux-mips.org/archives/linux-mips/2009-10/msg00286.html
>
> and here:
>
> http://www.linux-mips.org/archives/linux-mips/2009-10/msg00290.html

I'm not sure that the "search for a save of RA" thing is really a good idea.
The last version of that seemed to be "assume that any register stores
will be in a block that immediately precedes the move into RA", but even
if that's true now, it might not be in future.  And as Wu Zhangjin says,
it doesn't cope with long calls, where the target address is loaded
into a temporary register before the call.

FWIW, I'd certainly be happy to make GCC pass an additional parameter
to _mcount.  The parameter could give the address of the return slot,
or null for leaf functions.  In almost all cases[*], there would be
no overhead, since the move would go in the delay slot of the call.

[*] Meaning when the frame is <=32k. ;)  I'm guessing you never
    get anywhere near that, and if you did, the scan thing wouldn't
    work anyway.

The new behaviour could be controlled by a command-line option,
which would also give linux a cheap way of checking whether the
feature is available.

Richard
