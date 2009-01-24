Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2009 14:21:17 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.187]:53650 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S21366094AbZAXOVP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jan 2009 14:21:15 +0000
Received: by mu-out-0910.google.com with SMTP id w9so3616553mue.4
        for <linux-mips@linux-mips.org>; Sat, 24 Jan 2009 06:21:14 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9b+KxPgu2K2+5HXTswSJV9yKM27bxsHBCtu+yb3Ekxc=;
        b=xsDyQFyR8DIyc7L9XhrQWnPc7ceIJai43F0jCoHi2OwDwnAAC8nSeAI2LL7+H7Fe5u
         ZclSosu/TYF8GQlghKpjedz9Tzoyi6g2VdiF0q1pyiT+c4sfijDAaTNjCg+1Zq16H4o0
         RauJrhp8hnTRYoWhxo9w1OIzrRmSnnaPG+fNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KdLnbIeoIGH3+L/8RoXPr798SG3Z5fdmMdka1I3csfrERTlB4yi5qF0QKidE63gMGE
         qeeyKI+ZVuZChbjpWHJ7n1rerO1Tme7cgrd1ky6Wk7YIm32ZLpTS9s7TxI8C48t9ZqBx
         gJPXjaOH1DMrcS0ST8OSxZ6oELg+q7vRHUp30=
Received: by 10.103.243.9 with SMTP id v9mr882072mur.91.1232806874220;
        Sat, 24 Jan 2009 06:21:14 -0800 (PST)
Received: from localhost.localdomain (chello089077051219.chello.pl [89.77.51.219])
        by mx.google.com with ESMTPS id 23sm10880688mun.28.2009.01.24.06.21.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jan 2009 06:21:13 -0800 (PST)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] tx4939ide: typo fix and minor cleanup
Date:	Sat, 24 Jan 2009 15:10:01 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.29-rc2-next-20090123; KDE/4.1.3; i686; ; )
Cc:	linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
References: <1232374225-5325-1-git-send-email-anemo@mba.ocn.ne.jp>
In-Reply-To: <1232374225-5325-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901241510.01660.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Monday 19 January 2009, Atsushi Nemoto wrote:
> The bcount is greater than 0 and less than or equal to 0x10000.
> Thus '(bcount & 0xffff) == 0x0000' can be simplified as 'bcount == 0x10000'.
> 
> Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

applied
