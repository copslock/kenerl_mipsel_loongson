Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 16:17:01 +0000 (GMT)
Received: from ag-out-0708.google.com ([72.14.246.245]:56471 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20021919AbXCSQQ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 16:16:57 +0000
Received: by ag-out-0708.google.com with SMTP id 22so8433473agd
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 09:16:51 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aaZOmWi7s5qi6RmDLWhw2ntpZ9abf9/1g/OjRIeshXoz5uUSqqXZ5u+jzqYUZGm3zL0AlEF4EVGjU5mAOvLsUCBsJ/JH2tsrAI30jBw+OzNQYjK+8eU+yde0c5ZziVN0uP027oSzhsKVZM6CyinR3gfPXe0MQeoJVzxAR24gejA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BUSStQxY9r2LqJojz5abTIg8yzc92LLX/P/Vk7bWipQaBhNCiGPvRenCSbt9TUlb9F5YRE0RjG/WOjJUzklTCSdvb7DQySFcMStMvzQ37jbBd44NT+ERLEom9bw1N12WEGNfni6c7EDrYBPcIUbQBSrKzhub6V/3fDCXqpwCZYE=
Received: by 10.90.113.20 with SMTP id l20mr4229099agc.1174321010608;
        Mon, 19 Mar 2007 09:16:50 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 19 Mar 2007 09:16:50 -0700 (PDT)
Message-ID: <cda58cb80703190916g7851000dn7defeaa09eb038f@mail.gmail.com>
Date:	Mon, 19 Mar 2007 17:16:50 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	mbizon@freebox.fr
Subject: Re: [PATCH] Always use virt_to_phys() when translating kernel addresses
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1174320169.32046.113.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45FE5ADA.3030309@innova-card.com>
	 <1174320169.32046.113.camel@sakura.staff.proxad.net>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/19/07, Maxime Bizon <mbizon@freebox.fr> wrote:
>
> On Mon, 2007-03-19 at 10:41 +0100, Franck Bui-Huu wrote:
>
> Hi Franck,
>
> > This patch fixes two places where we used plain 'x - PAGE_OFFSET' to
> > achieve virtual to physical address convertion. This type of convertion
> > is no more allowed since commit 6f284a2ce7b8bc49cb8455b1763357897a899abb.
>
> I think you should also review arch/mips/mm/dma-noncoherent.c, it seems

dma-noncoherent.c has been removed since commit
9a88cbb5227970757881b1a65be01dea61fe2584. But you're right the new
'dma-default.c' still needs to be fixed...
-- 
               Franck
