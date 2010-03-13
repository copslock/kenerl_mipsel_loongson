Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Mar 2010 04:59:08 +0100 (CET)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:61272 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491050Ab0CMD7E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Mar 2010 04:59:04 +0100
Received: by pzk16 with SMTP id 16so590296pzk.22
        for <multiple recipients>; Fri, 12 Mar 2010 19:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=7dUePuOO3Q7r1rIccmG107rqk1MhTN5hivNOh25VDKs=;
        b=SXrwyEjlREXcgHWw0dAVf+HFvfQ0ZPjFpaMo2NnGb+yobSs9MNubUolKj60pjUJAJr
         C7w8bPAPUIo0vY+b9obDRtpAWhTMIJCaQJGiBrh3EYbXa2NYdsIJ85laI+ykzJB9+Fof
         LKvXoVyqLr6aFnH/s5IF0koX0HGRpRlDZlglM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=HDwxFNsVORyGSo0U3gBr46GZau3iFztYoXfNaujVLHYB6V1uYCFx2nCkD/I06JWpt9
         TuaBf7ofKPc4trzBOHJ2PCj6P708gxZR7VftnDvuCR9Z72GX8frz8M3ixFPc2h0OQn97
         iseBBZTvZwJg2bO17xg8k0dhITRfzIWguUAyM=
Received: by 10.142.195.14 with SMTP id s14mr3327581wff.186.1268452736577;
        Fri, 12 Mar 2010 19:58:56 -0800 (PST)
Received: from [202.201.12.142] ([202.201.12.142])
        by mx.google.com with ESMTPS id 21sm2130808pzk.12.2010.03.12.19.58.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 19:58:55 -0800 (PST)
Subject: Re: [PATCH 1/3] Loongson-2F: Flush the branch target history such
 as BTB and RAS
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        Greg KH <gregkh@suse.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20100311095944.GC18065@linux-mips.org>
References: <cover.1268153722.git.wuzhangjin@gmail.com>
         <d513f16856e499e82f0b4e428c97fe06afb5a426.1268153722.git.wuzhangjin@gmail.com>
         <4B98632E.70806@necel.com>  <20100311095944.GC18065@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 13 Mar 2010 11:52:21 +0800
Message-ID: <1268452341.21443.3.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-03-11 at 10:59 +0100, Ralf Baechle wrote:
> On Thu, Mar 11, 2010 at 12:27:42PM +0900, Shinya Kuribayashi wrote:
> 
> > Are you sure that RAS represents "Row Address Strobe", not "Return
> > Address Stack?"

This should be Return Address Stack.

Will resend this patch later.

Thanks & Regards,
	Wu Zhangjin
