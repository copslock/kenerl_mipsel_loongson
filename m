Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 18:48:13 +0100 (CET)
Received: from mail-la0-f53.google.com ([209.85.215.53]:43633 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008710AbbCMRsMPRuzG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 18:48:12 +0100
Received: by labge10 with SMTP id ge10so23746630lab.10
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 10:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2Oe1R+JqeVG5RZ3pYPWhy2KgJPDIYQ+rlw0iebnQRLk=;
        b=N0W41N23RxRubvRdiVVQZAHeygH5rQGMnh6dWn4iJofe3eN4W/fXNEXwyHXNJsCkMZ
         +P8sTp6WhZDStS53AIeGdZOWDA4Ra2zcOokT8Jsw8ZFX7KzPu155+fIoZ5s8s8cf4ceF
         fcmXf3QbM6Y70FEzHYQhRdRLcIJR8y7kg/zXfA8mxtqomUC8ZXLxqjbjCPRqJwwvMQxO
         O4H0Cx6hzgq5OeQ5pON6CtaFZ5cVQvMsc5sRoQD41jZYaPPfrrtvmkEsqEciLgZX8MBp
         jFrMqODRkU/A9i/v5dn0AItBfWQGb/q6RBt7jcxPJmNITr8HQKlEDXSSi6UGrql1JF0T
         NAaw==
X-Gm-Message-State: ALoCoQkh8wD5fRr7w66RQowjpkVRJ960G8dJIL3TRFFcEB0dy7Z8Yc+k8c6TOFgmR/ZSFeeVhbi8
X-Received: by 10.112.67.107 with SMTP id m11mr19551523lbt.43.1426268887601;
        Fri, 13 Mar 2015 10:48:07 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-251-226.pppoe.mtu-net.ru. [83.237.251.226])
        by mx.google.com with ESMTPSA id h7sm529194lbj.29.2015.03.13.10.48.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2015 10:48:06 -0700 (PDT)
Message-ID: <550322D4.6060303@cogentembedded.com>
Date:   Fri, 13 Mar 2015 20:48:04 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Paul Martin <paul.martin@codethink.co.uk>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/6] MIPS: OCTEON: Tell the kernel build system we can
 do Little Endian
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk> <1426268098-1603-2-git-send-email-paul.martin@codethink.co.uk>
In-Reply-To: <1426268098-1603-2-git-send-email-paul.martin@codethink.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46374
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

On 03/13/2015 08:34 PM, Paul Martin wrote:

> Update the Kconfig file so that the configure system will
> allow us to build the kernel little endian.

    You didn't sign off on your patches, so they can't be applied.

WBR, Sergei
