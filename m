Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 14:24:05 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:48453 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493089AbZIXMX5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2009 14:23:57 +0200
Received: by fxm21 with SMTP id 21so1280351fxm.33
        for <linux-mips@linux-mips.org>; Thu, 24 Sep 2009 05:23:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=NDvmG7rzdIRqpIG1TcF1vAe/FliuFWvffKHVuHFhEvE=;
        b=MpTEzrtRWCACywEK8ZX0ppwHMMqyPFNRLeg4vOFA6m1REVLWKaXzPyjVlKmGfj5iXR
         sTcZM/rXWnyHj8gIp5KFNLEQ72RDPPEebaH2BG1sepv9G4PEd5FHNgRnKDdJhej87QmI
         gUady4E1gKlP+6JwfAKgO5jqIV3ivuoTI5yNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xsqvlQhW58/cZOS0WetFa6qJNJrbTfnJcn19szL4X4J2781ucIl92PsjC+ZIHRy+ge
         YP+yUy8vIOEwq2faZ0D7ci6GKIb5eneoNeI4GvP4iTMd8wU0O3w0jb94HnAjakbI+9We
         Sv+DxRZtNAMnrzhBuKUsDJkQ9olTsVnlvdSVs=
MIME-Version: 1.0
Received: by 10.223.161.205 with SMTP id s13mr1215254fax.27.1253795031455; 
	Thu, 24 Sep 2009 05:23:51 -0700 (PDT)
In-Reply-To: <4ABB6189.5010909@gmail.com>
References: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>
	 <20090924091539.GA929@merkur.ravnborg.org>
	 <f861ec6f0909240224m4b5dcbd9hc835409e7a66102d@mail.gmail.com>
	 <f861ec6f0909240241x5c5858d4g4d44b40107021bb6@mail.gmail.com>
	 <4ABB6189.5010909@gmail.com>
Date:	Thu, 24 Sep 2009 15:23:51 +0300
Message-ID: <90edad820909240523m4f284d0ep1cf0abf0f4909d9c@mail.gmail.com>
Subject: Re: MIPS: Alchemy build broken in latest linus-git [with patch]
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Sam Ravnborg <sam@ravnborg.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Sep 24, 2009 at 3:09 PM, Manuel Lauss
<manuel.lauss@googlemail.com> wrote:
> Manuel Lauss wrote:
>> On Thu, Sep 24, 2009 at 11:24 AM, Manuel Lauss
>> <manuel.lauss@googlemail.com> wrote:
>>>> I'm away from my machine atm.
>>>> Could you try to add the following to arch/mips/kernel/makefile:
>>>>
>>>> CPPFFLAGS_vmlinux.lds += $(KBUILD_CFLAGS)
>>>>
>>>> This should fix it.
>>> Thank you, that did it.
>>
>> Spoke too soon:
>>
>> This leaves unprocessed directives in vmlinux.lds:
>>
>> [...]
>> OUTPUT_ARCH(mips)
>> ENTRY(kernel_entry)
>> PHDRS {
>>  text PT_LOAD FLAGS(7); /* RWX */
>>  note PT_NOTE FLAGS(4); /* R__ */
>> }
>> ifdef 1
>>  ifdef 1
>>   jiffies = jiffies_64;
>>  else
>>   jiffies = jiffies_64 + 4;
>>  endif
>> else
>>  jiffies = jiffies_6
>
> ... which is of course easily fixed after consumption of
> unhealthy amounts of coffee.
>
> Patch below works for me.

For me too, and I am using a custom IP22 config.

Thanks!

Dmitri
