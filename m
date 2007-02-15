Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 13:15:50 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.230]:1684 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038832AbXBONPp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 13:15:45 +0000
Received: by qb-out-0506.google.com with SMTP id e12so148021qba
        for <linux-mips@linux-mips.org>; Thu, 15 Feb 2007 05:14:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EJJ9DehZ27e/LyhUoyifxo2FWANlnbkWKSoGdRtS5XPyPLw09N56dLQxULcZnvIkPc8RNwkaZchDUJ4l1CedE6lTcS/aV6qhpiytL7EqDmgGXBIAJ9SyqG/WRpnlR0XV0MZki9fL5FAn8KnWIVhKEtHkfEHbyezN5+pAVCrYONk=
Received: by 10.115.61.1 with SMTP id o1mr948960wak.1171545283218;
        Thu, 15 Feb 2007 05:14:43 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 15 Feb 2007 05:14:43 -0800 (PST)
Message-ID: <cda58cb80702150514w76653104h2000f6b2c53b712f@mail.gmail.com>
Date:	Thu, 15 Feb 2007 14:14:43 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] Rename CONFIG_BUILD_ELF64 into KBUILD_64BIT_SYM32
In-Reply-To: <11715446611812-git-send-email-fbuihuu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11715446603241-git-send-email-fbuihuu@gmail.com>
	 <1171544660166-git-send-email-fbuihuu@gmail.com>
	 <11715446611812-git-send-email-fbuihuu@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/15/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> From: Franck Bui-Huu <fbuihuu@gmail.com>
>
>    ifeq ($(BUILD_ELF32), y)
> -    cflags-y += -msym32

argh, it should be "BUILD_SYM32" here. I'm resending this patch.

-- 
               Franck
