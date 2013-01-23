Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 11:45:26 +0100 (CET)
Received: from mail-we0-f180.google.com ([74.125.82.180]:45690 "EHLO
        mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831954Ab3AWKpYVL0pg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jan 2013 11:45:24 +0100
Received: by mail-we0-f180.google.com with SMTP id k14so538581wer.25
        for <linux-mips@linux-mips.org>; Wed, 23 Jan 2013 02:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=6IM1K/YzQZDjtonWJ51mhRaX2H25MVyWq5sY7hXUC0Y=;
        b=t1d0w2yqfflVTR37SrTdXIpac5U4YVFvIftyAfbsDWRi1SQI4rfRG/tqsBpOocn4Sd
         PT+nzNDAR9zF3BsUn0jKO0yjhNcHRhhKffLmNFUQo8gYM8zgrI+OuLgHovPWOH+37+Yq
         +iHLy2pDTKUAsdL4SseBN6CPezXUEQMVZtD0ilA6JOl5M8+QT3r2NghevA9YIXmIPngH
         qy1HX4/JB+wqIqQikiTrhS6wWxLWG27M6WHcrhh739oTf3FVMVN8q/PfzQDzn7xIhb9R
         BSvEkpE8+V2p7fKR/xi0TlUmP/5NpchKCXdNNWFffto692WmceMwdgm2zEP25zLpE0Z5
         Dbkg==
MIME-Version: 1.0
X-Received: by 10.180.20.138 with SMTP id n10mr31027020wie.0.1358937917261;
 Wed, 23 Jan 2013 02:45:17 -0800 (PST)
Received: by 10.216.72.134 with HTTP; Wed, 23 Jan 2013 02:45:16 -0800 (PST)
Date:   Wed, 23 Jan 2013 11:45:16 +0100
Message-ID: <CACna6rz2mpRUZsXqDr7wDjgTSz0bunq9wZ9PumyR5gO_cRhS1Q@mail.gmail.com>
Subject: git (linux-queue.git) not available: access denied or repository not exported
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

# git clone git://git.linux-mips.org/pub/scm/ralf/linux-queue.git
Cloning into 'linux-queue'...
fatal: remote error: access denied or repository not exported:
/pub/scm/ralf/linux-queue.git

I've tried this on two machines. Is there some mirror?

-- 
Rafał
