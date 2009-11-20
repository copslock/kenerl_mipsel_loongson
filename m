Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 03:10:57 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:36849 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493625AbZKTCKu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2009 03:10:50 +0100
Received: by ywh3 with SMTP id 3so2982115ywh.22
        for <multiple recipients>; Thu, 19 Nov 2009 18:10:41 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=+3SgBTnoQTtXQeDFbAivdmMX2FcK0j3coZE4sEokPHk=;
        b=Rww23InJSYyMI6gAJ6FcWVBaboLP/eyn61iWuzJKc6icWMR/O3RwBwrMZRMexeb6a9
         WY1sXX0RiE4jVCEaFiH16zyFGGrNelzcmk4kRRW6F+s3Zhi5HKWwYVR7dLu5+brvDM9t
         mT8GNDosyptGZJx0cnfFQNe6KmdkI62mDXobs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=MZMaF12JvAOEMKT8JJyw6wfeJfHVCz1jSIKvGXaYL2oLYmFShOy5qmyCEyA+jfaU9e
         gmBvuO/v0VeiBRuZRfSK1nP+qRsD1/o7icj9xK5NFxvRlBq+YB20EOeVQkYM2MUu6HZe
         irlqrqOE/Icfe5lyiBK83DWM9QCinmBFtsflo=
Received: by 10.150.46.21 with SMTP id t21mr1477971ybt.234.1258683041345;
        Thu, 19 Nov 2009 18:10:41 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 4sm401448ywi.12.2009.11.19.18.10.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 18:10:40 -0800 (PST)
Subject: Re: [PATCH v1] [loongson] yeeloong2f: add platform specific support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Richard Purdie <rpurdie@rpsys.net>,
	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com
In-Reply-To: <d1ce13aed520016726512981bd7a0280a817a5a3.1258654550.git.wuzhangjin@gmail.com>
References: <d1ce13aed520016726512981bd7a0280a817a5a3.1258654550.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 20 Nov 2009 10:10:27 +0800
Message-ID: <1258683027.2862.30.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-11-20 at 02:19 +0800, Wu wrote:
[...]
> +
> +#ifdef APM_EMULATION

This should be CONFIG_APM_EMULATION.

> +	apm_get_power_status = yeeloong_apm_get_power_status;
> +#endif
> +	return 0;
> +}
> +
> +static void yeeloong_apm_exit(void)
> +{
> +}
> +

Regards,
	Wu Zhangjin
