Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 08:21:01 +0200 (CEST)
Received: from mail-bw0-f218.google.com ([209.85.218.218]:40861 "EHLO
        mail-bw0-f218.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491008Ab0DNGUy convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Apr 2010 08:20:54 +0200
Received: by bwz10 with SMTP id 10so4174642bwz.24
        for <multiple recipients>; Tue, 13 Apr 2010 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xz2N/Q5EtsbQDXGrKec99DvrfW8IL4JgaIJp+qdLs2s=;
        b=SzLZ+Jzg9uATi31SqBBOfobOPdqr8gzhf6vHGCPmOCHk4wiJeK/QWXiAOfdHn2GFvL
         6/9NqR3/JHkSql8vSOyW9DpegNzFXiRKqnR9UledSRJ3NedhUmmrcV/O32qyXwd3Rs0l
         gR+NXrFxWk2TicUgDdKWyRlu7ohCDrJaHiflE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eQjpGdaEElmo7OEPTFQ6PYokn31Zk3VevAm57IM5iQCHq/7O21/384YoHe0rmCEzsM
         vDA/VIKtozC2ijRqHuoHQku19s0/G7cl/4MMOMyEq4o8LoLPf5lfTJ4ZncvKKqLB9XIW
         UT2c/TfzasZqyD8jWUCYaeFufnVThPvy8xDHk=
MIME-Version: 1.0
Received: by 10.103.193.7 with HTTP; Tue, 13 Apr 2010 23:20:46 -0700 (PDT)
In-Reply-To: <20100413224955.GC24077@linux-mips.org>
References: <1271184554-28058-1-git-send-email-manuel.lauss@gmail.com>
         <20100413224955.GC24077@linux-mips.org>
Date:   Wed, 14 Apr 2010 08:20:46 +0200
Received: by 10.103.7.31 with SMTP id k31mr3771733mui.132.1271226046385; Tue, 
        13 Apr 2010 23:20:46 -0700 (PDT)
Message-ID: <s2wf861ec6f1004132320j7dd21a39he378872ccf39ff7b@mail.gmail.com>
Subject: Re: [PATCH v5] MIPS: Alchemy: add sysdev for IRQ PM.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

> Queued for 2.6.35.  There were some line offsets and fuzz when applying
> this patch but I hope that's ok.

The version in queue is fine.

Vielen Dank,
     Manuel Lauss
