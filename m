Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 14:16:53 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.228]:1185 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037518AbXCEOQu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 14:16:50 +0000
Received: by hu-out-0506.google.com with SMTP id 22so1327156hug
        for <linux-mips@linux-mips.org>; Mon, 05 Mar 2007 06:15:49 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BWutyqVkxnzVuLWswrmL2hXQF9gOTii2Lyb5pL5vhBVC0Tn3+fMXAiktAcZmmI6Wwxa/hB8j6MDCL6ETZd2nCA0FblQZBUFPGnqkS54ApmMT7nh5dVpCv3B2qAJMrRxglZFavF6j8NfNjf4FedUQa6B9KUE1VWjPgC4FT6QwQZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VHCPWbrFy+jZbqLWkdt6sC1hCgc50FntDL/x+pQnJuTWMtrrBrY5A6SwD76ic55lcZCbVluSUPXaG61l2Esn7Wh2KveNzI4lUJvKqAJRPEAFCA3RIll9LavHszQN/cksyhyTKlB/4cx23kfC2D85VN1eN/LfF+KASSXJMKE5Tb8=
Received: by 10.114.202.15 with SMTP id z15mr1270833waf.1173104147291;
        Mon, 05 Mar 2007 06:15:47 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Mon, 5 Mar 2007 06:15:46 -0800 (PST)
Message-ID: <cda58cb80703050615r4e559ca1u78517634ac23a27@mail.gmail.com>
Date:	Mon, 5 Mar 2007 15:15:46 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	mbizon@freebox.fr
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Cc:	ralf <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1172879147.964.65.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <1172879147.964.65.camel@sakura.staff.proxad.net>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 3/3/07, Maxime Bizon <mbizon@freebox.fr> wrote:
> Looking at phys_to_virt(), it looks like I also need to change
> PAGE_OFFSET to 0x90000000 to get correct values. This makes the kernel
> boot with a correct memory map, but userspace doesn't work anymore.

No phys_to_virt() should already take care of that:

static inline void * phys_to_virt(unsigned long address)
{
        return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
}

Does your platform code do some address translation by using
CPHYSADDR() macro or by using anything else than pa() ?

>
> Just in case, I'm not using git head, but a 2.6.20 kernel with the 2

2.6.20 should be OK. This patchset need some commits which have been
applied before.

> patches applied. Just tell me if you need complete dmesg.
>

yes, please, it may help. Can you send your config file as well ?

Just to be sure, is your PAGE_OFFSET equal to 0x80000000 ?

Thanks
-- 
               Franck
