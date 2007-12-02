Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2007 21:37:09 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:46289 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20029466AbXLBVhB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 2 Dec 2007 21:37:01 +0000
Received: by nf-out-0910.google.com with SMTP id c10so2349760nfd
        for <linux-mips@linux-mips.org>; Sun, 02 Dec 2007 13:37:00 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=UAZtJ3kEYqMZ+aXyXI1j+O2cHDEjVbOGZDCAPwqu7n0=;
        b=QorbrMCunR6s+Dt7kBm7+wX3O3HTWNHhM3sz6yHnayTCb8SqaPN9XmcxU3dACIDfeNtJppCCvCkKYqjMQ186N61RPY/IMB6OcOc9JEkx8YBwqyIfOOavTjYLaVQxf/4DM2zQFVOq5S40bdav7OcuaO0GSuHL7RC7Q0f+ARJ1t9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=vEi+tkwE2AbK8750dhpD8JOLotLYZp1tRI33SShQu6uLfbgrqGRJs/sXmjaWc7B//kFUaxQ3R3D/Q5nfyWdnFgck8qayxogOw49Be84MVnYh7Wu/wC9xUd6nU6nBOEysJgjWFzlGjyF5WEvqLGOsLBTXGNz+M8JbxT0ryq1R85c=
Received: by 10.86.100.7 with SMTP id x7mr9883680fgb.1196631420724;
        Sun, 02 Dec 2007 13:37:00 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id l19sm11132985fgb.2007.12.02.13.36.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Dec 2007 13:36:59 -0800 (PST)
Message-ID: <47532577.804@gmail.com>
Date:	Sun, 02 Dec 2007 22:36:55 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	rmk@arm.linux.org.uk
CC:	linux-arch@vger.kernel.org, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Yet another __initxxx annotations: __initbss/__exitbss
References: <1196543586-6698-1-git-send-email-fbuihuu@gmail.com> <1196543586-6698-2-git-send-email-fbuihuu@gmail.com> <20071201231823.GB5411@flint.arm.linux.org.uk>
In-Reply-To: <20071201231823.GB5411@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Russell King wrote:
> On Sat, Dec 01, 2007 at 10:13:05PM +0100, Franck Bui-Huu wrote:
>> To select the BSS attribute for a peculiar section, the name of the
>> section must start with 'bss.' pattern. This is at least how GCC
>> 3.2/4.1.2 works and it's the reason why the 2 new sections haven't
>> been called '.{init,exit}.bss'.
>>
>> To mark a data part of one of these 2 sections, we use the 2 new
>> annotations: __initbss/__exitbss.
>>
>> All data marked as part of this section must not be initialized,
>> of course.
> 
> Are you sure about this?  The gcc manual for 4.1.1 says:
> 
>      Use the `section' attribute with an _initialized_ definition of a
>      _global_ variable, as shown in the example.  GCC issues a warning
>      and otherwise ignores the `section' attribute in uninitialized
>      variable declarations.
> 
> which has had that paragraph since at least 3.4.0.  Either the GCC
> documentation is wrong or the compiler is misbehaving if what you say
> works.  Either way, I'd be nervous about relying on this given that
> GCC developers like to change the compiler behaviour.
> 

Thanks for pointing this out.

We already have (incorrectly) uninitialized data which are part of the
init.data section and the section attribute isn't ignored at all, at
least on x86 and mips. On ARM, you could take a look at where
'command_line' array, declared in in arch/arm/kernel/setup.c, is
placed.

So, it seems that we already rely on the compiler behaviour.

> Suggest getting the GCC developers nailed down to ensure we know what
> the intended compiler behaviour is (and getting the docs to reflect that)
> before relying on the existing behaviour.
> 

Yes I agree. Do you have someone in mind to suggest or should I ask to
the GCC mailing list ?

		Franck
