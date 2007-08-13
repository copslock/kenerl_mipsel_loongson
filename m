Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2007 16:57:07 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.188]:22196 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022661AbXHMP47 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Aug 2007 16:56:59 +0100
Received: by nf-out-0910.google.com with SMTP id c10so498900nfd
        for <linux-mips@linux-mips.org>; Mon, 13 Aug 2007 08:56:58 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=c88YPGN7bAxM2f1bwRpCI89utZzp8AJsbTK41RN9riwwb9dIUmXxfUyRLD+TZEZp8IscdzplpfOeY+GNENV6RvH4vta3dk617AAMxLoivUMADJ9cHwbZ+yUtk3dAVhAMr12nVpA9FQaFEPs185xr1FnYb27D1lvoXecqx/YP99I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fkR8kXEMHOrLiUkdKsqqdZBshwsu511LqLomzYekbJdfz+Y+2dRj43Ee+k91v2TuvC/AyieIqEslipIEoj56w+x12wl6XQae+SKWWThBqOkH9szVC0VAFa2EtHG/WChoBm7Gi6lgm7CSkj7vnXU3lBrAIDeqjuPtyIApf+LNXxM=
Received: by 10.86.60.7 with SMTP id i7mr4797609fga.1187020617624;
        Mon, 13 Aug 2007 08:56:57 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id v23sm669854fkd.2007.08.13.08.56.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Aug 2007 08:56:56 -0700 (PDT)
Message-ID: <46C07F36.1070308@gmail.com>
Date:	Mon, 13 Aug 2007 17:56:38 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Use generic NTP code for all MIPS platforms
References: <S20023068AbXHMO0W/20070813142622Z+9352@ftp.linux-mips.org> <20070814.003242.59465104.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070814.003242.59465104.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Atsushi Nemoto wrote:
> With this, we now have this in Kconfig:
> 
> config GENERIC_CMOS_UPDATE
> 	bool
> 	default y
> 
> I think there are no point using GENERIC_CMOS_UPDATE for users of the
> new-style RTC_CLASS drivers or platforms with no RTC.
> 

But how the new-style RTC drivers get updated ?

		Franck
