Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2005 03:24:03 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.199]:35832 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226517AbVGMCXs> convert rfc822-to-8bit;
	Wed, 13 Jul 2005 03:23:48 +0100
Received: by wproxy.gmail.com with SMTP id i22so69534wra
        for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 19:24:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SYbinsB8Rj9t9jVSNK60FJdJe1U1o+Z4FKxQ00RMCninOHfpB7Ckhmu9eQ7gACz/thajvvy7pA9OeNRpmxgrKPdBKU5/fO3o4cL1S1W9m7SKKFmny3+sM/ubPSO3Z4Pdv/QI14cGnK4wiGCXmkH23gNXav3pWLy7uSuzlr4zpOw=
Received: by 10.54.115.3 with SMTP id n3mr157587wrc;
        Tue, 12 Jul 2005 19:24:51 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Tue, 12 Jul 2005 19:24:51 -0700 (PDT)
Message-ID: <ecb4efd1050712192448e247b1@mail.gmail.com>
Date:	Tue, 12 Jul 2005 22:24:51 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: reboot gets stuck in a TLB exception on Au1550 based board [resolved but not explained]
In-Reply-To: <ecb4efd105071217254e68b9e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <ecb4efd105071217254e68b9e2@mail.gmail.com>
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

On 7/12/05, Clem Taylor <clem.taylor@gmail.com> wrote:
> I was wondering if anyone else has a problem with reboot not working
> on a Au1550? When I issue a reboot, the kernel prints "** Resetting
> Integrated Peripherals", but the system doesn't reboot.

It seems that my problem was related to turning off sys_auxpll, which
is the clock source for the PCI bus. If I just comment out the write
to sys_auxpll in au1000_restart() then the reboot seems to work just
fine. I'm not sure why disabling the PCI clock would cause yamon to
take a TLB fault... I guess I need to hook up the analyzer and see
what happens to the PCI devices when the PCI clock goes away.

                      Thanks for the suggestions,
                      Clem
