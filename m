Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 15:18:01 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:3896 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022644AbXIDORw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Sep 2007 15:17:52 +0100
Received: by nf-out-0910.google.com with SMTP id 30so1460468nfu
        for <linux-mips@linux-mips.org>; Tue, 04 Sep 2007 07:17:34 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=e9ySAgG+6usmV11pKZejrRc+4efxFR0mCg+USoGQyxC4bU1XPh0qdZtAQv4r54FY012pjDFHmBd97m4mjWniNRgMpVsNTUTXrftRUoglwP4wYlaqKtLgBWepShiQEg3yz0SG3Ejc2Nv/hzPraC0T3fGYcxOk3OHr0F29f21x1jM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IOYrIHFDGuiGU64rAlrzWIVA0hg19eAbC4esi5fADU8zHAwmkTFozEeSRIYpP9ac8pXxPrhKMxxpMf+wv4Fk3PesvUf7Fzi/GRG03C22W26u3Hs9Anxgnrj6PXz5L2NldJaaKLIM7L0dDhUqwvnbkpgJG56lp/jFypFT8bSLTBI=
Received: by 10.78.188.10 with SMTP id l10mr4170784huf.1188915453844;
        Tue, 04 Sep 2007 07:17:33 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id s34sm1813554hub.2007.09.04.07.17.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Sep 2007 07:17:29 -0700 (PDT)
Message-ID: <46DD68F3.4030907@gmail.com>
Date:	Tue, 04 Sep 2007 16:17:23 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
References: <46DD53BE.2070004@gmail.com>	<20070904.225402.106261140.anemo@mba.ocn.ne.jp>	<46DD6616.6030303@gmail.com> <20070904.231608.51867742.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070904.231608.51867742.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 04 Sep 2007 16:05:10 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> Yeah, that what I think too and that's also why I was suggesting to
>> test a plain 2.6.23-rc5 with the randomize_va_space=0. Please see my
>> previous reply...
>>
>> Could you give it a try ?
> 
> OK, I'll try it in a few days...

thank you, Atsushi.

		Franck
