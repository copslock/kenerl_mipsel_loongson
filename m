Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 18:00:43 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:36473 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903605Ab2EWQAf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2012 18:00:35 +0200
Received: by bkwj4 with SMTP id j4so7929877bkw.36
        for <linux-mips@linux-mips.org>; Wed, 23 May 2012 09:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Sr9jsSeW+N5G8JX4uYJp5juwtuyIfhM5QsB2iyRniLs=;
        b=g9yOGIeNX/oFLgOoqe/sb4w2rImbSJ29AKY06sSi1gJ+qeD0dq7bhJfGj9Y9PDnGwQ
         7gtaGFoB6Rx8+3VNf2AAl/elG5ryuPqswkJ7pSB1hoVLEAyW5erwXLbp3eTRY/yo8zOa
         Nff1FSgwe7UP8r5/TIawolUPth9LJHcSif9imBoUNM5bTiyokpKF97/mBbk35NBLSh6D
         Pgq20x+a398b5kA/KMeuGlPF092Kldko8JfWvkUXgfpD8ns4ooyeQQRWz5vNSUOgUmbs
         IB9sgsPVNTghQdww2ItTypmoAHdIZjzK3n/7KSSwcA35ajhaRtsshGbYpVmgCb/VxZUH
         ed1Q==
Received: by 10.204.149.208 with SMTP id u16mr4030714bkv.81.1337788829222;
        Wed, 23 May 2012 09:00:29 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id e20sm38088981bkw.3.2012.05.23.09.00.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 09:00:28 -0700 (PDT)
Message-ID: <4FBD0951.1020906@mvista.com>
Date:   Wed, 23 May 2012 19:59:13 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Hill, Steven" <sjhill@mips.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] Fix race condition with FPU thread task flag during
 context switch.
References: <1336717702-731-1-git-send-email-sjhill@mips.com>,<20120523100003.GA25531@linux-mips.org> <31E06A9FC96CEC488B43B19E2957C1B80114694EB4@exchdb03.mips.com>,<4FBCF9E3.5040702@mvista.com> <31E06A9FC96CEC488B43B19E2957C1B80114694EDD@exchdb03.mips.com>
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B80114694EDD@exchdb03.mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnn4cn/q+bOXSl636t6xqsYvusFjS3JcOifB13W5dDrF/vpZzFSG5W/nq0wPVfVaMCRkZ96
X-archive-position: 33441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 05/23/2012 06:56 PM, Hill, Steven wrote:

> How about in the future you stop using reply all?

    Using reply-to-all on the mailing lists is normal default behavior. I don't 
quite understand what's your problem with this.

WBR, Sergei
