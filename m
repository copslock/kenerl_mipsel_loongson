Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2011 19:14:01 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:39542 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491010Ab1BXSN6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Feb 2011 19:13:58 +0100
Received: by pwi8 with SMTP id 8so233902pwi.36
        for <linux-mips@linux-mips.org>; Thu, 24 Feb 2011 10:13:50 -0800 (PST)
Received: by 10.142.75.6 with SMTP id x6mr889183wfa.229.1298571230529;
        Thu, 24 Feb 2011 10:13:50 -0800 (PST)
Received: from [192.168.2.3] ([118.95.25.226])
        by mx.google.com with ESMTPS id w11sm12633506wfh.18.2011.02.24.10.13.48
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 10:13:49 -0800 (PST)
Message-ID: <4D669FCE.8000601@nulltrace.org>
Date:   Thu, 24 Feb 2011 23:43:34 +0530
From:   Himanshu Chauhan <hschauhan@nulltrace.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     linux-mips <linux-mips@linux-mips.org>
Subject: Kernel link address assumption
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <hschauhan@nulltrace.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hschauhan@nulltrace.org
Precedence: bulk
X-list: linux-mips

Hi,

Does Linux kernel for MIPS assumes that its link address is always in Kseg0?
What if I change the link address to somewhere in useg?

Regards
Himanshu
