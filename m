Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Feb 2011 04:56:14 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:44243 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab1BYD4L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Feb 2011 04:56:11 +0100
Received: by yxh35 with SMTP id 35so627545yxh.36
        for <linux-mips@linux-mips.org>; Thu, 24 Feb 2011 19:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=H/6G3yxNdSWT/9jN7rIZL7v4Wq2rprRh78LZN8qI/G8=;
        b=iB2K6J7DFHJpRy2MAyAEZDrau+kP+vWyJ1yCNTGme5Fn3pmu2o5JXQ7QHFaOVc36ES
         YDO/CsF5Hq4kMyFJJ035re/1wB3JTVH092/fBRq5drDjNFRRRAfLQ9rxzbep4c7l7Ask
         n4Pm8ya+ap/IsB6NNHC3BOChjre4FD136ElZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=ST0Y13MV+nd5gVVnDFfRPU8NeCci9oWDADiyxwS20mncGdaIhLAuv/EkTaNSNnexFt
         WYAxJgvOmDBslyUgL4WGDkJlVaHZQQUkoCyWwbAVDmsnjI2QsD+/o84cwHZ7w4cUcWCa
         9mhpRgxiVcBsu6RQrEE0r+zXT9awd6U120hSs=
Received: by 10.150.49.19 with SMTP id w19mr2954573ybw.157.1298606164764;
        Thu, 24 Feb 2011 19:56:04 -0800 (PST)
Received: from [192.168.100.231] ([220.232.195.195])
        by mx.google.com with ESMTPS id w24sm5127984ybk.21.2011.02.24.19.56.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 19:56:04 -0800 (PST)
Message-ID: <4D672850.80902@gmail.com>
Date:   Fri, 25 Feb 2011 11:56:00 +0800
From:   Jacky Lam <lamshuyin@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     linux-mips <linux-mips@linux-mips.org>
Subject: Memory needed for hibernation too much
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lamshuyin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lamshuyin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

     I try the hibernation feature with my MIPS box which has 128MB RAM. 
After boot up, it remains to have 110MB something. Then I mount ramfs on 
a directory, create a file 100MB from /dev/urandom and enter 
hibernation. The process failed because of no memory. Then, I continue 
to cut the data file size and not success until 20MB.

     I want to make sure if it is an expected behavior or I am doing 
some wrong?

     Thanks.

BR,
Jacky
