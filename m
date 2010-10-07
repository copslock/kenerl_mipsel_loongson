Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2010 15:32:19 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:39364 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491168Ab0JGNcL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Oct 2010 15:32:11 +0200
Received: by qwe4 with SMTP id 4so38142qwe.36
        for <linux-mips@linux-mips.org>; Thu, 07 Oct 2010 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=c87ZhM/W5ohXAWWM9GpSFmliF2H5nMdVUBgK8K7JPX4=;
        b=aKjJvNNOEdX2i28Cn7wFjf82HmHsS6tZcw1O+T8IsIsJxgFNRa5b775TMmqFMseexx
         SgHKXbWIAiOaPlwtoyM2ISGyCONnpGHUXim2NtnDgu7e8GThb3nwmeNdPigkMHWySc68
         /LbWOqx2LsfpXZ6UXVLeV5pboe5A5rWuTzjwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Pdneq9k7waXdfGeueFM5+ft+Gx2TmyeVd2MD7gQFHmG5Q1/4m5+Xlsuc6t15fxGG/y
         pUlF11bbgjCDQ9juXWVwsUSTigS4OdLhxqps4vdaAZtDcIQAW1tVgiq3elT7hehY9o/s
         p0nSeYvtdX3GWLqNOK/KM/slW3ozsMQHnA+PE=
MIME-Version: 1.0
Received: by 10.224.208.130 with SMTP id gc2mr302630qab.69.1286458323113; Thu,
 07 Oct 2010 06:32:03 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Thu, 7 Oct 2010 06:32:03 -0700 (PDT)
In-Reply-To: <AANLkTikjZc029TOmzsaPKg7UqzRktMB7JFN44D1MwrAA@mail.gmail.com>
References: <AANLkTikjZc029TOmzsaPKg7UqzRktMB7JFN44D1MwrAA@mail.gmail.com>
Date:   Thu, 7 Oct 2010 21:32:03 +0800
Message-ID: <AANLkTi=Gt4j9j5DOPXtV7OYCnhsKRViM=SSuBJmrqQau@mail.gmail.com>
Subject: Re: ebase changed, leads to invalid access of data
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     chelly wilbur <wilbur512@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

2010/10/7 wilbur.chan <wilbur512@gmail.com>:

> any suggestions? Thank you in advance.
>

I think maybe I've got the answer: All cpus shared the same exception
handler, so if it was an invalid address , the linux can fix it

by tlb refilling.  Becasue I have changed the ebase of non-zero cpus
and did not implement TLB handler for them  , the tlb exception


happended from time to time.
