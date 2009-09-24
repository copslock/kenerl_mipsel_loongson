Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 09:50:01 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:36876 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492200AbZIXHty (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2009 09:49:54 +0200
Received: by bwz4 with SMTP id 4so1158754bwz.0
        for <linux-mips@linux-mips.org>; Thu, 24 Sep 2009 00:49:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SnnVxgOW7+Sr5F8AFW3b/SN7dJyxOAnRSHyHUGk4vFQ=;
        b=mPnvGZCYkGSbg2OJ06JHeWPgnlEVN5/6Q3ZPDUqVshHjlXTvJMkE3XPPWqIrSbkx8k
         9B+H5WJiN4DulgbbohWX+22mgFhYc2M0RqtQ3u+SBCPmKwauisVXe7Wrg6GKJakw8f9y
         aQ+fx+A6Mba8yljs2Q2OwEeNQS4U67qeEdQpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hZfpUe0KkCKgFyJETBq0peWSnZgcS0SZNXGoECMpVjoPPK9rJhrkIOpPUh9Vs/7YYk
         Szo2L31FacD5lh/WqS62lbtPh4nxAt2lwBp4nmaOCLWGVEfIl/NTf3A6LmjFQiGRSm13
         yr+qoFl0xumqOrqIzEhP2LUYJ6Peq7xaqO7ok=
MIME-Version: 1.0
Received: by 10.223.144.70 with SMTP id y6mr1032533fau.5.1253778588121; Thu, 
	24 Sep 2009 00:49:48 -0700 (PDT)
In-Reply-To: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>
References: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>
Date:	Thu, 24 Sep 2009 10:49:48 +0300
Message-ID: <90edad820909240049j693d6712wb659a469025c584f@mail.gmail.com>
Subject: Re: MIPS: Alchemy build broken in latest linus-git
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Sam Ravnborg <sam@ravnborg.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Sep 24, 2009 at 9:44 AM, Manuel Lauss
<manuel.lauss@googlemail.com> wrote:
> Hi Sam!
>

[skipped]

> error: spaces.h: No such file or directory

The same problem for the SGI IP22.

Thanks,
Dmitri
