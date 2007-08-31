Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2007 16:05:10 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.188]:1140 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023023AbXHaPFC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Aug 2007 16:05:02 +0100
Received: by mu-out-0910.google.com with SMTP id w1so660958mue
        for <linux-mips@linux-mips.org>; Fri, 31 Aug 2007 08:04:44 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=D0OBWTBipfSGmGDGbu1PrqjK7dTgyUiBm17l79yXWyqK7gjVNDcCWTEsotftdC4dL1gaevULTwGCR5aHFjBkHf9BMSAFejjoRp/o2bSD/8eyP3n6PYrvCTN0ECev4pp7X05nbR0EeBZexWK5hYSHN/W1ciTuxrHaZuygHE/nDvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=p0GIQ81pRDH2WCNXQjnLTY11KieS+kQuJ/wZE2awoyaqKLJB1O0rRL3ZO7ODy7V/Wl8ZjPRF+hcYGUN0tuQyNf2v9nVou1ZwPlgsYcQxpg/7WcqEHjCwRSbdiHwfnOGfQ2WMt3eCqzt8SSRq9vCtbsNqbVPE9pcdafZz0CS7qiE=
Received: by 10.82.160.19 with SMTP id i19mr3842763bue.1188572683963;
        Fri, 31 Aug 2007 08:04:43 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j12sm3397915fkf.2007.08.31.08.04.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Aug 2007 08:04:43 -0700 (PDT)
Message-ID: <46D82DFE.2060206@gmail.com>
Date:	Fri, 31 Aug 2007 17:04:30 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Markus Gothe <markus.gothe@27m.se>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: flush_kernel_dcache_page() not needed ?
References: <46D8089F.3010109@gmail.com> <46D82A9F.5080001@27m.se>
In-Reply-To: <46D82A9F.5080001@27m.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Markus Gothe wrote:
> Ralf added this a while ago:
> 
> "arch/mips/mm/cache.c:void __flush_dcache_page(struct page *page)"

I was asking for flush_kernel_dcache_page()...

Please note the word "kernel" in the name of the function.

		Franck
