Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 02:09:00 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:61593 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493520AbZKTBIy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2009 02:08:54 +0100
Received: by ywh3 with SMTP id 3so2941731ywh.22
        for <multiple recipients>; Thu, 19 Nov 2009 17:08:47 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=8vqJvzB9oV+7rV+cJSHHpHvS3CIcg8bSuXeuNWY3rCQ=;
        b=IWi/QCMTta9wIS6AXv8obh5bpprDb+5rh7lZ7MGULF4cnWpm4D1xrIp2+noC7rofV6
         kcewjMG6Gm00zsheEyTo4CgnWWIauy7isOGkn0O75+gEkNGeaKZe5gQkLPK6Nt8gj5qa
         uiInF9eZIyAmr+EHHrr+PUUSDuy5ZuduxJ0eM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=tV1m3DfI4Q6HUnabYVNoWY1HIkC/PqiB+XUwl2YoIcLQvXgQcSFC4NgxrmcdfW0fiC
         m+3c37vaubF5GxDa+raqu1fRAxenK4zthNqu1vKUgT+SomNXzQ1DA3ld/Xr8u9q6PLGl
         IKY0QvZUAmlp2SxPdem8A9/vsxp3l96J3xNDE=
Received: by 10.150.213.18 with SMTP id l18mr1399092ybg.183.1258679327344;
        Thu, 19 Nov 2009 17:08:47 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm383214ywh.46.2009.11.19.17.08.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 17:08:46 -0800 (PST)
Subject: Re: [PATCH 5/5] [loongson] yeeloong2f: add platform specific
 support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Richard Purdie <rpurdie@rpsys.net>, lm-sensors@lm-sensors.org,
	Jamey Hicks <jamey@crl.dec.com>
In-Reply-To: <4B05BBC6.2010000@ru.mvista.com>
References: <cover.1258651050.git.wuzhangjin@gmail.com>
	 <08cd92bb27734174fd53df79cc926e76400d586d.1258651050.git.wuzhangjin@gmail.com>
	 <1258653766.14308.13.camel@falcon.domain.org>
	 <4B05BBC6.2010000@ru.mvista.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 20 Nov 2009 09:08:33 +0800
Message-ID: <1258679313.1808.13.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-11-20 at 00:42 +0300, Sergei Shtylyov wrote:
[...]
> >  
> > -static void yeeloong_apm_get_power_status(struct apm_power_info *info)
> > +static void __maybe_unused yeeloong_apm_get_power_status(struct
> > apm_power_info
> > +		*info)
> >   
> 
>    Your patch is line-wrapped.
> 
Yes, I found it, thanks! I have merged this one into "[PATCH v1]
[loongson] yeeloong2f: add platform specific support".

Best Regards,
	Wu Zhangjin
