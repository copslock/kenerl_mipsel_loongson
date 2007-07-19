Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 13:36:45 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.182]:12119 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022573AbXGSMgn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 13:36:43 +0100
Received: by py-out-1112.google.com with SMTP id p76so1040956pyb
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 05:36:42 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mh6Elgu1bY3FgultDLZOcuv0en4s4PqK0dIV+fnYTZD3qfPi/nVcuZufxvdPKzEkvQ3baGLkWkd43tpyBcMYUYNOWKEZyVd+WxHEQIy1yPhDbhMYwhQH2tMj3RfSM54Up3Hw6feGza5KBQEa90sefwu+oA4rAIiiiVZk/QSRbkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ijbJj4/IJnfTl7ZoG47hlmf6DgFAJzC0n0SN6llzPhX1VWf3vgmbPxGUYAzal0l4z3160y0bJ2EG858e3PBLNnROGaW6AbuTtRlIVroPp5LCFK1tGNFurvmxSizxJRMBz9lnsfIC9ReI/sg+kULF9fOuL8maVCBtOWF9pGX9mOs=
Received: by 10.65.220.8 with SMTP id x8mr4624470qbq.1184848602470;
        Thu, 19 Jul 2007 05:36:42 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 19 Jul 2007 05:36:42 -0700 (PDT)
Message-ID: <cda58cb80707190536u5b81e588u4f7686fa03cd591f@mail.gmail.com>
Date:	Thu, 19 Jul 2007 14:36:42 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Nigel Stephens" <nigel@mips.com>
Subject: Re: [PATCH] User stack pointer randomisation
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <469F571E.5080408@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <469F5345.5010209@innova-card.com> <469F571E.5080408@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 7/19/07, Nigel Stephens <nigel@mips.com> wrote:
> Hmm, the kernel isn't necessarily built using the same ABI as
> applications. While this will in fact do the right thing for O32 apps

Hey that's true.

> running on 64-bit kernels, it's kind of by accident, and suggests some
> equivalence which isn't really there. Would it be better to force 16
> byte alignment (the maximum alignment required by any ABI) in all cases,
> rather than relying on the kernel's ALMASK being correct for user
> applications? Just a thought.
>

Again I totaly agree, this seems to me cleaner to force 16 bytes
alignment rather than using ALMASK which is part of the kernel
context.

Let's go for a take #3 if Ralf has no objection.

Thanks
-- 
               Franck
