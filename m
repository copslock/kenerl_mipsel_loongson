Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 08:24:45 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:55936 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492067AbZKJHYi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Nov 2009 08:24:38 +0100
Received: by pwi15 with SMTP id 15so2502818pwi.24
        for <multiple recipients>; Mon, 09 Nov 2009 23:24:31 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=RFQGElvsNKNnxLm+zNIK0XfV9ucvWMVumezfVlDS5ws=;
        b=vPZemaqucE5DxrrkHH/JKVvJMStwIXaeihKWpRZSDMDyCy4EDEN+AXSMbXv0498QIN
         BTtzjFcT690dcrUK4KKtPraCxrEgS3phQ3OEQTSunX8nqBNm8/BSnTFXsJaXVRPFszsV
         Fu9NSx9i5iTOZtUbXeQEBgQe60U+CFOv7mrEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=EN6iJ7xDA8v7RWsryrk672V+egr0wIKY1pf+h5qRVwwSR+AAsMpMlBfNT9NABKYRFA
         8yq3uvHIwvUXJSA6PWTxsZp2DiSfM2C1ThoZ5M1ubBJfDuSI9ol2kfM9+K3ZyGFtPhq3
         jUKAbmUX2w2zqvNApDny7vU406Oeg8sX1KO2k=
Received: by 10.115.103.9 with SMTP id f9mr15981588wam.112.1257837871175;
        Mon, 09 Nov 2009 23:24:31 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm270832pzk.2.2009.11.09.23.24.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 23:24:30 -0800 (PST)
Subject: Re: [PATCH v1 1/3] RTC: rtc-cmos.c: fix warning for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Paul Gortmaker <p_gortmaker@yahoo.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
In-Reply-To: <20091105074107.GA12826@linux-mips.org>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
	 <a91e34bf2595157830d599cb66becd52247b1819.1257383766.git.wuzhangjin@gmail.com>
	 <20091105074107.GA12826@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 10 Nov 2009 15:24:26 +0800
Message-ID: <1257837866.2822.47.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-11-05 at 08:41 +0100, Ralf Baechle wrote:
> On Thu, Nov 05, 2009 at 09:21:54AM +0800, Wu Zhangjin wrote:
> 
> > This patch fixes the following warning with RTC_LIB on MIPS:
> > 
> > drivers/rtc/rtc-cmos.c:697:2: warning: #warning Assuming 128 bytes of
> > RTC+NVRAM address space, not 64 bytes.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
>
>   Ralf

Hi, Paul or Alessandro

Could you please apply this pathset?

thanks!

Regards,
	Wu Zhangjin
