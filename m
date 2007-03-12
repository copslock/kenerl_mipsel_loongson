Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2007 17:06:16 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.229]:53351 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021367AbXCLRGM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Mar 2007 17:06:12 +0000
Received: by hu-out-0506.google.com with SMTP id 22so5774271hug
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2007 10:05:11 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O4O2brhiLC0JqrnEjkQFuQv+ccdNehNlA/gzsR/sQJL4jiiMmu9cll+lGOwKqr1n2kAfkm//mE/WNXEoOeiBJw/HdX62YU/aU90Xf4xb8gt7eLD7hPIomvH0fzcS6ynDOsom5jvr7Urlo2+lBYNy+a1pm5kcydZ0Dpk42+Dqm1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BjaiZWBZilZkGQl1QX/kOotn08viVn1w+eWOyi+TEkTsUV8K1AqduoTq6/0XlNgx/Xu8EEVeHv6wJcoEBKZp+tAhPQYhR2/MvBP3Wg75kv5Dk3940ceUE1UqZ290g9qk0KfaK2ABipGVOjFjpPmHGy+JNoMAIrZg9etn++wMBnw=
Received: by 10.114.167.2 with SMTP id p2mr1850309wae.1173719110450;
        Mon, 12 Mar 2007 10:05:10 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 12 Mar 2007 10:05:10 -0700 (PDT)
Message-ID: <cda58cb80703121005h53969eb2j7b2290b97b14374d@mail.gmail.com>
Date:	Mon, 12 Mar 2007 18:05:10 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	post@pfrst.de
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.58.0703121329450.440@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <Pine.LNX.4.58.0703101034500.19007@Indigo2.Peter>
	 <cda58cb80703120247q435b6bb1p8a025d8597aca2a2@mail.gmail.com>
	 <Pine.LNX.4.58.0703121329450.440@Indigo2.Peter>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/12/07, peter fuerst <post@pfrst.de> wrote:
>
> You see the problem. Any occurrence of PAGE_OFFSET must be checked.
>

yes and whatever the scheme you propose...

> the kernel-addresses.  Moreover it would be desirable, if this macro
> really could be used throughout the kernel, e.g. by drivers, handling
> any reasonable kernel-address, which isn't possible in the page_offset
> scheme anyway.
>

Can you explain why the current use of pa() failed to handle all
kernel address with a real example ?

A few people reported that they had problem with KPHYS/CKSEG0 address
mix for 64 bit kernels but as far I can see it was due to a miss
configuration of their kernels. Of course I can be wrong but these
people haven't given any feedbacks so far...

Thanks
-- 
               Franck
