Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 15:57:00 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.239]:41257 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038870AbXBLP44 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Feb 2007 15:56:56 +0000
Received: by qb-out-0506.google.com with SMTP id e12so607185qba
        for <linux-mips@linux-mips.org>; Mon, 12 Feb 2007 07:55:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZSKdRfsSIzSQzMjG5C3j6e7L1ELII5rTmFtxIkwDNh4NEongGRlLsJZlaK+C66aD9VP5PMO9nhgKGT7nbBKsMgzwxhA9fUFwcv2KGdAdZ5tw281dtWbYY0IMaB4uD9D2YcuZbebewS/4EBBwdRRZN7Np+ICzWmISEJmY6/NCM8s=
Received: by 10.115.108.1 with SMTP id k1mr5935110wam.1171295750280;
        Mon, 12 Feb 2007 07:55:50 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Mon, 12 Feb 2007 07:55:50 -0800 (PST)
Message-ID: <cda58cb80702120755hc47504fmd1fb570f7c5c3e19@mail.gmail.com>
Date:	Mon, 12 Feb 2007 16:55:50 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] clean up ret_from_{irq,exception}
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20070212.234538.25910340.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45C8A477.8070906@innova-card.com>
	 <20070211.004020.79071872.anemo@mba.ocn.ne.jp>
	 <cda58cb80702120044o6c434032pc2f3da68a7327097@mail.gmail.com>
	 <20070212.234538.25910340.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/12/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> _ret_from_irq is used by dec/int-handler.S directly, so you should not
> remove it (though decstation_defconfig disables CONFIG_PREEMPT).
>

woah, you're right. the name '_ret_from_irq' looks so private to me
that I didn't think that some other code could use it...

> But looking at dec/int-handler.S again, I can not see why it uses
> _ret_from_irq, and why it manipulates TI_REGS($28) in handle_it ...
>
> It seems dec/int-handler.S has been broken for a while.  I'll send a
> patch to fix it.  If it was ACKed, I ACK your patch.
>

ok I'm waiting...
-- 
               Franck
