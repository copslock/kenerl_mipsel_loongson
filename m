Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2008 19:02:34 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:3275 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S24208343AbYL2TCM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Dec 2008 19:02:12 +0000
Received: by bwz6 with SMTP id 6so13179826bwz.0
        for <linux-mips@linux-mips.org>; Mon, 29 Dec 2008 11:02:06 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+aLRc3gJHwU3Je9tZp2q/G8BclxZ7ucuh38nB5Lsi/M=;
        b=F61ikEgGjKFBDx53epy0gPD0NKBxpt/EIMwzHgvQfiRv/9S7/pHKFh5eE75EHcgaPG
         lkBXL9kJcvCXsXFALJTphl5CzZHXVfI4YM6OhgQEpy+Jh4s6xhwU2Wus6o+QiBKg8tEl
         EGei9d3IMkAKz5IPFQJ+8PgJF5gOOguIYzC04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AWom/l5Nxyj+aPTH67b2j2N95w++BF1U+MHWgZSS6lHwAO6YhnXs0DKYTqoB3q23Jg
         WQlEvWJMwxdCk1cMWs6CvKwOqHnRzoCE+5lA3vb7HCZOq3PHYjMNUSBomS5e8kNyYqi7
         QAD5giOFY3nmQxLkmHXz9uDc0tKQP0ngSlHaA=
Received: by 10.103.40.5 with SMTP id s5mr4973095muj.4.1230577326126;
        Mon, 29 Dec 2008 11:02:06 -0800 (PST)
Received: from localhost.localdomain (chello089077051219.chello.pl [89.77.51.219])
        by mx.google.com with ESMTPS id u26sm31119357mug.26.2008.12.29.11.02.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Dec 2008 11:02:05 -0800 (PST)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] tx4939ide: Do not use zero count PRD entry
Date:	Mon, 29 Dec 2008 19:38:14 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.28-rc8-next-20081219; KDE/4.1.3; i686; ; )
Cc:	linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, stable <stable@kernel.org>
References: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
In-Reply-To: <1230215558-9197-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812291938.14580.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Thursday 25 December 2008, Atsushi Nemoto wrote:
> This fixes data corruption on some heavy load.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: stable <stable@kernel.org>

applied
