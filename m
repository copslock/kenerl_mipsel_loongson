Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 18:40:48 +0100 (CET)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:61742 "EHLO
        mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492001AbZLBRko convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 18:40:44 +0100
Received: by mail-fx0-f225.google.com with SMTP id 25so497551fxm.26
        for <multiple recipients>; Wed, 02 Dec 2009 09:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OgwRzilwzzv05ykIRJ+Z5uggB7+R/TH6zeIGH1A2XO4=;
        b=wfucZ9ow/cwc88sIixlxTDtqEAWXqnO0MNQxi/7ztE5KC5+9GiJ5eUAKK73AuUyzML
         T5kdHYL2En1nU/Kp7Stnal29L9V5Pmg1tLN4aGHrdLWF42z3q9lj26US8jjd0F/QAybj
         eF6w8YA8PX9efDfcpj4eeILOIiJNyS+K0JEqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N17OO/Fd/llocXn6eXu4A0R7kpsaEKdi40Cf8PTpabi7O6RBv0srxUvQP6EnPVn6bN
         SEMMetMVZsvIeJg2rHjq+BWp2ChDuFqsn0VmtDnUM8GodZVjjJMwJ6o+t6BbRFw1T+tk
         98UwOoTtFa4sEQywJV7RMWraoB9fR9RYj9SpQ=
MIME-Version: 1.0
Received: by 10.223.164.104 with SMTP id d40mr58149fay.98.1259775644522; Wed, 
        02 Dec 2009 09:40:44 -0800 (PST)
In-Reply-To: <20091202170828.GA13441@linux-mips.org>
References: <1258835681-32200-1-git-send-email-dmitri.vorobiev@movial.com>
         <20091202170828.GA13441@linux-mips.org>
Date:   Wed, 2 Dec 2009 19:40:44 +0200
Message-ID: <90edad820912020940s3ac3aa18j4abf60922937f0b7@mail.gmail.com>
Subject: Re: [PATCH] [MIPS] Fix and enhance built-in kernel command line
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Dec 2, 2009 at 7:08 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> I also patched up the defconfig files to use the
> right settings for CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE.
>

Thanks, Ralf!

Dmitri

> Thanks,
>
>  Ralf
>
>
