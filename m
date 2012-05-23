Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 16:54:50 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:50993 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903607Ab2EWOyp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2012 16:54:45 +0200
Received: by bkwj4 with SMTP id j4so7837604bkw.36
        for <linux-mips@linux-mips.org>; Wed, 23 May 2012 07:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=KdBivJ1FhlRxIcoBUhPBbvVq/kyz1D1H9DdWuS1qSls=;
        b=O5Hta+12nZ9kjhEvUWT8Nid5I3ta2Em1J9MGFne/shyPB/Aff0NFuQ76UX/MGlOrLI
         5/A5cn4W23IUKoq040+S+HbChjObT6n8km+FOY4R/oSfRzqLwrrMp8skypwIlfOJ0dWG
         d3sCwgSXxthy3z0XAPujqVXBIz0TOw1TTZi1D0l2QzZPTnSbvrJ4RC0/vnJmeYZZGzmY
         T1WOfjdeFbMIH1SsboxIfENMCYZgR3adobN33XkfBHgGTX/mPWLLyVvwOn6xtfQY+mJm
         W2DlxCpDdRf5xtpQMcJy5VXA2E7jio3K9cyVM3GFURtTLeH+B1xilg0O3/MsUnEX9r0U
         fzBg==
Received: by 10.205.134.4 with SMTP id ia4mr8385811bkc.57.1337784879715;
        Wed, 23 May 2012 07:54:39 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id fu14sm11481661bkc.13.2012.05.23.07.54.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 07:54:38 -0700 (PDT)
Message-ID: <4FBCF9E3.5040702@mvista.com>
Date:   Wed, 23 May 2012 18:53:23 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Hill, Steven" <sjhill@mips.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Yegoshin, Leonid" <yegoshin@mips.com>
Subject: Re: [PATCH v2] Fix race condition with FPU thread task flag during
 context switch.
References: <1336717702-731-1-git-send-email-sjhill@mips.com>,<20120523100003.GA25531@linux-mips.org> <31E06A9FC96CEC488B43B19E2957C1B80114694EB4@exchdb03.mips.com>
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B80114694EB4@exchdb03.mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmqMW/GDj1Wq5c9cE40gqN8Ni3x3UGgaY/FrtOI4F6gplZNQ8kcZpXb6bGsevi/RwJwBVu4
X-archive-position: 33439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 05/23/2012 05:34 PM, Hill, Steven wrote:

> Leonid is the author of this patch.

    Then, for the future, you should put the real author in the From: field of 
the patch.

> -Steve

WBR, Sergei
