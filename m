Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2007 17:22:54 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:25618 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20023262AbXHNQWp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Aug 2007 17:22:45 +0100
Received: by ug-out-1314.google.com with SMTP id u2so109983uge
        for <linux-mips@linux-mips.org>; Tue, 14 Aug 2007 09:22:28 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VRztNMkme4dghJD6eADybM0ZMyqedcYfo0k72CxBt1q6itdixjd4cCUVL48wzRtX6310J1OsBls6KcN/ISaxsaVmw278KVFvA+iKU/6Mvj9RMROhK4ZYmamXbt/07Nd2VMxnsvgX7JRWly4duT3285rlEvQ8xG+vgbWaYWzunOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qT/oWi9oN0wsW127Wk5JP8THpX1UrNhPuSlILTnsNrnjVv2sfn9corov8MFXZVnLBmr9dweaYubCDLkjcCAA6or9e1r2v7RRsJ1UQgdzK3wcgNG6tWfNXaPdF7yfY3OfBeZSnqN2G13DgVqhzID5dfuH1ZFdDj/KrmkXWK1xRUc=
Received: by 10.67.92.1 with SMTP id u1mr740272ugl.1187108548165;
        Tue, 14 Aug 2007 09:22:28 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id u9sm24634872muf.2007.08.14.09.22.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Aug 2007 09:22:26 -0700 (PDT)
Message-ID: <46C1D6AB.6040205@gmail.com>
Date:	Tue, 14 Aug 2007 18:22:03 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] Remove '-mno-explicit-relocs' option when	CONFIG_BUILD_ELF64
References: <11715446603241-git-send-email-fbuihuu@gmail.com> <20070809151812.GA28142@caradoc.them.org> <46BB6D6C.2050601@gmail.com> <20070813193059.GA17969@caradoc.them.org>
In-Reply-To: <20070813193059.GA17969@caradoc.them.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> Yes, I rebased them on top of linux-mips HEAD as of Thursday.
> 

Ok, I rebased them too, and compare them to your diff and got almost
the same result except that you seem to not use the last patch 3/3
version. But it shouldn't hurt.

> My kernel crashed, so I gave your patchset a try, and it got a lot
> further and crashed somewhere different.
> 

It just means that before applying the patchset your kernel was
wrongly configured: you probably set "CONFIG_BUILD_ELF64=y" whereas
your kernel load address is in CKSEG0, is that correct ?

If so, your current issue may be related to a completely different
area and maybe a git-bisect session could help but don't forget to set
"CONFIG_BUILD_ELF64=n" before.

Oh, maybe before doing the git-bisect session, there's one thing you
could try: when building the kernel with the patchset applied do:

		$ make KBUILD_SYM32=no

It's equivalent to "CONFIG_BUILD_ELF64=y" _but_ the kernel will use
the correct definitions for kernel address translations.

In any cases, your dmesg could help.

		Franck
