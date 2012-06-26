Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 20:41:48 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56169 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903664Ab2FZSlj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 20:41:39 +0200
Received: by dadm1 with SMTP id m1so280464dad.36
        for <linux-mips@linux-mips.org>; Tue, 26 Jun 2012 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UzXAjkHfcNezm1zsQVJXXaSMgbCHBYVF2oLk3EYBSkk=;
        b=QbdTpwDO/ScNK185kQ0fVbkm0TLwHo3mPczwmJBvhDmwUHUsbYLgKTUz+zcJ/e2yQ+
         ttDQKnv1WDySGTR/f6AgrbhimmdgcNdBPUCFKeluam9D9SbuEa3lQz9rs5Q9daLSh+Kp
         Ag3jQ5jixZ4tO0qSrTeGazqIOrnzHF9h4yJhaZ70aCBUc5Zx8TAYWPbIbGHm0kPLGdOM
         SFdk7wvdOtwjl4TSis5NIogibODEgGtgMKKS08B88kk61BKMjJrLUhinrc21g5rTJOOA
         IheASbRfBfkAVcfP1yAAwok3wQ6csdeKPAv4P8STskO3k31G+A4G+bQVnO6mqd1OHSnM
         Txvg==
Received: by 10.68.130.67 with SMTP id oc3mr24099030pbb.18.1340736092108;
        Tue, 26 Jun 2012 11:41:32 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id b10sm12573355pbr.46.2012.06.26.11.41.30
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jun 2012 11:41:31 -0700 (PDT)
Message-ID: <4FEA0259.5030005@gmail.com>
Date:   Tue, 26 Jun 2012 11:41:29 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Hill, Steven" <sjhill@mips.com>
CC:     Jonas Gorski <jonas.gorski@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 00/33] Cleanup firmware support across multiple platforms.
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>,<CAOiHx=kKxZZzJZkRe+SRjFj0JD7yq4=3CmRFbqc6hW_Dhnbz3g@mail.gmail.com> <31E06A9FC96CEC488B43B19E2957C1B8011469833E@exchdb03.mips.com>
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B8011469833E@exchdb03.mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/26/2012 11:34 AM, Hill, Steven wrote:
> Jonas,
>
> Did you read the COPYING file of the kernel source tree? I'm pretty sure it states "or later" in the text. Therefore, I believe that my changes to the headers are alright.
>

Steve,

Why subject yourself to all these questions about changing the copyright 
messages that the original authors put in there?

Would it be a problem for you to leave them intact?

I think you would have better luck splitting you patches like this:

1) A set that changes the code and only adds your own copyright for 
files where you do major work.

2) A set that removes other people's copyright text.

Applying #1 should then be a no-brainer.

#2 might be more difficult, but if you were persistent, you might 
eventually get it merged.

David Daney
