Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 16:36:51 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:30808 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022902AbXICPgn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Sep 2007 16:36:43 +0100
Received: by nf-out-0910.google.com with SMTP id 30so1226374nfu
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2007 08:36:25 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IxtEy3WmD96ZLObx0esGxTv80WSgLLzkMrGz9sUpf2vNwWUgkhyodafljFQaK2jXGUAYNIuztrlmEXZzfLjgZA+tBY2PptfRUkx6k/r9fR8uZ+fd+FNJP7yn1kW6XO6yf041e+4S68hvzUi/H5mZbrCYBiQLINBydDkOKqMcLwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mAu2UmTPwxsZ8USrKoykrNB5w/2q87l4rNlnthfR7PxQDLvih2H6QMYium7jT/tM8vfKMrwx9DSsYhvipWnc2Qq6SIAwqW5pxntS7xPLyshjep1w9QH8+CUAjwQ6BmI+g8NImJYPONbRLqtZiuCOdt0hEo8Tqp//W/pYAQNbEhg=
Received: by 10.86.58.3 with SMTP id g3mr3527337fga.1188833784856;
        Mon, 03 Sep 2007 08:36:24 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id f19sm6162720fka.2007.09.03.08.36.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Sep 2007 08:36:24 -0700 (PDT)
Message-ID: <46DC29F0.3060200@gmail.com>
Date:	Mon, 03 Sep 2007 17:36:16 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
References: <46D8089F.3010109@gmail.com> <20070903.225239.61509667.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070903.225239.61509667.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 31 Aug 2007 14:25:03 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> I noticed that there's currently (v2.6.23-rc4) no implementation
>> of this function even for mips CPUs that have dcache aliasing.
>>
>> Could anybody explain why ?
> 
> Maybe because the API was not called by anybody until 2.6.23-rc1 :)
> 

But this function has been introduced since commit
5a3a5a98b6422d05c39eaa32c8b3f83840c7b768 ([PATCH] Add
flush_kernel_dcache_page() API) which had been merged during 2.6.16
merge window. So it's more than one year now...

Basically it gives a default implementation for all architectures. The
problem here is that this implementation may be boggus for
architectures that have dcache aliasing issue.

The sad thing is that the kernel will silently compile this default
implementation. At least, it could have showed a big fat warning
during the building process.

> Now copy_strings() calls this and I'm wondering we should implement or
> not.  It seems the kernel works fine for me without the API...
 
Do you use a cpu with dcache aliasing issue ?

> Do you have any problem due to luck of the API?

No, but looking at copy_strings(), I think we can have some trouble.

BTW, do you recall flush_anon_page() and fuse bug ? It seems the same
here...

		Franck
