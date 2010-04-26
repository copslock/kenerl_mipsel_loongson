Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2010 14:14:15 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:60313 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492511Ab0DZMOL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Apr 2010 14:14:11 +0200
Received: by gwb1 with SMTP id 1so266670gwb.36
        for <multiple recipients>; Mon, 26 Apr 2010 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=LWJ03z8zRf70fhkm1yYLfVLdgcf9mrEI05CXl6H0c7M=;
        b=li+PyiRBkiJtJYiwO/06awog1ZTLWRA+I4uY52IvroZhXE9oUhvVY1EbFYOapekdk+
         9ULUvqBa1UsIoMrCaAM5nbi5i5erozqQeWE3kDHtP0VCTQr2Zlp+PO9h7g9Is9GBudTq
         tBOdhZy8/0OYqXZf7Jbzc0NiQHIq1xdOVJbtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=UZ3wKOFgtlwihzfEzaTN91NKxvR6FPt4MVo3aA/B+JffsFmDCOjffcW76KAbhvGZjA
         78bm4+Nwve4tVxCVrJeO1u0QoybBCJiegsjfnr60TsYW4F3yOfJtR6Q7K61aa4wmVCHv
         cVo4hlxrDS25THCd4zptvs4z7lE+ExRKiVLu0=
Received: by 10.101.171.15 with SMTP id y15mr5035971ano.4.1272284045517;
        Mon, 26 Apr 2010 05:14:05 -0700 (PDT)
Received: from [192.168.2.213] ([202.201.14.140])
        by mx.google.com with ESMTPS id r21sm43246782anp.7.2010.04.26.05.14.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 05:14:02 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
In-Reply-To: <20100414112458.GA8861@alpha.franken.de>
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>
         <1271135034.25797.41.camel@falcon> <20100413073435.GA6371@alpha.franken.de>
         <20100413171610.GA16578@linux-mips.org> <1271232185.25872.142.camel@falcon>
         <20100414112458.GA8861@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 26 Apr 2010 20:13:55 +0800
Message-ID: <1272284035.11865.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-04-14 at 13:24 +0200, Thomas Bogendoerfer wrote:
> On Wed, Apr 14, 2010 at 04:03:05PM +0800, Wu Zhangjin wrote:
> > If using CKSEG0 as the ebase, CKSEG0 is defined as 0xffffffff80000000,
> > then we get the address: 0x97ffffff80000100, is this address ok?
> 
> the address is broken TO_UNCAC doesn't work properly for CKSEG0 addresses.
> And that's IMHO the real bug... I'm wondering whether this 
> set_uncached_handler() stunt is even needed. Is there a machine
> where CKSEG0 and CKSEG1 address different memory ? If not, we could
> just use the normal set_handler() function and be done with it.
> 

Hi, all

I'm not familiar with this part, is there any fixup/workaround for this
bug? otherwise, we will get a broken support for the r4k machines(at
least the loongson machines).

Regards,
	Wu Zhangjin
