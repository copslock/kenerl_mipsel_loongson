Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:54:34 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.236]:61038 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20044469AbXAWOya (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 14:54:30 +0000
Received: by wx-out-0506.google.com with SMTP id t14so1724202wxc
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 06:54:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cZmSrV9wNVPZOmmOi1kkUjBRMoc/EEc4F88UNMdBGX9Odx0R7JyhX/swMG36rU4SqnBx0vPAF2JblqQr8+UQIyp+HsUVqq5c/cGSwQy5F9drdlgGAbJ+V7vWUgXXTnX+oQu6mgeDKwnq+LhrgIQx94Cqppzammi9Ld+I8ePXl5c=
Received: by 10.90.90.16 with SMTP id n16mr8058403agb.1169564063352;
        Tue, 23 Jan 2007 06:54:23 -0800 (PST)
Received: by 10.90.104.20 with HTTP; Tue, 23 Jan 2007 06:54:23 -0800 (PST)
Message-ID: <cda58cb80701230654v301e9f97n15ba992b4a2653c2@mail.gmail.com>
Date:	Tue, 23 Jan 2007 15:54:23 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 0/7] Clean up signal code
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070123143214.GC18083@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1169561903878-git-send-email-fbuihuu@gmail.com>
	 <20070123143214.GC18083@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> No.  All the information in the MIPS c0_status register is priviledged.
> Unlike CISC architectures MIPS has no flags such as zero, equal, overflow
> or similar in the status register that is nothing that would constitute
> part of the thread context.
>
> The one flag one could possibly argument about might be c0_status.fr - but
> none of the ABIs or tools or application software can make use of it ...
>

OK.

> >     (b) Status register is saved by setup_sigcontext32() but
> >         not restored by restore_sigcontext(). Is it a bug ?
>
> Not really a bug but useless code, yes.  We used to save c0_status in the
> dark ages but again, no known code - not even IRIX code - relies on this
> field.
>

OK, for consistency I'll remove the saving in setup_sigcontext32()

thanks
-- 
               Franck
