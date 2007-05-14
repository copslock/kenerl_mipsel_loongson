Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2007 08:27:35 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.178]:39302 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022520AbXENH1d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 May 2007 08:27:33 +0100
Received: by py-out-1112.google.com with SMTP id u52so1375772pyb
        for <linux-mips@linux-mips.org>; Mon, 14 May 2007 00:27:32 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VmQjC06s3H8EtLsiex1Lu3rPeH+zJfx0mhCYfC1p+TqlVTjSXWDD1sHin8/e+5rCnb0XY9dTGvkchTw0XlWgifYV/AjmufaW+poF6DpwST+53UjtdYulrW1boiaIz3OAGR+IK7lTxJ+boo99Ia+p7himldcpyNgtTg6OGA9x5sA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ks7MNno5C5hpQ0fIFiPFhGU6EwCEN7w+G2G8mgpvryKRkMNwMzlsVV9CQTKZNC+csJgr86BCBgiGCiukIpoB1DOFynf3B9qT6tkXLVSZcffW5YvyOBuD1fsZNNBXJxS30W7kTqXgQy72n+y1mEf9vNGPneYN4RYOP9idOZg/KK4=
Received: by 10.65.220.8 with SMTP id x8mr9734057qbq.1179127652241;
        Mon, 14 May 2007 00:27:32 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Mon, 14 May 2007 00:27:32 -0700 (PDT)
Message-ID: <cda58cb80705140027t70a526c0idb2b70af28c17f4e@mail.gmail.com>
Date:	Mon, 14 May 2007 09:27:32 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
In-Reply-To: <20070512185854.GA8647@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
	 <20070512.005905.26096031.anemo@mba.ocn.ne.jp>
	 <cda58cb80705111223y5e94eafcy710b878517c48c48@mail.gmail.com>
	 <20070513.014713.74753298.anemo@mba.ocn.ne.jp>
	 <20070512185854.GA8647@uranus.ravnborg.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/12/07, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sun, May 13, 2007 at 01:47:13AM +0900, Atsushi Nemoto wrote:
> > Subject: [PATCH] MIPS: Simplify missing-syscalls for N32 and O32
>
> This is overengineered. The only reason to make the syscall check
> for each and every build was that this was easy and the missing syscalls
> are easy to spot during a normal build.

Well perhaps we shouldn't check for missing syscalls for a normal
build. After all, it's going to be used by arch maintainers or kernel
developpers once in a while (maybe every releases). So why not make it
optional ?

        $ make CHECK_SYSCALL=1

or

        $ make check-syscalls

> But checking all combinations is just not worth it.
> The arch responsible are assumed to build for the different architectures
> once in a while so a missing syscall are likely to be detected anyway.
>
> We cannot run each and every consistency check in all combinations
> for each build - that would end in only build noise.
>

That's not exactly the case, see Atsushi's reply.

-- 
               Franck
