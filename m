Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 17:25:07 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:45480 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1492785AbZKXQZE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 17:25:04 +0100
Received: by bwz21 with SMTP id 21so6228835bwz.24
        for <multiple recipients>; Tue, 24 Nov 2009 08:24:57 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JW4WYwAobcFpHG6RDN3/T3GCdPvUbc+JIwCF5AG9CP0=;
        b=KTkE2eT/3KPqZEWCTOfvuCLK5d3hAnncKryOY/EBSeoiQLptCsRZtqloaJqVJd0qH8
         1azRDvKq1XykMijkECBBMg8uH2i/BslP/oFWdOiOgrV1I/ONboj5Jqxsap6D5woLRDz4
         47r6Q6m01LccypGHABRPxE1oEYhjYgY70nGgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ODb07rwrRCFCOUDJmheoTM7fJFt00bX0c8cEbtJJG6DBeEtAwuyhOnmuMZ/7rSgrfZ
         21rd0t1NvO816muTZAlt1brysExTIWzex+Se1Y2/P4Zcdgsk/gPg0iCKgzUwqe/Q+JmB
         xirnoLJDxkfZPPP3gZLIQ1WAMgRVU4uvY1OtA=
MIME-Version: 1.0
Received: by 10.103.78.31 with SMTP id f31mr2902151mul.24.1259079897560; Tue, 
	24 Nov 2009 08:24:57 -0800 (PST)
In-Reply-To: <1259055230-15818-1-git-send-email-wuzhangjin@gmail.com>
References: <1259055230-15818-1-git-send-email-wuzhangjin@gmail.com>
Date:	Tue, 24 Nov 2009 17:24:57 +0100
Message-ID: <f861ec6f0911240824u187347d6od5bfebc509a27d8d@mail.gmail.com>
Subject: Re: [PATCH] MIPS: EARLY_PRINTK: Fixup of dependency
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Wu!

On Tue, Nov 24, 2009 at 10:33 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
[...]
> This patch will only enable that option when the DEBUG_KERNEL is
> enabled.

How about making it independent from DEBUG_KERNEL altogether?  If find
it useful even without full debug info.

Manuel
