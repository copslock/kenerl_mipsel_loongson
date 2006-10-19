Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 08:44:00 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:63697 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037479AbWJSHn6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 08:43:58 +0100
Received: by nf-out-0910.google.com with SMTP id l23so967140nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 00:43:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=HVCcm6uyeYruE1ySPUKoE42uJvQX5qgZVBteeTZS/znNQCvE+BTtwu/JOL+qdD5WCPjcaYeQQffuB/FH3IT+895Y89RJwl3Tf01ftQWAZd+iirs0dT3jzZtWxC7wx1xlSm7+fM2wiKvUGRTQ6byATDI+osaRP9uuZV6m3JZOyoM=
Received: by 10.49.75.2 with SMTP id c2mr5315915nfl;
        Thu, 19 Oct 2006 00:43:58 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id k23sm346671nfc.2006.10.19.00.43.57;
        Thu, 19 Oct 2006 00:43:57 -0700 (PDT)
Message-ID: <45372CBC.9090602@innova-card.com>
Date:	Thu, 19 Oct 2006 09:43:56 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	yoichi_yuasa@tripeaks.co.jp, vagabon.xyz@gmail.com,
	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 2/7] Make __pa() aware of XKPHYS/CKSEG0 address mix for
 64 bit kernels
References: <1160743146824-git-send-email-fbuihuu@gmail.com>	<20061019.130133.108306753.nemoto@toshiba-tops.co.jp>	<20061019154138.0343bbd0.yoichi_yuasa@tripeaks.co.jp> <20061019.160145.63741509.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061019.160145.63741509.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 19 Oct 2006 15:41:38 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
>>> +#define _LLCONST_(x)	x ## L
>>             ^^               ^
>> The name is not corresponding to reality.
>> It's not so good.
> 
> Indeed.  How about this?
> 

or why not simply replacing _LLCONST_ usages by _LCONST_ ? After all,
64 bits value seems to be used only for 64 bits kernels.

		Franck
