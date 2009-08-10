Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 11:12:48 +0200 (CEST)
Received: from mail-pz0-f179.google.com ([209.85.222.179]:33234 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492460AbZHJJMl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2009 11:12:41 +0200
Received: by pzk9 with SMTP id 9so2861218pzk.21
        for <linux-mips@linux-mips.org>; Mon, 10 Aug 2009 02:12:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=e9XvPoeq4RGWJp1ipOtu6w/j86h/LTqn40HKPS/7a/w=;
        b=LgYry5oIhpVZRjx84va1MS/Sthx05HBxxAUJnD+gbHEnC0uhGr/x3EbzP1yMgtnPJS
         hFIOzNKFZ1YDQFKpFUK2oSZgj4EamuxqDEOf8uEvkXzL0x5gEEYW8VbCPiLKKkokgZOI
         AS0N49GWMb4hvhldPwRLgDbL01Oxjf75z/Y9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=F9yInROhBHxZ9XbHXfnghE8x8KBbgEoTA/2+LbE4JQdylgH37s10nqiO7s2tdZqcUZ
         t9JDooGnjtQAJrKbW/v2HAkJSPtK4cnsRcy5rLXt0LIoBm4MjsJM7ahlINewZooImDod
         ptyQV0m36eErghBeb9cOPdpEAV8ZlpDfkdrPY=
Received: by 10.114.254.8 with SMTP id b8mr5998040wai.106.1249895554582;
        Mon, 10 Aug 2009 02:12:34 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id l30sm6876181waf.0.2009.08.10.02.12.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 02:12:32 -0700 (PDT)
Subject: Re: [PATCH] MIPS: add support for gzip/bzip2/lzma compressed
 kernel images
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Alexander Clouter <alex@digriz.org.uk>
Cc:	linux-mips@linux-mips.org
In-Reply-To:  <e4s3l6-dou.ln1@chipmunk.wormnet.eu>
References:  <1249757707-8876-1-git-send-email-wuzhangjin@gmail.com>
	 <e4s3l6-dou.ln1@chipmunk.wormnet.eu>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Mon, 10 Aug 2009 17:11:40 +0800
Message-Id: <1249895500.20588.10.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Sun, 2009-08-09 at 22:36 +0100, Alexander Clouter wrote:
> 
> This has made my AR7[1] based Linksys WAG54Gv2 (16MB RAM and 4MB flash, 
> limited to a 768kB kernel) useful, finally...thanks!
> > 
> I got it working (LZMA kernel) however you have hardcoded a lot of bits 
> in there.  It looks to my uneducated eye most of the issues lie in that 
> getting a suitable PORT(x), KERNEL_START, KERNEL_SIZE, FREE_MEM_START 
> and FREE_MEM_END is non-trivial on the MIPS platform currently; 
> probably because of the lack of a generic lzma/gzip/bzip2 framework to 
> be used with.
> 
> For me I used:
>   #define FREE_MEM_START CKSEG0ADDR(0x94a00000)
>   #define FREE_MEM_END CKSEG0ADDR(0x94f00000)
> 
> I had to replace (you probably should move this from dbg.c to dbg.h):
>   #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
> 
> The load address is awkward, but I replaced your 0x8100000 in the 
> Makefile with 0x94400000.
> 
> Now, the big question is how to work this all out at compile time. :)
> 

Thanks very much for your suggestion, just rewritten it and removed
almost all of the hard-coded parts(except the size of the HEAP) and a
new patch was sent out. and this new one _should_ work for the other
MIPS-based machines if not missed something else.

looking forward to your test result on AR7 with the new patch and
welcome to comment to this new E-mail thread: [PATCH -v1] MIPS: add
support for gzip/bzip2/lzma compressed kernel images

> As a side note, I would personally leave the DEBUG non-optional and 
> turned on as it all disappears at runtime anyway, but I'm no kernel 
> developer :)

ooh, in reality, I'm looking forward to the comment of Ralf and somebody
else. to my point of view, this _debug_ interface is only need to help
the developers of the other MIPS variants ensure this patch work for
them.

Thanks & Regards,
Wu Zhangjin
