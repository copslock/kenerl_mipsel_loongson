Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 22:09:11 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.172]:9701 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20029618AbYBSWJI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Feb 2008 22:09:08 +0000
Received: by ug-out-1314.google.com with SMTP id u2so699949uge.39
        for <linux-mips@linux-mips.org>; Tue, 19 Feb 2008 14:09:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=BXWoEQiiKvM56WHhwbM2D7ozmXuA7ZCYBSswilx5gAY=;
        b=qA1HZVpLYVu6SJUwtqQU/sDU/5k9FCYlZod/2NlN+2e0E3/5XcAzDQsg0ld0E29IUINsaaJ1H55ggNsYJDpGA98JqycJA4zvSTvBCD+qMZ2zYusUlF/xpAqFznev/GUXE6LK5xKT5fHOt05HsqJoHLD+KlriCOCI/TjE+CjxyKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jLdGnDeuRMHXtClNu9awwmxjlNg5Js+AeJphdybIjaTzGjgNvx0i9lE73qKdUH9uCW0XUXNILXWeDZI31pGn1FeZ7JDbKbwJwzPteeTHtyOUjXzexIIO+gNmdc/6SbfmzM7a89FaSBKRWTKtAd9to1Sjb+MT6cetJkq3nBwXPrA=
Received: by 10.67.116.4 with SMTP id t4mr5086398ugm.68.1203458946797;
        Tue, 19 Feb 2008 14:09:06 -0800 (PST)
Received: from ?192.168.1.3? ( [85.140.8.186])
        by mx.google.com with ESMTPS id f31sm341998fkf.15.2008.02.19.14.09.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Feb 2008 14:09:05 -0800 (PST)
Message-ID: <47BB537F.7030801@gmail.com>
Date:	Wed, 20 Feb 2008 01:09:03 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MIPS] Enable the timerfd_*() o32 system calls
References: <1203368557-32356-1-git-send-email-dmitri.vorobiev@gmail.com> <20080219141940.GA14991@linux-mips.org>
In-Reply-To: <20080219141940.GA14991@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle пишет:
> On Tue, Feb 19, 2008 at 12:02:37AM +0300, Dmitri Vorobiev wrote:
> 
>> This patch enables the system calls timerfd_create(), timerfd_settime()
>> and timerfd_gettime() for MIPS architecture.
>>
>> Please see the following Bugzilla entry for more details:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=10038
>>
>> This was tested using a Malta 4Kc board in both little-endian and
>> big-endian modes. The unit test program is available from the URL
>> above.
>>
>> Note that only the "o32"-style system calls have been added. This is
>> due to the fact that I have no suitable equipment to test the other
>> flavors of MIPS ABI.
> 
> Thanks.  I added the missing bits for the others ABIs and applied the
> combined patch.

Thank you, Ralf!

Dmitri

> 
>   Ralf
> 
