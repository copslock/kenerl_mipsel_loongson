Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 23:37:52 +0000 (GMT)
Received: from rn-out-0910.google.com ([64.233.170.188]:44731 "EHLO
	rn-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S23367291AbYKGXhu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Nov 2008 23:37:50 +0000
Received: by rn-out-0910.google.com with SMTP id j66so1174637rne.9
        for <multiple recipients>; Fri, 07 Nov 2008 15:37:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iD8nkQBUQcur0WqHuH8MriCj2n03oQKYC/44qBE5NG8=;
        b=DVF5wKmVPv4BKdjPUt9DRXpbqOX3uL0/so6wdOfgcIF1rwPINAiBgtvrlG9BVXvC4E
         tx82DoIle9YRAg3ulYTT3leeWCJCfIzkJgXqufj9ylfahweSbeCInHzeGmKamkPOa6nq
         N15fLhHWs60lOVgrB6bwOVyBeM6Ges1Idk1Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HdJtDtOSMTJZ6Z0hanGENjbBuWFNdRzUamrPD8KYCqylBoqAwf9N2XrfDyarSAgHBy
         QB2cyOkkP7Atf0q6JtozDqY+tWUmPY8mZtL9NUyz3fwG36opAeU35Afm4kNOKZXMHW94
         z1NAjvq9RetefnHmGx8NnFUAYiXLJNIYWP7aE=
Received: by 10.151.114.13 with SMTP id r13mr4445986ybm.55.1226101068359;
        Fri, 07 Nov 2008 15:37:48 -0800 (PST)
Received: by 10.150.185.15 with HTTP; Fri, 7 Nov 2008 15:37:48 -0800 (PST)
Message-ID: <90edad820811071537y4ca703abyb9cc8751aa69e87b@mail.gmail.com>
Date:	Sat, 8 Nov 2008 01:37:48 +0200
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Dmitri Vorobiev" <dmitri.vorobiev@movial.fi>
Subject: Re: [PATCH] Fix include paths in malta-amon.c
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"David Daney" <ddaney@avtrex.com>, linux-mips@linux-mips.org
In-Reply-To: <490B0060.3030709@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48D52FF4.2000905@avtrex.com>
	 <20081015143804.GA18506@linux-mips.org> <490B0060.3030709@movial.fi>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

2008/10/31 Dmitri Vorobiev <dmitri.vorobiev@movial.fi>:
> Ralf Baechle wrote:
>> On Sat, Sep 20, 2008 at 10:16:36AM -0700, David Daney wrote:
>>
>>> On linux-queue, malta doesn't build after the include file relocation.
>>> This should fix it.
>>>
>>> There some occurrences of 'asm-mips' in the comments of quite a few
>>> files, but this is the only place I found it in any code.
>>>
>>> Signed-off-by: David Daney <ddaney@avtrex.com>
>>
>> Thanks, applied.
>
> Hi,
>
> The fix is still not in Linus' tree.

Another week, but the fix is still not in Linus' tree.

Dmitri

>
> Dmitri
>
>>
>>   Ralf
>>
>
>
>
