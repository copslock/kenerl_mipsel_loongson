Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jul 2009 20:16:01 +0200 (CEST)
Received: from mail-fx0-f208.google.com ([209.85.220.208]:43530 "EHLO
	mail-fx0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493424AbZGYSPz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Jul 2009 20:15:55 +0200
Received: by fxm4 with SMTP id 4so1867461fxm.20
        for <linux-mips@linux-mips.org>; Sat, 25 Jul 2009 11:15:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lC+ebnB19S4yYt87I43CGUr28tkGgPuTpVb8rIUGfPs=;
        b=mcpXVNAiv8LIdDqyjEBoxYiEuHJod+GkPUb2xotOU4FLbLA/fZh8cgg1JOQKPO3opd
         P7yvr3yZhIKc1LWzthO57KzuoLcVVj1AkXRfu/DCZk21NTsZ4s1JVlO6Wu3MFnEJyCr9
         6vcSp0aytH8CoPIVwmWlbpAov4baEPdyP+Ucs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ncmG6XDL/0KRNixvUAatoFBXZl3l6XphPpML+lbxOfmH5+5k7si2Xw0nNg3wpPW6bE
         O6C5wPrpJq9APsKwcznRXv9IPSIFD9/D+69EK+P6xIJuDWimno3t+63mRLUCGWRzbSno
         si8G3SGhgj8oykD093RWTKERYWpTa0EgWPcR4=
MIME-Version: 1.0
Received: by 10.223.114.135 with SMTP id e7mr2032875faq.89.1248545750446; Sat, 
	25 Jul 2009 11:15:50 -0700 (PDT)
In-Reply-To: <20090725174449.GC14062@dtor-d630.eng.vmware.com>
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com>
	 <20090725174449.GC14062@dtor-d630.eng.vmware.com>
Date:	Sat, 25 Jul 2009 20:15:50 +0200
Message-ID: <f861ec6f0907251115n3e1ad622uaf94c21dc4de0393@mail.gmail.com>
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Frans Pop <elendil@planet.nl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Sat, Jul 25, 2009 at 7:44 PM, Dmitry
Torokhov<dmitry.torokhov@gmail.com> wrote:
> Hi Manuel,
>
> On Wed, Jul 22, 2009 at 05:18:39PM +0200, Manuel Lauss wrote:
>> Cc: Frans Pop <elendil@planet.nl>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>>
>> +
>> +static struct dev_pm_ops au1xmmc_pmops = {
>> +     .resume         = au1xmmc_resume,
>> +     .suspend        = au1xmmc_suspend,
>> +};
>> +
>
> Was suspend to disk tested? It requires freeze()/thaw().

No, only suspend-to-ram, but that's good to know.
Currently for me only STR is important (and testable),
I'll have to check wheter STD works on MIPS with my test
hardware.

Thank you!
     Manuel Lauss
