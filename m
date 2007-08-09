Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 20:40:13 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:23372 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024460AbXHITkD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Aug 2007 20:40:03 +0100
Received: by nf-out-0910.google.com with SMTP id c10so157796nfd
        for <linux-mips@linux-mips.org>; Thu, 09 Aug 2007 12:39:46 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kz6OH/cHWckmITOBs4jrRWq6qOLcLFomk/wvLuVqxBQ6kQsl8X0qHroposgNew/YvZAPKzt9BeckF1DKwOxvzCyTf+BjfXtk3JbKUzjIMrZgi5Yd6Kl1loN24Of7VIASiKD3mj3AyDdL1+iTdB0I6Ugg0LkQUh4pxnkvkgzcb3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Awpp27wKMr6XMjYQxYIh4LpsETx70VA9VeuGOW7XuOyteT0N0A40w+XRbvJEKr6knxVKl/H0SUTCSU/BDqFjESRbTvEmB00Msw8JSuGAjwA4NEh48tmyev9risZmLtWFpVKCMZpJnd/0asLOBhrFD4/ikewkdIHEvNMO/qnlmDg=
Received: by 10.86.100.7 with SMTP id x7mr1390902fgb.1186688386129;
        Thu, 09 Aug 2007 12:39:46 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e32sm4047267fke.2007.08.09.12.39.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Aug 2007 12:39:45 -0700 (PDT)
Message-ID: <46BB6D6C.2050601@gmail.com>
Date:	Thu, 09 Aug 2007 21:39:24 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] Remove '-mno-explicit-relocs' option when	CONFIG_BUILD_ELF64
References: <11715446603241-git-send-email-fbuihuu@gmail.com> <20070809151812.GA28142@caradoc.them.org>
In-Reply-To: <20070809151812.GA28142@caradoc.them.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> On Thu, Feb 15, 2007 at 02:04:18PM +0100, Franck Bui-Huu wrote:
>> From: Franck Bui-Huu <fbuihuu@gmail.com>
>>
>> This patch removes '-mno-explicit-relocs' usage when
>> CONFIG_BUILD_ELF64 is set since this option was only required
>> with the old hack to truncate addresses at the assembly level
>> where "-mabi=64 -Wa,-mabi=32" was used.
>>
>> This should yield a small code size improvement for inline
>> assembly, where the R constraint is used.
>>
>> The idea is coming from Maciej <macro@linux-mips.org>.
> 
> It looks like nothing ever came of these patches?  

yes it seems a common rule which is applied to the patches I send to
this mailing list ;)

> I tried to boot my
> Sentosa again today, and needed a slightly updated version of them.
> 

What do you mean by "slightly updated version" ? Did you rebase them
on top the current linux-mips tree, or something ? If not, what's your
kernel version ?

> I'm not positive I did the update correctly, though, since the board
> panics in swapper after jumping to a bogus pointer.
> 

Sorry I don't understand this. Do you mean:

  a) My kernel crashed, so I gave your patchset a try but it's still
     crahshing

  b) My kernel crashed, so I gave your patchset a try and it makes my
     kernel running fine.

I assume you're saying a).

Can you give a try to 2.6.23-rc2 because it includes commit
b1c65b3988c6e29ac371ab1cbbf6c4f8fb7092f8 which might fix your
issue. That would be a side effect but it gives us a hint on your
problem.

Also your .config, dmesg files are welcome.

		Franck
