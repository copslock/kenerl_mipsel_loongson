Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2009 16:09:06 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.152]:16639 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S21365700AbZAKQJE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2009 16:09:04 +0000
Received: by fg-out-1718.google.com with SMTP id d23so3597383fga.32
        for <multiple recipients>; Sun, 11 Jan 2009 08:09:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UefxnE99J9DrXPQQpvzAi+yJrLRo5QTvb+jX/SiimGI=;
        b=xuShZJPaTzqHjaZBcfNDDPr3SFKDiaamSyVArV2bEGzgNZLVuItnfQqOjCDBXCSMM6
         CcGntGSW6PYQylrSZAMm0aefWrr9wmyr8M4gLMA9Ycr2vFEIAkEd+wyAo2olIJQRvWkC
         oK5y943GKBGBTNdLg6ZJpSnQBAFWvBwl4E8uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vPXDSP5eJ2WoeQelKMAKIyZjsDoEw0h2brqdYbSAW9qMXmSwfzJsWnX/FLsfheKvLU
         tayfZQJfEZzY0Sk3LiEEhdqEmspEa+/CBQiMMKm9/a09CPrgdNJ9LCSYFmsHvyghMzGq
         jXwgUD7I9KjyMROWCP+9VaqPUaw3vaSix8P9I=
Received: by 10.86.84.18 with SMTP id h18mr16110622fgb.22.1231690143194;
        Sun, 11 Jan 2009 08:09:03 -0800 (PST)
Received: from ?192.168.1.23? (93.17.192-77.rev.gaoland.net [77.192.17.93])
        by mx.google.com with ESMTPS id 3sm6848015fge.37.2009.01.11.08.09.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 08:09:02 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] define io_map_base for rc32434's PCI controller
Date:	Sun, 11 Jan 2009 17:08:58 +0100
User-Agent: KMail/1.9.9
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
References: <1226445364-5402-1-git-send-email-n0-1@freewrt.org>
In-Reply-To: <1226445364-5402-1-git-send-email-n0-1@freewrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901111708.59195.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Ralf,

This patch still applies to current linux-queue/linux.git, can you merge it 
please ? Thanks a lot.

Le Wednesday 12 November 2008 00:16:04 Phil Sutter, vous avez écrit :
> The code is rather based on trial-and-error than knowledge. Verified Via
> Rhine functionality in PIO as well as MMIO mode.
>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> Tested-by: Florian Fainelli <florian@openwrt.org>
> ---
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
