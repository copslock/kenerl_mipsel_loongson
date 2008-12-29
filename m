Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2008 19:02:14 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.188]:52344 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S24208296AbYL2TCL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Dec 2008 19:02:11 +0000
Received: by mu-out-0910.google.com with SMTP id w9so2234230mue.4
        for <linux-mips@linux-mips.org>; Mon, 29 Dec 2008 11:02:10 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UUuSZQhXaz9fF93lBMe2AvYf7ND4h6ivQy5kEmWLpIs=;
        b=X4sa1pO9qJHKqlcsaVsbqhbh6QG1hu4JDm65wElsH+o8aJeElUeIVxwhlNmTG3jASA
         x3j7et8c0/TN5gmMQ7bsRMaRXNdsMTQdzlp1IPD2a8MtvxhmNoDPZk5eJVUsjfCW5VZH
         1oKBMXImeogq7914ofxoriYFWqCFRGKaXCuCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QSAaRTk26AfH+oaDZcI53MYCWYyCZTVv1EpG/IQrBZ8rdEQAaTyjgn6mECquHm6TNd
         yRaBRfZY6iyoCe7u0wjavsQP4g8qqBuL9r6/SCKyEmqo7lOxsZGO8iAkJtmlm6r8JWi3
         VkGdYpHFh0o6/byzMQG3u1kRcU4E0qts9IbPs=
Received: by 10.103.173.15 with SMTP id a15mr4966423mup.59.1230577330822;
        Mon, 29 Dec 2008 11:02:10 -0800 (PST)
Received: from localhost.localdomain (chello089077051219.chello.pl [89.77.51.219])
        by mx.google.com with ESMTPS id u26sm31119357mug.26.2008.12.29.11.02.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Dec 2008 11:02:10 -0800 (PST)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] tx493[89]ide: Fix length for __ide_flush_dcache_range
Date:	Mon, 29 Dec 2008 19:38:54 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.28-rc8-next-20081219; KDE/4.1.3; i686; ; )
Cc:	linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, stable <stable@kernel.org>
References: <1230215558-9197-2-git-send-email-anemo@mba.ocn.ne.jp>
In-Reply-To: <1230215558-9197-2-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812291938.54435.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Thursday 25 December 2008, Atsushi Nemoto wrote:
> This fixes data corruption on PIO mode.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: stable <stable@kernel.org>

applied
