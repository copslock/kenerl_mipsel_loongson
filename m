Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2009 08:57:42 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:33989 "EHLO
	mail-ew0-f174.google.com") by ftp.linux-mips.org with ESMTP
	id S20024908AbZDFH5f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2009 08:57:35 +0100
Received: by ewy22 with SMTP id 22so1883911ewy.0
        for <linux-mips@linux-mips.org>; Mon, 06 Apr 2009 00:57:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ykdRjLzcvsOhqBmoBb0SuwZfYQ9MDnPrgotsCQcR3Qc=;
        b=P7KEbF1Nih3SnmP5pMeeAvu/x7qV7Fe5VoOzvUfnObWHewXitjjgOCId6ERmXsKaRT
         lqFyBtV7+scIaG4nNk4eE0DRMXg4svejaYusnN+bR7PauUgJpVDVDRX0WjjPjzO2AadZ
         AIVXoj/92BVc2YicZ4IeoQICTvUZYIN/JwJXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UHCtug5MxWzphUvkPocTTE11uNkNfxYBkHY1Od49A2slbxsdymwv7tmwQ9F1S2DKXo
         bMsYWaql9/T66UCXxr9lI4RPxVFx5ESudTjzn72MI4RuLt8aBch2ycguHM/e82R+R6cd
         KZKfW+bn+DVruabVF735jR5Nh9Gwjaws2sD9U=
Received: by 10.216.71.196 with SMTP id r46mr1106450wed.54.1239004649777;
        Mon, 06 Apr 2009 00:57:29 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id p10sm11203949gvf.13.2009.04.06.00.57.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 00:57:29 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH 3/3] Alchemy: convert to physmap flash
Date:	Mon, 6 Apr 2009 09:57:27 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Linux-MTD <linux-mtd@lists.infradead.org>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net> <1238318822-4772-3-git-send-email-mano@roarinelk.homelinux.net> <1238318822-4772-4-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1238318822-4772-4-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904060957.27415.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel,

Le Sunday 29 March 2009 11:27:02 Manuel Lauss, vous avez écrit :
> Add physmap-flash support to all Alchemy devboards and get rid of the
> alchemy-flash.c MTD map driver.

Thanks !

>
> Cc: Linux-MTD <linux-mtd@lists.infradead.org>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Acked-by: Florian Fainelli <florian@openwrt.org>

-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
