Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 08:06:29 +0000 (GMT)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.192]:43950 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8224990AbULPIGY>;
	Thu, 16 Dec 2004 08:06:24 +0000
Received: by rproxy.gmail.com with SMTP id j1so1068074rnf
        for <linux-mips@linux-mips.org>; Thu, 16 Dec 2004 00:06:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=UNtRTampy3MNEU+xRTOCvQalhhgsNjPE/8UlO3N49FALIq5WyQHoHOXuuEt6MxoKK8yy7c+vY6t5yo/1Ej1pplSg6XF7wk3BpHh5+YAWLdcF69V7wqtAdFDWH1D8nW8zxYImgRHoUJjypCeqMD6lx/BawcGSKmCq7cr5j1ov16c=
Received: by 10.38.89.5 with SMTP id m5mr2239930rnb;
        Thu, 16 Dec 2004 00:06:12 -0800 (PST)
Received: by 10.38.66.71 with HTTP; Thu, 16 Dec 2004 00:06:12 -0800 (PST)
Message-ID: <73e6204504121600066a2ce0b1@mail.gmail.com>
Date: Thu, 16 Dec 2004 16:06:12 +0800
From: zhan rongkai <zhanrk@gmail.com>
Reply-To: zhan rongkai <zhanrk@gmail.com>
To: linux-mips@linux-mips.org
Subject: About task->used_math and TIF_USEDFPU
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <zhanrk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhanrk@gmail.com
Precedence: bulk
X-list: linux-mips

hi all,

I am a little confused about the task_struct member 'used_math', and
thread_info flag TIF_USEDFPU.

What are their meaning, and what is the difference between them?

thanks.
