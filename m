Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Dec 2007 17:04:34 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.169]:2290 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S28576521AbXLYREZ (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 25 Dec 2007 17:04:25 +0000
Received: by ug-out-1314.google.com with SMTP id k3so1306217ugf.38
        for <linux-mips@ftp.linux-mips.org>; Tue, 25 Dec 2007 09:04:14 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ixh6lv2cB14se4hLyU3fB1oJyY/anfBTFv0bMmHDQwQ=;
        b=fbYoZW2UT1QP7yo3TzVUNOwc2bgxXBrWabUoIrZdQ/DF86Rvr8W7z0jcH2rkMTvjDfvwazkuOqJhqC8IvaV6uhfy3huZZ53UGY6cTvPUnVidjwwJ02BEwZjxc/7iCrjDz+4oZSa397zCkAfhbkw7GXWNnWXPAo6LIORi1mDl7Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HNG+6OslokDP9P41l0iHfbGQqUkqaf0ePKiH1fmn1xnnluiXc0LxiRv0K7CHSQxyv9OrkhVs2CJ4TEeYW2r1Rkr67A0UzGOX1qOCX7JvAZ5FruPfbapv77Fy4rOFp/hEmGoHOA2T2QE1OTSAzKW8jGmANHyz5gfbbi3QU6d/4kM=
Received: by 10.67.116.9 with SMTP id t9mr4765344ugm.77.1198602254626;
        Tue, 25 Dec 2007 09:04:14 -0800 (PST)
Received: by 10.67.117.17 with HTTP; Tue, 25 Dec 2007 09:04:14 -0800 (PST)
Message-ID: <9e0cf0bf0712250904t213d623bp977db54b6be5e3e@mail.gmail.com>
Date:	Tue, 25 Dec 2007 19:04:14 +0200
From:	"Alon Bar-Lev" <alon.barlev@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [MIPS] MEM_SDREFCFG is not defined for Alchemy DB1550 (compile fail)
Cc:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	"Ralf Baechle" <ralf@linux-mips.org>
In-Reply-To: <4770DE51.5000205@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e0cf0bf0712230733o3dfd54fcp4962ebf3f84cdff@mail.gmail.com>
	 <4770DE51.5000205@ru.mvista.com>
Return-Path: <alon.barlev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alon.barlev@gmail.com
Precedence: bulk
X-list: linux-mips

Thank you for your reply!

On 12/25/07, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>     PM code is generally broken and unmaintained, so no wonder. I don't
> remember if anyone has fixed CPU context restoration code (it uses a "skewed"
> stack frame).

So suspend modes on these boards are not supported?
Only "Always On" configuration is supported?
Or there is another method to preserve power?

Best Regards,
Alon Bar-Lev.
