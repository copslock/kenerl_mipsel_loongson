Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 16:56:07 +0200 (CEST)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:44736 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493259AbZJVO4B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Oct 2009 16:56:01 +0200
Received: by yxe42 with SMTP id 42so1417296yxe.22
        for <linux-mips@linux-mips.org>; Thu, 22 Oct 2009 07:55:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Bg1b5aIXppFKOJqP/24e05lhEJlNlvQBg2pAqpdhygM=;
        b=EEHAH2YYPtO+CFG7lZpcNJOw+uderRGaghY6ujIjUjZtmHrzpQ1BTNt8vntldi+DzO
         ZWC4NGat9U3yrlWycgLmXWRgXltwoJ1pARDztRXa8aDicYDH6lHNj3CMwrHjziQKJSpg
         75Qrk1p90517Rg1dFOOoyuCFjdftHbvzMUvMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vKAiOPXf8euUfD/sWHTfU2kjytrQ1ceO4+Bonact0qgR/8H67GKrOF+07bGJ9YqFlS
         gVHU91vfqSTjgCqVRh3sskenS0Br7N6JxcaOoT/ImXsY1Ng+jBRgqyo8lNffQxDLVzDi
         BNhBWy+eXjEHKW4aSqqcyFjrl0wZ8nTAQ+zo0=
MIME-Version: 1.0
Received: by 10.90.222.1 with SMTP id u1mr6166880agg.103.1256223351727; Thu, 
	22 Oct 2009 07:55:51 -0700 (PDT)
In-Reply-To: <4ADFAC5E.5020506@paralogos.com>
References: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>
	 <4ADF32D1.6030801@ru.mvista.com>
	 <e997b7420910211704w67517b3bud6f4757a35945ba@mail.gmail.com>
	 <4ADFAC5E.5020506@paralogos.com>
Date:	Thu, 22 Oct 2009 22:55:51 +0800
Message-ID: <e997b7420910220755m3e78c397ia5f183c580fb170b@mail.gmail.com>
Subject: Re: Got trap No.23 when booting mips32 ?
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	ddaney@caviumnetworks.com, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/22 Kevin D. Kissell <kevink@paralogos.com>:
> wilbur.chan wrote:
>>
>> Kernal didn't resgister IRQ 23 when booting. Hmm....the only '23'
>> number I can find in kernel is in traps.c.
>>
>> Why a 23 IRQ was triggered?
>>
>>
>
> The usual reason would be a failure to correctly initialize an interrupt
> controller, or the Status.IM mask field.  The kernel complains precisely
> *because* IRQ 23 wasn't registered, but an interrupt was nevertheless
> delivered that was decoded as being that IRQ.
>
>         Regards,
>
>         Kevin K.
>


Thanks for your suggestion.

And I found that , as a matter of  fact , kernel has registered No.23 as a trap.

In trap_init :

/*
1419          * Only some CPUs have the watch exceptions.
1420          */
1421         if (cpu_has_watch)
1422                 set_except_vector(23, handle_watch);


So, if a No.23 "signal" happened , kernel should  invoke handle_watch instead.


But why here kernel complained ? and why kernel entered the IRQ branch
(do_IRQ) rather than trap branch?
