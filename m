Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2016 14:35:45 +0100 (CET)
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36695 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007520AbcCKNfnNkGD3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Mar 2016 14:35:43 +0100
Received: by mail-oi0-f41.google.com with SMTP id r187so85424040oih.3
        for <linux-mips@linux-mips.org>; Fri, 11 Mar 2016 05:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=FouGC9OkJ0XplPOlVRUeR6C3rjJDFqYiK+dqdqHAyco=;
        b=gtyy9m/oMUTXaKd5MJqOxSqlOUZo/QAgBNrpP0BQz7F9MlPnFIbmmSO90Oj5NSqRSJ
         iUA6dYkFItF+RGPAeMK8OWj5+dZRvvTkAe0W0Zavcogt4v5zY/tgKr9iU7TCqJV9Deq6
         4FdgOrvIbnMNiBwikp9gJfqzHGShrTUzaanZZnUwkC4FpuUFABKWtLNzeqKSE7G5N/h+
         nz2TdGej1aovhRrIMpIALpRUwxOCfQXJeXhH8lMLnixrPrzcB42YflCS1eLY0/q+ziZs
         Lcl3fPo5FrhI1oiJnckljCQa0RpfMzbHnoJUb8Wdjdjj0pBdkTCj9JNr8aksBHdQYWdI
         z7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FouGC9OkJ0XplPOlVRUeR6C3rjJDFqYiK+dqdqHAyco=;
        b=EDcFcuGUtWx4GBC1kh67mcL7uiafEqaNq30xKb8DSISl61BZkbpXP2Iz7QaZoNcSnS
         Om5xjjyOszvelpnXc+oEQUM/Ms4Nju9mbkLpqqV9EiQyQ2YoCJx8EfUelibP8tnHKure
         0xL8avvTA0l4fYm5nzBzZ3syDCP8Slja1tWLNQsR0wu5MMqeyYDeWMqVpzVvJyhDTIDh
         2MNycAvkL5KwRl10puGL5DMKgEKie4S+2f2hx/FjRu7SF9KkHXac6i8HITUevCOb0Vfk
         sxhTp+z4eBu0NX481khGje80y81CqfSorWMqB27UYq4BKRUMSeu9JAs0NlnYIbTgHgdm
         lOzg==
X-Gm-Message-State: AD7BkJJIFBM9HW8PWTlMRFfuUlKNTpgc/FoP0Wcdhgt7zW4UdpPhkNlSD8Jqiy18EA0TrRVB/zM/pkuIQCyjEQ==
MIME-Version: 1.0
X-Received: by 10.202.3.135 with SMTP id 129mr5393839oid.91.1457703337215;
 Fri, 11 Mar 2016 05:35:37 -0800 (PST)
Received: by 10.182.45.68 with HTTP; Fri, 11 Mar 2016 05:35:37 -0800 (PST)
Date:   Fri, 11 Mar 2016 19:05:37 +0530
Message-ID: <CAL1vVhox1WZLwSJHgCpGYiJB0TuX9p2SRYemNcZw4AdjLzM5BA@mail.gmail.com>
Subject: uImage for MIPS32 load address below 0x80000000
From:   Kaushal Parikh <kaushalparikh@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <kaushalparikh@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaushalparikh@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello,

MIPS arch Makefile only allows uImage target for load address >
0xffffffff80010000. Any specific reason for this limitation?

I am using a lower load address on MIPS interAptiv CPU (with EVA
enabled). So to enable uImage target, I had to remove the check in
Makefile.

Thanks
Kaushal
