Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 16:21:42 +0200 (CEST)
Received: from mail-la0-f52.google.com ([209.85.215.52]:64670 "EHLO
        mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832656Ab3ISOVgxfVAL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Sep 2013 16:21:36 +0200
Received: by mail-la0-f52.google.com with SMTP id ev20so6725252lab.25
        for <linux-mips@linux-mips.org>; Thu, 19 Sep 2013 07:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=G9U+9OJb1ki+CtGWPiaDJ//HfmFQkBHqCQ88d4euAs4=;
        b=erIgtiuzhYpBZZkHs9lkoq7Ti/DEUGQIRmSp2rbsyNsGYSm7YXYLW5uiokcO/w9EUK
         HJfqyOm23lxdHYDFZ/eAsDXsJI1OM8uLDy5+RiFl3vauwt3n4CYclP4ijirSvllwtSQ7
         6vz8ahTcYcM/bacB6JPuoKpFNXnqUD2jHAWoPYuv2GDHHN7Mrds0UJCuCnpIBiDQNUtf
         +68f5XgbA9u283VLnw98s1V6IrDb1hXSbMRdvpdfPyW3xi6zBopFk2YvQ91wO9ugUnqB
         kGUr+r1RBIhbm3x38hnwcvymHJgPflUqCx7FxkeCVLQi7YdZagMmC8saz2QYapDLj4vx
         4vlA==
X-Gm-Message-State: ALoCoQnJilxz137qPvRNpe1XnXMEyJnFT1NpAnJ411fEfQQB72PVnmOzxu4ZOXG7LBEVOj4x5VsP
X-Received: by 10.112.189.162 with SMTP id gj2mr292649lbc.53.1379600491135;
        Thu, 19 Sep 2013 07:21:31 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-86-6.pppoe.mtu-net.ru. [91.76.86.6])
        by mx.google.com with ESMTPSA id l10sm4035299lbh.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 07:21:30 -0700 (PDT)
Message-ID: <523B086B.3040206@cogentembedded.com>
Date:   Thu, 19 Sep 2013 18:21:31 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
CC:     ralf@linux-mips.org, steven.hill@imgtec.com, mmarek@suse.cz,
        swarren@nvidia.com, linux-mips@linux-mips.org,
        linux-kbuild@vger.kernel.org, james.hogan@imgtec.com
Subject: Re: [PATCH] MIPS: fix invalid symbolic link file
References: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 09/19/2013 05:09 PM, Madhavan Srinivasan wrote:

>     Commit 3b29aa5ba204c created a symlink file in include/dt-bindings.

    Please also specify that commit's summary line in parens.

>     Even though commit diff is fine, symlink is invalid.
>     ls -lb shows a newline character at the end of the filename.

    Don't indent the changelog please.

> lrwxrwxrwx 1 maddy maddy 35 Sep 19 18:11 dt-bindings ->
> ../../../../../include/dt-bindings\n

> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

WBR, Sergei
