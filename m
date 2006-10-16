Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 15:51:42 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:44216 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039621AbWJPOve (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 15:51:34 +0100
Received: by nf-out-0910.google.com with SMTP id l23so2509251nfc
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2006 07:51:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=iRmMAAUBSYPq1oVRRc3ydaxLpTuBoOvcbGsyoj9qD5df41wvTCm8veN389I7RR2nd5S/22fmhXvk5VAR5tygT7Y1Eidd7d0vK12tihpSQ/MlfP8aY5JUkuROyAtBgSVKio7GThopF/rHnB75CsfBwVlrD6qeAt8meNLP2Fp5wSU=
Received: by 10.49.43.2 with SMTP id v2mr12279492nfj;
        Mon, 16 Oct 2006 07:51:34 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id n22sm956420nfc.2006.10.16.07.51.33;
        Mon, 16 Oct 2006 07:51:34 -0700 (PDT)
Message-ID: <45339C78.70508@innova-card.com>
Date:	Mon, 16 Oct 2006 16:51:36 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <45333CC1.3090704@innova-card.com>	<20061016.171046.55511403.nemoto@toshiba-tops.co.jp>	<45334765.6000805@innova-card.com> <20061016.180740.88700024.nemoto@toshiba-tops.co.jp> <45339A6B.2050406@innova-card.com>
In-Reply-To: <45339A6B.2050406@innova-card.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Atsushi Nemoto wrote:
>> On Mon, 16 Oct 2006 10:48:37 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> thanks but it doesn't explain anything either...Anyways what about this
>>> patch on top of the previous one ?
>>> +	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + sizeof(u32) * 2 + 1));
>> This breaks the addinitrd.  You mean this perhaps?
>>
>> initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + sizeof(u32) * 2)) - sizeof(u32) * 2;
>>
> 
> you're right, but I really don't see how this work and IMHO this
> code is broken.

nope it's not, I just realised what is it for, see my reply to Thiemo.

		Franck
