Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 19:36:37 +0000 (GMT)
Received: from gv-out-0910.google.com ([216.239.58.187]:27403 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22677186AbYJ2Tg0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 19:36:26 +0000
Received: by gv-out-0910.google.com with SMTP id e6so108405gvc.2
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2008 12:36:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xs+U5sqVqQZkeUBcF7J6xkl3QC4VzxIFwRvGzHhScWA=;
        b=m3WUHT4Q4d+jBEDDGQvijaYffpnITQMubJcYDWjr5KZldpTw57wpeLyDrLU+LrCZwA
         7ZMbEoC2WKaf7jain70zP953l5MtKOsrg9sR0ZJqBu4Gjq4IN302j3fcpYi1ahZa8wLr
         /aHVyRw6YZ5hhwwCkkHAxkqPNSAzvTABwVMxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=G0xYSt2F1ECQrMSwbtHxf/Jf+iOV5HyUKDk8Noq9miL+DvyfC5KS558w4u8dSVAOV+
         ohtoMqxhKzD573mqaeunM4Wa9PfI4l+bm+7YyhsYPCIz0Prgmv1Ki/kYYmx59BYhfTfr
         59dqwgWadCgWyGY77Bzq1d2SeD+10mmkSYgLA=
Received: by 10.102.218.6 with SMTP id q6mr4386560mug.127.1225308539347;
        Wed, 29 Oct 2008 12:28:59 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id j10sm599903mue.17.2008.10.29.12.28.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 12:28:58 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] tx4938ide: Avoid underflow on calculation of a wait cycle
Date:	Wed, 29 Oct 2008 20:20:17 +0100
User-Agent: KMail/1.9.10
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
References: <20081028.220904.128617360.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081028.220904.128617360.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810292020.17975.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Tuesday 28 October 2008, Atsushi Nemoto wrote:
> Make 'wt' variable signed while it can be negative during calculation.
> 
> Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

applied
