Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 17:22:40 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:50118 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493232Ab0ADQWa convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2010 17:22:30 +0100
Received: by pxi11 with SMTP id 11so11163593pxi.22
        for <multiple recipients>; Mon, 04 Jan 2010 08:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mQa0CiU4AC7g1xO7anA8K7eeg/6JSqZErSxudOSKvfs=;
        b=xCZyPdamIETLdJ+B3JMYHSR/MnVhGWZ+zwddlyXxybztSFecwhWy15cLufpb8U/Vc4
         rbYJGyT0esQpO0zmJHY+qghX/oZjGQCNdZrFvJwdH8nDbK3NAFqlqVU6aJBGNo6+wbk5
         15ObUFZAXFKtFBnK78JU6VxDqNCvdGRZZxF2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=a6VeVxNTgl4oP/1J5GZN5BT7V27B3f/Gpum4lVLQvaEg/Vt4cxqWfgw5b7CHbBivjG
         i49xWNGon7AThh+/rD2lOy0mNVHw9j4z21Lv7PKxTdZgqiL8hD9K18U76sKZ2nV47jHW
         N+6flmy1CAnpBzPk791fbnBDz72uKQ4b7hOGE=
MIME-Version: 1.0
Received: by 10.142.248.42 with SMTP id v42mr15302225wfh.187.1262622142065; 
        Mon, 04 Jan 2010 08:22:22 -0800 (PST)
In-Reply-To: <20100103151406.20228c3a@infradead.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com> 
        <4B411F14.1040302@kernel.org> <20100103150134.5bdab023@infradead.org> 
        <4B412341.2010002@kernel.org> <20100103151406.20228c3a@infradead.org>
From:   Hui Zhu <teawater@gmail.com>
Date:   Tue, 5 Jan 2010 00:22:02 +0800
Message-ID: <daef60381001040822q188d7374te5a177c5f9877ac2@mail.gmail.com>
Subject: Re: [PATCH] stack2core: show stack message and convert it to core 
        file when kernel die
To:     Arjan van de Ven <arjan@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Russell King <linux@arm.linux.org.uk>,
        saeed bishara <saeed.bishara@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
        Chris Dearman <chris@mips.com>,
        Paul Gortmaker <Paul.Gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Coly Li <coly.li@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: teawater@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2452

Thanks for your mail.

I am not sure s2c is not a duplicating work with with others or not.

The main work of it is give user a coredump when kernel die like a
user level program die.
The user can very easy use it with gdb.
Now, it support x86/x8664/mips/arm.  It's very easy to extend.  To
support a new arch is not a very hard work. (I use half a day make it
support mips and mips64 include the test work.)

And the s2c convert program can run on every environment.  I try it in
x86, x8664, mipsn32 . It didn't depend on any special lib.  User can
compile it with "gcc s2c.c" to get it.  And run it in a small board
that didn't have some script support.

markup_oops.pl sames still not support cross compile environment.  It
get module message with modinfo,right?  And use some objdump and so
on.
So even if it support cross compile environment, user use it will need
set which objdump he want use.  Which mod dir  he want use.  Right?

For the s2c, user just "s2c < message >core" It did everything with itself.
After that, gdb vmlinux core.

Best regards,
Hui

On Mon, Jan 4, 2010 at 07:14, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 04 Jan 2010 08:07:45 +0900
> Tejun Heo <tj@kernel.org> wrote:
>
>> On 01/04/2010 08:01 AM, Arjan van de Ven wrote:
>> > On Mon, 04 Jan 2010 07:49:56 +0900
>> > Tejun Heo <tj@kernel.org> wrote:
>> >>
>> >> If implementing parsing of oops message in C is too awkward
>> >> (unsurprising at all), maybe implementing a converter in perl or
>> >> python is the easiest way so that it takes the oops message and
>> >> puts out well formatted input for the s2c program?
>> >
>> > you mean like scripts/markup_oops.pl ?
>>
>> Whichever one works but s2c wouldn't require symbol decoding.  Maybe
>> we can simply add an option to tell it to just parse the oops and
>> output it in machine friendly format.  Oh, also, the patch does add
>> new information the module load addresses.  We should be able to add
>> those to the oops message in a compact form.
>
> actually one does not need those; you know the start address of the
> function already from the current oops output, and since you know the
> address of the function within the module as well, you know the start
> address of the module.
>
>
> --
> Arjan van de Ven        Intel Open Source Technology Centre
> For development, discussion and tips for power savings,
> visit http://www.lesswatts.org
>
