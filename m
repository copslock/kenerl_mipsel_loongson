Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 08:54:57 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:24767 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024608AbXJSHys (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 08:54:48 +0100
Received: by nf-out-0910.google.com with SMTP id c10so360237nfd
        for <linux-mips@linux-mips.org>; Fri, 19 Oct 2007 00:54:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=rGIx6co7MfRglut91XpAkkHsnk/GQOlUFHMOwKYxBEo=;
        b=j5bQP3fQTI9zbq8XIIb4jgJL/13y6vJ+p7H9T+ShmZEdE3fV/Z1LbANqjLbbWLTK0zz1Gl69bCMFhFoam4sjCjIoh5yRBA2BN7iKh/U/CgmN+nJay5g5BzdC1YqqfpSWgZE7FtAzXuyrFGlYN5gP3gkVKz5ZZ/IDZKuTtdNrb3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=QsGb+tqDAtf38tfujHHV+4DA0G7NW0H6kyaIU2tOzP1bF4UiM3RbMIUN1xi4WZJCKPVRovCQmwjG8VmfRi4mlL2OKdIgKKAz3w1thhSfg8BjMkBw+09EFRDEOJuZMDKjnN3NfEn0/UFHfbin8zXQwkgAyyz4bBDQB8Y7ihQa3wE=
Received: by 10.86.50.8 with SMTP id x8mr1153687fgx.1192780488431;
        Fri, 19 Oct 2007 00:54:48 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e32sm3205510fke.2007.10.19.00.54.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Oct 2007 00:54:46 -0700 (PDT)
Message-ID: <471862C4.8090305@gmail.com>
Date:	Fri, 19 Oct 2007 09:54:44 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Andrew Sharp <andy.sharp@onstor.com>
CC:	macro@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/4] vmlinux.ld.S: correctly indent .data section
References: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>	<1192741953-7040-4-git-send-email-fbuihuu@gmail.com> <20071018145723.4e4153c1@ripper.onstor.net>
In-Reply-To: <20071018145723.4e4153c1@ripper.onstor.net>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Andrew Sharp wrote:
> On Thu, 18 Oct 2007 23:12:32 +0200 Franck Bui-Huu <fbuihuu@gmail.com>
> wrote:
> 
>> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
>> ---
>>  arch/mips/kernel/vmlinux.lds.S |   32
>> +++++++++++++++++--------------- 1 files changed, 17 insertions(+),
>> 15 deletions(-)
>>
>> diff --git a/arch/mips/kernel/vmlinux.lds.S
>> b/arch/mips/kernel/vmlinux.lds.S index e0a4dc0..2f6c225 100644
>> --- a/arch/mips/kernel/vmlinux.lds.S
>> +++ b/arch/mips/kernel/vmlinux.lds.S
>> @@ -55,21 +55,23 @@ SECTIONS
>>  
>>  	/* writeable */
>>  	.data : {	/* Data */
>> -	  . = . + DATAOFFSET;		/* for
>> CONFIG_MAPPED_KERNEL */
>> -	  /*
>> -	   * This ALIGN is needed as a workaround for a bug a gcc
>> bug upto 4.1 which
>> -	   * limits the maximum alignment to at most 32kB and
>> results in the following
>> -	   * warning:
>> -	   *
>> -	   *  CC      arch/mips/kernel/init_task.o
>> -	   * arch/mips/kernel/init_task.c:30: warning: alignment of
>> â??init_thread_unionâ??
>> -	   * is greater than maximum object file alignment.  Using
>> 32768
>> -	   */
>> -	  . = ALIGN(_PAGE_SIZE);
>> -	  *(.data.init_task)
>> -
>> -	  DATA_DATA
>> -	  CONSTRUCTORS
>> +		. = . + DATAOFFSET;		/* for
>> CONFIG_MAPPED_KERNEL */
>> +		/*
>> +		 * This ALIGN is needed as a workaround for a bug a
>> +		 * gcc bug upto 4.1 which limits the maximum
> 
> at least fix the text while you're here: 'a bug a gcc bug'
> 
>> +		 * to at most 32kB and results in the following
>> +		 * warning:
>> +		 *
>> +		 *  CC      arch/mips/kernel/init_task.o
>> +		 * arch/mips/kernel/init_task.c:30: warning:
>> alignment
>> +		 * of â??init_thread_unionâ?? is greater than maximum
> 
> is that utf-8 or something?  probably should remove that.
> 
> sorry for the picayunes, but hey as long as you're here changing the
> indenting ~:^)
> 
> 

Okay I'll fix them.

Thanks
		Franck
