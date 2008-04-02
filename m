Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 14:46:18 +0200 (CEST)
Received: from fk-out-0910.google.com ([209.85.128.185]:10878 "EHLO
	fk-out-0910.google.com") by lappi.linux-mips.net with ESMTP
	id S525111AbYDBMqJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Apr 2008 14:46:09 +0200
Received: by fk-out-0910.google.com with SMTP id f40so7147275fka.0
        for <linux-mips@linux-mips.org>; Wed, 02 Apr 2008 05:45:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=vE8PlF/QgpsKhdQ3nQGmQHoGnLSxOlr5STkGRUz8CN8=;
        b=MEZ2vy6R/Pm6cz+qqs+QTLxSU2GdpkZqsPVNzAHWRAsaUwXPZ+WCHFRRoOYrQO8Jfhlf6edyE7tMHkVbu3ql0xSR5zNFfDsrylEQnXwFfbNiHVqme03TKABauIbstGYGpZxBJmokD1USNyytxsht8JVGl3uQ9tWkTXcUcphoSTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Y3MLfMZKqsjeRrDRpnzFHGHfPxvjDhg6x+aFJYiAR3ZnM+VxFgFq05XEWE4kjVYTtXz/j2+p+qbr6F1lnkTpPYdm9Qha+eo1ttlSPftkZb7bog+jaPDdwUV7pk48AHLER1kmTQdH5BPugIIoIPwJNG+h6ojUGUQcOKH+/HKH8V4=
Received: by 10.82.121.15 with SMTP id t15mr23655567buc.8.1207140346512;
        Wed, 02 Apr 2008 05:45:46 -0700 (PDT)
Received: from ?192.168.1.3? ( [91.76.28.42])
        by mx.google.com with ESMTPS id u14sm2117561gvf.1.2008.04.02.05.45.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Apr 2008 05:45:45 -0700 (PDT)
Message-ID: <47F37FF6.50206@gmail.com>
Date:	Wed, 02 Apr 2008 16:45:42 +0400
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] [MIPS] unexport null_perf_irq() and make it static
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>	<1207094318-21748-6-git-send-email-dmitri.vorobiev@gmail.com> <20080402.213817.74752727.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080402.213817.74752727.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto пишет:
> On Wed,  2 Apr 2008 03:58:38 +0400, Dmitri Vorobiev <dmitri.vorobiev@gmail.com> wrote:
>> --- a/arch/mips/oprofile/op_model_mipsxx.c
>> +++ b/arch/mips/oprofile/op_model_mipsxx.c
>> @@ -31,6 +31,8 @@
>>  
>>  #define M_COUNTER_OVERFLOW		(1UL      << 31)
>>  
>> +int (*save_perf_irq)(void);
> 
> This should be another target of "make it static" patch :-)

Indeed. Thank you for noticing that.

> 
> ---
> Atsushi Nemoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
