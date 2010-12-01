Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 18:03:28 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:39304 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493038Ab0LARDZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 18:03:25 +0100
Received: by gyg4 with SMTP id 4so3829856gyg.36
        for <multiple recipients>; Wed, 01 Dec 2010 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=UXbO+N571YzFORa4xu8GF3KRgcaDHGMbPpvnsTiW9iA=;
        b=gEPLlLEuW1TmQxtGwsbcQLkZEJ2M4XRYNCcwpN1hfYATeFxJXmNv6+sLChyvQSMAU9
         epyD07rP4uK3L5OoCUvwaWJFWh8ppIv1192nRpc1M5ozjOM3P0yNKmNXZMtI/xtxzavY
         0YWHIOhraCPbiurA7yCO/abBjLfY6mYSdRa6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=GQNZZpwrittj1V46XIBegPVWjjWpFtCVn++cTTmGFsYva45a4OQY3vPdJjsfIHLVH2
         pEsx5ky2zyAUlgTB0pDwKBRmmv5LfHovZsymivhuocm332rxHpc8+txuMifNzUGgyDgm
         I2tPuIFqQt/yQk+OrtO79hL16eVMmncAgN/5s=
Received: by 10.151.47.9 with SMTP id z9mr15033831ybj.278.1291222998794;
        Wed, 01 Dec 2010 09:03:18 -0800 (PST)
Received: from [192.168.10.102] ([211.201.183.198])
        by mx.google.com with ESMTPS id k2sm1801450ybj.20.2010.12.01.09.03.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 09:03:18 -0800 (PST)
Subject: Re: [PATCH] MIPS: Fix build failure on mips_sc_is_activated()
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <20101201165517.GA5560@linux-mips.org>
References: <1291221282-9056-1-git-send-email-namhyung@gmail.com>
         <20101201165517.GA5560@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 02 Dec 2010 02:03:11 +0900
Message-ID: <1291222991.1684.49.camel@leonhard>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 8bit
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: namhyung@gmail.com
Precedence: bulk
X-list: linux-mips

2010-12-01 (수), 16:55 +0000, Ralf Baechle:
> On Thu, Dec 02, 2010 at 01:34:42AM +0900, Namhyung Kim wrote:
> 
> > The commit ea31a6b20371 ("MIPS: Honor L2 bypass bit") breaks
> > malta build as follows. Looks like not compile-tested :(
> 
> Already fixed in the linux-mips git tree by an identical patch in
> commit 9a3475880131752d3d78ac25516fd3eab3fca871.
> 
> Thanks anyway!
> 
>   Ralf

Oh, didn't know that.
Thanks.

-- 
Regards,
Namhyung Kim
