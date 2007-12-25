Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Dec 2007 17:35:57 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.173]:9869 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S28576562AbXLYRft (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 25 Dec 2007 17:35:49 +0000
Received: by ug-out-1314.google.com with SMTP id k3so1310093ugf.38
        for <linux-mips@ftp.linux-mips.org>; Tue, 25 Dec 2007 09:35:39 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RiVsQZ51Yr5B96HvHMyDueMOvn/xPBis6n+3saIs06c=;
        b=l4gY1CPMYYCJ0J8tI5p29peEivRXUeIXSPPtb8KRolPhpeKhEI4MuYoGiDPZOIGjtA5SA3Cb76VWSZl0liobnSZkxlSrEOnvU9oFDSn24r6KK5Ncch6sMZRbfy0My99OXHoQwgYZ0HVk7cnfc0mzR53eW4T/omMNmuCN+wIv9Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uRR2/EQVgbpQJCrDi2JR8lCSGgXKJGbIJNhKLkj9tfG5iR6sGk59S2Ml3NMqRjs4iAWsB2SIvS1xJtI2yuzAKyfvnQNelKJQSTs0gxjrh7Vnu12r+JC1zPoYJB85fWcdf8pIh0mw29H96RHIM+AIX96hgOcY8tg3w4VXjbOcOrI=
Received: by 10.67.116.7 with SMTP id t7mr4941512ugm.38.1198604138745;
        Tue, 25 Dec 2007 09:35:38 -0800 (PST)
Received: by 10.67.117.17 with HTTP; Tue, 25 Dec 2007 09:35:38 -0800 (PST)
Message-ID: <9e0cf0bf0712250935m57b36328h91bdcd45eee5987e@mail.gmail.com>
Date:	Tue, 25 Dec 2007 19:35:38 +0200
From:	"Alon Bar-Lev" <alon.barlev@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [MIPS] MEM_SDREFCFG is not defined for Alchemy DB1550 (compile fail)
Cc:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	"Ralf Baechle" <ralf@linux-mips.org>
In-Reply-To: <47713B7A.9050102@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e0cf0bf0712230733o3dfd54fcp4962ebf3f84cdff@mail.gmail.com>
	 <4770DE51.5000205@ru.mvista.com>
	 <9e0cf0bf0712250904t213d623bp977db54b6be5e3e@mail.gmail.com>
	 <47713B7A.9050102@ru.mvista.com>
Return-Path: <alon.barlev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alon.barlev@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/25/07, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > So suspend modes on these boards are not supported?
> > Only "Always On" configuration is supported?
>
>     Sleep mode is supported according to the code. But as I've said PM bits
> haven't been maintained -- probably since the submission.

Thanks!
Will it be maintained? Are there any plans?
Is there, a missing features list (TODO)?
Or this is completely unsupported board?

Best Regards,
Alon Bar-Lev.
