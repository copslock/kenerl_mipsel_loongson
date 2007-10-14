Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 20:25:15 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:59045 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20035403AbXJNTZG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 20:25:06 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1092931nfd
        for <linux-mips@linux-mips.org>; Sun, 14 Oct 2007 12:24:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=dVQzCWFPkDhqmR4szy5u5H6O/G62/S7fq5Q/omABvgg=;
        b=M9/HO/tVnY6P61Cszs1fFFj1JWAmAUXPfFPRhXhuaqfxDpdbOMTQSiiHUFMrsNt/7JLS54OZTrcXlLqUEtuP4U5tUAa9l5Bvj1IK6rcMcBRvm4iDB4ZzUcSY7You/0FSfNsQd2FNw2yFQaYZITstmXj4NAAQaWF7+dRRxwZ6VN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dX8FBsTK2TuFbEPp4mFNrdCfxqByn6AWK05kjHe1X1NTZVTZzlx5OW/nE9UhqEzRZUOvrR46cNUmtiT7Av2zaHDo0888y8R161V765K7Uj9Kc4cczt0mPrACPG3fmx+ce1xLrK7KJjhyvWHO8Lmotu1dJFShYanUe52H2Px6CIM=
Received: by 10.86.78.4 with SMTP id a4mr4352037fgb.1192389888857;
        Sun, 14 Oct 2007 12:24:48 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id g1sm5722045muf.2007.10.14.12.24.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 12:24:47 -0700 (PDT)
Message-ID: <47126CD3.7020309@gmail.com>
Date:	Sun, 14 Oct 2007 21:24:03 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] tlbex.c: Cleanup __init usages.
References: <470F16B9.7030406@gmail.com>	<470F170E.1060303@gmail.com> <20071012.180742.59650681.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20071012.180742.59650681.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 12 Oct 2007 08:41:18 +0200, Franck Bui-Huu <fbuihuu@gmail.com> wrote:
>>  #define I_0(op)							\
>> -	static inline void __init i##op(u32 **buf)		\
>> +	static inline void i##op(u32 **buf)		\
>>  	{							\
>>  		build_insn(buf, insn##op);			\
>>  	}
> 
> This causes section mismatches, since i_tlbwr and i_tlbwi can not be
> inlined (see head of build_tlb_write_entry()).
> 

You're right. I compiled tlbex.o alone and missed that.

> Maybe __init __maybe_unused is preferred?
> 

Yes I'll do that.

Thanks,
		Franck
