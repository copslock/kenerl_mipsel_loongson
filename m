Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2007 09:48:14 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.230]:55134 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022265AbXCLJsH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Mar 2007 09:48:07 +0000
Received: by hu-out-0506.google.com with SMTP id 22so5432270hug
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2007 02:47:06 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KLx9g4ywPVEEdJYFd0P5mWC1bIEDA2prGlbtMQe2JF5pj6ReGZvrGVPz/oRnHZxph2VlKHKK3r1+7HKwXmOMfxVhT47VOThaCc+9xpNQgCjqGqGS2u99Qz3yzUpB3kxyIBa17CpQ2ASkDcFc960/TiFgWATSXIcUqYB/hrxYWH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dpSoUUh7huhYbd3gBko8Hn/Nk1tkjzkamtOJWNYvPP7SkyWnoBpUEYYhsWi1jrabDwCsD0bzN8zmpwmJfC1sZe3oKiufn47wIE54PGUU7ryIkw/T4KXp8Ras1EGxeNgFUk7oEngf10r9nhePTdJ5xZW9w3YBZFXC3l+6YNoLPPE=
Received: by 10.114.145.1 with SMTP id s1mr1184788wad.1173692821563;
        Mon, 12 Mar 2007 02:47:01 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 12 Mar 2007 02:47:01 -0700 (PDT)
Message-ID: <cda58cb80703120247q435b6bb1p8a025d8597aca2a2@mail.gmail.com>
Date:	Mon, 12 Mar 2007 10:47:01 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	post@pfrst.de
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.58.0703101034500.19007@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <Pine.LNX.4.58.0703101034500.19007@Indigo2.Peter>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 3/10/07, peter fuerst <post@pfrst.de> wrote:
> 3) The page_offset adjustment may force fixes in other, not yet blown up,
>    places (pmd_phys() cried out lately...).
>

Not really fair. It crashed lately because until now I was the only
one to use it. And unfortunately I failed to give back this change to
Ralf's tree.

BUT, note that the root cause of this bug is that we did _plain_
address translation instead of using dedicated macro.

So I would say that this patch helps to fix these buggy places.

> What can PHYS_OFFSET achieve here - besides obfuscating ?
> Are there future uses for it, that justify the contortions ?
>

How do you deal with fancy cases such as physical memory starting at
0x20000000 for example ?

-- 
               Franck
