Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 13:36:39 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.239]:8865 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021472AbXCINgf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Mar 2007 13:36:35 +0000
Received: by hu-out-0506.google.com with SMTP id 22so2199703hug
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2007 05:35:35 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UKjf6bw6t5x4tLe9xHoMnOUiqls5iR0CsWNJYy+o/ogpZUa+ynZITH9zCd18Byj2zt7BSFT2+cgtKN8UMYo13Hi8hU9oyptyFmaHS3+nYa01QLW8ut1KhYzZpbkPrAo3j6jlpwZvFo1QPlACTaY3Fgrdy4bBgPsS3yaa+72TaHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=apFdCy/7V8nWos3qZ0lfkAhb5cHpJOxnxM8V2YiQlQ8eaE78k6Vkz2BVgAwI4RtC+JAviUkR4bqj5x6uIqAOFEbMqfK2rcnzkvrUgeJ0fSteFALY92c9TPn8pmWjaLEQKk/BLIYU5IFEJsY/kYgyjg2IBh/6Az0wQ5VyiJGH/HY=
Received: by 10.115.95.1 with SMTP id x1mr538691wal.1173447332746;
        Fri, 09 Mar 2007 05:35:32 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Fri, 9 Mar 2007 05:35:32 -0800 (PST)
Message-ID: <cda58cb80703090535i3b039ec0x3b31198c52bcee63@mail.gmail.com>
Date:	Fri, 9 Mar 2007 14:35:32 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	post@pfrst.de
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.58.0703091415250.604@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <1172879147.964.65.camel@sakura.staff.proxad.net>
	 <cda58cb80703050615r4e559ca1u78517634ac23a27@mail.gmail.com>
	 <1173112433.7093.36.camel@sakura.staff.proxad.net>
	 <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
	 <Pine.LNX.4.58.0703091415250.604@Indigo2.Peter>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/9/07, peter fuerst <post@pfrst.de> wrote:
>
> Never. If the kernel virtual address is 0x80000000+off with 0 <= off <=
> 0x1fffffff (aka kseg0, defined by bits 31..29), the corresponding physical
> address is always 0+off, no matter what PHYS_OFFSET you invent. Physical
> memory at 0x20000000 is not reachable from kesg0/1.
>

I already answered that was bullshit and I took drugs before writing this...

thanks
-- 
               Franck
