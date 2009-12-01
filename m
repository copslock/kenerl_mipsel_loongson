Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 14:39:49 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:60383 "EHLO
        mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492465AbZLANjo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 14:39:44 +0100
Received: by pxi26 with SMTP id 26so3768973pxi.21
        for <multiple recipients>; Tue, 01 Dec 2009 05:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=egZOucI2YJkQhWZenIZ2feceD8wlmSXzK8CRRlTaQWc=;
        b=B3Fwyt59UcU1Km2X4svou59PX9tEqf2kqD8OyQiaZ6mS2NCExE4EwY0xVDIRriy4TH
         L62Ix5VzSPVGwcx2hU48g56JZV87M7Z4ynYwOJKleZuuMx/h/+PEMTLZbg/QQsxq9KWS
         XlyhXvBQYqZTcw9anmdh318QbEGK0wu1p3qIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=SOetTkCqQ1t4A3JAjUNM67YUh0N5WB6o1S1p2MPVgeudJsl267tjBKc2yN3Lz5Xzet
         sPiS5D033+qm2AU9EPafqsKErziJh20ygT5jbXGwX6WsTrM3phAHYiVfK2rWJhRUSgQL
         NfwBvJX5Se5NhGcozn0MTHFd6naJfLPpH38Y4=
Received: by 10.115.67.24 with SMTP id u24mr10982815wak.59.1259674776723;
        Tue, 01 Dec 2009 05:39:36 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm80392pzk.14.2009.12.01.05.39.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 05:39:35 -0800 (PST)
Subject: Re: [PATCH v6 2/8] Loongson: YeeLoong: add platform specific option
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com
In-Reply-To: <20091201133427.GB14064@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
         <e420b43bb54c33343e15cf53baf39806ba6583ae.1259664573.git.wuzhangjin@gmail.com>
         <20091201133427.GB14064@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 01 Dec 2009 21:39:11 +0800
Message-ID: <1259674751.11106.5.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-01 at 13:34 +0000, Ralf Baechle wrote:
> On Tue, Dec 01, 2009 at 07:07:45PM +0800, Wu Zhangin wrote:
> 
> > This patch add a new LEMOTE_YEELOONG2F option, a yeeloong_laptop/
> > directory for the coming yeeloong specific support, and for the
> > ec_kb3310b belongs to yeeloong, so, move it to yeeloong_laptop/ too.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> I suggest you fold this patch into patch 2/8.

Sorry, do you mean merging the following two? for this patch itself is
2/8?

[PATCH v6 1/8] Loongson: Lemote-2F: add platform specific submenu
[PATCH v6 2/8] Loongson: YeeLoong: add platform specific option

Regards,
	Wu Zhangjin
