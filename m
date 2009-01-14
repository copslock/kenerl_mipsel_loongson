Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2009 18:02:14 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:28147 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S21365086AbZANSCM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Jan 2009 18:02:12 +0000
Received: by bwz6 with SMTP id 6so1993336bwz.0
        for <multiple recipients>; Wed, 14 Jan 2009 10:02:06 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jcAqcVa4JM82rzh1IRnKm7umuPY28E6ZgDtV4Kj2paA=;
        b=JeX+Cffo8P06OrckH0xc0YY22lOk8RVllf30ZpWbWr5Fsyz1Qy7CyPhjm5FSLDZrGC
         UsCpfqaeeNctZIEpXTQnQs69i8piV7G8iAujgCJWhfo4I1HgYUV3OSVsknwqlFSaCv9O
         1lq/5NR/EruTms0kf6n5ORlm81N7iI3PuRWEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=a/78NA6GHO6affA0BPwMRUIc3EvVTG7/IaNVyUGYmmwIvGgnZw+67oTACGrKRys12W
         YwvsSV/wa8BAv5B6O2pjurxtXvhKsGBdYV37j8r/8FK+BykNspx889BmZ22exijT3h4Z
         OCUhJwqt78EArtlMsUBCk5sF6VDjDJXwgSX+A=
Received: by 10.103.172.9 with SMTP id z9mr214050muo.39.1231956124399;
        Wed, 14 Jan 2009 10:02:04 -0800 (PST)
Received: from ?157.159.15.69? ([157.159.15.69])
        by mx.google.com with ESMTPS id s10sm61475406muh.7.2009.01.14.10.02.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 10:02:03 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] MIPS: rb532: use driver_data instead of platform_data
Date:	Wed, 14 Jan 2009 19:01:47 +0100
User-Agent: KMail/1.9.9
Cc:	Linux-Mips List <linux-mips@linux-mips.org>, jeff@garzik.org,
	ralf@linux-mips.org
References: <20090112.215202.194850308.davem@davemloft.net> <1231954874-31245-1-git-send-email-n0-1@freewrt.org>
In-Reply-To: <1231954874-31245-1-git-send-email-n0-1@freewrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901141901.47947.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Wednesday 14 January 2009 18:41:14 Phil Sutter, vous avez écrit :
> As the korina ethernet driver uses platform_get_drvdata() to extract the
> driver specific data from the platform device, driver_data has to be
> used here.

Right, thanks for changing this.

>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>

Acked-by: Florian Fainelli <florian@openwrt.org>
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
