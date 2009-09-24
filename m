Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 11:41:54 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:62043 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492313AbZIXJls (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2009 11:41:48 +0200
Received: by bwz4 with SMTP id 4so1216079bwz.0
        for <linux-mips@linux-mips.org>; Thu, 24 Sep 2009 02:41:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Sztkcj1QUoIyUyzPvqPPgX2xNCf/iwOs7lpkEKbHgek=;
        b=eeJmlZEi9Hg0nXj7oRodB9nbmzveSvWOhlPIJLHTczLKLqMuTLFV37EBnQCIGi2QVp
         EgOwp9rX3OURwFs5htq2uJaG3Tay5up8ZHuaHtp3XgTkqu36/cvYmc+OPvRKDR6rWZ4q
         7fE4Hxl4rYjOaxJC4kt7kV0kzwbX1Ob35ty/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pcoYDB7lB7cI6meAgU18CLUqNmstKjMg2kRx2jLrLdpju84CNaYnfL2Ee5EoSgwW83
         OzJEr0ibI6YGEmvShybYduYVkLI76ExYNt3+EHnQ7j9WFQecwA2nagqX5lwbhWS6Xp2u
         K9xHwmq4o0tmS2wgjYvhRCoVGFKvnRMTdZbLA=
MIME-Version: 1.0
Received: by 10.103.85.28 with SMTP id n28mr1383110mul.66.1253785301301; Thu, 
	24 Sep 2009 02:41:41 -0700 (PDT)
In-Reply-To: <f861ec6f0909240224m4b5dcbd9hc835409e7a66102d@mail.gmail.com>
References: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>
	 <20090924091539.GA929@merkur.ravnborg.org>
	 <f861ec6f0909240224m4b5dcbd9hc835409e7a66102d@mail.gmail.com>
Date:	Thu, 24 Sep 2009 11:41:41 +0200
Message-ID: <f861ec6f0909240241x5c5858d4g4d44b40107021bb6@mail.gmail.com>
Subject: Re: MIPS: Alchemy build broken in latest linus-git
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Thu, Sep 24, 2009 at 11:24 AM, Manuel Lauss
<manuel.lauss@googlemail.com> wrote:
>> I'm away from my machine atm.
>> Could you try to add the following to arch/mips/kernel/makefile:
>>
>> CPPFFLAGS_vmlinux.lds += $(KBUILD_CFLAGS)
>>
>> This should fix it.
>
> Thank you, that did it.

Spoke too soon:

This leaves unprocessed directives in vmlinux.lds:

[...]
OUTPUT_ARCH(mips)
ENTRY(kernel_entry)
PHDRS {
 text PT_LOAD FLAGS(7); /* RWX */
 note PT_NOTE FLAGS(4); /* R__ */
}
ifdef 1
 ifdef 1
  jiffies = jiffies_64;
 else
  jiffies = jiffies_64 + 4;
 endif
else
 jiffies = jiffies_64;
endif
SECTIONS
{
 . = 0xffffffff80100000;
 /* read-only */
 _text = .; /* Text and read-only data */
[...]


        Manuel Lauss
