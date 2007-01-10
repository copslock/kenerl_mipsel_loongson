Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 16:38:53 +0000 (GMT)
Received: from p549F72FE.dip.t-dialin.net ([84.159.114.254]:33981 "EHLO
	p549F72FE.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20039514AbXAJQig (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 16:38:36 +0000
Received: from wx-out-0506.google.com ([66.249.82.236]:22526 "EHLO
	wx-out-0506.google.com") by lappi.linux-mips.net with ESMTP
	id S136830AbXAJOwQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 15:52:16 +0100
Received: by wx-out-0506.google.com with SMTP id t14so133838wxc
        for <linux-mips@linux-mips.org>; Wed, 10 Jan 2007 06:52:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sByzxjlNVYkuk6BrJptTOrhUuj/GhqIrS+VRKS8rg4QLfVPvVEG4Gh1jDw+MJ8HkKCP1EwTNMq7/m08dnwyF3l/POEbLz5WH/QP0CnwDhS5L+93OysKRsWDBcczVu6EJHsdhqI2csBajLhJz4SN1N53Rr6/1WepHmKZdFZoiRdo=
Received: by 10.90.78.1 with SMTP id a1mr283162agb.1168440735745;
        Wed, 10 Jan 2007 06:52:15 -0800 (PST)
Received: by 10.90.104.20 with HTTP; Wed, 10 Jan 2007 06:52:15 -0800 (PST)
Message-ID: <cda58cb80701100652l218d6d32m39242f2da8942caf@mail.gmail.com>
Date:	Wed, 10 Jan 2007 15:52:15 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070110112054.GA6193@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <20070110112054.GA6193@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/10/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> So this series now works for me, both 1/2 along and 1/2 + 2/2 applied.
> So I'll drop this into the 2.6.21 queue.
>

Great !

What did the console say when 1/2 was applied alone ?

Did you try to set PHYS_OFFSET to something different from 0 when 1/2,
2/2 are applied ? If so, does mem_map[] size decrease ?

Thanks for your time.
-- 
               Franck
