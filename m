Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2009 17:52:46 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:455 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S21365086AbZANRwn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Jan 2009 17:52:43 +0000
Received: by bwz6 with SMTP id 6so1979178bwz.0
        for <multiple recipients>; Wed, 14 Jan 2009 09:52:37 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=b24Tn7uxHsu4PkCmu4kjy+V6Jn4JnfB0fMTsfut/Yts=;
        b=aF/pXf+mZMxqetW/ZL3oxRAY2NfmOyimBly9CZMT3Bf8s7Vg8wnArxcW6yu+7Qz3hS
         foFu/QBZJ/DU465bNbca/4QlZcmBZCFZwZLf9Ib6fhM2ypVuQS2SVLXcgaXo3mfCp5r0
         O0YK87JjF3Uw5zV63AZ5o8rvBtSzd2K6sqKb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=a5T1uXk/s9UJOp3hEHse73/hBzf6EUat/W43+hja8+qMBunLt+6IvgoQwqgPauXAsb
         FAcp/GbR4yZtBKwGHCjLf6jne1eXkush3ryDlnuXDauU4Kd142rKRizpg25P6tzBU/rT
         S6ARJEgsIclzEHujZrx3vIP+utVftAC8cKMIE=
Received: by 10.103.229.12 with SMTP id g12mr208623mur.16.1231955557223;
        Wed, 14 Jan 2009 09:52:37 -0800 (PST)
Received: from ?157.159.15.69? ([157.159.15.69])
        by mx.google.com with ESMTPS id s10sm61458664muh.7.2009.01.14.09.52.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 09:52:36 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] MIPS: rb532: detect uart type, add platform device
Date:	Wed, 14 Jan 2009 18:52:20 +0100
User-Agent: KMail/1.9.9
Cc:	Linux-Mips List <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>
References: <1231954029-13860-1-git-send-email-n0-1@freewrt.org>
In-Reply-To: <1231954029-13860-1-git-send-email-n0-1@freewrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901141852.20918.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Phil,

Le Wednesday 14 January 2009 18:27:09 Phil Sutter, vous avez écrit :
> Auto-detection works just fine, so use it instead of specifying the type
> manually. Also define a platform device for the uart, as suggested by
> David Daney.

Thanks !

>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
Acked-by: Florian Fainelli <florian@openwrt.org>

-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
